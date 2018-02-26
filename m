Received: from eggs.gnu.org ([2001:4830:134:3::10]:36166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqRuL-0004wX-Db
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 18:10:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqRuI-00037n-KY
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 18:10:09 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44476 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eqRuI-00037W-G9
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 18:10:06 -0500
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180226225744.26356-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bff425ea-60bf-7b86-543e-e3cfca95f8dd@redhat.com>
Date: Mon, 26 Feb 2018 17:10:05 -0600
MIME-Version: 1.0
In-Reply-To: <20180226225744.26356-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 23.5/29] watchdog: Consolidate QAPI into
 single file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, mprivozn@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com, marcandre.lureau@redhat.com

On 02/26/2018 04:57 PM, Eric Blake wrote:
> Commit f0df84c6 added watchdog-set-action in the main qapi-schema.json,
> but it belongs better in qapi/run-state.json alongside the definition
> of WatchdogAction.

I'm adding:

The command was written prior to commit 0e201d34 creating the latter 
file, even though it was merged after.

> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> Based on my review of 24/29, I'm inserting this patch right before
> rebasing that one onto master.
> 
>   qapi-schema.json    | 9 ---------
>   qapi/run-state.json | 9 +++++++++
>   2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 05cc58e121e..93912e804ab 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -3180,12 +3180,3 @@
>   # Since: 2.9
>   ##
>   { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
> -
> -##
> -# @watchdog-set-action:
> -#
> -# Set watchdog action
> -#
> -# Since: 2.11
> -##
> -{ 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'} }
> diff --git a/qapi/run-state.json b/qapi/run-state.json
> index bca46a8785f..3924357fef4 100644
> --- a/qapi/run-state.json
> +++ b/qapi/run-state.json
> @@ -283,6 +283,15 @@
>     'data': [ 'reset', 'shutdown', 'poweroff', 'pause', 'debug', 'none',
>               'inject-nmi' ] }
> 
> +##
> +# @watchdog-set-action:
> +#
> +# Set watchdog action
> +#
> +# Since: 2.11
> +##
> +{ 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'} }
> +
>   ##
>   # @GUEST_PANICKED:
>   #
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

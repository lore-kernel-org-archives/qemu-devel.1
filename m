Received: from eggs.gnu.org ([2001:4830:134:3::10]:56195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euqxB-0006ge-B2
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 21:43:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euqx8-0005Hd-86
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 21:43:17 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34292 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1euqx8-0005HV-3I
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 21:43:14 -0500
References: <20180309090006.10018-1-peterx@redhat.com>
	<20180309090006.10018-22-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6c1368c4-4246-677a-55c8-6f2c70e126bf@redhat.com>
Date: Sat, 10 Mar 2018 20:42:57 -0600
MIME-Version: 1.0
In-Reply-To: <20180309090006.10018-22-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 21/23] qmp: add command "x-oob-test"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 03/09/2018 03:00 AM, Peter Xu wrote:
> This command is only used to test OOB functionality.  It should not be
> used for any other purposes.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   qapi/misc.json | 18 ++++++++++++++++++
>   qmp.c          | 16 ++++++++++++++++
>   2 files changed, 34 insertions(+)
> 
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 8c7e736681..07932bdacf 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -3264,3 +3264,21 @@
>   ##
>   { 'event': 'COMMAND_DROPPED' ,
>     'data': { 'id': 'any', 'reason': 'CommandDropReason' } }
> +
> +##
> +# @x-oob-test:
> +#
> +# Test OOB functionality.  When send this command with lock=true,

s/send/sending/

> +# it'll try to hang the dispatcher.  When send it with lock=false,

s/send/sending/

> +# it'll try to notify the locked thread to continue.  Note: it should
> +# only be used by QMP test program rather than anything else.
> +#
> +# Since: 2.12
> +#
> +# Example:
> +#
> +# { "execute": "x-oob-test",
> +#   "arguments": { "lock": true } }
> +##
> +{ 'command': 'x-oob-test', 'data' : { 'lock': 'bool' },
> +  'allow-oob': true }
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

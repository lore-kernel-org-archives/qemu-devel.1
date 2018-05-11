Received: from eggs.gnu.org ([2001:4830:134:3::10]:42299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fH9nS-0002q7-MD
	for qemu-devel@nongnu.org; Fri, 11 May 2018 11:17:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fH9nP-0006n9-H3
	for qemu-devel@nongnu.org; Fri, 11 May 2018 11:17:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43664 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fH9nP-0006n3-CT
	for qemu-devel@nongnu.org; Fri, 11 May 2018 11:17:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D59C7400187F
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 15:17:22 +0000 (UTC)
References: <1525423069-61903-1-git-send-email-imammedo@redhat.com>
	<1525423069-61903-4-git-send-email-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0255b39e-efb1-e660-82df-091aea19ce5b@redhat.com>
Date: Fri, 11 May 2018 10:17:21 -0500
MIME-Version: 1.0
In-Reply-To: <1525423069-61903-4-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 03/11] qapi: introduce preconfig runstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, pkrempa@redhat.com, armbru@redhat.com

On 05/04/2018 03:37 AM, Igor Mammedov wrote:
> New preconfig runstate will be used in follow up patches
> related to introducing --preconfig CLI option and is
> intended to replace prelaunch runstate from QEMU start
> up to machine_init callback.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   qapi/run-state.json | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/qapi/run-state.json b/qapi/run-state.json
> index 1c9fff3..9694a9f 100644
> --- a/qapi/run-state.json
> +++ b/qapi/run-state.json
> @@ -49,12 +49,15 @@
>   # @colo: guest is paused to save/restore VM state under colo checkpoint,
>   #        VM can not get into this state unless colo capability is enabled
>   #        for migration. (since 2.8)
> +# @preconfig: QEMU is paused before board specific init callback is executed.
> +#             The state is reachable only if the --preconfig CLI option is used.
> +#             (Since 2.13)
>   ##
>   { 'enum': 'RunState',
>     'data': [ 'debug', 'inmigrate', 'internal-error', 'io-error', 'paused',
>               'postmigrate', 'prelaunch', 'finish-migrate', 'restore-vm',
>               'running', 'save-vm', 'shutdown', 'suspended', 'watchdog',
> -            'guest-panicked', 'colo' ] }
> +            'guest-panicked', 'colo', 'preconfig' ] }
>   
>   ##
>   # @StatusInfo:
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

Received: from eggs.gnu.org ([2001:4830:134:3::10]:52999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fPxtP-0007Yt-7A
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 18:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fPxtO-0007Vn-CX
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 18:23:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42454 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fPxtO-0007Vj-7w
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 18:23:58 -0400
References: <20180603050546.6827-1-zhangckid@gmail.com>
	<20180603050546.6827-12-zhangckid@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8ed3dcba-d574-7b08-9f82-4e8d61c2245c@redhat.com>
Date: Mon, 4 Jun 2018 17:23:56 -0500
MIME-Version: 1.0
In-Reply-To: <20180603050546.6827-12-zhangckid@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V8 11/17] qapi: Add new command to query
 colo status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangckid@gmail.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

On 06/03/2018 12:05 AM, Zhang Chen wrote:
> Libvirt or other high level software can use this command query colo status.
> You can test this command like that:
> {'execute':'query-colo-status'}
> 
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---

> +++ b/qapi/migration.json
> @@ -1231,6 +1231,40 @@
>   ##
>   { 'command': 'xen-colo-do-checkpoint' }
>   
> +##
> +# @COLOStatus:
> +#
> +# The result format for 'query-colo-status'.
> +#
> +# @mode: COLO running mode. If COLO is running, this field will return
> +#        'primary' or 'secodary'.

s/secodary/secondary/

> +#
> +# @colo-running: true if COLO is running.
> +#
> +# @reason: describes the reason for the COLO exit.
> +#
> +# Since: 2.13

3.0

> +##
> +{ 'struct': 'COLOStatus',
> +  'data': { 'mode': 'COLOMode', 'colo-running': 'bool', 'reason': 'COLOExitReason' } }
> +
> +##
> +# @query-colo-status:
> +#
> +# Query COLO status while the vm is running.
> +#
> +# Returns: A @COLOStatus object showing the status.
> +#
> +# Example:
> +#
> +# -> { "execute": "query-colo-status" }
> +# <- { "return": { "mode": "primary", "colo-running": true, "reason": "request" } }
> +#
> +# Since: 2.13

3.0

> +##
> +{ 'command': 'query-colo-status',
> +  'returns': 'COLOStatus' }
> +
>   ##
>   # @migrate-recover:
>   #
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

Received: from eggs.gnu.org ([2001:4830:134:3::10]:44874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gDWjy-0001W3-TW
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 11:31:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gDWju-00013h-Ui
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 11:31:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gDWju-00010T-Kt
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 11:31:02 -0400
References: <1539919345-10703-1-git-send-email-jasowang@redhat.com>
	<1539919345-10703-13-git-send-email-jasowang@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a42bdd2a-4163-e1f0-4e2e-d3be0c857732@redhat.com>
Date: Fri, 19 Oct 2018 10:30:53 -0500
MIME-Version: 1.0
In-Reply-To: <1539919345-10703-13-git-send-email-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL V2 12/26] qapi: Add new command to query
 colo status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Zhang Chen <chen.zhang@intel.com>, Zhang Chen <zhangckid@gmail.com>

On 10/18/18 10:22 PM, Jason Wang wrote:
> From: Zhang Chen <zhangckid@gmail.com>
> 
> Libvirt or other high level software can use this command query colo status.
> You can test this command like that:
> {'execute':'query-colo-status'}
> 
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---

> +++ b/qapi/migration.json
> @@ -1308,6 +1308,38 @@
>   { 'command': 'xen-colo-do-checkpoint' }
>   
>   ##
> +# @COLOStatus:
> +#
> +# The result format for 'query-colo-status'.
> +#
> +# @mode: COLO running mode. If COLO is running, this field will return
> +#        'primary' or 'secondary'.
> +#
> +# @reason: describes the reason for the COLO exit.
> +#
> +# Since: 3.0

Now that the pull request has landed, please submit a followup patch 
that fixes s/3.0/3.1/

> +##
> +{ 'struct': 'COLOStatus',
> +  'data': { 'mode': 'COLOMode', 'reason': 'COLOExitReason' } }
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
> +# <- { "return": { "mode": "primary", "active": true, "reason": "request" } }
> +#
> +# Since: 3.0

at both locations


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

Received: from eggs.gnu.org ([2001:4830:134:3::10]:59765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiecl.fnst@cn.fujitsu.com>) id 1cJIg3-0006Ry-5g
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 06:33:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiecl.fnst@cn.fujitsu.com>) id 1cJIg2-00073i-At
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 06:33:51 -0500
Message-ID: <5859172D.7080602@cn.fujitsu.com>
Date: Tue, 20 Dec 2016 19:34:05 +0800
From: Changlong Xie <xiecl.fnst@cn.fujitsu.com>
MIME-Version: 1.0
References: <1480926904-17596-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1480926904-17596-3-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1480926904-17596-3-git-send-email-zhang.zhanghailiang@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v2 2/6] replication: add shared-disk
 and shared-disk-id options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: stefanha@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, wency@cn.fujitsu.com, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

On 12/05/2016 04:35 PM, zhanghailiang wrote:
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index c29bef7..52d7e0d 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2232,12 +2232,19 @@
>   #          node who owns the replication node chain. Must not be given in
>   #          primary mode.
>   #
> +# @shared-disk-id: #optional The id of shared disk while in replication mode.
> +#
> +# @shared-disk: #optional To indicate whether or not a disk is shared by
> +#               primary VM and secondary VM.
> +#

I think we need more detailed description here.

For @shared-disk, we can only both enable or disable it on both side.
For @shared-disk-id, it must/only be given when @shared-disk enable on 
Primary side.

More, you also need to perfect the replication_open() logic.

>   # Since: 2.8
>   ##
>   { 'struct': 'BlockdevOptionsReplication',
>     'base': 'BlockdevOptionsGenericFormat',
>     'data': { 'mode': 'ReplicationMode',
> -            '*top-id': 'str' } }
> +            '*top-id': 'str',
> +            '*shared-disk-id': 'str',
> +            '*shared-disk': 'bool' } }
>
>   ##
>   # @NFSTransport
> --

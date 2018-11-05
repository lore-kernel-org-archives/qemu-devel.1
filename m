Received: from eggs.gnu.org ([2001:4830:134:3::10]:34917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gJhHL-0004vm-PN
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:59:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gJhHJ-00012p-EF
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:59:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gJhHJ-00010I-1p
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:59:01 -0500
References: <20181105124559.21561-1-yuval.shaia@oracle.com>
	<20181105124559.21561-11-yuval.shaia@oracle.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b5e5ae7c-f308-3d55-7f09-1accd324afd8@redhat.com>
Date: Mon, 5 Nov 2018 09:58:56 -0600
MIME-Version: 1.0
In-Reply-To: <20181105124559.21561-11-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/18] json: Define new QMP message for
 pvrdma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>, marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, armbru@redhat.com, shamir.rabinovitch@oracle.com, qemu-devel@nongnu.org

On 11/5/18 6:45 AM, Yuval Shaia wrote:
> pvrdma requires that the same GID attached to it will be attached to the
> backend device in the host.
> 
> A new QMP messages is defined so pvrdma device can broadcast any change
> made to its GID table. This event is captured by libvirt which in turn
> will update the GID table in the backend device.
> 
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---

> +++ b/qapi/rdma.json
> @@ -0,0 +1,34 @@
> +# -*- Mode: Python -*-
> +#
> +
> +##
> +# = RDMA device
> +##
> +
> +##
> +# @RDMA_GID_STATUS_CHANGED:
> +#
> +# Emitted when guest driver adds/deletes GID to/from device
> +#
> +# @netdev: RoCE Network Device name - char *
> +#
> +# @gid-status: Add or delete indication - bool
> +#
> +# @subnet-prefix: Subnet Prefix - uint64
> +#
> +# @interface-id : Interface ID - uint64
> +#
> +# Since: 2.12.1

You've missed 2.12.1 by a long shot. Since we are in soft freeze and 
this is a new feature, the soonest this can be released is in 3.2.

> +#
> +# Example:
> +#
> +# <- { {"timestamp": {"seconds": 1540819325, "microseconds": 504544},
> +#       "event": "ADDGID", "data": {"netdev": "bridge0",
> +#       "interface-id": 7052258031502978997, "subnet-prefix": 33022}}
> +#
> +##
> +{ 'event': 'RDMA_GID_STATUS_CHANGED',
> +  'data': { 'netdev'        : 'str',
> +            'gid-status'    : 'bool',
> +            'subnet-prefix' : 'uint64',
> +            'interface-id'  : 'uint64' } }
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

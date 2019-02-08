Received: from eggs.gnu.org ([209.51.188.92]:38869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gs7ET-0005s1-1a
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 09:34:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gs7ES-0004dG-EE
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 09:34:21 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gs7ES-0004c0-5P
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 09:34:20 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x18EY7bk147135
	for <qemu-devel@nongnu.org>; Fri, 8 Feb 2019 14:34:16 GMT
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
	by userp2120.oracle.com with ESMTP id 2qd98nmy1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 14:34:16 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x18EYFVt012681
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Fri, 8 Feb 2019 14:34:16 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x18EYFN8003923
	for <qemu-devel@nongnu.org>; Fri, 8 Feb 2019 14:34:15 GMT
References: <20190208142347.214815-1-sgarzare@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <737a11b9-68d0-47f0-b0e3-4083ce9af4f4@oracle.com>
Date: Fri, 8 Feb 2019 14:34:13 +0000
MIME-Version: 1.0
In-Reply-To: <20190208142347.214815-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] virtio-blk: cleanup using VirtIOBlock *s
 and VirtIODevice *vdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 08/02/2019 14:23, Stefano Garzarella wrote:
> In several part we still using req->dev or VIRTIO_DEVICE(req->dev)
> when we have already defined s and vdev pointers:
>      VirtIOBlock *s = req->dev;
>      VirtIODevice *vdev = VIRTIO_DEVICE(s);
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Reviewed-by: Liam Merwick <liam.merwick@oracle.com>

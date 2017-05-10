Received: from eggs.gnu.org ([2001:4830:134:3::10]:51095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d8P0d-0000RY-0r
	for qemu-devel@nongnu.org; Wed, 10 May 2017 06:38:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d8P0Y-00018G-4W
	for qemu-devel@nongnu.org; Wed, 10 May 2017 06:38:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49032
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d8P0X-00017x-UI
	for qemu-devel@nongnu.org; Wed, 10 May 2017 06:38:14 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4AAXrSS130388
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 06:38:13 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2abhaxug1u-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 06:38:12 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 10 May 2017 11:38:09 +0100
Date: Wed, 10 May 2017 12:38:00 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <52177e87-8d46-e1f6-49cf-397f296dd366@linux.vnet.ibm.com>
References: <20170505173507.74077-1-pasic@linux.vnet.ibm.com>
	<20170505173507.74077-7-pasic@linux.vnet.ibm.com>
	<20170508165501.GH2120@work-vm>
	<52177e87-8d46-e1f6-49cf-397f296dd366@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170510123800.3e1972e8.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 06/10] virtio-ccw: use vmstate way for
 config migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On Tue, 9 May 2017 19:05:28 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> From e92135590ab95cc565b37913de77a9ed17012933 Mon Sep 17 00:00:00 2001
> From: Halil Pasic <pasic@linux.vnet.ibm.com>
> Date: Tue, 9 May 2017 16:01:50 +0200
> Subject: [PATCH 1/2] virtio-ccw: replace info with VMSTATE_WITH_TMP
> 
> Convert s VMSatateInfo based solution manipulating the migration stream
> directly to VMSTATE_WITH_TMP witch keeps IO and transformation logic
> separate. 
> 
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  hw/s390x/virtio-ccw.c | 40 +++++++++++++++++++++++-----------------
>  1 file changed, 23 insertions(+), 17 deletions(-)

FWIW: Looks reasonable to me.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:49304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dslEm-0006tx-3l
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 03:40:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dslEh-0004qK-7X
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 03:40:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dslEh-0004pB-0y
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 03:40:27 -0400
References: <cover.1505403478.git.alifm@linux.vnet.ibm.com>
	<b9b4d8a8c1d17bf3f086b120fdf04c925da0f331.1505403478.git.alifm@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ee7ba6d5-b97a-cf3d-9190-21e97628d51a@redhat.com>
Date: Fri, 15 Sep 2017 09:40:21 +0200
MIME-Version: 1.0
In-Reply-To: <b9b4d8a8c1d17bf3f086b120fdf04c925da0f331.1505403478.git.alifm@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] virtio-gpu-ccw: Create a virtio gpu
 device for the ccw bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, kraxel@redhat.com, cohuck@redhat.com

On 14.09.2017 17:55, Farhan Ali wrote:
> Wire up the virtio-gpu device for the CCW bus. The virtio-gpu
> is a virtio-1 device, so disable revision 0.
> 
> Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  hw/s390x/virtio-ccw.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/s390x/virtio-ccw.h | 10 ++++++++++

Reviewed-by: Thomas Huth <thuth@redhat.com>

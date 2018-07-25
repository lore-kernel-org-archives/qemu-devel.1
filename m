Received: from eggs.gnu.org ([2001:4830:134:3::10]:40947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fiKDS-0003Ac-PX
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 09:52:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fiKDN-0006Fv-EU
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 09:52:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49568
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fiKDN-0006Fi-8D
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 09:52:29 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6PDmZqx131108
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 09:52:26 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2keswy9n25-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 09:52:26 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 25 Jul 2018 14:52:24 +0100
References: <1532521224-27235-1-git-send-email-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 25 Jul 2018 15:52:19 +0200
MIME-Version: 1.0
In-Reply-To: <1532521224-27235-1-git-send-email-thuth@redhat.com>
Content-Language: en-US
Message-Id: <c2f864e7-4009-e86d-ebd4-6ddea71df5e0@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.1 00/10] Move virtio-ccw devices to
 separate files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

Are you planning to do a similar thing for virtio-pci? I think it would be good
to keep virtio-ccw similar to virtio-pci when it makes sense.

On 07/25/2018 02:20 PM, Thomas Huth wrote:
> For more fine-grained control over the build process, it would be good
> to have the possibility to disable single virtio devices, too. We already
> have CONFIG_VIRTIO_* switches in the Makefiles, but currently all
> virtio-ccw devices are compiled in anyway. Move them to separate files
> so we can disable them in the Makefile more easily.
> 
> NB: I did not move virtio-blk-ccw and virtio-net-ccw to a separate file
> yet since they are essential for the s390x-virtio machine and thus it
> does IMHO not make much sense to disable net and blk. But if somebody
> needs that possibility, too, I can add two more patches on top...
> 
> Thomas Huth (10):
>   hw/s390x/virtio-ccw: Consolidate calls to virtio_ccw_unrealize()
>   hw/s390x: Move virtio-ccw-serial code to a separate file
>   hw/s390x: Move virtio-ccw-balloon code to a separate file
>   hw/s390x: Move virtio-ccw-scsi code to a separate file
>   hw/s390x: Move virtio-ccw-rng code to a separate file
>   hw/s390x: Move virtio-ccw-9p code to a separate file
>   hw/s390x: Move virtio-ccw-crypto code to a separate file
>   hw/s390x: Move vhost-vsock-ccw code to a separate file
>   hw/s390x: Move virtio-ccw-gpu code to a separate file
>   hw/s390x: Move virtio-ccw-input code to a separate file
> 
>  MAINTAINERS                   |   2 +-
>  hw/s390x/Makefile.objs        |   9 +
>  hw/s390x/vhost-vsock-ccw.c    |  60 +++++
>  hw/s390x/virtio-ccw-9p.c      |  65 +++++
>  hw/s390x/virtio-ccw-balloon.c |  70 +++++
>  hw/s390x/virtio-ccw-crypto.c  |  75 ++++++
>  hw/s390x/virtio-ccw-gpu.c     |  67 +++++
>  hw/s390x/virtio-ccw-input.c   | 118 +++++++++
>  hw/s390x/virtio-ccw-rng.c     |  74 ++++++
>  hw/s390x/virtio-ccw-scsi.c    | 125 +++++++++
>  hw/s390x/virtio-ccw-serial.c  |  78 ++++++
>  hw/s390x/virtio-ccw.c         | 581 +-----------------------------------------
>  12 files changed, 749 insertions(+), 575 deletions(-)
>  create mode 100644 hw/s390x/vhost-vsock-ccw.c
>  create mode 100644 hw/s390x/virtio-ccw-9p.c
>  create mode 100644 hw/s390x/virtio-ccw-balloon.c
>  create mode 100644 hw/s390x/virtio-ccw-crypto.c
>  create mode 100644 hw/s390x/virtio-ccw-gpu.c
>  create mode 100644 hw/s390x/virtio-ccw-input.c
>  create mode 100644 hw/s390x/virtio-ccw-rng.c
>  create mode 100644 hw/s390x/virtio-ccw-scsi.c
>  create mode 100644 hw/s390x/virtio-ccw-serial.c
> 

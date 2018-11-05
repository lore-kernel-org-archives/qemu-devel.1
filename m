Received: from eggs.gnu.org ([2001:4830:134:3::10]:55199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <v.mayatskih@gmail.com>) id 1gJfMN-0001PE-0F
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <v.mayatskih@gmail.com>) id 1gJfMM-0006yb-A4
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:56:06 -0500
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:44589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <v.mayatskih@gmail.com>)
	id 1gJfML-0006xx-QS
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:56:06 -0500
Received: by mail-qk1-x744.google.com with SMTP id n12so14678780qkh.11
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 05:56:05 -0800 (PST)
MIME-Version: 1.0
References: <20181102191538.7532-1-v.mayatskih@gmail.com>
	<4222cd0b956ac767f74b56a32772d190d1b84b51.camel@redhat.com>
In-Reply-To: <4222cd0b956ac767f74b56a32772d190d1b84b51.camel@redhat.com>
From: Vitaly Mayatskih <v.mayatskih@gmail.com>
Date: Mon, 5 Nov 2018 08:55:53 -0500
Message-ID: <CAGF4SLh8+YV3F5zEtRpBMnCUFDx03VJdV1jfcgSSKqx6KUmvaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/1] Add vhost-pci-blk driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mlevitsk@redhat.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

> >  configure                  | 10 +++++++
> >  default-configs/virtio.mak |  1 +
> >  hw/block/Makefile.objs     |  1 +
> >  hw/virtio/virtio-pci.c     | 60 ++++++++++++++++++++++++++++++++++++++
> >  hw/virtio/virtio-pci.h     | 19 ++++++++++++
> >  5 files changed, 91 insertions(+)
> >
>
> I think that you haven't sent all the files because at least some of the files
> are missing.
> For example the build fails with missing 'hw/virtio/vhost-blk.h'
>
> Also I don't see here any mention on how the qemu passes to the in-kernel
> driver, the file which the in-kernel driver is supposed to read/write.
> I don't think that generic vhost backend have this functionality because till
> now it was limited to iscsi, and thus qemu just passed to the kernel, the wwpn
> of the device.

Yes, I screwed it up and forgot two files. Will resend shortly.

Thanks!

-- 
wbr, Vitaly

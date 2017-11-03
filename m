Received: from eggs.gnu.org ([2001:4830:134:3::10]:33916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eAWHV-0000pI-Ki
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 03:20:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eAWHR-0003Mg-Hy
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 03:20:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eAWHR-0003M0-Ba
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 03:20:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 35A9AC04AC4E
	for <qemu-devel@nongnu.org>; Fri,  3 Nov 2017 07:20:40 +0000 (UTC)
Message-ID: <1509693637.31823.7.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 03 Nov 2017 08:20:37 +0100
In-Reply-To: <CABdb734XVCNxyyRUfFtU5cm=34K28zsuRgyuj6F2SEBjPUu27w@mail.gmail.com>
References: <20171102133115.19195-1-lprosek@redhat.com>
	<20171102163348-mutt-send-email-mst@kernel.org>
	<CABdb734XVCNxyyRUfFtU5cm=34K28zsuRgyuj6F2SEBjPUu27w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] virtio-pci: Don't force Subsystem Vendor
 ID = Vendor ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Yan Vugenfirer <yvugenfi@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Vadim Rozenfeld <vrozenfe@redhat.com>


> > > Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> > 
> > I wonder whether it's a problem that legacy devices ignore
> > the subsystem ID (that's part of spec).
> 
> I don't understand this comment. I don't see anything in the spec
> related to ignoring the subsystem ID.

Well, the subsystem *device* id is defined to be the virtio device id,
so it is certainly not ignored.  The subsystem *vendor* id is not used
as far I know (or ignored in the sense that it doesn't change driver
behavior), allowing to set that makes sense to me.

Possibly not only for virtio devices, most pci devices have 1af4:1100
as subsystem id, other vendors might want set it too for consistency.

cheers,
  Gerd

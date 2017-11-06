Received: from eggs.gnu.org ([2001:4830:134:3::10]:37534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eBdXt-0002ws-9o
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:18:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eBdXp-0006fv-9x
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:18:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eBdXp-0006fL-3b
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:18:13 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A10F67CB87
	for <qemu-devel@nongnu.org>; Mon,  6 Nov 2017 09:18:10 +0000 (UTC)
Message-ID: <1509959887.30277.8.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 06 Nov 2017 10:18:07 +0100
In-Reply-To: <CABdb734DG_itxuUjCiANz_ps+j5EdJj287HXrd8Xa_akyGAsaA@mail.gmail.com>
References: <20171102133115.19195-1-lprosek@redhat.com>
	<20171102163348-mutt-send-email-mst@kernel.org>
	<CABdb734XVCNxyyRUfFtU5cm=34K28zsuRgyuj6F2SEBjPUu27w@mail.gmail.com>
	<1509693637.31823.7.camel@redhat.com>
	<CABdb734MR3vMCSBH-JhD8vWYKLBx6QOxrVZFYUyDbuQJg8mZ6Q@mail.gmail.com>
	<20171103170426-mutt-send-email-mst@kernel.org>
	<CABdb734DG_itxuUjCiANz_ps+j5EdJj287HXrd8Xa_akyGAsaA@mail.gmail.com>
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

  Hi,

> > So in my humble opinion the right thing for people to do is simply
> > to
> > avoid legacy devices. Is something preventing that?
> 
> The same reasons why the concept of transitional devices exists at
> all?

We discussing future driver versions running on future qemu versions,
so we should have virtio 1.0 support on both ends.  So IMO the question
 isn't that silly ...

But by default qemu uses transitional by default for non-express
devices, i.e. for all i440fx machines types.  Which implies virtio-
legacy compatible pci ids.

If we want change this we need a transitional/modern virtio config
switch.  Not only in qemu, but for the whole management stack too.
I don't think it is a good idea to go that route.

cheers,
  Gerd

Received: from eggs.gnu.org ([209.51.188.92]:57732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gzaxP-0001iN-Dr
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 00:43:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gzaxO-0003MM-Mj
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 00:43:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gzaxO-0003M1-GQ
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 00:43:38 -0500
Date: Fri, 1 Mar 2019 06:43:35 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190301054335.qck44hrsnldbpwhu@sirius.home.kraxel.org>
References: <20190225152618.r3epnypkpu6fyokt@sirius.home.kraxel.org>
	<A17B6D30-F428-48E5-B9D0-6F6E7DEE3778@gmail.com>
	<20190226064347.i5kvwazmz3xcupkj@sirius.home.kraxel.org>
	<CAKyx-3OOkkdSQ=UAucP_ZpormrEczwNhEpAnVtFeQOSOrnD7Vg@mail.gmail.com>
	<20190227052755.3lgo3265kaa6bzmi@sirius.home.kraxel.org>
	<1ef851d2-4148-56f0-65ac-a0e75022f20e@ilande.co.uk>
	<20190228054923.wxguahjavmqybddn@sirius.home.kraxel.org>
	<7de277ad-ab04-795b-8399-7a01d476e130@ilande.co.uk>
	<20190228063812.b75cqgoacf32bri4@sirius.home.kraxel.org>
	<d2b28d19-0533-e467-013d-66427c307126@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2b28d19-0533-e467-013d-66427c307126@ilande.co.uk>
Subject: Re: [Qemu-devel] Questions about EDID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: G 3 <programmingkidx@gmail.com>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

  Hi,

> > Well, not really.  EDID is about monitor capabilities.  The monitor will
> > see 8 bit per color channel, no matter whenever your GPU composes that
> > signal using a 8bpp mode + color palette or 24bpp mode with direct
> > color.
> 
> Hmmm okay. Perhaps it might still be worth hooking -g XxYxD to also put X and Y into
> xres and yres within the EDID so at least everything is consistent between OpenBIOS
> and the client driver when it eventually loads?

That makes sense, sure.  Will be a bit tricky due to (I think) only ppc
and sparc actually looking at -g right now, to make sure current
behavior of the other archs doesn't change when -g is not specified.

cheers,
  Gerd

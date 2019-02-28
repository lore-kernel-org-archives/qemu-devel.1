Received: from eggs.gnu.org ([209.51.188.92]:35290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gzEZZ-0005aa-3L
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 00:49:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gzEZT-0001nV-Dn
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 00:49:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gzEZS-0001j3-5W
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 00:49:27 -0500
Date: Thu, 28 Feb 2019 06:49:23 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190228054923.wxguahjavmqybddn@sirius.home.kraxel.org>
References: <CAKyx-3Paa6_RreGZw3sT+qmwu1=_DLnR_RDxa_gN20vwD1EnLw@mail.gmail.com>
	<20190225152618.r3epnypkpu6fyokt@sirius.home.kraxel.org>
	<A17B6D30-F428-48E5-B9D0-6F6E7DEE3778@gmail.com>
	<20190226064347.i5kvwazmz3xcupkj@sirius.home.kraxel.org>
	<CAKyx-3OOkkdSQ=UAucP_ZpormrEczwNhEpAnVtFeQOSOrnD7Vg@mail.gmail.com>
	<20190227052755.3lgo3265kaa6bzmi@sirius.home.kraxel.org>
	<1ef851d2-4148-56f0-65ac-a0e75022f20e@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ef851d2-4148-56f0-65ac-a0e75022f20e@ilande.co.uk>
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

> Right, at the moment all the MacOS driver does is parse the resolution list from the
> EDID and add them to the dropdown list - it doesn't support the xres and yres properties.

> The main reason for this that OpenBIOS currently makes use of the -g XxYxD parameter
> to set up the display resolution and bit depth, and AFAICT we currently only have
> access to the X and Y resolutions via the EDID blob. So it's not clear whether EDID
> can completely replace the existing mechanism yet.

EDID can only propagate x + y, not depth.

cheers,
  Gerd

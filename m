Received: from eggs.gnu.org ([2001:4830:134:3::10]:54407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tom.k.cook@gmail.com>) id 1dSoXx-0001D3-DS
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:57:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tom.k.cook@gmail.com>) id 1dSoXw-0008TA-H9
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:57:05 -0400
Received: from mail-yb0-x22b.google.com ([2607:f8b0:4002:c09::22b]:32935)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tom.k.cook@gmail.com>)
	id 1dSoXw-0008Rs-BX
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:57:04 -0400
Received: by mail-yb0-x22b.google.com with SMTP id 84so74687991ybe.0
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 10:57:02 -0700 (PDT)
MIME-Version: 1.0
From: Tom Cook <tom.k.cook@gmail.com>
Date: Wed, 05 Jul 2017 17:56:51 +0000
Message-ID: <CAFSh4Uw0bH=a18C0s0k9FReSTebihesfEuwT+PV2Vp50LsX8sA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Modular hardware emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

I'm using qemu to emulate a certain fruit-flavoured single-board computer -
which is fantastic for testing changes configuration, by the way.

We have a bit of custom hardware attached to that single-board computer -
essentially an SPI-slave 8-channel ADC with some analog electronics
attached.

I'm trying to get a feel for the level of effort involved in writing an
emulation of this custom hardware that will work with qemu.  I can see two
extremes:  At one end of the scale, there might be a nice Python interface
already in place for writing SPI device emulations and all I need to do is
point a command-line parameter at a suitable script and away it goes.  At
the other end, I need to hack around in the qemu source, understand about
3/4 of it and create a custom build of the whole emulator.

Can someone give me some sort of idea what level of effort is involved, and
perhaps a pointer in the right direction, please?

Regards,
Tom

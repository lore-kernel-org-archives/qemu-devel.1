Received: from eggs.gnu.org ([209.51.188.92]:33054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1h1kHF-0000le-1j
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 23:05:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1h1kHD-0002Xy-S3
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 23:05:00 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:36149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <randrianasulu@gmail.com>)
	id 1h1kHD-0002Vg-Ki
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 23:04:59 -0500
Received: by mail-pf1-x431.google.com with SMTP id n22so10361268pfa.3
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 20:04:52 -0800 (PST)
From: Andrew Randrianasulu <randrianasulu@gmail.com>
Date: Thu, 7 Mar 2019 07:01:17 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201903070701.18037.randrianasulu@gmail.com>
Subject: Re: [Qemu-devel] PMON2000 compilation and kernel question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: balaton@eik.bme.hu, qemu-devel@nongnu.org

> Checked off-list, just for the record: looks like your compiled binary tries to set up a flat-panel display besides the CRT but flat-panel part of GPU is not modelled and with both screens pmon tries to put CRT screen at an 80MB offset which can't work as chip has only 16MB VRAM. This results in distorted screen. I'm not sure why it does that but it shouldn't try to use flat-panel display at the first place because fulong2e mini-pc QEMU tries to emulate is not a laptop and has no flat panel. The pmon_2e.bin binary does not do this and only creates a CRT screen at offset 0 so I think the config used to compile pmon is not right yet.

May be I send you wrong binary :/
sorry, will double-check

distorted screen was when I tried 800x600 or 32 bpp ....

sha256sum /dev/shm/pmon-my/pmon/zloader.2edev/pmon.bin
ecc82c621c33d140ac1ba01a70876f467e47a7cc9eb154a0647c227355d39e60  /dev/shm/pmon-my/pmon/zloader.2edev/pmon.bin

https://ibin.co/4ZKKU0t9xNDE.png - image I got.

mac99 machine with your ati-vga device look like this (after upgrading X and r128 driver)
https://ibin.co/4ZKLzg90dFZA.png
note again, this is with NoAccel (while strangely overlay still around via xvinfo)

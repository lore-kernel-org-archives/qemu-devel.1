Received: from eggs.gnu.org ([2001:4830:134:3::10]:40362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cbmv3-0005kZ-CC
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 06:29:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cbmuz-00058w-FP
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 06:29:45 -0500
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:34578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cbmuz-00057v-7q
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 06:29:41 -0500
Received: by mail-wr0-x231.google.com with SMTP id o16so81568595wra.1
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 03:29:39 -0800 (PST)
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 09 Feb 2017 11:29:49 +0000
Message-ID: <8760kjy53m.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] How can I exercise the CPU reset code for iMX boards?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU-DEV <qemu-devel@nongnu.org>


Hi Jean-Christophe,

As part of the MTTCG work I've been tweaking the reset handling code in
imx6_src.c to handle the fact the reset is now asynchronous:

  https://github.com/stsquad/qemu/commit/ef8e78e7adccb8c881a1772ac01cd78c6b436de3

The only image I currently have is from Peter's image zoo which is a
simple kernel and initrd. I can successfully offline/online CPUs but
with printfs I can see this never causes them to be reset. So a couple
of questions:

  - does Linux even exercise the reset bit?
  - if not are there any test OS images that do?

and a follow-up bonus questions:

  - what's the QEMU invocation for the iMX boards with a SD card?
  - are there any full images you suggest with a more complete rootfs?

Regards,

--
Alex Bennée

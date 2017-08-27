Received: from eggs.gnu.org ([2001:4830:134:3::10]:53206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongyi.zhao@gmail.com>) id 1dlxqN-0002jV-9R
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 09:43:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongyi.zhao@gmail.com>) id 1dlxqM-0002cD-5O
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 09:43:15 -0400
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:34828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongyi.zhao@gmail.com>)
	id 1dlxqM-0002bI-0W
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 09:43:14 -0400
Received: by mail-oi0-x236.google.com with SMTP id k77so28426244oib.2
	for <qemu-devel@nongnu.org>; Sun, 27 Aug 2017 06:43:12 -0700 (PDT)
MIME-Version: 1.0
From: Hongyi Zhao <hongyi.zhao@gmail.com>
Date: Sun, 27 Aug 2017 21:43:10 +0800
Message-ID: <CAGP6PO+aB9V-u+wKMc2zFV03Qrn0qPmJi89EuOXsbBhkZXJRXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Using the latest git version of qemu and usb-tablet.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi all,

Currently, I use the latest git version of qemu, see following for detail:

$ qemu-system-x86_64 --version
QEMU emulator version 2.9.90 (v2.10.0-rc0-29-ga588c4985e-dirty)
Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
$

On my Debian Stretch host, I installed the macOS Sierra 10.12.6 as the
guest with qemu/kvm  based on the instructions here:

https://github.com/kholia/OSX-KVM

And I started the qemu with the following option:

  -device usb-tablet

With the above methods, I already can move the mouse through the host
and guest seamlessly.

Please note, I don't install the "Driver for Qemu's usb-tablet
absolute pointing device" in the guest OS.

As you can see from my above description, I don't install the
following driver on the guest:
http://philjordan.eu/osx-virt/binaries/QemuUSBTablet-1.2.pkg, but
still I can obtain the corresponding effect.

So, my issue is:  When using the latest git version of qemu, is it
still need to install this driver or not?

Regards
-- 
Hongsheng Zhao <hongyi.zhao@gmail.com>
Institute of Semiconductors, Chinese Academy of Sciences
GnuPG DSA: 0xD108493

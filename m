Received: from eggs.gnu.org ([2001:4830:134:3::10]:33711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alegend45@gmail.com>) id 1diVfA-0007vZ-NU
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 21:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alegend45@gmail.com>) id 1diVf9-0004XE-E5
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 21:01:24 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alegend45@gmail.com>) id 1diVf9-0004X0-9P
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 21:01:23 -0400
Received: by mail-qt0-x242.google.com with SMTP id t37so7741319qtg.2
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 18:01:21 -0700 (PDT)
MIME-Version: 1.0
From: Darius Goad <alegend45@gmail.com>
Date: Thu, 17 Aug 2017 20:01:00 -0500
Message-ID: <CAMM1KhhxQg8H8uYeGEHpXYgE=iTRyhik7pU+MdRr7HL6utpREg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] nVidia emulation in QEMU?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello. I'm Melissa, a trans woman who is the main developer of the nVidia
emulation code for 86Box. I'm interested in porting this code over to QEMU
as QEMU has higher compatibility with newer operating systems, as well as
expanding the developer base for nVidia graphics card emulation.

The 86Box code currently only handles the RIVA 128, the RIVA TNT, and a few
versions of the RIVA TNT2, and in a very incomplete state at that. I have
not been able to progress further due to the fact that 86Box's support of
modern Linux operating systems is poor, and due to the lack of a debugger
in 86Box.

I do need some help, however, as QEMU's code structure is not my strong
suit.

Anyway, my code is here:
https://github.com/MoochMcGee/86Box-experimental/blob/experimental/src/VIDEO/vid_nv_riva128.c

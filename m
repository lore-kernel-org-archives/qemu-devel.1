Received: from eggs.gnu.org ([2001:4830:134:3::10]:50028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cmvmb-0001nn-Uc
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 00:11:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cmvmY-0001J8-GR
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 00:11:05 -0500
Received: from mail-io0-x22d.google.com ([2607:f8b0:4001:c06::22d]:34955)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1cmvmX-0001Iy-VI
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 00:11:02 -0500
Received: by mail-io0-x22d.google.com with SMTP id z13so68945086iof.2
	for <qemu-devel@nongnu.org>; Sat, 11 Mar 2017 21:11:00 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <22858FDC-B303-45A6-803D-C3F9DDCC931D@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Sun, 12 Mar 2017 00:10:56 -0500
Subject: [Qemu-devel] Risu and the PowerPC 970
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>

Does Risu support the PowerPC 970? I tried compiling it but I saw  
this error:

gcc  -Wall -D_GNU_SOURCE -DARCH=ppc64 -g  -o risu.o -c risu.c
In file included from risu.c:29:
risu.h:27:30: error: risu_reginfo_ppc64.h: No such file or directory
make: *** [Makefile:44: risu.o] Error 1

The PowerPC 970 is a 64-bit PowerPC CPU.

My configure line:
ARCH=ppc64 ./configure

I cloned Risu from here:
https://git.linaro.org/people/peter.maydell/risu.git

Received: from eggs.gnu.org ([209.51.188.92]:45423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hKvpJ-0006zk-0W
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 22:15:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hKvpD-0002yh-7Y
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 22:15:25 -0400
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f]:36006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1hKvp8-0002xT-Jq
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 22:15:20 -0400
Received: by mail-io1-xd2f.google.com with SMTP id d19so7670973ioc.3
	for <qemu-devel@nongnu.org>; Sun, 28 Apr 2019 19:15:17 -0700 (PDT)
Received: from [192.168.0.2] (d14-69-20-184.try.wideopenwest.com.
	[69.14.184.20]) by smtp.gmail.com with ESMTPSA id
	e19sm9463643ioc.13.2019.04.28.19.15.15 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 28 Apr 2019 19:15:15 -0700 (PDT)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <47019F45-9440-44BF-BFEF-0A35F7F230E3@gmail.com>
Date: Sun, 28 Apr 2019 22:15:13 -0400
Subject: [Qemu-devel] Apple Hypervisor - unimplemented handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

When running Windows 7 using "-M accel=3Dhvf --cpu host", Windows 7 =
would crash. What was printed to the console was this:

Unimplemented handler (fffff8000c0c2050) for 0 (f c3)=20

This message is from target/i386/hvf/x86_emu.c. The c3 seems to indicate =
this is a problem with the MOVNTI or RETN instruction.

This is the webpage I used for figuring out this: =
http://ref.x86asm.net/coder32.html. A search of the page shows another =
instruction with the c3 opcode called RETN. So I'm not 100% sure which =
instruction is the problem instruction.

In the file target/i386/hvf/x86_decode.c, this line of code makes me =
think it is RETN:

{0xc3, X86_DECODE_RET_NEAR, 0, false, NULL,
     NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE}

Any help with this issue would be appreciated.

Thank you.=

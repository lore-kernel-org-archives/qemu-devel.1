Received: from eggs.gnu.org ([209.51.188.92]:51285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dhruv.agarwal_ug19@ashoka.edu.in>)
	id 1giHy1-0003sE-Cm
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 07:00:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dhruv.agarwal_ug19@ashoka.edu.in>)
	id 1giHy0-0000gp-F0
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 07:00:45 -0500
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933]:42663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dhruv.agarwal_ug19@ashoka.edu.in>)
	id 1giHy0-0000gB-0Q
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 07:00:44 -0500
Received: by mail-ua1-x933.google.com with SMTP id d21so5603633uap.9
	for <qemu-devel@nongnu.org>; Sat, 12 Jan 2019 04:00:43 -0800 (PST)
MIME-Version: 1.0
From: Dhruv Agarwal <dhruv.agarwal_ug19@ashoka.edu.in>
Date: Sat, 12 Jan 2019 17:30:31 +0530
Message-ID: <CADKdUyQad_gm_z0GJC+XNV4EOw+U8Fb8uBHc-8=9pzTmBf+cpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] QEMU 3.1 - Getting Instruction Traces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Dear Developers,

I am an undergraduate student trying to generate *a trace of all
instructions executed by the QEMU ARM emulator when it runs a given binary*.

I have been using the* following command* (from an out-of-tree build from
source code):
arm-linux-user/qemu-arm -d in_asm ~/Desktop/hello
(hello is the name of my binary cross-compiled for ARM
using gcc-arm-none-eabi on an x86 host machine).

By doing this, I do get a list of translation blocks that are executed by
the emulator, however I was told by a colleague that this trace/log is
incomplete because of the following reason: the translation blocks already
in the translation cache are not translated again, and hence are not logged
to the screen by QEMU.

Hence, I am now stuck and r*equire a way to generate a complete instruction
trace of all instructions that are executed by the ARM emulator for a given
binary*. Has anyone done the same earlier and can guide me on how to get
this trace?

Thank you and best regards,
Dhruv

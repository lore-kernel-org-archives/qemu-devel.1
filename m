Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22A3C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 08:21:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9995A20863
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 08:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9995A20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48743 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT01d-0003iW-TQ
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 04:21:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hT00n-0003P7-Iq
	for qemu-devel@nongnu.org; Tue, 21 May 2019 04:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hT00l-0001Ql-0l
	for qemu-devel@nongnu.org; Tue, 21 May 2019 04:20:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hT00g-0001Ef-Uu
	for qemu-devel@nongnu.org; Tue, 21 May 2019 04:20:35 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9093E7F746;
	Tue, 21 May 2019 08:20:17 +0000 (UTC)
Received: from localhost (ovpn-117-188.ams2.redhat.com [10.36.117.188])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7EFF61001DE9;
	Tue, 21 May 2019 08:20:11 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: <qemu-devel@nongnu.org>
Date: Tue, 21 May 2019 09:20:10 +0100
Message-Id: <20190521082010.29756-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Tue, 21 May 2019 08:20:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH qemu-web] Add a blog post about micro:bit
 emulation
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>, jim@groklearning.com,
	qemu.ml@steffen-goertz.de, joel@jms.id.au,
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU 4.0 ships the core micro:bit emulation that was implemented during
Outreachy and GSoC 2018.  This blog posts explains how to use it and
describes the current status.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 _posts/2019-05-21-microbit.md | 132 ++++++++++++++++++++++++++++++++++
 screenshots/makecode.png      | Bin 0 -> 55960 bytes
 2 files changed, 132 insertions(+)
 create mode 100644 _posts/2019-05-21-microbit.md
 create mode 100644 screenshots/makecode.png

diff --git a/_posts/2019-05-21-microbit.md b/_posts/2019-05-21-microbit.m=
d
new file mode 100644
index 0000000..333a336
--- /dev/null
+++ b/_posts/2019-05-21-microbit.md
@@ -0,0 +1,132 @@
+---
+layout: post
+title:  "QEMU 4.0 adds micro:bit emulation support"
+date:   2019-05-21 07:45:00 +0200
+categories: ['qemu 4', microbit, gsoc, outreachy, internships]
+---
+[micro:bit](http://microbit.org/) emulation support is available from QE=
MU 4.0
+onwards and can be used for low-level software testing and development. =
 Unlike
+existing micro:bit simulators, QEMU performs full-system emulation and a=
ctually
+runs the same ARM code as the real hardware.  This blog post explains wh=
at
+full-system emulation means and why QEMU is now a useful tool for develo=
ping
+micro:bit software.
+
+The [micro:bit is a tiny ARM board](https://tech.microbit.org/hardware/)
+designed for teaching.  It is increasingly being used around the world t=
o
+expose children to computers, programming, and electronics in a low-cost=
 way
+with an active online community that shares project ideas, lesson plans,=
 and
+programming tips.
+
+![micro:bit board](https://pxt.azureedge.net/blob/12e4685e5f24df67255a24=
2bccb4d1c8e1395e5f/static/courses/csintro/making/microbit-board.png)
+
+## Simulators and emulators
+*Simulators* are used for many tasks from mobile app development to
+performance analysis of computer hardware.  It is possible to develop co=
de
+using a simulator without having access to real hardware.  Oftentimes us=
ing a
+simulator is more convenient than flashing and debugging programs on rea=
l
+hardware.
+
+*Emulators* allow programs written for one computer system to run on a
+different computer system.  They use techniques like [machine code
+interpreters](https://en.wikipedia.org/wiki/Interpreter_%28computing%29)=
 and
+[just-in-time
+compilers](https://en.wikipedia.org/wiki/Just-in-time_compilation) to ex=
ecute
+guest programs that do not run natively on the host computer.  Each CPU
+instruction must be correctly implemented by the emulator so it can run =
guest
+software.
+
+## How existing micro:bit simulators work
+Simulators can be implemented at various layers in the software stack.  =
The
+[MakeCode editor](https://makecode.microbit.org/#editor) for JavaScript
+development includes a micro:bit simulator:
+
+![MakeCode editor](/screenshots/makecode.png)
+
+This simulator does not execute any ARM code and is therefore not runnin=
g
+the same CPU instructions as a real micro:bit.  Instead it reuses the Ja=
vaScript
+engine already available in your web browser to execute micro:bit JavaSc=
ript
+programs.  This is achieved by providing the micro:bit JavaScript APIs t=
hat
+micro:bit programs expect.  The programs don't need to know whether thos=
e APIs
+are implemented by the real micro:bit software stack or whether they are
+actually calling into the MakeCode simulator.
+
+In the screenshot above the micro:bit program calls `showString("Hello
+world!")` and this becomes a call into the MakeCode simulator code to
+render images of LEDs in the web browser.  On real hardware the code pat=
h is
+different and eventually leads to an LED matrix driver that lights
+up the LEDs by driving output pins on the micro:bit board.
+
+## Full-system emulation
+Unlike the MakeCode simulator, QEMU emulates the micro:bit CPU and boots
+from the same ARM code as the real micro:bit board.  The simulation happ=
ens at
+the CPU instruction and hardware interface level instead of at the JavaS=
cript
+API level.  This is called *full-system emulation* because the entire
+guest software environment is present.
+
+What are the advantages of full-system emulation?
+* Programs written in any language can run (MicroPython, mbed C/C++, etc=
)
+* Boot, device driver, and language runtime code can be tested
+* Bugs in lower layers of the software stack can be reproduced
+* CPU architecture-specific bugs can be reproduced (stack and memory cor=
ruption bugs)
+* A debugger can be connected to inspect the entire software stack
+
+The main disadvantage of full-system emulation is that the performance
+overhead is higher since simulation happens at the CPU instruction level=
.
+Programs consist of many CPU instructions so the task of emulation is
+performance-sensitive.  Luckily the micro:bit's CPU is much less powerfu=
l than
+CPUs available in our laptops and desktops, so programs execute at a rea=
sonable
+speed.
+
+## Running micro:bit programs on QEMU
+QEMU emulates the core devices on the micro:bit, including the serial po=
rt
+(UART) and timers.  This is enough for developing and testing low-level
+software but does not offer the LEDs, radio, and other devices that most
+micro:bit programs rely on.  These devices might be emulated by QEMU in =
the
+future, but for now the main use of QEMU is for developing and testing
+low-level micro:bit code.
+
+To run `test.hex`:
+```shell
+$ qemu-system-arm -M microbit -device loader,file=3Dtest.hex -serial std=
io
+```
+
+Any output written to the serial port is printed to the terminal by QEMU=
.
+
+## Debugging micro:bit programs with QEMU and GDB
+QEMU has GDB guest debugging support.  This means GDB can connect to QEM=
U in
+order to debug the guest software.  This is similar to debugging a real =
system
+over JTAG, except no hardware is necessary!
+
+Connect with GDB to debug the guest:
+```
+$ qemu-system-arm -M microbit -device loader,file=3Dtest.hex -s
+$ gdb
+(gdb) target remote tcp:127.0.0.1:1234
+(gdb) x/10i $pc
+=3D> 0x161c4:	ldr	r3, [r4, #0]
+   0x161c6:	cmp	r3, #0
+   0x161c8:	beq.n	0x161d2
+   0x161ca:	ldr	r3, [pc, #48]	; (0x161fc)
+   0x161cc:	ldr	r3, [r3, #0]
+   0x161ce:	cmp	r3, #0
+   0x161d0:	bne.n	0x161d8
+   0x161d2:	movs	r0, #6
+   0x161d4:	bl	0x16160
+   0x161d8:	ldr	r0, [r4, #0]
+```
+
+Having a debugger is very powerful.  QEMU can also load ELF files in
+addition to the popular .hex files used for micro:bit programs.  ELF fil=
es can
+contain debugging information that enables source-level debugging so GDB=
 can
+display function and variable names as well as listing the source code i=
nstead
+of showing assembly instructions.
+
+## Conclusion
+QEMU now offers a platform for developing and testing micro:bit programs=
.
+It is open to future extension, hopefully to emulate more devices and of=
fer
+a graphical user interface.
+
+micro:bit emulation was contributed by Julia Suvorova and Steffen G=C3=B6=
rtz as
+part of their Outreachy and Google Summer of Code internships with QEMU.=
  Jim
+Mussared, Joel Stanley, and Stefan Hajnoczi acted as mentors and contrib=
uted
+patches as well.
diff --git a/screenshots/makecode.png b/screenshots/makecode.png
new file mode 100644
index 0000000..f675768
Binary files /dev/null and b/screenshots/makecode.png differ
--=20
2.21.0



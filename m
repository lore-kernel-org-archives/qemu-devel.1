Received: from eggs.gnu.org ([2001:4830:134:3::10]:51202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cd1cd-0000Gw-9p
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 16:23:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cd1cc-0007JM-3k
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 16:23:51 -0500
MIME-Version: 1.0
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Sun, 12 Feb 2017 22:23:28 +0100
Message-ID: <CACXAS8CBg-tuCeuv0GKwjbDKASUTQjr44R9fuZHr7XaPVTKm6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] AIX KDB under 40p
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org, =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>

With -cpu 601 it's slow, but interesting:

qemu-system-ppc -M 40p -bios p12h0456.img -hda aix-5.1-cd1.iso -cpu 601

^^^ -cpu 601 is crucial. With the default CPU (604) it just hangs
after a greeting.

 And after 90 minutes,  on the serial line....

AIX Version pinmore.c, s.@(#)65 1.1
Instruction Storage Interrupt - PROC
[kdb_get_virtual_memory] no real storage @ 646E6D60
KDB(0)> f
pvthread+000000 STACK:
WARNING: bad IAR: 646E6D60, display stack from LR: 646E6D5D
KDB(0)>
KDB(0)> dr
r0  : 00000000  r1  : 00595910  r2  : 00595C58  r3  : 00000001  r4  : 01C08180
r5  : 00000000  r6  : 00000000  r7  : 00000000  r8  : 00000000  r9  : 00000000
r10 : 00000000  r11 : 00000000  r12 : 646E6D61  r13 : 00606178  r14 : 000000B8
r15 : 00000020  r16 : 00000020  r17 : 0803004D  r18 : 005AF0BC  r19 : 003FED04
r20 : 00606178  r21 : 00000020  r22 : 00606000  r23 : 00003F50  r24 : 00003F48
r25 : 00003F3C  r26 : 00000000  r27 : 63683A2C  r28 : 00003A24  r29 : 00003A20
r30 : 00590C70  r31 : 00000000
KDB(0)>



-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu

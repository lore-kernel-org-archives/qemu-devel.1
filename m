Received: from eggs.gnu.org ([2001:4830:134:3::10]:33999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <adeelbm@outlook.com>) id 1cLzYy-0002mq-78
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 16:45:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <adeelbm@outlook.com>) id 1cLzYv-0004uI-4y
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 16:45:40 -0500
Received: from bay004-omc3s2.hotmail.com ([65.54.190.140]:65355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <adeelbm@outlook.com>) id 1cLzYu-0004r3-By
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 16:45:36 -0500
From: Adeel Mujahid <adeelbm@outlook.com>
Date: Tue, 27 Dec 2016 21:45:32 +0000
Message-ID: <DB6PR0401MB2613DAE7BA80EA45AA90C416BA690@DB6PR0401MB2613.eurprd04.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Question - Is precise assembly code transpilation
 possible?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hello,


[sorry in advance -- this is bit of an off-topic / academic question w.r.t =
qemu-devel]


Given the userspace virtualization capability of qemu, is it possible to sh=
ip the code that deals with source-to-source mapping of assembly code (say =
MIPS64 <-> AMD64) as a separate library, so we can potentially build assemb=
ly language converter utility?


For instance, consider a C/C++ project with couple of .asm/.S files contain=
ing Intel or ATT flavored assembly code for AMD64, and the aim is to port t=
o AARCH64 -- is it even a deterministic problem to transpile precise and bu=
g free AARCH64 assembly code, given the full usage context and all code pat=
hs at our disposal? In my understanding, qemu is doing something very simil=
ar; but I am not sure as there might be missing optimization opportunities,=
 which render machine converted asm code less likely to match the one hand-=
roled by humans.


To this date, there are not many tools for assembly language, that convert =
between different dialects (ATT to Intel) or various architecture instructi=
on sets. I have heard that LLVM has certain project, which aim to convert a=
smA -> via IR -> asmB but I haven't found it yet.


-- best

Adeel

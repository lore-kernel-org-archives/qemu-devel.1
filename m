Received: from eggs.gnu.org ([209.51.188.92]:44783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lucienmp_antispam@yahoo.com>) id 1gmL7p-0008Eg-60
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:11:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lucienmp_antispam@yahoo.com>) id 1gmL7n-00048s-QX
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:11:37 -0500
Received: from sonic313-10.consmr.mail.ne1.yahoo.com ([66.163.185.33]:39726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lucienmp_antispam@yahoo.com>)
	id 1gmL7j-00040z-UT
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:11:35 -0500
Date: Wed, 23 Jan 2019 15:58:27 +0000 (UTC)
From: Lucien Anti-Spam <lucienmp_antispam@yahoo.com>
Message-ID: <251451940.431966.1548259107629@mail.yahoo.com>
MIME-Version: 1.0
References: <251451940.431966.1548259107629.ref@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] m68k gdb has stopped single stepping correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi folks,
I noticed that with 3.x release that the GDB options (-S -s) for certain CP=
U results in very weird stepping.Usually stops afer a few steps, whilst the=
 stub continues responding the PC doesnt update, however,=C2=A0I have only =
deeply looked at the m68k.
In the case of the m68K the SR gets the trace bit set (T=3D10b), and the PC=
 doesnt update.The m68k gdbstub, and main gdbstub seem mostly unchanged.But=
 it seems the INSN handling has changed greatly for the m68k.
Does anyone have any ideas what happened?
Cheers,Luc

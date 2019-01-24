Received: from eggs.gnu.org ([209.51.188.92]:48263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lucienmp_antispam@yahoo.com>) id 1gmebv-0000Op-Kn
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:00:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lucienmp_antispam@yahoo.com>) id 1gmebu-0007xh-GU
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:59:59 -0500
Received: from sonic311-21.consmr.mail.ne1.yahoo.com ([66.163.188.202]:36898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lucienmp_antispam@yahoo.com>)
	id 1gmebu-0007wu-AJ
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:59:58 -0500
Date: Thu, 24 Jan 2019 12:59:54 +0000 (UTC)
From: Lucien Anti-Spam <lucienmp_antispam@yahoo.com>
Message-ID: <70145779.391347.1548334794441@mail.yahoo.com>
In-Reply-To: <20190123180804.GA1040@flamenco>
References: <251451940.431966.1548259107629.ref@mail.yahoo.com>
	<251451940.431966.1548259107629@mail.yahoo.com>
	<20190123180804.GA1040@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] m68k gdb has stopped single stepping correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

=20

   > On Thursday, January 24, 2019, 3:08:07 AM GMT+9, Emilio G. Cota <cota@=
braap.org> wrote: > > On Wed, Jan 23, 2019 at 15:58:27 +0000, Lucien Anti-S=
pam via Qemu-devel wrote:> > Hi folks,
> > I noticed that with 3.x release that the GDB options (-S -s) for certai=
n CPU results in very weird stepping.Usually stops afer a few steps, whilst=
 the stub continues responding the PC doesnt update, however,=C2=A0I have o=
nly deeply looked at the m68k.
> > In the case of the m68K the SR gets the trace bit set (T=3D10b), and th=
e PC doesnt update.The m68k gdbstub, and main gdbstub seem mostly unchanged=
.But it seems the INSN handling has changed greatly for the m68k.
> > Does anyone have any ideas what happened?>> Can you please bisect to fi=
nd at which point things start misbehaving?
>=C2=A0
> Thanks,
>=C2=A0 Emilio
Understood, I was hoping my original post might jog someone's memory about =
the issue.=C2=A0=C2=A0
Apparently not, so after some digging I found that it was introduced with t=
he refactor to TranslatorOps, specifically two lines got dropped that updat=
e the PC if single-stepping is being performed (=C2=A0commit 11ab74b01e0a8e=
a4973eed89c6b90fa6e4fb9fb6 )
Since its not valid to revert, shall I go ahead and submit a patch for thes=
e two lines?
Also I noticed a lack of gdb-stub tests, but there are cpu tests (eg.=C2=A0=
check-qtest-m68k).=C2=A0 I was considering it might be interesting to write=
 some basic network code to send / receive=C2=A0gdb packets to re-use these=
 cpu tests for step, break-point, register update, and so on.
I saw a gdb-python test but I felt this would need specific kernel \ gdb fo=
r each cpu with is likely to end in a lot of problems getting right gdbs - =
simple packet send/receive/check would be better?
What do people think, what would be the right approach to this?

Cheers,Luc

 =20

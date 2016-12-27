Received: from eggs.gnu.org ([2001:4830:134:3::10]:53287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cLxGl-0003Qc-Bk
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 14:18:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cLxGi-0005qj-73
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 14:18:43 -0500
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=utf-8
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <CAK5BdwN8hXReei6YAUs=9OmNqF1DTxmH+q2BSuvUESWLf_1ABw@mail.gmail.com>
Date: Tue, 27 Dec 2016 14:18:37 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <7094FB37-03A9-4511-B4A6-519CDA1E6854@gmail.com>
References: <516AC28F-18A9-4FC9-8028-5AE2F37CB897@gmail.com>
	<C50D14FE-4C5D-4944-948B-09376B20FF16@gmail.com>
	<CAK5BdwOhfw2t=AYqs-Bu4sFJcRe4a-aq7k+2G-boLbV-P+5MyQ@mail.gmail.com>
	<5A9C1952-461A-4829-8916-C2F40EE8E5D8@gmail.com>
	<CAK5BdwN8hXReei6YAUs=9OmNqF1DTxmH+q2BSuvUESWLf_1ABw@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] PowerPC question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?0JTQvNC40YLRgNC40Lkg0KHQvNC40YDQvdC+0LI=?= <vave1313@gmail.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>, "list@suse.de:PowerPC list:PowerPC" <qemu-ppc@nongnu.org>


On Dec 27, 2016, at 2:16 PM, =D0=94=D0=BC=D0=B8=D1=82=D1=80=D0=B8=D0=B9 =
=D0=A1=D0=BC=D0=B8=D1=80=D0=BD=D0=BE=D0=B2 wrote:

> Unfortunately, I have to use version 2.5.1.1. Can I do something in =
this case?

Why do you need to use it? What is the guest operating system you are =
using? Version 2.8 has a lot more bug fixes in it. You might find it =
easier to use.

>=20
> 2016-12-27 22:01 GMT+03:00 G 3 <programmingkidx@gmail.com>:
> The version of qemu-system-ppc you are using is kind of old. Version =
2.8.0 is the newest version. I suggest trying the newest version before =
trying to fix a broken feature in an older version.
>=20
> http://wiki.qemu.org/Download
>=20
>=20
> On Dec 27, 2016, at 1:57 PM, =D0=94=D0=BC=D0=B8=D1=82=D1=80=D0=B8=D0=B9 =
=D0=A1=D0=BC=D0=B8=D1=80=D0=BD=D0=BE=D0=B2 wrote:
>=20
> qemu-system-ppc version: 2.5.1.1
>=20
> Ubuntu 14.04
> gcc version 4.8.4 (Ubuntu 4.8.4-2ubuntu1~14.04)
> GTK 2.0, libsdl1.2-dev
> ./configure --target-list=3D"ppc-softmmu" --disable-xfsctl
>=20
> By zero meaning, do you mean this: decr =3D 0
> Yes.
>=20
>=20
> 2016-12-27 21:16 GMT+03:00 G 3 <programmingkidx@gmail.com>:
> When I type 'info registers', I see 'DECR 3919147695' at the top of =
the screen, so it appears to be working. I think we need more =
information from you.
>=20
> qemu-system-ppc version:
>=20
> gcc version (gcc -v):
>=20
> Host info: Ubuntu <version>
>=20
> Front-end (GTK, SDL, ...):
>=20
> Compile command: ./configure ....
>=20
> Note: please respond to this email with "reply all". That way everyone =
can try to help you.
>=20
> On Dec 27, 2016, at 1:06 PM, =D0=94=D0=BC=D0=B8=D1=82=D1=80=D0=B8=D0=B9 =
=D0=A1=D0=BC=D0=B8=D1=80=D0=BD=D0=BE=D0=B2 wrote:
>=20
> All the registers, which are printing with 'info registers', dump to =
file before (./target-ppc/translate.c), but there is no SPR_DECR.
> I tried to add in 'translate.c' and ./monitor.c some code (print of =
cpu_ppc_load_decr(env), print of env->spr[SPR_DECR]), but I have zero =
meaning. Also I tried 'p $decr' with the same answer.
>=20
> By zero meaning, do you mean this: decr =3D 0
>=20
> Maybe I have this problem, because I using VirtualBox->Ubuntu->Qemu?
>=20
> This should not be a problem. An emulator can run anywhere.
>=20
>=20
> 2016-12-27 18:52 GMT+03:00 G 3 <programmingkidx@gmail.com>:
>=20
>=20
> On Dec 27, 2016, at 10:38 AM, qemu-ppc-request@nongnu.org wrote:
>=20
> Hello, devs!
>=20
> I'm using ppc-softmmu target, and in my qemu monitor I need to print =
the
> SPR_DECR meaning, but I don't understand how.
> Could anyone help me with my problem?
>=20
> Best regards!
>=20
> I think you want to try the 'info registers' command in the monitor.
>=20
>=20
>=20
>=20
>=20
>=20

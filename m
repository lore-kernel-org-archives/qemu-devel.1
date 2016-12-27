Received: from eggs.gnu.org ([2001:4830:134:3::10]:49377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cLwzq-0005tM-EJ
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 14:01:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cLwzn-0001NU-DN
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 14:01:14 -0500
In-Reply-To: <CAK5BdwOhfw2t=AYqs-Bu4sFJcRe4a-aq7k+2G-boLbV-P+5MyQ@mail.gmail.com>
References: <516AC28F-18A9-4FC9-8028-5AE2F37CB897@gmail.com>
	<C50D14FE-4C5D-4944-948B-09376B20FF16@gmail.com>
	<CAK5BdwOhfw2t=AYqs-Bu4sFJcRe4a-aq7k+2G-boLbV-P+5MyQ@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=UTF-8; delsp=yes; format=flowed
Message-Id: <5A9C1952-461A-4829-8916-C2F40EE8E5D8@gmail.com>
Content-Transfer-Encoding: quoted-printable
From: G 3 <programmingkidx@gmail.com>
Date: Tue, 27 Dec 2016 14:01:06 -0500
Subject: Re: [Qemu-devel] [Qemu-ppc] PowerPC question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0KHQvNC40YDQvdC+0LI=?= <vave1313@gmail.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>, "list@suse.de:PowerPC list:PowerPC" <qemu-ppc@nongnu.org>

The version of qemu-system-ppc you are using is kind of old. Version =20
2.8.0 is the newest version. I suggest trying the newest version =20
before trying to fix a broken feature in an older version.

http://wiki.qemu.org/Download

On Dec 27, 2016, at 1:57 PM, =D0=94=D0=BC=D0=B8=D1=82=D1=80=D0=B8=D0=B9 =
=D0=A1=D0=BC=D0=B8=D1=80=D0=BD=D0=BE=D0=B2 wrote:

> qemu-system-ppc version: 2.5.1.1
>
> Ubuntu 14.04
> gcc version 4.8.4 (Ubuntu 4.8.4-2ubuntu1~14.04)
> GTK 2.0, libsdl1.2-dev
> ./configure --target-list=3D"ppc-softmmu" --disable-xfsctl
>
> By zero meaning, do you mean this: decr =3D 0
> Yes.
>
>
> 2016-12-27 21:16 GMT+03:00 G 3 <programmingkidx@gmail.com>:
> When I type 'info registers', I see 'DECR 3919147695' at the top of =20=

> the screen, so it appears to be working. I think we need more =20
> information from you.
>
> qemu-system-ppc version:
>
> gcc version (gcc -v):
>
> Host info: Ubuntu <version>
>
> Front-end (GTK, SDL, ...):
>
> Compile command: ./configure ....
>
> Note: please respond to this email with "reply all". That way =20
> everyone can try to help you.
>
> On Dec 27, 2016, at 1:06 PM, =D0=94=D0=BC=D0=B8=D1=82=D1=80=D0=B8=D0=B9 =
=D0=A1=D0=BC=D0=B8=D1=80=D0=BD=D0=BE=D0=B2 wrote:
>
> All the registers, which are printing with 'info registers', dump =20
> to file before (./target-ppc/translate.c), but there is no SPR_DECR.
> I tried to add in 'translate.c' and ./monitor.c some code (print of =20=

> cpu_ppc_load_decr(env), print of env->spr[SPR_DECR]), but I have =20
> zero meaning. Also I tried 'p $decr' with the same answer.
>
> By zero meaning, do you mean this: decr =3D 0
>
> Maybe I have this problem, because I using VirtualBox->Ubuntu->Qemu?
>
> This should not be a problem. An emulator can run anywhere.
>
>
> 2016-12-27 18:52 GMT+03:00 G 3 <programmingkidx@gmail.com>:
>
>
> On Dec 27, 2016, at 10:38 AM, qemu-ppc-request@nongnu.org wrote:
>
> Hello, devs!
>
> I'm using ppc-softmmu target, and in my qemu monitor I need to =20
> print the
> SPR_DECR meaning, but I don't understand how.
> Could anyone help me with my problem?
>
> Best regards!
>
> I think you want to try the 'info registers' command in the monitor.
>
>
>
>

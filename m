Received: from eggs.gnu.org ([2001:4830:134:3::10]:38048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Aleksandar.Markovic@rt-rk.com>) id 1fb5Zt-0007ud-7q
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 10:49:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Aleksandar.Markovic@rt-rk.com>) id 1fb5Zq-0005Rc-3F
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 10:49:49 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:48426 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Aleksandar.Markovic@rt-rk.com>)
	id 1fb5Zp-0005Il-NK
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 10:49:46 -0400
from: "Aleksandar Markovic" <Aleksandar.Markovic@rt-rk.com>
date: Thu, 05 Jul 2018 16:49:41 +0200
MIME-Version: 1.0
message-id: <588b-5b3e3000-9-4af27280@234961430>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] =?utf-8?b?RndkOj89PT91dGYtOD9xPyBGdzogc29tZSB0aG91?=
 =?utf-8?q?ghts_on_nanoMIPS_solution?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org, qemu-devel@nongnu.org, Petar Jovanovic <Petar.Jovanovic@rt-rk.com>

> > Therefore, I think it makes sense to (more or less) split translate=
.c into,
> > let's say, following set of files:
> >
> >=C2=A0=C2=A0 * translate=5Fcmn=5Fchk.h - definitions of (typically i=
nlined) functions check=5FXXX()
> >=C2=A0=C2=A0 * translate=5Fcmn=5Fgen.h - declarations of gen=5FXXX()=
 family of functions, and
> >=C2=A0=C2=A0=C2=A0=C2=A0 definitions of such functions among them th=
at are inlined
> >=C2=A0=C2=A0 * translate=5Fcmn=5Fgen.c - definitions of non-inlined =
gen=5FXXX() functions
> >=C2=A0=C2=A0=C2=A0=C2=A0 (including all their callees)
> >
> >=C2=A0=C2=A0 * translate.h - common structure definitions such as Di=
sasContext
> >=C2=A0=C2=A0 * translate.c - the rest of=C2=A0code after splitting
> >
> >
> > The nanoMIPS code would be, in such organization, in a separate fil=
e:
> >
> >=C2=A0=C2=A0 * translate=5Fnanomips.c
>
> This sounds fine.=C2=A0 Thanks for being willing to tackle this.

I may submit something that attempts to be "the best of both worlds" be=
tween yours and mine alternative in next few days. Let's talk over the =
code. :)

Regards,
Aleksandar
=C2=A0@bn7pr08mb4868.namprd08.prod.outlook.com>

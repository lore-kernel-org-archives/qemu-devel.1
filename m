Received: from eggs.gnu.org ([209.51.188.92]:48983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1h2uCk-0006kE-P6
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1h2uCj-0003NR-PY
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:53:10 -0400
Received: from m12-17.163.com ([220.181.12.17]:52004)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1h2uCh-0003HX-Tu
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:53:09 -0400
MIME-Version: 1.0
From: Li Qiang <liq3ea@163.com>
Date: Sun, 10 Mar 2019 16:52:34 +0800
In-Reply-To: <20190309173756.GA1038@flamenco>
References: <5C8354E3.03C6BB.09225@m12-12.163.com>
	<20190309173756.GA1038@flamenco>
Message-Id: <5C84D065.DEF7BE.23880@m12-17.163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] =?utf-8?b?562U5aSNOiAnbWFrZSBjaGVjaycgZXJyb3I=?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Thanks Emilio,
I found the ssh connection is very slow and the submodule wasn=E2=80=99t ch=
ecked out completely.
I uses the https connection and it works as normal.

Thanks,
Li Qiang

=E5=8F=91=E4=BB=B6=E4=BA=BA: Emilio G. Cota
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2019=E5=B9=B43=E6=9C=8810=E6=97=A5 1:=
38
=E6=94=B6=E4=BB=B6=E4=BA=BA: Li Qiang
=E6=8A=84=E9=80=81: qemu-devel@nongnu.org
=E4=B8=BB=E9=A2=98: Re: 'make check' error

On Sat, Mar 09, 2019 at 13:53:32 +0800, Li Qiang wrote:
> Hi all,=20
>=20
> Today I =E2=80=98git clone=E2=80=99 && configure && make && make check=20
>=20
> And get following error,=20
>=20
> fp-test.c:50:10: fatal error: fail.h: No such file or directory
>  #include "fail.h"
>           ^~~~~~~~
>=20
> I look at the commit:
> https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D3ac1f81329f4dfdc10a=
51e180f9cf28dbcb02a3c;hp=3Db44b5abeae4a3b54ccbd7137f59c0a8923cecec9
>=20
> Seems it=E2=80=99s old commit, I think I got =E2=80=98make check=E2=80=99=
 work after this commit.
> So I don=E2=80=99t know anywhere wrong.
>=20
> Any hints?

fail.h is part of berkeley-testfloat-3 -- I suspect the
berkeley-testfloat-3 git submodule wasn't checked out.

Make sure both berkeley-softfloat-3 and berkeley-testfloat-3 are
checked out at $src/tests/fp. If not, you can get them with
"git submodule init && git submodule update".

Hope that helps,

		Emilio

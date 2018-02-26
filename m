Received: from eggs.gnu.org ([2001:4830:134:3::10]:40445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eqHVi-0008I6-H4
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:04:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eqHVc-00020j-QX
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:04:02 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41278 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eqHVc-00020V-Lz
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:03:56 -0500
Date: Mon, 26 Feb 2018 12:03:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180226120344.GN14196@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1519344729-73482-1-git-send-email-mjc@sifive.com>
	<20180223101032.GA31076@redhat.com>
	<CAHNT7NvMMAD6sAT60RnLgFXwdFPWHEXtysMQt04Qejnpw30Bkg@mail.gmail.com>
	<20180226104723.GH14196@redhat.com>
	<CAFEAcA_Gwh3EpVVhZ_zU3LuogZXjh8cpRWrvtHbNdfgQmdzgJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_Gwh3EpVVhZ_zU3LuogZXjh8cpRWrvtHbNdfgQmdzgJg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 00/23] RISC-V QEMU Port Submission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Clark <mjc@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On Mon, Feb 26, 2018 at 11:57:10AM +0000, Peter Maydell wrote:
> On 26 February 2018 at 10:47, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> > I accept that MIT is compatible with GPLv2+, so that's not an immedia=
te legal
> > problem. The issue is that as we add more & more different licenses t=
o QEMU,
> > it becomes a maintenance burden to developers, especially when doing =
code
> > refactoring across files. You have to be careful you're not taking a =
piece
> > of GPLv2+ code and copying/moving it into a file that's MIT licensed,=
 as
> > that would be non-compliant. We already suffer this problem with our =
mixture
> > of GPLv2-only and GPLv2+ and LGPLv2+ and BSD licensed code. So I'm pe=
rsonally
> > loathe to see us add yet another license to the mix.
>=20
> Unless I'm confused, we already have a lot of MIT-licensed code in the =
tree,
> including much of the block layer, accel/tcg, the audio subsystem. Look=
ing
> at vl.c, it was put under the MIT license by Fabrice in 2003, so we've
> been living with it as part of our licensing mix for a very long time a=
lready.

Eeek, I totally missed that as the top level LICENSE file only mentions
GPL and BSD licenses :-(  I guess that's a trigger for a patch to improve
the text in the LICENSE file to better reflect reality...

So I guess you can ignore my comments in this thread about MIT license
being different from normal practice in QEMU.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

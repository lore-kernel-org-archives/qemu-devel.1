Received: from eggs.gnu.org ([2001:4830:134:3::10]:58402)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<SRS0=oT7+=7O=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
	id 1dgUbm-0002Zr-Lx
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 07:29:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<SRS0=oT7+=7O=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
	id 1dgUbh-0005ez-Mg
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 07:29:34 -0400
Received: from sonata.ens-lyon.org ([140.77.166.138]:52816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from
	<SRS0=oT7+=7O=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
	id 1dgUbh-0005eP-FQ
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 07:29:29 -0400
Date: Sat, 12 Aug 2017 13:29:25 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170812112925.mpi2mmewt46wna7j@var.youpi.perso.aquilenet.fr>
References: <35BC0F0B-7CB0-424C-86EA-2B5D8E219634@gmail.com>
	<20170811215845.n667iobglz5cef3z@var.youpi.perso.aquilenet.fr>
	<CAFEAcA_XrnDxZLhX5FGFBh+Mh-_80z3Z6b+0LkmQuoWzrWK0tA@mail.gmail.com>
	<20170812110410.rosk6yhkj22w346s@var.youpi.perso.aquilenet.fr>
	<CAFEAcA-N5pAM+3PXvjaJ-LMPFswAtmkAXA6yn151CCtfn+=JQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-N5pAM+3PXvjaJ-LMPFswAtmkAXA6yn151CCtfn+=JQA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] SLIRP warning messages displayed while compiling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Programmingkid <programmingkidx@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

Peter Maydell, on sam. 12 ao=C3=BBt 2017 12:18:16 +0100, wrote:
> On 12 August 2017 at 12:04, Samuel Thibault <samuel.thibault@gnu.org> w=
rote:
> > Peter Maydell, on sam. 12 ao=C3=BBt 2017 11:53:20 +0100, wrote:
> >> The utility of the warning is that it means you get told
> >> about stuff that might break on other architectures.
> >
> > Sure, I understand that. But here all fields are aligned on their siz=
e
> > inside the packed structure. So there can't be alignment issues, and =
the
> > compiler should be able to determine that.
>=20
> Alignment is architecture-dependent, and the compiler
> can't know the alignment requirements for every
> architecture.

Sure.

> There's no rule in C that says that uint16_t only needs 2 byte
> alignment and not 4 on some hosts.

Are there really systems where that happens?  Such systems would have to
pad uint16_t arrays then, really?

> (Also I just noticed 'struct ip6' uses bitfields:
> that's badly non-portable if it's trying to
> match an on-the-wire layout.)

struct ip has been doing so for so long too.

I'm not saying the code is perfectly portable, I'm just saying it's
portable enough for being both practical and readable.

Samuel

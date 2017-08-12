Received: from eggs.gnu.org ([2001:4830:134:3::10]:34725)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<SRS0=oT7+=7O=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
	id 1dgUtD-0003gB-Nu
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 07:47:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<SRS0=oT7+=7O=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
	id 1dgUt9-0007iq-PS
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 07:47:35 -0400
Received: from sonata.ens-lyon.org ([140.77.166.138]:52941)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from
	<SRS0=oT7+=7O=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
	id 1dgUt9-0007hw-IQ
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 07:47:31 -0400
Date: Sat, 12 Aug 2017 13:47:28 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170812114728.cnikfuyke5dbrake@var.youpi.perso.aquilenet.fr>
References: <35BC0F0B-7CB0-424C-86EA-2B5D8E219634@gmail.com>
	<20170811215845.n667iobglz5cef3z@var.youpi.perso.aquilenet.fr>
	<CAFEAcA_XrnDxZLhX5FGFBh+Mh-_80z3Z6b+0LkmQuoWzrWK0tA@mail.gmail.com>
	<20170812110410.rosk6yhkj22w346s@var.youpi.perso.aquilenet.fr>
	<CAFEAcA-N5pAM+3PXvjaJ-LMPFswAtmkAXA6yn151CCtfn+=JQA@mail.gmail.com>
	<20170812112925.mpi2mmewt46wna7j@var.youpi.perso.aquilenet.fr>
	<60ba7c95-8989-13bb-3aaf-ac9a8389320f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60ba7c95-8989-13bb-3aaf-ac9a8389320f@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Programmingkid <programmingkidx@gmail.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Jan Kiszka <jan.kiszka@siemens.com>

Eric Blake, on sam. 12 ao=C3=BBt 2017 06:41:30 -0500, wrote:
> Here's an idea:  Instead of using struct ip6 { ... } QEMU_PACKED, use
>=20
> struct ip6 {
> ...
> };
> QEMU_BUG_ON(sizeof(struct ip6) !=3D 32);

That's an interesting way indeed.  I however wonder whether there may be
not-so-uncommon systems where the compiler aligns some fields just for
performance or such.

Samuel

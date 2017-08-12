Received: from eggs.gnu.org ([2001:4830:134:3::10]:52793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dgUDJ-0002RG-G3
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 07:04:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dgUDI-0005DB-L3
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 07:04:17 -0400
Received: from [2a01:474::1] (port=36870 helo=hera.aquilenet.fr)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1dgUDI-0005A3-Ei
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 07:04:16 -0400
Date: Sat, 12 Aug 2017 13:04:10 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170812110410.rosk6yhkj22w346s@var.youpi.perso.aquilenet.fr>
References: <35BC0F0B-7CB0-424C-86EA-2B5D8E219634@gmail.com>
	<20170811215845.n667iobglz5cef3z@var.youpi.perso.aquilenet.fr>
	<CAFEAcA_XrnDxZLhX5FGFBh+Mh-_80z3Z6b+0LkmQuoWzrWK0tA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_XrnDxZLhX5FGFBh+Mh-_80z3Z6b+0LkmQuoWzrWK0tA@mail.gmail.com>
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

Peter Maydell, on sam. 12 ao=C3=BBt 2017 11:53:20 +0100, wrote:
> The utility of the warning is that it means you get told
> about stuff that might break on other architectures.

Sure, I understand that. But here all fields are aligned on their size
inside the packed structure. So there can't be alignment issues, and the
compiler should be able to determine that.

Samuel

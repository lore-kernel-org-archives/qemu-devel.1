Received: from eggs.gnu.org ([2001:4830:134:3::10]:37951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eUdvF-00040x-JL
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 14:33:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eUdvC-0007mF-F4
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 14:32:57 -0500
Received: from [2a01:474::1] (port=59162 helo=hera.aquilenet.fr)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1eUdvC-0007jy-62
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 14:32:54 -0500
Date: Thu, 28 Dec 2017 20:32:47 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20171228193247.gcndffotjjterju3@var.youpi.perso.aquilenet.fr>
References: <20171228141104.15198-1-samuel.thibault@ens-lyon.org>
	<189dec5d-6408-31d6-1df8-52e3397c8a98@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <189dec5d-6408-31d6-1df8-52e3397c8a98@vivier.eu>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] linux-user: Fix sched_get/setaffinity
 conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>

Laurent Vivier, on jeu. 28 d=C3=A9c. 2017 18:50:14 +0100, wrote:
> > +                    for (j =3D 0; j < abi_ubits; j++, bit++) {
> > +                        if (mask[bit / ubits] & (1UL << (bit % ubits=
))) {
>=20
> You should use __CPUMASK() and introduce a TARGET_CPUMASK().

Err, do we really want to use such insides of glibc?

Samuel

Received: from eggs.gnu.org ([2001:4830:134:3::10]:47395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fPeAH-0006DY-8b
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 21:20:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fPeAD-0003Jz-4r
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 21:20:05 -0400
Date: Mon, 4 Jun 2018 10:43:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180604004307.GD4251@umbus>
References: <152568372989.443627.900708381919207053.stgit@bahia.lan>
	<71b68bd5-e50b-3baa-3f72-f6af78db4e2e@redhat.com>
	<20180508113425.003c5031@bahia.lan>
	<CAFEAcA8bbdzEPZLA1sTXH-eGeOPUZw8f=p3_a9c4ERq35+mDew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SO98HVl1bnMOfKZd"
Content-Disposition: inline
In-Reply-To: <CAFEAcA8bbdzEPZLA1sTXH-eGeOPUZw8f=p3_a9c4ERq35+mDew@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] ppc: e500: use g_strdup_printf() instead
 of snprintf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Howard Spoelstra <hsp.cat7@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>


--SO98HVl1bnMOfKZd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 08, 2018 at 12:01:59PM +0100, Peter Maydell wrote:
> On 8 May 2018 at 10:34, Greg Kurz <groug@kaod.org> wrote:
> > On Mon, 7 May 2018 12:53:45 -0500
> > Eric Blake <eblake@redhat.com> wrote:
> >
> >> On 05/07/2018 04:02 AM, Greg Kurz wrote:
> >> > qemu-system-ppc fails to build with GCC 8.0.1:
> >> >
> >> > /home/hsp/src/qemu-master/hw/ppc/e500.c: In function =E2=80=98ppce50=
0_load_device_tree=E2=80=99:
> >> > /home/hsp/src/qemu-master/hw/ppc/e500.c:442:37: error: =E2=80=98/pic=
@=E2=80=99
> >> > directive output may be truncated writing 5 bytes into a region of
> >> > size between 1 and 128 [-Werror=3Dformat-truncation=3D]
> >> >       snprintf(mpic, sizeof(mpic), "%s/pic@%llx", soc, MPC8544_MPIC_=
REGS_OFFSET);
> >> >                                       ^~~~~
> >>
> >> >
> >> > Fix this by converting e500 to use g_strdup_printf()+g_free() instead
> >> > of snprintf(). This is done globally, even for call sites that don't
> >> > break build, since this is the preferred practice in QEMU.
> >> >
> >> > Reported-by: Howard Spoelstra <hsp.cat7@gmail.com>
> >> > Signed-off-by: Greg Kurz <groug@kaod.org>
> >> > ---
> >> >   hw/ppc/e500.c |   39 +++++++++++++++++++++++----------------
> >> >   1 file changed, 23 insertions(+), 16 deletions(-)
> >> >
> >>
> >> Reviewed-by: Eric Blake <eblake@redhat.com>
> >>
> >
> > Hi Peter,
> >
> > David said the next pull request for ppc would happen in a month. This
> > patch fixes an annoying build break with recent GCC, and it already
> > got two positive reviews, is it possible to have it merged upstream ?
>=20
> Sure; applied to master.

Thanks!

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SO98HVl1bnMOfKZd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsUixsACgkQbDjKyiDZ
s5I8bg//czG5Fjb46x3KExfC3HQ7eGt/rYx/Cuy/PaxLxWABj/VLP7VmMBR9WiuX
tijd5o2MDjnJyd2JYbvC6Cg8ArlSBi5mOhHFbqqeG6Y2V416r9RyWcj7KPTCxxFL
tSaiasJzLlCjohPe784pb4KAyMhze5n210xLYyRPPMs5320o+sqmZuSVzPrQqu3Q
y8Q9L8oe1xuWISoSvSzARR2E6O7ASyCke8H0vQwt9wdonhOX64Af1MzM5uKPfiSJ
zuJs6w8blCeimg9kZ0oJShJRMSE8JBkzArIbACS3JNqon7jt4DvQd7D0Uy1ZwKxp
lNa0leGbAk97iQ09f/m8YUpm897NT8nb0mecDZOAkkO+Cy6L6P4D4pYNTc9SW+y9
TH1XRz6e1GujRe6b2OvxvZnx4OsyZZc7yxU7COXAv5+q3+BFDXPlrqfjCZ/B/zJU
nhUVwfC/Snga5nG/e3qaOWo/6VwVhGuol+DAwHU0btNVFyfgu6tyKSnKlLQE44z2
fAP+HmMovOnMTtY0Fs/6w5/HuJzXoVIyBUszpCi9hGZiOBiQoocfR3UwMgpXhqIp
eeKKavX9TFP0f30eRf4I08v+UOlBMSWyVAzwMsxUVuKTofQcQzwm9AlAfC3tyEfm
ghDkRlr8trEY1mXe2/F6/Cug+A0yrYyaN2Ot9vosRcc6+S2C4T8=
=ZUkq
-----END PGP SIGNATURE-----

--SO98HVl1bnMOfKZd--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:47139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fl7OW-0006X3-I6
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 02:47:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fl7OT-0001Mn-GM
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 02:47:32 -0400
Date: Thu, 2 Aug 2018 07:47:25 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180802064725.GA13481@stefanha-x1.localdomain>
References: <20180725085944.11856-1-stefanha@redhat.com>
	<20180725085944.11856-5-stefanha@redhat.com>
	<CAFEAcA92R=_aLRSJ0Jqsir8kmcFExNUUhZgyw0PSDuSc--GD6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <CAFEAcA92R=_aLRSJ0Jqsir8kmcFExNUUhZgyw0PSDuSc--GD6Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 4/7] target/arm: add "cortex-m0" CPU
 model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jim Mussared <jim@groklearning.com>, Steffen =?iso-8859-1?Q?G=F6rtz?= <mail@steffen-goertz.de>, Su Hang <suhang16@mails.ucas.ac.cn>, Liviu Ionescu <ilg@livius.net>, Alistair Francis <alistair@alistair23.me>, QEMU Developers <qemu-devel@nongnu.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Steffen Gortz <qemu.ml@steffen-goertz.de>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Julia Suvorova <jusual@mail.ru>


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 30, 2018 at 06:52:29PM +0100, Peter Maydell wrote:
> On 25 July 2018 at 09:59, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > Define a "cortex-m0" ARMv6-M CPU model.
> >
> > Most of the register reset values set by other CPU models are not
> > relevant for the cut-down ARMv6-M architecture.
> >
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  target/arm/cpu.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> > index 3848ef46aa..7e477c0d23 100644
> > --- a/target/arm/cpu.c
> > +++ b/target/arm/cpu.c
> > @@ -1255,6 +1255,15 @@ static void arm11mpcore_initfn(Object *obj)
> >      cpu->reset_auxcr =3D 1;
> >  }
> >
> > +static void cortex_m0_initfn(Object *obj)
> > +{
> > +    ARMCPU *cpu =3D ARM_CPU(obj);
> > +    set_feature(&cpu->env, ARM_FEATURE_V6);
> > +    set_feature(&cpu->env, ARM_FEATURE_M);
> > +
> > +    cpu->midr =3D 0x410cc200;
> > +}
>=20
> We have all the patches for turning off not-v6M bits of
> behaviour either in master or in target-arm.for-3.1 already,
> right?

Yes.  I've sent this series because Julia's work is now in
target-arm.for-3.1.

Stefan

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbYqj9AAoJEJykq7OBq3PItk4IAIO0i0O1ZEqBFIllq904rqau
SumY/XwrBtplyUvVrHLIGThHP4KyehoMXajT1M45ddvOT/vAZzAZNpPu2VzkO1Yi
jM3eCBNDN4X7qqUvIdRLj3AMLPn6fiJMvalzI9JGeUPoEUafdeMm4hv5KKNA/43z
B4h9SrGB/Z5xfHa6f9eSUFAD1Ofx9MIK25UrKq9kGNZSM3mMnQau15mNBDXOOWNy
w4VV5jGmYx5d/BqmjrL0JDzlt8OJ6K77Q+SCbDyriqXn2Nbz9XoxoCT2ICLtS916
vojRG+qvecbGE7Tlz44/zu8QK+8hJJSIIBsmPYH8iSJO0Vn1y2bsG+D22+798bU=
=PHIx
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--

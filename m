Received: from eggs.gnu.org ([2001:4830:134:3::10]:42614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drn5G-0000Gl-DU
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:26:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drn5B-0001ei-D3
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:26:42 -0400
Received: from 8.mo1.mail-out.ovh.net ([178.33.110.239]:41242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1drn5B-0001aM-4d
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:26:37 -0400
Received: from player691.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 4EDF3913FD
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 17:26:34 +0200 (CEST)
Date: Tue, 12 Sep 2017 17:26:21 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170912172621.4d0b6444@bahia.lan>
In-Reply-To: <6198350f-a694-cf1b-ec00-4c42ccce39a6@redhat.com>
References: <20170912140149.7692-1-lvivier@redhat.com>
	<20170912164644.2a0b6977@bahia.lan>
	<6198350f-a694-cf1b-ec00-4c42ccce39a6@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/1M0=P7k53H1vv2fybky0ry3";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v3 0/3] hmp: fix "dump-quest-memory"
 segfault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org, "Daniel P .
	Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Dr . David
	Alan Gilbert" <dgilbert@redhat.com>, ehabkost@redhat.com

--Sig_/1M0=P7k53H1vv2fybky0ry3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Sep 2017 16:51:46 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 12.09.2017 16:46, Greg Kurz wrote:
> > On Tue, 12 Sep 2017 16:01:46 +0200
> > Laurent Vivier <lvivier@redhat.com> wrote:
> >  =20
> >> Fix aarch64 and ppc when dump-guest-memory is
> >> used with none machine type and no CPU.
> >>
> >> The other machine types don't have the problem.
> >>
> >> Update test-hmp, to test none machine type
> >> with (2 MB) and without memory, and add a test
> >> to test dump-quest-memory without filter parameters
> >> (it needs the fix from Cornelia Huck to work)
> >>
> >> v3:
> >>   - remove blank line after a comment
> >>   - forbid memory dump when there is no CPU
> >> =20
> >=20
> > So in the end, we would forbid dump on aarch64 and
> > ppc, while it is allowed on i386... I don't really
> > care about which behavior is more appropriate but
> > I guess they should be consistent at least. =20
>=20
> It's kind of consistent: Allow it on architectures with fixed endianess,
> but disallow it on architectures without fixed endianess ;-)
>=20

Heh, fun and true: only these ones need first_cpu to guess the endianess,
in case it isn't the default... but the CPU may also be needed to guess
32 or 64 bits.

Let's just hope no one ever tries to add yet another endian-changing
abomination with 32/64-bit support in QEMU :P


> Honestly, it should not matter - we're talking here about the "none"
> machine without a CPU ... as long as it does not crash, there is no need
> for a working "dump-guest-memory" function here.
>=20

Erroring out in dump_init() if nr_cpus =3D=3D 0, before calling the target
specific code would be neater IMHO.

Cheers,

--
Greg

>  Thomas
>=20


--Sig_/1M0=P7k53H1vv2fybky0ry3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWbf8nQAKCRAC/DrrAQHb
wi0yAKCeQ3m5Bmdqglax8VVlZ+N5HFVOawCgg51YjxeLc5oMg/VoDry5fVdHSCs=
=Q0tA
-----END PGP SIGNATURE-----

--Sig_/1M0=P7k53H1vv2fybky0ry3--

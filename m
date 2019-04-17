Received: from eggs.gnu.org ([209.51.188.92]:36905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phrdina@redhat.com>) id 1hGqCQ-0006kz-3u
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:26:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <phrdina@redhat.com>) id 1hGqCP-0005Bq-2J
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:26:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <phrdina@redhat.com>) id 1hGqCL-00050F-OD
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:26:23 -0400
Date: Wed, 17 Apr 2019 21:26:10 +0200
From: Pavel Hrdina <phrdina@redhat.com>
Message-ID: <20190417192610.GC19065@antique-laptop>
References: <1555416373-28690-1-git-send-email-puwen@hygon.cn>
	<20190416141700.GR18986@antique-laptop>
	<e7abd74f-61bb-fc34-0b3a-08c635d9f78c@hygon.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
Content-Disposition: inline
In-Reply-To: <e7abd74f-61bb-fc34-0b3a-08c635d9f78c@hygon.cn>
Subject: Re: [Qemu-devel] [PATCH v3] i386: Add new Hygon 'Dhyana' CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pu Wen <puwen@hygon.cn>
Cc: pbonzini@redhat.com, rth@twiddle.net, mst@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com


--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2019 at 10:53:04PM +0800, Pu Wen wrote:
> On 2019/4/16 22:17, Pavel Hrdina wrote:
> > On Tue, Apr 16, 2019 at 08:06:13PM +0800, Pu Wen wrote:
> > > Add a new base CPU model called 'Dhyana' to model processors from Hyg=
on
> > > Dhyana(family 18h), which derived from AMD EPYC(family 17h).
> > >=20
> > > The following features bits have been removed compare to AMD EPYC:
> > > aes, pclmulqdq, sha_ni
> > >=20
> > > The Hygon Dhyana support to KVM in Linux is already accepted upstream=
[1].
> > > So add Hygon Dhyana support to Qemu is necessary to create Hygon's own
> > > CPU model.
> >=20
> > I have once question that we will have to solve for EPYC CPUs as well.
> > The name should not be based on the Product name or Model name as that
> > usually doesn't change with introduction of new microarchitecture.
> >=20
> > With EPYC we made a mistake to name the CPU like that, luckily with
> > Intel we already use the microarchitecture name, so the EPYC CPU should
> > have been named ZEN-Server and for Ryzen CPUs there should be ZEN-Client
> > if there is any difference or otherwise we can simply use ZEN.
> >=20
> > The issue here is what happens once the ZEN2 microarchitecture is out
> > wihch introduces new features and we will have to come up with a CPU
> > name.
> >=20
> > Obviously we cannot change/remove the EPYC models so the question is
> > what is the difference between the AMD EPYC CPU and this new Dhyana CPU
> > if they are both based on the ZEN microarchitecture?
>=20
> Right now there's no much difference between Dhyana and EPYC from the
> software's view. Dhyana removed the instructions aes, pclmulqdq, sha_ni
> compared to EPYC, but will have it's own implementation such as for aes in
> future CPU models. Hygon also will implement something different from AMD=
 in
> the future.
>=20
> > In addition is there any way how we can introduce ZEN-Server &
> > ZEN-Client or simply ZEN, if there is no difference, as an alias or a
> > new model next to the EPYC?
>=20
> Also as Eduardo mentioned that there's no CPU model alias or inheritance
> system in x86, so I think it's worthwhile to keep a separate CPU model for
> Hygon.

So what happens once Zen2 is out and there are new Dhyana CPUs based on
the Zen2 microarchitecture with some new features, what CPU models we
will introduce, EPYC-G2 and Dhyana-G2, but that will not correspond to
the CPU model anymore.

My idea was that we should probably introduce CPU model Zen-Server which
could cover both EPYC and Dhyana as they are both based on the Zen
microarchitecture.  The fact that Dhyana doesn't support all the
features is not an issue as QEMU will not use them if they are not
available on the host.

Another possibility is to introduce Zen-Server (or AMD-Zen-Server) and
Hygon-Zen-Server with different set of features.

In the future when new microarchitecture is introduced we can simply use
the exact name of the microarchitecture and we don't have to follow the
road as we did with AMD Opteron CPUs where we have different suffixes.

The whole point is that we should name the CPUs the same way for all
vendors and stop introducing new CPU names that will create more
confusion.

Pavel

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEcbzs91ho/coWWY7aUi1kczAH4YwFAly3fdIACgkQUi1kczAH
4Yy9MQ/+ILxdTSmV5vWFEOOfb+c2oYJUO49z3ow34b6tMe1mYW3KvHzTKegWwGRo
BUDc3+lCDO07Lpt2Nac3+m9MnsR53LQjiMXrauKlsaw4OpqG+lRr+cSnNPVbi0Hh
K1aYrhGImc+oJb3MT2/dGscX/qbyHvvqk8KGo4cP/dmBzoYBDSYKQ0nfHYfxejA9
3sgViP5tS11oz8afTHNSexqOxyvdO832SZluRlJ8WwQICP3gjyqY4YxdWYWs8zkw
MPy7h35uSIML/mR22WKq0w1ubkIHquQBzG6u+P/PfhLyKjpUiNMnUfy9AN6kLuQ5
/wAUPPVO02SkykYqa32y/mzgqe8QzE4ozj8cOcrryEsslA8H1hirlQZkclZFBIRC
t1PdCeeGSfJRzs/jmqqriUhNoeFihrikVMTTh7blm6AbJYLdwQBJ87tWnDbiOM/S
ZDDtqNCVSUycaaOcgti7INpZkAGFiAx/okD6kkfgdPl8vZLAXpEcdLgOV06Jjco8
VzgHLqEMSunamag/2ieEDgdy7RdAwWuQ3RiVwrm7ciw4WOiafHgAMOI5pIOP6lM+
IN8bhRif362wkrgZMjr6aQqtxsb0NqHRucTFPNScLoKH5lSyQN+8ioh52ncWS4iX
I6tFkKeW/uBn7hbszZCFo3IDNRHBXMhZ2W0NWOhlI5MHpzr/l+Q=
=ZzwK
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--

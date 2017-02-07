Received: from eggs.gnu.org ([2001:4830:134:3::10]:42053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cb34p-00079V-PF
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:32:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cb34l-0005Ye-3R
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:32:47 -0500
Received: from 9.mo179.mail-out.ovh.net ([46.105.76.148]:53176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cb34k-0005Xq-U7
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:32:43 -0500
Received: from player732.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id C3B5921AB3
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 11:32:38 +0100 (CET)
Date: Tue, 7 Feb 2017 11:32:31 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170207113231.44e35be6@bahia.lan>
In-Reply-To: <20170207001533.3f18e4ea@bahia.lan>
References: <1486123043-26493-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1486123043-26493-2-git-send-email-pradeep.jagadeesh@huawei.com>
	<71b1733d-7638-5e27-e828-fad57f76f507@redhat.com>
	<20170207001533.3f18e4ea@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/vS9BAwF/kJ5rKzJV9+/Xuxf";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 1/2 v16] fsdev: add IO throttle support to
 fsdev devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Alberto Garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, qemu-devel@nongnu.org

--Sig_/vS9BAwF/kJ5rKzJV9+/Xuxf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Feb 2017 00:15:33 +0100
Greg Kurz <groug@kaod.org> wrote:

> On Mon, 6 Feb 2017 13:36:43 -0600
> Eric Blake <eblake@redhat.com> wrote:
>=20
> > On 02/03/2017 05:57 AM, Pradeep Jagadeesh wrote: =20
> > > This patchset adds the throttle support for the 9p-local driver.
> > > For now this functionality can be enabled only through qemu cli optio=
ns.
> > > QMP interface and support to other drivers need further extensions.  =
 =20
> >=20
> > This part is a bit scary - if 2.9 is released with just the cli option
> > and not the QMP interface, then how does someone like libvirt introspect
> > whether the feature is available for use?
> >  =20
>=20
> I'm not aware of anything related to fsdev in QMP... and libvirt seems to
> only parse the output of -help to guess fsdev capabilities.

Oops, reading some more libvirt code I now see that libvirt doesn't parse
-help anymore with QEMU >=3D 1.2.0... sorry for the noise :)

> And indeed,
> qemu-options.hx doesn't expose this new feature.
>=20
> > Please make sure we don't reach 2.9 with only a half-baked feature;
> > whether that means finishing the QMP work or temporarily disabling the
> > cli additions until a later release can finish the work.
> >  =20
>=20
> Would this be ok to add the missing bits in qemu-options.hx or do you
> expect more ?
>=20
> Cheers.
>=20
> --
> Greg


--Sig_/vS9BAwF/kJ5rKzJV9+/Xuxf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAliZokAACgkQAvw66wEB28KYiwCdEsfcr/PS9JdGvm2DcTXQorzg
NaIAoJIqeOoTKF9UZN5W4j4fSKkPzT/F
=1BHh
-----END PGP SIGNATURE-----

--Sig_/vS9BAwF/kJ5rKzJV9+/Xuxf--

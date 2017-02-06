Received: from eggs.gnu.org ([2001:4830:134:3::10]:42443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1casVf-0004Un-1q
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 18:15:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1casVa-0003Lx-4l
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 18:15:47 -0500
Received: from 9.mo179.mail-out.ovh.net ([46.105.76.148]:59709)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1casVZ-0003LW-Qg
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 18:15:41 -0500
Received: from player732.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 59F821E986
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 00:15:40 +0100 (CET)
Date: Tue, 7 Feb 2017 00:15:33 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170207001533.3f18e4ea@bahia.lan>
In-Reply-To: <71b1733d-7638-5e27-e828-fad57f76f507@redhat.com>
References: <1486123043-26493-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1486123043-26493-2-git-send-email-pradeep.jagadeesh@huawei.com>
	<71b1733d-7638-5e27-e828-fad57f76f507@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/2vaI71pYDuic=5Om9BgmgVm";
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

--Sig_/2vaI71pYDuic=5Om9BgmgVm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Feb 2017 13:36:43 -0600
Eric Blake <eblake@redhat.com> wrote:

> On 02/03/2017 05:57 AM, Pradeep Jagadeesh wrote:
> > This patchset adds the throttle support for the 9p-local driver.
> > For now this functionality can be enabled only through qemu cli options.
> > QMP interface and support to other drivers need further extensions. =20
>=20
> This part is a bit scary - if 2.9 is released with just the cli option
> and not the QMP interface, then how does someone like libvirt introspect
> whether the feature is available for use?
>=20

I'm not aware of anything related to fsdev in QMP... and libvirt seems to
only parse the output of -help to guess fsdev capabilities. And indeed,
qemu-options.hx doesn't expose this new feature.

> Please make sure we don't reach 2.9 with only a half-baked feature;
> whether that means finishing the QMP work or temporarily disabling the
> cli additions until a later release can finish the work.
>=20

Would this be ok to add the missing bits in qemu-options.hx or do you
expect more ?

Cheers.

--
Greg

--Sig_/2vaI71pYDuic=5Om9BgmgVm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAliZA5UACgkQAvw66wEB28KVswCfckL0Ua4jmsd3jL279QWvjFBC
fh0An0GQYxIj68/YlqjqWISJ5Oi9Zqx8
=EKm0
-----END PGP SIGNATURE-----

--Sig_/2vaI71pYDuic=5Om9BgmgVm--

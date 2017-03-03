Received: from eggs.gnu.org ([2001:4830:134:3::10]:43613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cjpLR-0001Dj-0G
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:42:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cjpLM-000814-4e
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:42:13 -0500
Received: from 4.mo173.mail-out.ovh.net ([46.105.34.219]:36373)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cjpLL-00080P-Tu
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:42:08 -0500
Received: from player726.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 47CBA29E2E
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 16:42:04 +0100 (CET)
Date: Fri, 3 Mar 2017 16:41:59 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170303164159.5f9a1799@bahia.lan>
In-Reply-To: <CAFEAcA9WO4f9PuN=f1T61WjTsA8Veq4vERuucQfg-ZRAN0uT8Q@mail.gmail.com>
References: <a8300848-9e60-7d62-d8bd-c0084691abbb@ilande.co.uk>
	<20170302174026.GI11445@redhat.com>
	<CAFEAcA9WO4f9PuN=f1T61WjTsA8Veq4vERuucQfg-ZRAN0uT8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/UA_bGmZAEqfdd7SRFrWsmVt";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] git master build failure in 9pfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel <qemu-devel@nongnu.org>

--Sig_/UA_bGmZAEqfdd7SRFrWsmVt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 2 Mar 2017 18:10:29 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 2 March 2017 at 17:40, Daniel P. Berrange <berrange@redhat.com> wrote:
> > On Thu, Mar 02, 2017 at 05:28:24PM +0000, Mark Cave-Ayland wrote: =20
> >> Build platform is Debian Wheezy on an x86_64 host. =20
> >
> > IIUC, O_PATH was introduced in glibc 2.14 and Wheezy only has 2.13.
> >
> > So unless we want to make this 9pfs code a configurable option, this
> > means Debian Wheezy is no longer a supportable platform for QEMU. =20
>=20
> I suspect some of our other supported host OSes still have
> glibc 2.13 as well.
>=20
> I think we should make this a configure check (assuming O_PATH
> is a hard requirement for 9p now).

No it's not. It can be defined to 0 if doesn't exist.

BTW, I only discover now about this problem... Mark, please Cc me next time
for 9p related problems.

Cheers.

--
Greg

> We already only build 9pfs if
> we're on a Linux host and have the libcap and libattr libraries available.
>=20
> thanks
> -- PMM
>=20


--Sig_/UA_bGmZAEqfdd7SRFrWsmVt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAli5jscACgkQAvw66wEB28Kb6ACbBZpnhccqH+91Otny2MQeh7TI
XIYAnjtrL1DXNDpM+mGwp68JQ/nD1RFX
=BmHi
-----END PGP SIGNATURE-----

--Sig_/UA_bGmZAEqfdd7SRFrWsmVt--

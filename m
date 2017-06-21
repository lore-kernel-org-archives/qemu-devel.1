Received: from eggs.gnu.org ([2001:4830:134:3::10]:33303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dNgfX-0007d1-Qy
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:31:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dNgfS-0006vL-8d
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:31:43 -0400
Received: from mo183.mail-out.ovh.net ([178.32.228.183]:55666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dNgfS-0006st-2v
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:31:38 -0400
Received: from player695.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo183.mail-out.ovh.net (Postfix) with ESMTP id E745810A578
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 15:53:13 +0200 (CEST)
Date: Wed, 21 Jun 2017 15:43:09 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170621154309.0c4ff240@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <w51shitmrdw.fsf@maestria.local.igalia.com>
References: <1497877896-35700-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1497877896-35700-2-git-send-email-pradeep.jagadeesh@huawei.com>
	<w51shitmrdw.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/rIHIPRH6iuXbLtUXovQLUY5";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v5 1/5] throttle: factor out duplicate code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, eric blake <eblake@redhat.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org, Markus
	Armbruster <armbru@redhat.com>

--Sig_/rIHIPRH6iuXbLtUXovQLUY5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Jun 2017 14:55:55 +0200
Alberto Garcia <berto@igalia.com> wrote:

> On Mon 19 Jun 2017 03:11:32 PM CEST, Pradeep Jagadeesh wrote:
> > This patch factor out the duplicate throttle code that was present in
> > block and fsdev devices.
> >
> > Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com> =20
>=20
> Reviewed-by: Alberto Garcia <berto@igalia.com>
>=20

Thanks ! Is it okay if this goes through my 9P tree ?

> Berto

Cc'ing Markus, for the same question.

--Sig_/rIHIPRH6iuXbLtUXovQLUY5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllKd+4ACgkQAvw66wEB28JgqQCghVgxDrWLhCrY2lQqTatfjO7H
hp0AoIK5rcC1pkkz6rFMMTgsP9C2mncj
=SnOJ
-----END PGP SIGNATURE-----

--Sig_/rIHIPRH6iuXbLtUXovQLUY5--

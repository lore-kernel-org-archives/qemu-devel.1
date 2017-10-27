Received: from eggs.gnu.org ([2001:4830:134:3::10]:53155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e89WE-0003nr-2U
	for Qemu-devel@nongnu.org; Fri, 27 Oct 2017 14:38:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e89WC-0003TZ-SN
	for Qemu-devel@nongnu.org; Fri, 27 Oct 2017 14:38:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e89WC-0003SW-Lm
	for Qemu-devel@nongnu.org; Fri, 27 Oct 2017 14:38:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6E3EA85376
	for <Qemu-devel@nongnu.org>; Fri, 27 Oct 2017 18:38:07 +0000 (UTC)
Received: from [10.10.121.108] (ovpn-121-108.rdu2.redhat.com [10.10.121.108])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D0E285C670
	for <Qemu-devel@nongnu.org>; Fri, 27 Oct 2017 18:38:05 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Message-ID: <51dd774a-ca64-d0d9-4445-c0c2f642ce82@redhat.com>
Date: Fri, 27 Oct 2017 17:52:11 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aiILwc1wFG1GeOui4cR6DneqjpJGh7jSi"
Subject: [Qemu-devel] rfc: help on improving get_maintainer.pl for usage in
 sendemail.cccmd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aiILwc1wFG1GeOui4cR6DneqjpJGh7jSi
From: Eric Blake <eblake@redhat.com>
To: "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>
Message-ID: <51dd774a-ca64-d0d9-4445-c0c2f642ce82@redhat.com>
Subject: rfc: help on improving get_maintainer.pl for usage in sendemail.cccmd
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I've got my git set up to auto-cc anyone mentioned on a per-patch basis,
by doing:

[sendemail]
	cccmd /path/to/scripts/get_maintainer.pl --nogit-fallback --noroles

However, it has the drawback that it does not auto-cc anyone on the 0/N
cover-letter; for that, I have to manually choose who to cc.  Does
anyone have git hints or script ideas on how we could teach
get_maintainer.pl that when it sees a 0/N letter it should then compute
the cc list as the union of the cc lists of each of the other patches in
the series?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--aiILwc1wFG1GeOui4cR6DneqjpJGh7jSi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnzVisACgkQp6FrSiUn
Q2r1mQf+NdBH4Bc+dtolAZ7P8R4oY0c632gO1i+ob7+qJUHQoeoesGM4NQIzWxC7
exclRd8D2cIBW11/MJq1iTYCjbpD4LKA7HMiiGVtS06vCnXp3Ru6/Gl7uy/deG7a
nGdoaUxZszFPpQFAwIdXuy9pPb/vQkSwzFhIbtLiys6h+TljacQPjuDsbVIhtPHZ
SEJlHxS4GJsR31ySs38JAawUsFHNEm1gURMMBtm84h/Vp5cnBeiJC4AyLrj3r6js
DEwxC8PtWpouGC+vGaZOqKFBoRAu6m/7oLcFTrQQ0bSErpiSMMhOCFs4AsnQSUZJ
4XPbklbNE1ce3dwtbi6RLa3wqaAZZw==
=6/xt
-----END PGP SIGNATURE-----

--aiILwc1wFG1GeOui4cR6DneqjpJGh7jSi--

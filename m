Received: from eggs.gnu.org ([2001:4830:134:3::10]:52055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dufZa-0007mZ-O1
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dufZW-0008Bo-7Y
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:01:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dufZW-0008Ab-1M
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:01:50 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1A24E12B3B
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 14:01:49 +0000 (UTC)
References: <20170920105026.1458-1-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <22b5ec35-90d0-2cf2-c37b-21e27764150a@redhat.com>
Date: Wed, 20 Sep 2017 09:01:42 -0500
MIME-Version: 1.0
In-Reply-To: <20170920105026.1458-1-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sVWlmU1KprOhA0039hCgo66avVn4jCRQe"
Subject: Re: [Qemu-devel] [PATCH] tests: Move postcopy migration test to
 migrate-set-parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sVWlmU1KprOhA0039hCgo66avVn4jCRQe
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com
Message-ID: <22b5ec35-90d0-2cf2-c37b-21e27764150a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tests: Move postcopy migration test to
 migrate-set-parameters
References: <20170920105026.1458-1-quintela@redhat.com>
In-Reply-To: <20170920105026.1458-1-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/20/2017 05:50 AM, Juan Quintela wrote:
> migrate_set_speed and migrate_set_dowtime are deprecated since long ago=
=2E

s/dowtime/downtime/

Still, even if they are deprecated, maintaining coverage for both old
and new spellings in the testsuite doesn't hurt, does it?  Maybe it
would be better to add a comment stating that our use of the old
interface is intentional, or to run the test twice, once per spelling?


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--sVWlmU1KprOhA0039hCgo66avVn4jCRQe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnCdMYACgkQp6FrSiUn
Q2rg9ggAh33OFJtRN1xaAzrnxUu37VkCughBblBRcg2dXf5T3K3dwXaaCdeGIVWQ
+2mihwUi6yDO/9dDwBtqXyShljlgSuu9Ii0jpejQu0JgoY0+jgpIvpZ7cMa+IFFE
H/b3L8wChnAnCosLlaTpAAN/vTWW1Hlxw7DWOxwr0CTyLJDqUzYTmgqyQSnYseZM
ez0xI64K4IrHJsh8/LTGxEfhnMijuaCY3yqLHETefeBfBLrEWcBZ+OiY4NSm4+CK
qRRYt4Frj303b6T5Ran+iyTuv801KtNjQ2GFwis6bn/DGqEY6TylOSfmmVoass2B
sn+MNaHX42U5c5Az28XfedIhddnkxA==
=k7dP
-----END PGP SIGNATURE-----

--sVWlmU1KprOhA0039hCgo66avVn4jCRQe--

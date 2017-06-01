Received: from eggs.gnu.org ([2001:4830:134:3::10]:51568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGRoa-0000D4-9O
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:15:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGRoZ-0004g8-4G
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:15:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11753)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dGRoY-0004fN-Sg
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:15:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 56303448D6B
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 15:15:05 +0000 (UTC)
References: <1496320911-51305-1-git-send-email-pbonzini@redhat.com>
	<1496320911-51305-25-git-send-email-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cad75a92-b2c1-e705-e446-68ed242b32ab@redhat.com>
Date: Thu, 1 Jun 2017 10:15:02 -0500
MIME-Version: 1.0
In-Reply-To: <1496320911-51305-25-git-send-email-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0ABhUO7q1srtmfL4LbUIj3I1vCHXmce9M"
Subject: Re: [Qemu-devel] [PULL 24/33] nbd: Fully initialize client in case
 of failed negotiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0ABhUO7q1srtmfL4LbUIj3I1vCHXmce9M
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Message-ID: <cad75a92-b2c1-e705-e446-68ed242b32ab@redhat.com>
Subject: Re: [PULL 24/33] nbd: Fully initialize client in case of failed
 negotiation
References: <1496320911-51305-1-git-send-email-pbonzini@redhat.com>
 <1496320911-51305-25-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1496320911-51305-25-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/01/2017 07:41 AM, Paolo Bonzini wrote:
> From: Eric Blake <eblake@redhat.com>
>=20
> If a non-NBD client connects to qemu-nbd, we would end up with
> a SIGSEGV in nbd_cilent_put() because we were trying to

Since it looks like you have to respin this pull request for other
reasons, you could s/cilent/client/ while touching things up.

> unregister the client's association to the export, even though
> we skipped inserting the client into that list.  Easy trigger
> in two terminals:
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--0ABhUO7q1srtmfL4LbUIj3I1vCHXmce9M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZMC92AAoJEKeha0olJ0NqGPgIAKWcoBUL8APCVqpESq2e5gw+
mFVDK3A5F5TUzafbOkJM7C56GLUD/bE10CcGCUIOS3KGby0O6qllFK9z6vmPxrfA
clbWkEgX+1nqiTwKIwwyXG0dgjMajqq0mEhl4t1TLhvCY8cPWCT8LeaXxx/IteGQ
Q5HDWyvORs+TNmv/9fW6haqbTmSv8QLIk+nVLEXmjx+O5kGcu0qKMNt6En+L3Xbm
4GpSV88p3lJbd3sn36qiSPlQa3UVqRkMSbUEqSSr70eLFHMdRxh6ZHKLebBnqCoN
+sBZkScdRp7QvZS+v0lGnUmubvOboZEhcU+nUJyycTirsO+xTlCGSyXQeO0RS94=
=fz9N
-----END PGP SIGNATURE-----

--0ABhUO7q1srtmfL4LbUIj3I1vCHXmce9M--

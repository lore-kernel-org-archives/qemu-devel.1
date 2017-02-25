Received: from eggs.gnu.org ([2001:4830:134:3::10]:34864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chf0e-00071K-N2
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 11:15:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chf0b-00039P-F8
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 11:15:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1chf0b-00039C-9u
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 11:15:45 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7BDC3C05678D
	for <qemu-devel@nongnu.org>; Sat, 25 Feb 2017 16:15:45 +0000 (UTC)
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
	<1487886317-27400-16-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <12041f08-197a-e98a-2e13-08bfc79de8f8@redhat.com>
Date: Sat, 25 Feb 2017 10:15:43 -0600
MIME-Version: 1.0
In-Reply-To: <1487886317-27400-16-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8XrE3bsq59ggCrSPcXutmVDCglufn47OQ"
Subject: Re: [Qemu-devel] [PATCH 15/21] qom: Make
 object_property_set_qobject()'s input visitor strict
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8XrE3bsq59ggCrSPcXutmVDCglufn47OQ
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <12041f08-197a-e98a-2e13-08bfc79de8f8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 15/21] qom: Make
 object_property_set_qobject()'s input visitor strict
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
 <1487886317-27400-16-git-send-email-armbru@redhat.com>
In-Reply-To: <1487886317-27400-16-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/23/2017 03:45 PM, Markus Armbruster wrote:
> Commit 240f64b made all qobject input visitors created outside tests
> strict, except for the one in object_property_set_qobject().  That one
> was left behind only because Eric couldn't spare the time to figure
> out whether making it strict would break anything, with a TODO
> comment.  Time to resolve it.

Yay.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--8XrE3bsq59ggCrSPcXutmVDCglufn47OQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYsa2vAAoJEKeha0olJ0NqBuYH/3amWEqyruiSZZ758rHrZErv
v+RvS+pX6ja58a97fBS/AvghLGkTLq4zxze3bN+itgfONAFhR8vuSqHdDTx3PebV
cJCFfoJe+B0Zg8A828M0U2LfFgO+Y8SzipjeubpwsI+yss1MUK7MpnNDoDJ5OMeJ
Y5935GxFfGp4ZfjxnX4dVp4sSvwBMvVXX03ujlNPsvdjb97WAcMJwfnfgLYktcqf
ekMt8A51aA0qKAgsPPEb9bZ3o+1P1rLH977xdftRPnK1DeGR7UNZy/Oe+hK4D6y8
F8gU/lowIubl0EcZ6etX0KW2Bdesu5oFXx1bXDydfIsbXTlzUlf4f9GTzz2j3g8=
=rlIy
-----END PGP SIGNATURE-----

--8XrE3bsq59ggCrSPcXutmVDCglufn47OQ--

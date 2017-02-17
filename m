Received: from eggs.gnu.org ([2001:4830:134:3::10]:60640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cepPF-0000yi-M6
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:45:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cepPD-00004z-2v
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:45:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cepPC-0008Vi-TK
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:45:27 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0CBB5C04BD4F
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 20:45:27 +0000 (UTC)
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-16-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <70ff3bbf-a3e9-6b2f-18c5-3b3f6e2e9ad1@redhat.com>
Date: Fri, 17 Feb 2017 14:45:25 -0600
MIME-Version: 1.0
In-Reply-To: <1487067971-10443-16-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ercT0OdcaGAJq2Qa87D3WbvIp6vuUIsRd"
Subject: Re: [Qemu-devel] [PATCH 15/24] util/cutils: Rename qemu_strtosz()
 to qemu_strtosz_mebi()
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
--ercT0OdcaGAJq2Qa87D3WbvIp6vuUIsRd
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <70ff3bbf-a3e9-6b2f-18c5-3b3f6e2e9ad1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 15/24] util/cutils: Rename qemu_strtosz() to
 qemu_strtosz_mebi()
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
 <1487067971-10443-16-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-16-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/14/2017 04:26 AM, Markus Armbruster wrote:
> With qemu_strtosz(), no suffix means mebibytes.  It's used rarely.
> I'm going to add a similar function where no suffix means bytes.
> Rename qemu_strtosz() to qemu_strtosz_mebi() to make the name
> qemu_strtosz() available for the new function.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

With the conversion to Paolo's suggested naming (s/mebi/MiB/),

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--ercT0OdcaGAJq2Qa87D3WbvIp6vuUIsRd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYp2DlAAoJEKeha0olJ0Nq4I4H/iwNUvJGhxVYGipHOZSIO1mF
tSo/jOWhILAugEg9KBvL49q8KC1r2f60NX4iYusn6KR0QTbjnQdVQgnPTcb2KuXf
WmtD6aV3Oskc7biKEsyn2vPBC5VZSFUw6BK5RpMEQRe4db2uPtVdUp6/lDNOkZSc
lQvjIBhu5Xhh5XvXkhVsDV7gdTsmjlXRkWZzIk/8x7ILUaA4j3FlvO2jFqmEPC+o
xl2oCUZdLFPCtG3CmoMQ17Y/j7QsW1ApbAkrvKB9XKx5Jk5q5i3KgegHnsjAmUGu
KbTxNiojCP0FR112XUpy2L2Q5Hvk86LFoc4UvvV83hfRfbKVWhFYbLsfhRA8tgc=
=jn2W
-----END PGP SIGNATURE-----

--ercT0OdcaGAJq2Qa87D3WbvIp6vuUIsRd--

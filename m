Received: from eggs.gnu.org ([2001:4830:134:3::10]:37140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYfas-00080o-GW
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 16:04:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYfan-0007Fb-Lt
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 16:04:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cYfan-0007FR-GP
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 16:03:57 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 59477C04B332
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 21:03:57 +0000 (UTC)
References: <1485788877-3823-1-git-send-email-abologna@redhat.com>
	<1485894840.1076.45.camel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0a4ea84b-56da-4069-e0d5-19d98dfe86f0@redhat.com>
Date: Tue, 31 Jan 2017 15:03:52 -0600
MIME-Version: 1.0
In-Reply-To: <1485894840.1076.45.camel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lMsl0m9lGpxbARGBfdnVuN2MAPCnrb6VI"
Subject: Re: [Qemu-devel] [PATCH] q35: Provide improved sample configurations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Andrea Bolognani <abologna@redhat.com>
Cc: drjones@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lMsl0m9lGpxbARGBfdnVuN2MAPCnrb6VI
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, Andrea Bolognani <abologna@redhat.com>
Cc: drjones@redhat.com, qemu-devel@nongnu.org
Message-ID: <0a4ea84b-56da-4069-e0d5-19d98dfe86f0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] q35: Provide improved sample configurations
References: <1485788877-3823-1-git-send-email-abologna@redhat.com>
 <1485894840.1076.45.camel@redhat.com>
In-Reply-To: <1485894840.1076.45.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/31/2017 02:34 PM, Gerd Hoffmann wrote:

>=20
> Note that you can specify -readconfig multiple times, so you can split
> out common stuff and ask people to run "qemu -readconfig
> q35-paravirt-base.cfg -readconfig q35-paravirt-$style.cfg"

Can we add #include-like semantics, so that one .cfg file can
automatically pull in pre-requisites without having to document a
command-line use of multiple -readconfig?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--lMsl0m9lGpxbARGBfdnVuN2MAPCnrb6VI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYkPu4AAoJEKeha0olJ0NqgCsH/19W5TO/n8ePqpt48sb8FHhR
nVHdbLX7lmhkROi2nYi5JPq9ZW0IWGfUE+a9f6vmNFZBZYDzURJrh8hiQx20n8Lj
aKwjS6XaAo/c05m4ZgR0BLu1XYhO2JCUfizx2PeaedVOerfaqCT0rlWHgKTtOCcQ
MmpM2D8feqzBJ+YSO6BW0oyESR6YpkLvF22fl+T5MmZcrNCrjyu7YiYEXp2Yc8jw
2z/uR1v1WnLeHMxLd4JMxQns1NaTbEoxNYQJ3PB4dogXNP5egsXJ0m7qlzoHJhpG
u1QeZ6a2Vgjjdr5J3m00CpGdKWkISHNS+RdxJzO7cnJLsJDt7/xy7OqnZtrdO2I=
=fotg
-----END PGP SIGNATURE-----

--lMsl0m9lGpxbARGBfdnVuN2MAPCnrb6VI--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:41777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpi95-0004LB-Hv
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 17:46:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpi90-0004PH-Te
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 17:46:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51294)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dpi90-0004Oz-L6
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 17:45:58 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ABE7AC04B941
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 21:45:57 +0000 (UTC)
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-27-eblake@redhat.com>
	<a6e44bb3-c858-3277-4bdc-50dddf19981f@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <34d47331-3ba6-68ba-8b80-830fc5e0f657@redhat.com>
Date: Wed, 6 Sep 2017 16:45:53 -0500
MIME-Version: 1.0
In-Reply-To: <a6e44bb3-c858-3277-4bdc-50dddf19981f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MHfGeNpWSc9HwJ08vAUq2IGLoesKGnfVI"
Subject: Re: [Qemu-devel] [PATCH v6 26/29] fw_cfg-test: Drop dependence on
 global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MHfGeNpWSc9HwJ08vAUq2IGLoesKGnfVI
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com
Message-ID: <34d47331-3ba6-68ba-8b80-830fc5e0f657@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 26/29] fw_cfg-test: Drop dependence on
 global_qtest
References: <20170901180340.30009-1-eblake@redhat.com>
 <20170901180340.30009-27-eblake@redhat.com>
 <a6e44bb3-c858-3277-4bdc-50dddf19981f@redhat.com>
In-Reply-To: <a6e44bb3-c858-3277-4bdc-50dddf19981f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/05/2017 06:05 AM, Thomas Huth wrote:
> On 01.09.2017 20:03, Eric Blake wrote:
>> As a general rule, we prefer avoiding implicit global state
>> because it makes code harder to safely copy and paste without
>> thinking about the global state.  It turns out that with the
>> recent changes to libqos, fw_cfg-test was not even using
>> global_qtest any more.  Avoid a pointless strdup while at it.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>  tests/fw_cfg-test.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>

>>
>=20
> Why don't you merge this with patch 14/29?

Sure.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--MHfGeNpWSc9HwJ08vAUq2IGLoesKGnfVI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmwbJIACgkQp6FrSiUn
Q2oy7gf/RcjUMCGlDSJauDhxl0CkQFtTDwUUzck4K3qFSZ5FFgO9Bhz9rrADGzBL
yVLejO+H3bg7UFRqub6/6nlp6ui36kz9NIL7yJWLtFUCWlDz5B3zMIF7l+YIYciW
jiGEcXPMFM3RBSqJ7asB3nq0cCtqMWoPLGRCBaww/43o1UuK/WKyPrcNix+t+SCH
zHVoyx6OCeHv5okG4b/VUCRgH9pmgPbS/eh01TZGKzIp9nfGmQ9MGc7yxGogws+0
DHRo2EmIinnsuyDWwTqZLNsY94IRGMsnTUh7/QKK1Mt6VnVmGqwSk9562NUEM/VS
YB66ZBZ5FXE3yrzxurPf1JaflPOb7w==
=hYdZ
-----END PGP SIGNATURE-----

--MHfGeNpWSc9HwJ08vAUq2IGLoesKGnfVI--

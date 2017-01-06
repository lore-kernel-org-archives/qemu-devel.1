Received: from eggs.gnu.org ([2001:4830:134:3::10]:46967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPcy9-0004fD-F5
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 17:26:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPcy5-0003WH-Re
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 17:26:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPcy5-0003W5-Lu
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 17:26:37 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9C9301555C
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 22:26:37 +0000 (UTC)
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
	<20170105165329.17227-20-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e7c5de06-ffa0-f680-320b-a07eb8de5a9f@redhat.com>
Date: Fri, 6 Jan 2017 16:26:35 -0600
MIME-Version: 1.0
In-Reply-To: <20170105165329.17227-20-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="K2wdrxtcxNAOggOLJlo1EFvVbhSa8PGQ2"
Subject: Re: [Qemu-devel] [PATCH 19/20] vc: use a common prefix for chr
 callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--K2wdrxtcxNAOggOLJlo1EFvVbhSa8PGQ2
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <e7c5de06-ffa0-f680-320b-a07eb8de5a9f@redhat.com>
Subject: Re: [PATCH 19/20] vc: use a common prefix for chr callbacks
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
 <20170105165329.17227-20-marcandre.lureau@redhat.com>
In-Reply-To: <20170105165329.17227-20-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2017 10:53 AM, Marc-Andr=C3=A9 Lureau wrote:
> vc_chr_write() is more appropriate than _puts() since no newline is
> appended, even though it's not used only as a callback.
>=20
> Keep "qemu_chr_parse" prefix, most chardev parse functions use this
> prefix atm.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  ui/console.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--K2wdrxtcxNAOggOLJlo1EFvVbhSa8PGQ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYcBmbAAoJEKeha0olJ0NqJw8H/1I6xyBx4Gg50EkGquvLEM5W
pUmyQKMjPirPBxny2f1GInEOFbJghRY5m6xZk7UaT3WIbNTBkUUN2HP0ME/aZCmd
65yl3zvl2sMJUX4fTpeGkbg9N8A6jqbo1PTiVSsw+RKYmv5zYlKXJ4l8GhvG1Jbl
06PcT76Qy1o8yZ/+ebnWQ0L5jPScd9Es17Y4k/Q96cBdrdJphdKAUnM/x2a3jtft
fhsyhqeZRRFj5FDYSFWaC72D08HKX4BgJGHWSjctV/q0FRLG5Kr4Xrt9AATSXShy
9TWJ2pnIfjdn0u1EqxquFrXs2TUic9iFETvuP0kdeGHPMgihsg6dSUOKIkIZm/o=
=N0an
-----END PGP SIGNATURE-----

--K2wdrxtcxNAOggOLJlo1EFvVbhSa8PGQ2--

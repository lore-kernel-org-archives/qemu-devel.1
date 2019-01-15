Received: from eggs.gnu.org ([209.51.188.92]:43014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjT3b-0005xN-JS
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:03:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjT3Y-0004De-RN
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:03:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gjT3Y-0004DG-Io
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:03:20 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 75F872D7E4
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 18:03:19 +0000 (UTC)
References: <1547574976-6372-1-git-send-email-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a017f3b2-f237-d46c-3d53-06fd8ca45a93@redhat.com>
Date: Tue, 15 Jan 2019 12:03:18 -0600
MIME-Version: 1.0
In-Reply-To: <1547574976-6372-1-git-send-email-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Qw8Ybeo98Or5c6ZeemxM3L338v9LSDoAd"
Subject: Re: [Qemu-devel] [PATCH] tap: flush STDOUT on newline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Qw8Ybeo98Or5c6ZeemxM3L338v9LSDoAd
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com
Message-ID: <a017f3b2-f237-d46c-3d53-06fd8ca45a93@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tap: flush STDOUT on newline
References: <1547574976-6372-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1547574976-6372-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/15/19 11:56 AM, Paolo Bonzini wrote:
> This makes it easier to follow what is going on.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/tap-driver.pl | 1 +
>  scripts/tap-merge.pl  | 1 +
>  2 files changed, 2 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--Qw8Ybeo98Or5c6ZeemxM3L338v9LSDoAd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw+IGYACgkQp6FrSiUn
Q2qtzAf/R/tGgCbZ+N2PF7zdiMcUBbcJQ8sSWR3TY261NXH5FktuMUN8gW4EdWp9
PHtGau3KiofVRvusXQFup4YlWfUfQv7NtVQgON6KIfGhsQnMy/g8uIfMcDOg0VUU
dcskYfej1/xZ/KcDrc9XEOSs8Haa/ktAoqsFwVY0Xl++t+bCEsOM8tq2RR6L0XAK
5r75MvGN6jFSQfnoDD66v0kOQglN2Q8OXmofreVOLikac55Rnf8nBTgOn07mBYLW
AWHo0otS2QWO4we77fsf9sUJhS7A3UesjW9k3+ttFAJzuUOXgDIkFzx7Szi3EluR
uo0AlB9evInrHtUefh537WlMvKhTQg==
=FAWC
-----END PGP SIGNATURE-----

--Qw8Ybeo98Or5c6ZeemxM3L338v9LSDoAd--

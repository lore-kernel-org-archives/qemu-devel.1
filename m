Received: from eggs.gnu.org ([209.51.188.92]:38077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hDZZ6-0002fU-Mw
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:04:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hDZZ5-00084l-9T
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:04:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hDZZ4-00082y-IN
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:04:18 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DE0B0307EAA0
	for <qemu-devel@nongnu.org>; Mon,  8 Apr 2019 19:04:17 +0000 (UTC)
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-15-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <53312567-fb1e-0f9d-f2d1-1adbf584ef21@redhat.com>
Date: Mon, 8 Apr 2019 14:04:13 -0500
MIME-Version: 1.0
In-Reply-To: <20190408083627.7479-15-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uvecyl1cSTheA3j6bGWfY2wEGNl45w3GH"
Subject: Re: [Qemu-devel] [PATCH 14/15] char: Make -chardev help print to
 stdout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uvecyl1cSTheA3j6bGWfY2wEGNl45w3GH
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <53312567-fb1e-0f9d-f2d1-1adbf584ef21@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 14/15] char: Make -chardev help print to
 stdout
References: <20190408083627.7479-1-armbru@redhat.com>
 <20190408083627.7479-15-armbru@redhat.com>
In-Reply-To: <20190408083627.7479-15-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/8/19 3:36 AM, Markus Armbruster wrote:
> Command line help explicitly requested by the user should be printed
> to stdout, not stderr.  We do elsewhere.  Adjust -chardev to match:
> use qemu_printf() instead of error_printf().  Plain printf() would be
> wrong because we need to print to the current monitor for chardev-add
> help".

Mismatched "

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--uvecyl1cSTheA3j6bGWfY2wEGNl45w3GH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyrmy0ACgkQp6FrSiUn
Q2rfIQgAhu6Fo/MBkJRy+UumHl8qaiaAUwBoW7w22ntwp9R222xOrQZgCHAbKaoC
/8FZzicW+PYLdHAn+AwjAhb67g6dU80gUaxCeoBjlmuUCaTYfanUN/iVI3ewbEFL
2F40oxN2IgPEhTUP4zisuOfggNxt0LbtvPzZz83QB4n20Z6zlZ7nTJBahu7WR+ko
aFbKqe8i2vgHFqs4wSJPBBTaSXsIOJ+ZmJ5E333yne8nkdTFeePeJTq3QvmKuniX
Pb8ywe7XxEWyEgY6hRvWENv0BqEVRdu6Pe7XPgc2OraNolk28bzyat4Poz0cbUtE
y0R0OZlPCm0HYSuqWoCYwWeYiYj+qg==
=UZxR
-----END PGP SIGNATURE-----

--uvecyl1cSTheA3j6bGWfY2wEGNl45w3GH--

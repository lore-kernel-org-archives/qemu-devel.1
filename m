Received: from eggs.gnu.org ([209.51.188.92]:38233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGqH4-0002LO-KB
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:31:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGqH0-00026N-MM
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:31:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hGqGy-00024L-N8
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:31:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9CE823007C26
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 19:31:07 +0000 (UTC)
References: <20190417190641.26814-1-armbru@redhat.com>
	<20190417190641.26814-15-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8d6af59f-c715-a1ce-9007-efdc738ede37@redhat.com>
Date: Wed, 17 Apr 2019 14:31:06 -0500
MIME-Version: 1.0
In-Reply-To: <20190417190641.26814-15-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NOCDhaIELDmizjznZFmrkmhMAbEPNP1dp"
Subject: Re: [Qemu-devel] [PATCH v3 14/15] char-pty: Print "char device
 redirected" message to stdout
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
--NOCDhaIELDmizjznZFmrkmhMAbEPNP1dp
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <8d6af59f-c715-a1ce-9007-efdc738ede37@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 14/15] char-pty: Print "char device
 redirected" message to stdout
References: <20190417190641.26814-1-armbru@redhat.com>
 <20190417190641.26814-15-armbru@redhat.com>
In-Reply-To: <20190417190641.26814-15-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/17/19 2:06 PM, Markus Armbruster wrote:
> char_pty_open() prints a "char device redirected to PTY_NAME (label
> LABEL)" message to the current monitor or else to stderr.  This is not
> an error, so it shouldn't go to stderr.  Print it to stdout instead.
>=20
> Why is it even printed?  No other ChardevClass::open() prints anything
> on success.  It's because you need to know PTY_NAME to actually use
> this char device, e.g. like e.g. "socat STDIO,cfmakeraw FILE:PTY_NAME"
> to use the monitor's readline interface.  You can get PTY_NAME with
> "info chardev" (a.k.a. query-chardev for QMP), but only if you already
> have a monitor.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  chardev/char-pty.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--NOCDhaIELDmizjznZFmrkmhMAbEPNP1dp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly3fvoACgkQp6FrSiUn
Q2ranQf/bPVRwBz5ke0rPH2tPXc8eSiWs9Bgqr55tft1tujNZe3CY1LIFWTz3pFc
xZrf4w3AhAJCR0McEe61EEgH+nszDsj7cPziyJFvEVNXGI281u23nnQaTuDvz+Fn
If3IGUCLeizySYeXLowx019gz/f/K7ODlfKZXx5UvtMKn/APDrPUKrFbuWhAK8od
Mz4quxQzfpGNFxAY1hdnT4MQdXWu9FFBwAS4BO9NL6rh/Bv/NZATMxXLiBxAWPbb
QYffyMuNYKQV8rmmtzCOX+dkJmdua67Ngmzsr37cOioQrW8N8hffX9dUo+ewKRuO
bMAIg9F5TgZ+Kfqf88jazVPDJLZcyw==
=XJOV
-----END PGP SIGNATURE-----

--NOCDhaIELDmizjznZFmrkmhMAbEPNP1dp--

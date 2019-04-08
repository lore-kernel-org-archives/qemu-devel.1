Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99441C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 19:14:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 181B620879
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 19:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 181B620879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57695 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDZiU-0007w0-2T
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 15:14:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hDZhi-0007af-TC
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:13:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hDZhh-0003JJ-UL
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:13:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hDZhf-0003Hz-Bg; Mon, 08 Apr 2019 15:13:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6E0848831D;
	Mon,  8 Apr 2019 19:13:10 +0000 (UTC)
Received: from [10.3.117.110] (ovpn-117-110.phx2.redhat.com [10.3.117.110])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D0DA906B;
	Mon,  8 Apr 2019 19:13:09 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-3-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=eblake@redhat.com; keydata=
	xsBNBEvHyWwBCACw7DwsQIh0kAbUXyqhfiKAKOTVu6OiMGffw2w90Ggrp4bdVKmCaEXlrVLU
	xphBM8mb+wsFkU+pq9YR621WXo9REYVIl0FxKeQo9dyQBZ/XvmUMka4NOmHtFg74nvkpJFCD
	TUNzmqfcjdKhfFV0d7P/ixKQeZr2WP1xMcjmAQY5YvQ2lUoHP43m8TtpB1LkjyYBCodd+LkV
	GmCx2Bop1LSblbvbrOm2bKpZdBPjncRNob73eTpIXEutvEaHH72LzpzksfcKM+M18cyRH+nP
	sAd98xIbVjm3Jm4k4d5oQyE2HwOur+trk2EcxTgdp17QapuWPwMfhaNq3runaX7x34zhABEB
	AAHNHkVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPsLAegQTAQgAJAIbAwULCQgHAwUV
	CgkICwUWAgMBAAIeAQIXgAUCS8fL9QIZAQAKCRCnoWtKJSdDahBHCACbl/5FGkUqJ89GAjeX
	RjpAeJtdKhujir0iS4CMSIng7fCiGZ0fNJCpL5RpViSo03Q7l37ss+No+dJI8KtAp6ID+PMz
	wTJe5Egtv/KGUKSDvOLYJ9WIIbftEObekP+GBpWP2+KbpADsc7EsNd70sYxExD3liwVJYqLc
	Rw7so1PEIFp+Ni9A1DrBR5NaJBnno2PHzHPTS9nmZVYm/4I32qkLXOcdX0XElO8VPDoVobG6
	gELf4v/vIImdmxLh/w5WctUpBhWWIfQDvSOW2VZDOihm7pzhQodr3QP/GDLfpK6wI7exeu3P
	pfPtqwa06s1pae3ad13mZGzkBdNKs1HEm8x6zsBNBEvHyWwBCADGkMFzFjmmyqAEn5D+Mt4P
	zPdO8NatsDw8Qit3Rmzu+kUygxyYbz52ZO40WUu7EgQ5kDTOeRPnTOd7awWDQcl1gGBXgrkR
	pAlQ0l0ReO57Q0eglFydLMi5bkwYhfY+TwDPMh3aOP5qBXkm4qIYSsxb8A+i00P72AqFb9Q7
	3weG/flxSPApLYQE5qWGSXjOkXJv42NGS6o6gd4RmD6Ap5e8ACo1lSMPfTpGzXlt4aRkBfvb
	NCfNsQikLZzFYDLbQgKBA33BDeV6vNJ9Cj0SgEGOkYyed4I6AbU0kIy1hHAm1r6+sAnEdIKj
	cHi3xWH/UPrZW5flM8Kqo14OTDkI9EtlABEBAAHCwF8EGAEIAAkFAkvHyWwCGwwACgkQp6Fr
	SiUnQ2q03wgAmRFGDeXzc58NX0NrDijUu0zx3Lns/qZ9VrkSWbNZBFjpWKaeL1fdVeE4TDGm
	I5mRRIsStjQzc2R9b+2VBUhlAqY1nAiBDv0Qnt+9cLiuEICeUwlyl42YdwpmY0ELcy5+u6wz
	mK/jxrYOpzXKDwLq5k4X+hmGuSNWWAN3gHiJqmJZPkhFPUIozZUCeEc76pS/IUN72NfprZmF
	Dp6/QDjDFtfS39bHSWXKVZUbqaMPqlj/z6Ugk027/3GUjHHr8WkeL1ezWepYDY7WSoXwfoAL
	2UXYsMAr/uUncSKlfjvArhsej0S4zbqim2ZY6S8aRWw94J3bSvJR+Nwbs34GPTD4Pg==
Organization: Red Hat, Inc.
Message-ID: <3d4cd6c6-49f0-daad-bb1b-25a2456f740f@redhat.com>
Date: Mon, 8 Apr 2019 14:13:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408083627.7479-3-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nnbR4IIvO4NjYRaGotPhRcCXk56pxtgKG"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Mon, 08 Apr 2019 19:13:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 02/15] block/ssh: Do not report
 read/write/flush errors to the user
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>,
	qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408191308.V_pqsYpAU7Ba_ONnDI1CzbkHRtvSbnEgLT41xNy7nTg@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nnbR4IIvO4NjYRaGotPhRcCXk56pxtgKG
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <3d4cd6c6-49f0-daad-bb1b-25a2456f740f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/15] block/ssh: Do not report
 read/write/flush errors to the user
References: <20190408083627.7479-1-armbru@redhat.com>
 <20190408083627.7479-3-armbru@redhat.com>
In-Reply-To: <20190408083627.7479-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/8/19 3:36 AM, Markus Armbruster wrote:
> Callbacks ssh_co_readv(), ssh_co_writev(), ssh_co_flush() report
> errors to the user with error_printf().  They shouldn't, it's their
> caller's job.  Replace by a suitable trace point.
>=20
> Perhaps we should convert this part of the block driver interface to
> Error, so block drivers can pass more detail to their callers.  Not
> today.
>=20
> Cc: "Richard W.M. Jones" <rjones@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: qemu-block@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/ssh.c        | 36 ++++++++++++------------------------
>  block/trace-events |  3 +++
>  2 files changed, 15 insertions(+), 24 deletions(-)
>=20

> -static void GCC_FMT_ATTR(2, 3)
> -sftp_error_report(BDRVSSHState *s, const char *fs, ...)
> +static void sftp_error_trace(BDRVSSHState *s, const char *op)
>  {
> -    va_list args;
> +    char *ssh_err;
> +    int ssh_err_code;
> +    unsigned long sftp_err_code;
> =20
> -    va_start(args, fs);
> -    error_vprintf(fs, args);
> -
> -    if ((s)->sftp) {

The old code was conditional,

> -        char *ssh_err;
> -        int ssh_err_code;
> -        unsigned long sftp_err_code;
> -
> -        /* This is not an errno.  See <libssh2.h>. */
> -        ssh_err_code =3D libssh2_session_last_error(s->session,
> +    /* This is not an errno.  See <libssh2.h>. */
> +    ssh_err_code =3D libssh2_session_last_error(s->session,
>                                                    &ssh_err, NULL, 0);

Indentation looks off now.

> -        /* See <libssh2_sftp.h>. */
> -        sftp_err_code =3D libssh2_sftp_last_error((s)->sftp);
> +    /* See <libssh2_sftp.h>. */
> +    sftp_err_code =3D libssh2_sftp_last_error((s)->sftp);

but it appears the new code can call libssh2_sftp_last_error(NULL). Am I
missing something, or could that be a problem?

/me rescans the full file...

Okay, connect_to_ssh() won't succeed unless s->sftp is set, and it
appears that all callers to the trace function can only be reached if
connect succeeded.

Indentation fixup can be done by maintainer,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--nnbR4IIvO4NjYRaGotPhRcCXk56pxtgKG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyrnUQACgkQp6FrSiUn
Q2pr/Af/TUGAGVBgPTDtDIgSINGV4EkLbuEJWbKpYLLhJqbIbcTRHP8gjpTVwSPd
SYRmcHyQqQ6bKpJ1X+bg4MONts/4iZRX2ns1TG634AYguTcYKh5VGPzHQJmhhTH/
ueM6+ezJRtzKWyL8f08aCxYVfZYsfgbw4Ae80I1QUlwhbeZpIU7l9UrijH5B5EDP
sf7Q2Q05bmaZKu30l/QEAwoTeM05Z6Sx3CWrdOE4f11Gc2ViXNKfHrBwkOi1nL5/
NboUwUm7T5ZX86lWctEgKeIRmj6/Hm9JN3CK/9pdiXHcMi/bes7nmCXa/ZoKZxvw
E4wJ0D7KNJ5fCdsLT4AbE+JA7qChmg==
=PH+N
-----END PGP SIGNATURE-----

--nnbR4IIvO4NjYRaGotPhRcCXk56pxtgKG--


Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1B9C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 15:25:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D2202083E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 15:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2202083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50661 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEbZa-0005Ja-AG
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 11:25:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1hEbYS-0004VB-CZ
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:23:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1hEbYR-0004v2-5f
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:23:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1hEbYQ-0004sE-Oz
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:23:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4ABF13DBCB
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 15:23:52 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.43.2.229])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 922D35D9D5;
	Thu, 11 Apr 2019 15:23:47 +0000 (UTC)
Date: Thu, 11 Apr 2019 17:23:45 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190411152345.GM4288@angien.pipo.sk>
References: <20190411145256.8614-1-armbru@redhat.com>
	<20190411145256.8614-4-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="guYUoZW38XEuSLXo"
Content-Disposition: inline
In-Reply-To: <20190411145256.8614-4-armbru@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Thu, 11 Apr 2019 15:23:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 03/15] char-pty: Drop "char device
 redirected to" message
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
	qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411152345.iEWg9DVPM8jk-S2XubBrXCYtaVJ1Gy8Ur_kxGTMqgJI@z>


--guYUoZW38XEuSLXo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 16:52:44 +0200, Markus Armbruster wrote:
> char_pty_open() prints a "char device redirected to PTY_NAME (label
> LABEL)" message to the current monitor or else to stderr.  No other
> ChardevClass::open() prints anything on success.  Drop the message.
>=20
> Cc: "Marc-Andr=E9 Lureau" <marcandre.lureau@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/char-pty.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> index b034332edd..a48d3e5d20 100644
> --- a/chardev/char-pty.c
> +++ b/chardev/char-pty.c
> @@ -211,8 +211,6 @@ static void char_pty_open(Chardev *chr,
>      qemu_set_nonblock(master_fd);
> =20
>      chr->filename =3D g_strdup_printf("pty:%s", pty_name);
> -    error_printf("char device redirected to %s (label %s)\n",
> -                 pty_name, chr->label);

Don't be scared by the one occurence of this string in a 'strstr' call
in libvirt. We thankfully deleted the code that was using it to extract
the PTY path a long time ago. The only leftover part is to skip it when
we are attempting to extract an useful error from qemu which would be
reported to stderr prior to initiating QMP so getting rid of the message
actually has no effect.

https://libvirt.org/git/?p=3Dlibvirt.git;a=3Dcommitdiff;h=3D932534e85f34a47=
9c7eac174e997bfd9c85bd22d

--guYUoZW38XEuSLXo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlyvW/0ACgkQHGwCByjY
1GpDRQ/+NBliGSDbAiio+IMnBhGRfKLTEhjJ+ceH6j5SCcGpaqhK+zGv8kT2X2zS
6x0Kw0Xak3aJNwNjXl764ZJ4Q/WzUmByMHcW/tEtvF6uANRNEcAffVK1Qh89VDX/
ORJ5e6/n+YfV4OIGEZdfCNpK2H3+m4E3R9FSac19WgeOvQCWLbABev3QYmMeuWt0
6PGHzh2KtrpYUXcm7qiw07Zck0yaQzsWXbDhmJfIYda20+RORpCu+Qj5rb8bSIf6
EtJWpbnt7bdtOe8H8dceN+ig85YeL+7QA4LI+6C8v6/b4JqfyVVIc5RMKPjd7Aw5
8on2wwR2Aue2tY07siGTsrIx2JUoRlEuY5A5usrqolGfPSTA1a/V/JP/lIEEW2SD
wkl4AeJdwfqmE1n+yCQra71z7uWEjfmtWNPIS8K+LFgU63Gs9wa2YACEMPRTjCsQ
DSh4dcjcs+3XNYjnDEQz9f03bBc25ra927oSjH0zj19Hk7QG3B3S3O5zdvjRmWJ7
+hQM2zjYjRUXAZ65yWVIftWDpIgXhu9Vhoyfav3Oc1PoP5pW4U0K0GvedjBYjVic
oqZFqZdqQjiHKwBH0Pwrw0tLd6Mp/mjkX54SoS58y5XPidb2e72b39oJlYXFnNrJ
Z58BhbBxdyV5sw+fIouIhvUh9+yKwm1ECcXo4UlWizlNw1BitSY=
=ZwaU
-----END PGP SIGNATURE-----

--guYUoZW38XEuSLXo--


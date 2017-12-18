Received: from eggs.gnu.org ([2001:4830:134:3::10]:37050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eQv8g-0007uI-T0
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:07:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eQv8d-0004ZV-LD
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:07:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eQv8d-0004Y4-Fp
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:07:23 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BFD15356F4
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 13:07:21 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A628584034
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 13:07:21 +0000 (UTC)
Date: Mon, 18 Dec 2017 08:07:21 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <167321084.622468.1513602441314.JavaMail.zimbra@redhat.com>
In-Reply-To: <20171218130309.2682-1-pbonzini@redhat.com>
References: <20171218130309.2682-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] checkpatch: volatile with a comment or
 sig_atomic_t is okay
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, lersek@redhat.com, famz@redhat.com

Hi

----- Original Message -----
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> This assumes that the comment gives some justification;
> "volatile sig_atomic_t" is also self-explanatory and usually
> correct.
>=20
> Discussed in:
> '[Qemu-devel] [PATCH] dump-guest-memory.py: fix "You can't do that withou=
t a
> process to debug"'
>=20
> Suggested-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Message-Id: <20171215181810.4122-1-marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks, I can add it to my 2 patches series for dump (to avoid error on Pet=
er's end)

Unless you send a pull request with it sonnish


> ---
>  scripts/checkpatch.pl | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 34df753571..3dc27d9656 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2475,8 +2475,11 @@ sub process {
> =20
>  # no volatiles please
>  =09=09my $asm_volatile =3D qr{\b(__asm__|asm)\s+(__volatile__|volatile)\=
b};
> -=09=09if ($line =3D~ /\bvolatile\b/ && $line !~ /$asm_volatile/) {
> -=09=09=09ERROR("Use of volatile is usually wrong: see
> Documentation/volatile-considered-harmful.txt\n" . $herecurr);
> +=09=09if ($line =3D~ /\bvolatile\b/ && $line !~ /$asm_volatile/ &&
> +                    $line !~ /sig_atomic_t/ &&
> +                    !ctx_has_comment($first_line, $linenr)) {
> +=09=09=09my $msg =3D "Use of volatile is usually wrong, please add a com=
ment\n" .
> $herecurr;
> +                        ERROR($msg);
>  =09=09}
> =20
>  # warn about #if 0
> --
> 2.14.3
>=20
>=20

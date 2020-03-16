Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168C2C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 10:18:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C28BB20736
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 10:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/1Jd/Sr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28BB20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDmpN-0000NV-GJ
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 06:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39118)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jDmSG-0001Xu-MS
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 05:54:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jDmSE-0000DS-E7
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 05:54:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52843
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jDmSD-0008IL-8Z
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 05:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584352474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EjG8CvKoeUPFuZmxhgWZvsc7yDDr/GMkjBJsuMwsZNQ=;
 b=e/1Jd/SrWFHfxwQ7veTSxgkXQ4/sjKc4SNPAH7eFLeSQrxY7XI8+IH8OCdTJTVZ3XbpULU
 ev6pwuvg+X8ZZ9KVDk4esV3N4PCrK9rfe/LnEzZSuy3cSy74ykLErG2ZRHfYlj8mo9Rtfy
 9kPAzqk3napA3Maip9nu7TGK4PJYcas=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-heA0sUrNNjGvnMzCGK4NdA-1; Mon, 16 Mar 2020 05:54:32 -0400
X-MC-Unique: heA0sUrNNjGvnMzCGK4NdA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B82C1137843;
 Mon, 16 Mar 2020 09:54:31 +0000 (UTC)
Received: from localhost (unknown [10.36.119.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1272A907F7;
 Mon, 16 Mar 2020 09:54:28 +0000 (UTC)
Date: Mon, 16 Mar 2020 09:54:27 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] checkpatch: enforce process for expected files
Message-ID: <20200316095427.GA340615@stefanha-x1.localdomain>
References: <20200315113323.526984-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200315113323.526984-1-mst@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 imammedo@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 15, 2020 at 07:35:46AM -0400, Michael S. Tsirkin wrote:
> If the process documented in tests/qtest/bios-tables-test.c
> is followed, then same patch never touches both expected
> files and code. Teach checkpatch to enforce this rule.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>=20
> Peter, Igor what do you think?

Minor comments below:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

>=20
>  scripts/checkpatch.pl | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index b27e4ff5e9..96583e3fff 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -35,6 +35,8 @@ my $summary_file =3D 0;
>  my $root;
>  my %debug;
>  my $help =3D 0;
> +my $testexpected;
> +my $nontestexpected;

If you respin, please add acpi to these variable names since they are
specific to acpi.

> =20
>  sub help {
>  =09my ($exitcode) =3D @_;
> @@ -1256,6 +1258,26 @@ sub WARN {
>  =09}
>  }
> =20
> +# According to tests/qtest/bios-tables-test.c: do not
> +# change expected file in the same commit with adding test
> +sub checkfilename {
> +=09my ($name) =3D @_;

There is a tab instead of spaces here that could be fixed if you decide
to respin.

> +        if ($name =3D~ m#^tests/data/acpi/# and
> +            # make exception for a shell script that rebuilds the files
> +            not $name =3D~ m#^\.sh$# or
> +            $name =3D~ m#^tests/qtest/bios-tables-test-allowed-diff.h$#)=
 {
> +            $testexpected =3D $name;
> +        } else {
> +            $nontestexpected =3D $name;
> +        }
> +        if (defined $testexpected and defined $nontestexpected) {
> +            ERROR("Do not add expected files together with tests, " .
> +                  "follow instructions in " .
> +                  "tests/qtest/bios-tables-test.c: both " .
> +                  $testexpected . " and " . $nontestexpected . " found\n=
");
> +        }
> +}
> +
>  sub process {
>  =09my $filename =3D shift;
> =20
> @@ -1431,9 +1453,11 @@ sub process {
>  =09=09if ($line =3D~ /^diff --git.*?(\S+)$/) {
>  =09=09=09$realfile =3D $1;
>  =09=09=09$realfile =3D~ s@^([^/]*)/@@ if (!$file);
> +                        checkfilename($realfile);
>  =09=09} elsif ($line =3D~ /^\+\+\+\s+(\S+)/) {
>  =09=09=09$realfile =3D $1;
>  =09=09=09$realfile =3D~ s@^([^/]*)/@@ if (!$file);
> +                        checkfilename($realfile);

The surrounding lines in this hunk use tab indentation, not spaces.

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5vTNMACgkQnKSrs4Gr
c8ivTggAlcNrLuL0ddPvu/uWpx5eVTT6heqqZQm3ZsCYByZwXDSHx2zzy/h6xfiW
SpE6DmY/QxNnza1CfT4JTTEq3yNwsEqyeGPITdF9sDrdxxC+hWrdJf3kdKjuY0hG
NRd1pVc5oR3U5k33pFLpD4qaiTjTfhBienztelFDRCt6kSnxqcCd/7Qu3oKc9Gc8
jeiswRLfMpU74HJAeCyfBZdTEJgKXlQ5xyeaIZDyJC/fFfT4v7CyBklPcpgm5Ymg
0njq3uMUuxAe/XHPyzu1Poob45LZCd44T/EFjir5ZRjHTdHKoVneX/I/LQwLT9hF
AJwrQD7tVn2YZH7KK0EdA1UiCzkwjQ==
=lze3
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--



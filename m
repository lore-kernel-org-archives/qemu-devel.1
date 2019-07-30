Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4343C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 07:35:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DBD52087F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 07:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0PbMLw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DBD52087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsMfj-0002cs-RV
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 03:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42640)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hsMfB-00022W-An
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 03:35:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hsMfA-00032E-6d
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 03:35:13 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53833)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1hsMf9-0002zk-Tm; Tue, 30 Jul 2019 03:35:12 -0400
Received: by mail-wm1-x343.google.com with SMTP id x15so56083342wmj.3;
 Tue, 30 Jul 2019 00:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=+4LNRmKGnIfbCBFbbSIiJBqgqERgJ/B7b7xpwxBd82I=;
 b=S0PbMLw1UXHSWGtPwXLoF8HdazoI6qKWIqrP9mI7nNZmgFqwG2E6mB2l7oXE8NiLvG
 XKQroGzrZwd3SbtUBTBt9Wl71vbQL6fJeyQTQzU4Ofn6SbNu64YuGj2bN7+g+C44wawR
 oNKOv1l6S/XvzdFgH3P4f7kXHziJJnWbXh+ktVHbglX00JXh01to55bnRiavsR19kQh+
 5qzRxmmNTYtVXkVstVHOgPw/RG9Zese0VL/ilVpLhJU6XTYi5GH5aXgK2g+wso0GWM39
 qCTo/JLTeaBH1HrVjP12trAzUO5X3TZBXsn82AC0S3iB0Suh6bDnktH9P4pnqxO9+pVw
 Srow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=+4LNRmKGnIfbCBFbbSIiJBqgqERgJ/B7b7xpwxBd82I=;
 b=NRflIlSDqXs8EKj6pYXBQn+iM7Z1GaT/PdmMcIFg93P/LE71LqRYs1KJMdLCFhQD6L
 5+Qa7ZVAWTwZdGH+I+HpvuF4onLWwL8TEoP39TVKalFFX9HshkcGi1BOV76CmxiYxIvx
 CtWnVMEDhA9ntFckWJGeikH0gpFjNafJI/ReChenIjZ22nqGrcYNkjs8gNhlps4Jnd7H
 /Kcw304np8ltjtJjK6sl5B1vuvRRYYFgVV+eEyINT/qteRIyElaIQuPJsZac0Fi1LAUL
 L3ooyynyeUdFs50/i/bZaroU/Bl8Dinl82XlLX/jetSLC1JUYSrsqukZdItnlLzCLK0W
 ZKpg==
X-Gm-Message-State: APjAAAVDKlKo6oejAygXv1blCPmZjGdANkoN6VQwFvMUwzinTSW734qW
 m01Kmp3YiY4raVWeqSg4Hyk=
X-Google-Smtp-Source: APXvYqwRd8PSvJEGn0laXtQi6LYucrv59UB7TJTpYQJnf0b1cPKv4MzAlFeF2hqk5qAudgietPgJEg==
X-Received: by 2002:a1c:cfc3:: with SMTP id
 f186mr97308223wmg.134.1564472110544; 
 Tue, 30 Jul 2019 00:35:10 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id p63sm15203897wmp.45.2019.07.30.00.35.07
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 30 Jul 2019 00:35:09 -0700 (PDT)
Date: Tue, 30 Jul 2019 08:34:59 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190730073459.GC30213@stefanha-x1.localdomain>
References: <20190729151651.21306-1-mehta.aaru20@gmail.com>
 <20190729151651.21306-12-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="32u276st3Jlj2kUU"
Content-Disposition: inline
In-Reply-To: <20190729151651.21306-12-mehta.aaru20@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v7 11/15] qemu-io: adds option
 to use aio engine
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefan@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--32u276st3Jlj2kUU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2019 at 08:46:47PM +0530, Aarushi Mehta wrote:
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> ---
>  qemu-io.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>=20
> diff --git a/qemu-io.c b/qemu-io.c
> index f64eca6940..6568f0c369 100644
> --- a/qemu-io.c
> +++ b/qemu-io.c
> @@ -130,7 +130,8 @@ static void open_help(void)
>  " -C, -- use copy-on-read\n"
>  " -n, -- disable host cache, short for -t none\n"
>  " -U, -- force shared permissions\n"
> -" -k, -- use kernel AIO implementation (on Linux only)\n"
> +" -k, -- use kernel AIO implementation (Linux only, prefer use of -i)\n"
> +" -i, -- use AIO mode (threads, native or io_uring)"

Missing \n

>  " -t, -- use the given cache mode for the image\n"
>  " -d, -- use the given discard mode for the image\n"
>  " -o, -- options to be given to the block driver"
> @@ -172,7 +173,7 @@ static int open_f(BlockBackend *blk, int argc, char *=
*argv)
>      QDict *opts;
>      bool force_share =3D false;
> =20
> -    while ((c =3D getopt(argc, argv, "snCro:kt:d:U")) !=3D -1) {
> +    while ((c =3D getopt(argc, argv, "snCro:kit:d:U")) !=3D -1) {

'i' requires an argument so it must be "i:".

>          switch (c) {
>          case 's':
>              flags |=3D BDRV_O_SNAPSHOT;
> @@ -204,6 +205,13 @@ static int open_f(BlockBackend *blk, int argc, char =
**argv)
>                  return -EINVAL;
>              }
>              break;
> +        case 'i':
> +            if (bdrv_parse_aio(optarg, &flags) < 0) {
> +                error_report("Invalid aio option: %s", optarg);
> +                qemu_opts_reset(&empty_opts);
> +                return -EINVAL;
> +            }
> +            break;
>          case 'o':
>              if (imageOpts) {
>                  printf("--image-opts and 'open -o' are mutually exclusiv=
e\n");
> @@ -291,7 +299,9 @@ static void usage(const char *name)
>  "  -n, --nocache        disable host cache, short for -t none\n"
>  "  -C, --copy-on-read   enable copy-on-read\n"
>  "  -m, --misalign       misalign allocations for O_DIRECT\n"
> -"  -k, --native-aio     use kernel AIO implementation (on Linux only)\n"
> +"  -k, --native-aio     use kernel AIO implementation\n"
> +"                       (Linux only, prefer use of -i)\n"
> +"  -i, --aio=3DMODE       use AIO mode (threads, native or io_uring)\n"
>  "  -t, --cache=3DMODE     use the given cache mode for the image\n"
>  "  -d, --discard=3DMODE   use the given discard mode for the image\n"
>  "  -T, --trace [[enable=3D]<pattern>][,events=3D<file>][,file=3D<file>]\=
n"
> @@ -489,7 +499,7 @@ static QemuOptsList file_opts =3D {
>  int main(int argc, char **argv)
>  {
>      int readonly =3D 0;
> -    const char *sopt =3D "hVc:d:f:rsnCmkt:T:U";
> +    const char *sopt =3D "hVc:d:f:rsnCmki:t:T:U";
>      const struct option lopt[] =3D {
>          { "help", no_argument, NULL, 'h' },
>          { "version", no_argument, NULL, 'V' },
> @@ -501,6 +511,7 @@ int main(int argc, char **argv)
>          { "copy-on-read", no_argument, NULL, 'C' },
>          { "misalign", no_argument, NULL, 'm' },
>          { "native-aio", no_argument, NULL, 'k' },
> +        { "aio", required_argument, NULL, 'i' },
>          { "discard", required_argument, NULL, 'd' },
>          { "cache", required_argument, NULL, 't' },
>          { "trace", required_argument, NULL, 'T' },
> @@ -567,6 +578,11 @@ int main(int argc, char **argv)
>              break;
>          case 'k':
>              flags |=3D BDRV_O_NATIVE_AIO;

Missing break statement.

> +        case 'i':
> +            if (bdrv_parse_aio(optarg, &flags) < 0) {
> +                error_report("Invalid aio option: %s", optarg);
> +                exit(1);
> +            }
>              break;
>          case 't':
>              if (bdrv_parse_cache_mode(optarg, &flags, &writethrough) < 0=
) {
> --=20
> 2.21.0
>=20
>=20

--32u276st3Jlj2kUU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0/8yMACgkQnKSrs4Gr
c8jjowf7B0Jdiy8pFROB4wgd9JVyi3eyvzivy+NcDfJuZgUfRbGjcMN1lfzPgwwt
mF5CbusyXwQDj4SHMUrY+09Oc+NkoUDtZ4Ri/s+AFihJp23D5n55ShpljWK8FGNv
xtluItd3tNEHznlWlB+MAz2SwL7jRaVRK32Unvv/kBVi6eXobEkh8aICB11k6fTZ
Mt2pZphvgvkFS98dSH8LsDxZzobrCqqRsufXiJSVBg+YVQGUoZpCXsfXmyOqIC/p
dgESoM5BeTsitMyQTsT3wPNzylF/vHFrJDi21vefZ6KT8XJrcoaK2Y4aaPL2TdlB
BXvo1qeZ9++uHBlPVdZVNDQG/l2Psg==
=4eZg
-----END PGP SIGNATURE-----

--32u276st3Jlj2kUU--


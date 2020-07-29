Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207D9C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 10:31:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE9AE2076E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 10:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9lYl9ou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE9AE2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0jN4-0004sA-4a
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 06:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k0jM3-0004Gw-Ml; Wed, 29 Jul 2020 06:30:35 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43695)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k0jM2-0002jW-1C; Wed, 29 Jul 2020 06:30:35 -0400
Received: by mail-wr1-x443.google.com with SMTP id a15so21104669wrh.10;
 Wed, 29 Jul 2020 03:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=wv8WhaoimUnQFGcpBoct9wJ0DoqQoA7rT0yrZmmBj7U=;
 b=d9lYl9ouXt41AW9iDEAszVlwm12yr0bLeDydjiWz0h/lJ1nE2TIdtPp7l1cVjK/wQ6
 ZjtSjEj3vzeGGXc7TjVggzqoH2qRpjucAvyLJC/sYp/wygozsNMtZcHieYc/GkuBmABV
 4QL5GG+EQHc7GXfRTVu7amqUjls58B/Ljhc7eEESFc1ydJg+DDRrI4bRLZSLl3wYDPAF
 U1CUHR8xATCRVXq3kKJ0xd/PQBS1tPiLQLkaOzp5npLtZFV/rWc5ZbEhyH/qag2hi0yx
 VO/PNMz7ZkBqCJstarzB71Eeba8XUtNTPJ1OQ0aGyC3IEeyyXYVWTK7C64NZ4+0ipQvm
 aNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wv8WhaoimUnQFGcpBoct9wJ0DoqQoA7rT0yrZmmBj7U=;
 b=IglQLAG8fDfLCzZcpHGB/AbeT7dx47AGEHWPssKM3X9TBFEeu1dqODlz9oKxykCKgt
 NZzEKKZO2zCcpTHo2SndU1wyBESqq4MQJ7g8YBJO9rZLWPVrkxrw+ZgKx6sHUa4oAYDG
 8dfJa/dQ6wQ9vVOwcjqcsS1ZRFBskkToG6E1DJOa9MoUoB1ohMwx0UUhidt0QWZ/i3T+
 AkAvD5l5ttk2MtouFDwLbwbZCb8M46TUyngBJ6ryA5IGSuejV7SV+SFph/65fc+/kHlq
 gbUto6zWNhlf6NKehb6kWP7FZGIfFPteuU+Futaa41mcFCHGREJzEx0jfZQudiM8w11k
 xtuA==
X-Gm-Message-State: AOAM5308rV+/HKeTBiVIwBNkXFSb6ZDRpM76Xmhllbg6u5LYsUN4X+p9
 eACr5tU5L9n5GIqcwI7zSrU=
X-Google-Smtp-Source: ABdhPJybmFYWHEQdZNrQOg+A6iSW/DcEMNoMje48VI0eHqZqhcBUnx0z+T/+UYfOStTmWS1aIxD+Rg==
X-Received: by 2002:adf:ed88:: with SMTP id c8mr27264261wro.233.1596018632087; 
 Wed, 29 Jul 2020 03:30:32 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id w14sm4303862wrt.55.2020.07.29.03.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 03:30:30 -0700 (PDT)
Date: Wed, 29 Jul 2020 11:30:29 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Denis V. Lunev" <den@openvz.org>
Subject: Re: [PATCH 2/2] block: add logging facility for long standing IO
 requests
Message-ID: <20200729103029.GB37763@stefanha-x1.localdomain>
References: <20200710172711.8059-1-den@openvz.org>
 <20200710172711.8059-3-den@openvz.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline
In-Reply-To: <20200710172711.8059-3-den@openvz.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2020 at 08:27:11PM +0300, Denis V. Lunev wrote:
> +static void block_acct_report_long(BlockAcctStats *stats,
> +                                   BlockAcctCookie *cookie, int64_t late=
ncy_ns)
> +{
> +    unsigned latency_ms =3D latency_ns / 1000000;

Please use SCALE_MS.

> +    int64_t start_time_host_s;
> +    char buf[64];
> +    struct tm t;
> +    BlockDriverState *bs;
> +
> +    if (cookie->type =3D=3D BLOCK_ACCT_NONE) {
> +        return;
> +    }
> +    if (stats->latency_log_threshold_ms =3D=3D 0) {
> +        return;
> +    }
> +    if (latency_ms < stats->latency_log_threshold_ms) {
> +        return;
> +    }
> +
> +    start_time_host_s =3D cookie->start_time_ns / 1000000000ull;

Please use NANOSECONDS_PER_SECOND.

> diff --git a/blockdev.c b/blockdev.c
> index 31d5eaf6bf..d87260958c 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -625,7 +625,8 @@ static BlockBackend *blockdev_init(const char *file, =
QDict *bs_opts,
> =20
>          bs->detect_zeroes =3D detect_zeroes;
> =20
> -        block_acct_setup(blk_get_stats(blk), account_invalid, account_fa=
iled);
> +        block_acct_setup(blk_get_stats(blk), account_invalid, account_fa=
iled,
> +                qemu_opt_get_number(opts, "latency-log-threshold", 0));
> =20
>          if (!parse_stats_intervals(blk_get_stats(blk), interval_list, er=
rp)) {
>              blk_unref(blk);
> @@ -3740,6 +3741,10 @@ QemuOptsList qemu_common_drive_opts =3D {
>              .type =3D QEMU_OPT_BOOL,
>              .help =3D "whether to account for failed I/O operations "
>                      "in the statistics",
> +        },{
> +            .name =3D "latency-log-threshold",
> +            .type =3D QEMU_OPT_STRING,

QEMU_OPT_NUMBER?

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8hT8UACgkQnKSrs4Gr
c8iGgwgAg4AL0UjMcfgSci0tPviLTC+qgk5OJsxsNsiHzg1BUbfFLLSD3tb6QDZB
lnXbqli+njqc36Is59A9ppvTQkm2z3ZDaZU80ZT99WBqrQURWLx8QfPVmPe3srFp
1f/dZFmOVf2peoqQMpaQvyUvfmsdk0nppEukCoe+lwqdT03WApN4rO91YKL6Lai3
Xk2XAR+2Yczn04+Y9Ttuc5kEL1SzJlq7GniEUOAxZG0nqA6jhjzvmAnZZEPWJQXq
Mid7XefnEhiTmSujh9Ulvc4+LvS9ZaRSoBp9Y5f0XdgxWFmvkLStAM+4qWhLfNU4
e+jSjPaOjD6Tex312Vajv/o+IhXrGQ==
=i3e7
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--


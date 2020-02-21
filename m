Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE13AC35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:47:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAAAF208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdhdYLk+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAAAF208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58eC-0002NL-SJ
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:47:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36315)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j58cz-000157-TG
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:46:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j58cy-0006KK-Mv
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:46:01 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39276)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1j58cy-0006Jd-GS; Fri, 21 Feb 2020 08:46:00 -0500
Received: by mail-wr1-x443.google.com with SMTP id y11so2139942wrt.6;
 Fri, 21 Feb 2020 05:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=IrO6c+72x0jsUzCnXshzT3WiL0L2/uCWKXt2x5ppUOI=;
 b=WdhdYLk+A1S+UF/gloxWSUbgz9WRV1gCsF3SX5Fvw7tArZEYFR5bE/pk8pYGsd0Vwa
 vZTPuXiCjAYAngfnqDHtb6XsnGBljVe90WFQu+D/ci7dfJQBoTobjct8KIOykhql1IRt
 y9+z2WcvLVPEu/OvGOPa7TTGcJE969BJKnuPceFqZJuez2uRAdBkSEF1LXTyw+UqfucA
 y3pVrsEfvZsq3ZCzYqxVKbv526WkwlepywIqpWWsARwhI82xUMaeWV8HSzgJyFHWrhGq
 MWM9J3FpFqs7dVsNzYSexiAtCb2xWMeM4KivOc9TrrI6f18kPlBA557EsrBClRj9hgOX
 ll+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=IrO6c+72x0jsUzCnXshzT3WiL0L2/uCWKXt2x5ppUOI=;
 b=aV78rC2WUla5sNyg8XOy0bUZnWGxOW8rqCfZTyj7eos0RPhQ3evmACFQZ3tKUE0Eb2
 2llNR/oXVmLsRdfFEb7bI6BGVgwDTgG+4N8VIymkTrB2ZlmOCCPWsqq3SFQ5/lTdbItx
 oP7z9Qw0lCJKps6gWRuSxnwKizmTGtTMdmsFJrofUTweyPIVXIAAc8HtSQLmsyrB73Z/
 GP8uxg5edkygdN4OkxpiNUKczyDcnbpW6peoqZ5wdf9kOtl1HxHBaInEUwhzkLr9jpbg
 87TSR5y9Tmo9rV1ghy9/B8ATk6+4Lj9fGrnsGgSHyl8PkyPPp+ufeqUjHzyF8daIRWam
 pjDA==
X-Gm-Message-State: APjAAAUbQPBWJhVmLmsShStcC1e0mu0lTMYA10n4G6E2NQztjadZR3MU
 Ql2LT6rY4C/TpB5geiwJ6Ng=
X-Google-Smtp-Source: APXvYqyOA5/ZdYlJQ4Oh2F4rRH7NsWU7nG4+G7FXjgPm35KMNT0b7+Q5bOvEH6s5RztKPgzFtsKPRg==
X-Received: by 2002:adf:f850:: with SMTP id d16mr47812644wrq.161.1582292757914; 
 Fri, 21 Feb 2020 05:45:57 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id s1sm3928027wro.66.2020.02.21.05.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:45:56 -0800 (PST)
Date: Fri, 21 Feb 2020 13:45:55 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Subject: Re: [PATCH v1] block/nvme: introduce PMR support from NVMe 1.4 spec
Message-ID: <20200221134555.GK1484511@stefanha-x1.localdomain>
References: <20200218224811.30050-1-andrzej.jakowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OOq1TgGhe8eTwFBO"
Content-Disposition: inline
In-Reply-To: <20200218224811.30050-1-andrzej.jakowski@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: kwolf@redhat.com, Haozhong Zhang <haozhong.zhang@intel.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 keith.busch@intel.com, Zhang Yi <yi.z.zhang@linux.intel.com>,
 Junyan He <junyan.he@intel.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--OOq1TgGhe8eTwFBO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2020 at 03:48:11PM -0700, Andrzej Jakowski wrote:
> This patch introduces support for PMR that has been defined as part of NV=
Me 1.4
> spec. User can now specify a pmr_file which will be mmap'ed into qemu add=
ress
> space and subsequently in PCI BAR 2. Guest OS can perform mmio read and w=
rites
> to the PMR region that will stay persistent accross system reboot.
>=20
> Signed-off-by: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
> ---
>  hw/block/nvme.c       | 145 ++++++++++++++++++++++++++++++++++-
>  hw/block/nvme.h       |   5 ++
>  hw/block/trace-events |   5 ++
>  include/block/nvme.h  | 172 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 326 insertions(+), 1 deletion(-)

NVDIMM folks, please take a look.  There seems to be commonality here.

Can this use -object memory-backend-file instead of manually opening and
mapping a file?

Also CCing David Gilbert because there is some similarity with the
vhost-user-fs's DAX Window feature where QEMU mmaps regions of files
into a BAR.

> @@ -1303,6 +1327,38 @@ static const MemoryRegionOps nvme_cmb_ops =3D {
>      },
>  };
> =20
> +static void nvme_pmr_write(void *opaque, hwaddr addr, uint64_t data,
> +    unsigned size)
> +{
> +    NvmeCtrl *n =3D (NvmeCtrl *)opaque;
> +    stn_le_p(&n->pmrbuf[addr], size, data);
> +}
> +
> +static uint64_t nvme_pmr_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    NvmeCtrl *n =3D (NvmeCtrl *)opaque;
> +    if (!NVME_PMRCAP_PMRWBM(n->bar.pmrcap)) {
> +        int ret;
> +        ret =3D msync(n->pmrbuf, n->f_pmr_size, MS_SYNC);
> +        if (!ret) {
> +            NVME_GUEST_ERR(nvme_ub_mmiowr_pmrread_barrier,
> +                       "error while persisting data");
> +        }
> +    }

Why is msync(2) done on memory loads instead of stores?

--OOq1TgGhe8eTwFBO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5P3xMACgkQnKSrs4Gr
c8jK1wgAtCF1ehtsGiKD67pBiQmnHD0LeFGYsbLatsV1x8cbNakmrBZoCEuATB8m
avIWo96nGwnugDqdz4bOGQhIQ6o6dd2xuY+DnCokGAgMfNHbN1oeDpN8x8CvMbak
dpmmWgVP6EoIj0ynSggAg0/wIwDzc8BuLSJ8rPzN11yvaaZegz3snbHsxllKhBdL
20XFIiYCo0EBEEtAovgcHBF5+KXFfVSn8UtDwgUI0HZU7Qj+wIPTC6ukEvLODk5f
uUDQvBxo7Db/47YN3HvCqnJp3Zs1n1ZCMbgsTbjPp0c+iakD14yRhVfmPpY/xMEY
oxXOMHB+pJORm7X/8qr38lJFo5PsVQ==
=TDKk
-----END PGP SIGNATURE-----

--OOq1TgGhe8eTwFBO--


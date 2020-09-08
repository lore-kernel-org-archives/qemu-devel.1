Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F99FC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:13:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0DE520708
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qW3VEflM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0DE520708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFwAC-0007fa-Rr
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 05:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kFw9J-0006MS-I5; Wed, 09 Sep 2020 05:12:17 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37370)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kFw9H-0003Rr-W5; Wed, 09 Sep 2020 05:12:17 -0400
Received: by mail-wm1-x343.google.com with SMTP id a9so1583816wmm.2;
 Wed, 09 Sep 2020 02:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=RzK1fdV4GsKAM8E21F1ZtG0w+PIRDjmqlFK/GB0Mkuc=;
 b=qW3VEflM2I83kfl8YooPi2whO+cZkLwlzuPda529pktBDLVDOXwwqset49YT2bmd3O
 tjRJNd5kdNcyC4/onWNdLFimOJYFPFHccacenHuSBKPHW3Qgun/gt3p/D9RVuiVb9u4o
 yHujsapjJm7LKNeLq/pZ9RYwUuiQWTchv6uSHQSamgjhhO3Fl+EtSQGQ3EfV3hNPfk3O
 lAQqIbgoMNs4PzPJyMt40ORyZJ2H60FJigtBjc4k28dfw5UznBit3CsqZN9IOmLqRX/J
 EOmztgMCJPT3UJZOtXsaIom3rYXnmWzexoQFXTeyMUGoyT2JYKtWd3wc1MV/Zbwv4euO
 HykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=RzK1fdV4GsKAM8E21F1ZtG0w+PIRDjmqlFK/GB0Mkuc=;
 b=RDjrZP2uCPNYuqDmCrUYJmDgGkXlDMWWMwbHmWa92k8IS+l/6qjV9D2mWnQE1MuUbw
 yQ4eeEBSw+g0fYgMlClON3kPvQcl/h9Npl4kgZnhrF9KQu2jeHM1V7w9JRyPU4RujEvU
 2IXrHam8cEdJvgzIpiwYNG7avOdoyY0gfBuCnxfi/y0XORm/ZhDWLCCmAuRM5gJbOKqa
 wh/6XGwwhE9HZFyoNxi7Qa/dIWR5zlf3WSU2pgtB8V/PTtXEFncRlVRN4NN/pFG/sjfv
 1sfZa4KDWEwe2EHryn+6CbFKwsBlEF4Hte0+x81uqoK3iqsKdIV3Onsf3Em8jBZki3o7
 aEEg==
X-Gm-Message-State: AOAM533i1pj1Hh+HFKRuY8ipYSDLHNQiHKNFnLLhNrYpGiY7xQtg3sM0
 6W1s/L+qLUm8rsxcnnV/F6E=
X-Google-Smtp-Source: ABdhPJznaDr7w+6942jPNPL2YPTmgcXbg7qjcxMclGspeRra+rta7AGYK/6fGlfmZtAVtWlk6+9LqQ==
X-Received: by 2002:a1c:f619:: with SMTP id w25mr2513647wmc.62.1599642733544; 
 Wed, 09 Sep 2020 02:12:13 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id b194sm3077085wmd.42.2020.09.09.02.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 02:12:12 -0700 (PDT)
Date: Tue, 8 Sep 2020 15:10:46 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: add Stefan Hajnoczi as block/nvme.c
 maintainer
Message-ID: <20200908141046.GA7154@stefanha-x1.localdomain>
References: <20200907111632.90499-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <20200907111632.90499-1-stefanha@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 07, 2020 at 12:16:32PM +0100, Stefan Hajnoczi wrote:
> Development of the userspace NVMe block driver picked up again recently.
> After talking with Fam I am stepping up as block/nvme.c maintainer.
> Patches will be merged through my 'block' tree.
>=20
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Klaus Jensen <k.jensen@samsung.com>
> Cc: Fam Zheng <fam@euphon.net>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9XkOYACgkQnKSrs4Gr
c8hcDgf/bGZWvmK/luEd7fQuFKHjYdDgypVY+werk/HVhfbFl+jyRkbQgpaBmAMF
7KKwpcFT4CzxXpF4i+4rMw4mJOdPJtiEVcMw702yby3s13MbjsdanSXnxy5KZYHj
EgiDAxJAySFJlmtLT02Hjk/iDRflEgWvVcCkdPgieIzFHF5EFTJyGLiJE1h0yVSH
5EcexvA+gd3lXwu5licGjB59C6+Ei59V12uQSOYHndGkMsoOUsTyTo5gG+7CrgHo
485S6TLJPZ/D4kGYd0IaHDpXGvoez9byaNwAVDygBpzIs8azfoSIGGjRfJ0ETm4n
O6EwoJu22pdn/jW5THNIxO4Wi7g/Iw==
=/InN
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--


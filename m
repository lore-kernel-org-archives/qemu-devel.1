Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A6AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:38:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14C6D20786
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpRgv6PC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14C6D20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0N0Y-00069b-A1
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 06:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k0MzH-0004TV-2x; Tue, 28 Jul 2020 06:37:35 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:39637)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k0MzF-0002j4-Ib; Tue, 28 Jul 2020 06:37:34 -0400
Received: by mail-wm1-x32b.google.com with SMTP id t142so11312266wmt.4;
 Tue, 28 Jul 2020 03:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=auj3sQMa8Sg6EHOHIY6/vd+MYwdtq8kIo7akGMM8QCY=;
 b=UpRgv6PCsj4twVHvqpoHMReQEWCufLK/hUTP4JGcdLcdQtZlMwJ0x0LyCC8sMsiqHo
 hpV4dEtPiCgRol26uIRKH2hg2G21Z1tQ9DVEyjmVYjYzvIlJT0UcoNWLPKfXC1al2S7k
 KBXicsB/nFTH/Q678dE94A/GX71MYPa7ZORhR5sjylaKSi3Og5fz7A6itENPbsBp6RhW
 IZq7XQpH1CPZVpQ0GwjuCG+TLSEL5Ivo4vmELO5y9QDRAFtE5E6rdGeIxKozsTRl13FH
 ny04guiYHgNVwttwobjqMIBu1lJy7FPa/6ThNtbhtMQkYo93T20v6t35J40g8htdzz8K
 fAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=auj3sQMa8Sg6EHOHIY6/vd+MYwdtq8kIo7akGMM8QCY=;
 b=SNkxIkoWRq0JGbVzjOowVhmUBWbAtzrgcLNeBhW3DsFiHVuMitnpTGqMFXN5jH1sxP
 RCImoWV7IB6u2iSpKZPC+NCb9yBkbSfgOghltiACqMnhFhtOKxkTtkI+Lv2QmbjRdl0k
 0TJTURMySGQpFy7NQaEi+PCVHNOevwQILu7Wo6eRorWeEIXq8IPlFNbfJKOImFPfU9CD
 BD2aGINLI61g3lKo84leSgtoOTPfEPyIlAnabDWh/9KxvT/2wyRM61HMiHtCxynFNXZU
 woT2mHoUB2ns0RYnEzaE6CGz5EdlFauLh8l3LsG/+NF+58n5qIf6GOUN1b6L3sfIAlcL
 rXVg==
X-Gm-Message-State: AOAM5338gFPdsAQVMbe6rD/3lKHYH+DGNip4ydJvOHLNE1ibAXBoLTPT
 fsLVPQM06Hh+cWp5cRQwjfQ=
X-Google-Smtp-Source: ABdhPJycXJo7uh092jy6siXJ+6GPfxvxgP2vkE6yYmTN0BAyzXNXNzy8YuZtH4nNFUDaBi/4INsYMw==
X-Received: by 2002:a1c:c256:: with SMTP id s83mr3639046wmf.17.1595932651740; 
 Tue, 28 Jul 2020 03:37:31 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id g3sm18661341wrb.59.2020.07.28.03.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2020 03:37:30 -0700 (PDT)
Date: Tue, 28 Jul 2020 11:37:29 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Asmita Jha <asmita.jha82@gmail.com>
Subject: Re: Qemu installation error from source
Message-ID: <20200728103729.GD10336@stefanha-x1.localdomain>
References: <CAKKBCQoBmk3rA=Ht=AVZkOUc0zDVJCVyX1GLbEWK97hodOfqDA@mail.gmail.com>
 <20200629131227.GL31392@stefanha-x1.localdomain>
 <CAKKBCQrhrYNULaV2q9YGd1vxeeCrexVy_cMbQBjJKxaRKYvf3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="a2FkP9tdjPU2nyhF"
Content-Disposition: inline
In-Reply-To: <CAKKBCQrhrYNULaV2q9YGd1vxeeCrexVy_cMbQBjJKxaRKYvf3Q@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x32b.google.com
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
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--a2FkP9tdjPU2nyhF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2020 at 06:04:33AM +0530, Asmita Jha wrote:
> Thanks  for your response. I am not sure I compiled libbz2.
> Because while installing qemu from source , I just followed the steps as
> mentioned in wiki.
> I am noob in this field.
>=20
> I tried using ./configure --static, it gave an error as attached in
> screenshot.

In the screenshot the linker cannot find the library dependencies needed
to build QEMU.

There are Dockerfiles that show how to build QEMU on a number of Linux
distributions. For example, the Fedora Dockerfile is here:
tests/docker/dockerfiles/fedora.docker

This could help you in setting up the environment (which packages are
needed, etc).

Stefan

--a2FkP9tdjPU2nyhF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8f/+kACgkQnKSrs4Gr
c8gN5ggAjm1II0svUf41aUvq60JWEJE5vMPKMUBQH91AVJXIXgTw0pFJ4a+w9Aro
+p2oyXoq4faJnAk6pERYw8sSXCQX2Ji+ePezILMQHPokKqvnjfcgmDsTb936bmYi
lmGaQ3TucZNTEjJiP3omQ/SPNs0LcXnx9Tg6sbzHzs4aBuM6exA2pxI1avXokm72
mBkb10lepjTpfgkFXvuh4QhOV1Xx40r/dyfiQFzB5lUwYT3kTLmxH+tuactAAKAV
DYN2Uu3tz31TFIgp4H2fUDcjfo3TWdfUDS+0/BEAqO42LAxYmXAJteQUCdrxOclR
14OhM4TxM1ONa7+oErylWEbollWTaA==
=VtAB
-----END PGP SIGNATURE-----

--a2FkP9tdjPU2nyhF--


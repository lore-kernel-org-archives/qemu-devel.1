Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F417C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:18:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1A7F20723
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sn+5a3BV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A7F20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnjka-0006Pf-8Z
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 10:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jnjiZ-0003r0-HZ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:16:07 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35751)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jnjiX-0004Iy-QC
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:16:07 -0400
Received: by mail-wm1-x344.google.com with SMTP id g21so3414312wmg.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 07:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ve11soKIvGhQlYJuWeIT4U79417CZFGjqvWFfV4CPnQ=;
 b=Sn+5a3BVvMPDLt/91qVadHkrBEmvCAzMNv3I+RHxBG90w9GZ0FgCeGCqu0SdIOMeq2
 Uw0IRZeruRsN801jBBCjiLwk8dNCLuaKBbymcOsPHOENv8gmq2YpAMEaIUVr4jNsMPCb
 kGFJ/Nul1fx5SGoMuKD2ujN48bxMNt+p2S98xqp5ht/PRMuTvvCMfP/oOjO75PrmVGzn
 F+jh7Ru7BVgQ7wS+MxhVsjwLNeJ/osEP2gfeOY0QlUJmDjKGn0L5nZUtwK3f5EdsUlbB
 oisnRv4mBDOIeNOSdZAVVdS79o2sluD3oqu06ps0eQsOz4tdA20W90Kc/rO3bC+W0AnJ
 mQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ve11soKIvGhQlYJuWeIT4U79417CZFGjqvWFfV4CPnQ=;
 b=kzPV7V5TtHUrv5/KhFFOvU8IBEOYbY0RDQV6ZijTwUo2JIWJRA48GEut3qxGqra9WE
 VOipNq8iXa28UtE+w3sjuiIZC1Hpi74TAljeXkDTnS6K/ufLeg/SYi7kiojeShzOXSD6
 kyIc9i5+sQVrS86HL9asMEIlnAgfJRJh/HPwReaysXsmjSAOpep1ZWJDGLhm1rcstea4
 22xdvUhSq1trmPn/oyV1hIu+1A6/M2y3UCJJm3fetscWf9s90c3svSG9h9fGEVUeBA+Q
 mFUBIQCTWs5AkF9uY2M21XZEi4Q0h2OJULBef+9WXYoA0m/fnXz24YwKR8fPNfvaxcqU
 OxRg==
X-Gm-Message-State: AOAM531u9Cl+a4uqofbVAsMSzGO/RwwDhrIcmX69yWGOfE76P6LgX9u3
 iUBMrQcUHgF91h0zhZnMdLA=
X-Google-Smtp-Source: ABdhPJxTUJeDRagWCVeIfPdi8zIEIxNnKwGrCsHMZRly7qpcJBrw/m5pENc26RVA6j9HhkwtVKE6/w==
X-Received: by 2002:a1c:2b86:: with SMTP id r128mr25687065wmr.13.1592921764040; 
 Tue, 23 Jun 2020 07:16:04 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id f17sm2039744wrq.3.2020.06.23.07.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 07:16:03 -0700 (PDT)
Date: Tue, 23 Jun 2020 15:16:01 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [RFC PATCH 0/3] fuzz: add generic fuzzer
Message-ID: <20200623141601.GL36568@stefanha-x1.localdomain>
References: <20200611055651.13784-1-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="QWRRbczYj8mXuejp"
Content-Disposition: inline
In-Reply-To: <20200611055651.13784-1-alxndr@bu.edu>
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, f4bug@amsat.org, darren.kenny@oracle.com,
 bsd@redhat.com, dstepanov.src@gmail.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--QWRRbczYj8mXuejp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2020 at 01:56:48AM -0400, Alexander Bulekov wrote:
> These patches add a generic fuzzer for virtual devices. This should
> allow us to fuzz devices that accept inputs over MMIO, PIO and DMA
> without any device-specific code.
>=20
> Example:
> QEMU_FUZZ_ARGS=3D"-device virtio-net" \
> FUZZ_REGION_WHITELIST=3D"virtio pci-" \
> ./i386-softmmu/qemu-fuzz-i386 --fuzz-target=3Dgeneral-pci-enum-fuzz
>=20
> The above command will add a virtio-net device to the QEMU arguments and
> restrict the fuzzer to only interact with MMIO and PIO regions with
> names that contain "virtio" or "pci-". I find these names using the info
> mtree monitor command.=20
>=20
> Basically, the fuzzer splits the input into a series of commands, such
> as mmio_write, pio_write, etc. Additionally, these patches add "hooks"
> to functions that are typically used by virtual-devices to read from RAM
> (DMA). These hooks attempt to populate these DMA regions with fuzzed
> data, just in time.  There are some differences from my reference code
> that seem to result in performance issues that I am still trying to iron
> out. I also need to figure out how to add the DMA "hooks" in a neat way.
> Maybe I can use -Wl,--wrap for this. I appreciate any feedback.
>=20
> Alexander Bulekov (3):
>   fuzz: add a general fuzzer for any qemu arguments
>   fuzz: add support for fuzzing DMA regions
>   fuzz: Add callbacks for dma-access functions
>=20
>  exec.c                                |  17 +-
>  include/exec/memory.h                 |   8 +
>  include/exec/memory_ldst_cached.inc.h |   9 +
>  include/sysemu/dma.h                  |   5 +-
>  memory_ldst.inc.c                     |  12 +
>  tests/qtest/fuzz/Makefile.include     |   1 +
>  tests/qtest/fuzz/general_fuzz.c       | 556 ++++++++++++++++++++++++++
>  7 files changed, 606 insertions(+), 2 deletions(-)
>  create mode 100644 tests/qtest/fuzz/general_fuzz.c

CCing Dima in case he is interested in this generic fuzzing approach.

Stefan

--QWRRbczYj8mXuejp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7yDqEACgkQnKSrs4Gr
c8jjoggAmueA8E4fmB1xW/8kTfM+bAP+Cynl9eH9E3SYunbDz08yHZzpUYkssF2K
XBLZh017byxar7F1KzdKsO1mjYDESd82yzeLaOf8GTHljDQkgguvSGu/CukWKx3A
qhevu8hwFuC2MKmK0MrlI/c0ClZh8LEiEmBpoSnOAEJKYYu3j+25+TyubJ/0Hgog
W+S8qiO4j7Lzdz3szb9MN5cl2yuQWxXSKcUfzho1hK45Xqxx095/FqA5CkF472iK
5US+I7X6ikjMED8bYVDf3Aoc2qv+OvhvQQmXsotbITB810YJcjc/hMFbbuZApD++
K3/IFBeZ1fSuwQ452p8F/fIWC8ghdw==
=pDZ1
-----END PGP SIGNATURE-----

--QWRRbczYj8mXuejp--


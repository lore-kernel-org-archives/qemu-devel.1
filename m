Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F565C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 12:51:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EAC72053B
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 12:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qb/9EV1S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EAC72053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdvWb-0000Tn-H5
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 08:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jdvVp-0008Gp-Ly; Wed, 27 May 2020 08:50:25 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53845)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jdvVo-0003bv-KA; Wed, 27 May 2020 08:50:25 -0400
Received: by mail-wm1-x344.google.com with SMTP id l26so2922266wme.3;
 Wed, 27 May 2020 05:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=cdrcJ4tWIfsVuxC8hlUvY3Vp2ojYRkqC5WIJtimHwTU=;
 b=Qb/9EV1SoXRumIdt451LiMfrP3palf0o3pCbV9EJDh3oixF08Q02mkpTauewUEiulH
 ck+dIphz4ZcchcqM92LxsSkr06BwJitG8uPFcRkXohnZTV8fzTtR4zBLs1WxSnYVdpb2
 y0vSjBImfDl24Rd3++BlCvQMJXJw5+2L+vv2XTu9VBTt2VsEbrXEYbw8tcswNWlNNZ1Z
 7BJKC5H9d1z9ektCQxwTuLCWYxuCdRKTdh+5wQWCLesRoBtkn1NuDBsY+7mpRYmS6KjL
 IiPPPOTIMKf1dnaM5T5IN+I4xu5PgxPID4WARUl6KvPhv7bqbcZa9JzH6ieZNBVgnvsk
 uoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cdrcJ4tWIfsVuxC8hlUvY3Vp2ojYRkqC5WIJtimHwTU=;
 b=sh04wcIT0jMpTn9AYGtQyN/ObWlK0jSP48wzB8qsSSXD0JC+mzATfTiVlwOEaeYq3u
 UjuFKmMwPFBlNSTSiH6+ZaCgm0fxW51rFkPKyAzwRNFmkpeDmshZsis5+e+QquiNaWn7
 SQb7ZCyu8NrradIkmBqUMBsyEeMxfo5vQPRXrhAlqd7lcvFuUOMfcRofLrNy/d+TKvNX
 7zOVtSgivC86lIhHAhckhi9SRhZOEaccVhUXXmP9HR+4LCMzpUz7rxt0RDAqrB8rzOBl
 QmdT9T5deESXKqxT8R2FtQsIpMeBikv3140WxK3jioL+2TNRcBfTn0OzGzRNWY6JANLm
 lYrQ==
X-Gm-Message-State: AOAM533ZdJEtor3ABTyJcD58+3BryujQjNcSYxIowggKvTI+2jQtkAKT
 Akk1e0eT3nNs0o4ZOmSl8EA=
X-Google-Smtp-Source: ABdhPJx9+sVo+lrTBMR5cFeDIxZttqP6lc8rsCm2Bj5xJirRxujFsWhyEJoqmSpv4B25OtYzyO5VMg==
X-Received: by 2002:a1c:bb05:: with SMTP id l5mr3989327wmf.141.1590583819233; 
 Wed, 27 May 2020 05:50:19 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id m23sm2612038wmg.45.2020.05.27.05.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 05:50:17 -0700 (PDT)
Date: Wed, 27 May 2020 13:50:16 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 0/4] memory: Add memory_region_msync() & make NVMe
 emulated device generic
Message-ID: <20200527125016.GF29137@stefanha-x1.localdomain>
References: <20200508062456.23344-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vKFfOv5t3oGVpiF+"
Content-Disposition: inline
In-Reply-To: <20200508062456.23344-1-philmd@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Beata Michalska <beata.michalska@linaro.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--vKFfOv5t3oGVpiF+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 08, 2020 at 08:24:52AM +0200, Philippe Mathieu-Daud=E9 wrote:
> Let the NVMe emulated device be target-agnostic.
>=20
> It is not clear if dccvap_writefn() really needs
> memory_region_writeback() or could use memory_region_msync().
>=20
> Philippe Mathieu-Daud=E9 (4):
>   memory: Rename memory_region_do_writeback -> memory_region_writeback
>   memory: Extract memory_region_msync() from memory_region_writeback()
>   hw/block: Let the NVMe emulated device be target-agnostic
>   exec: Rename qemu_ram_writeback() as qemu_ram_msync()
>=20
>  include/exec/memory.h   | 15 +++++++++++++--
>  include/exec/ram_addr.h |  4 ++--
>  exec.c                  |  2 +-
>  hw/block/nvme.c         |  6 ++----
>  memory.c                | 12 +++++++++---
>  target/arm/helper.c     |  2 +-
>  hw/block/Makefile.objs  |  2 +-
>  7 files changed, 29 insertions(+), 14 deletions(-)

Thanks, applied to my block tree with Paolo's Acked-by:
https://github.com/stefanha/qemu/commits/block

Stefan

--vKFfOv5t3oGVpiF+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7OYggACgkQnKSrs4Gr
c8hgRgf8CC2QMO6EXSDjEInBPXt7ihx86t6J0HKkhspJOMYpMapcV0JSSx1/IWQd
AAUbxr9JbVNgZGImgJkSkBzeZ0JernnPpuQSPs/S1AaoeNUZp0TunXbfFFy2zoL+
oF1R8KackG02+SktcfQ7vWvyG0NbuGam172T182qI31MQkNJ+TBBwfR9rludjfBo
0+QkP5KmYcg/k53ryHGkmguFoZJ+VtGk4q89PH+A0lKTIEqvY6sXBGXb5EVWJYA3
igazLJGMqQhcFF6voi1Vwn+292geGb4IVHyE1qE4pewEFoMTj0SojvRAUx0c+XSc
oHyMC0td5UotWyrVS/CPChcovByAYw==
=ZKmE
-----END PGP SIGNATURE-----

--vKFfOv5t3oGVpiF+--


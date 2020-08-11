Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80191C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 09:32:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 434C120774
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 09:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JDcXinRP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 434C120774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Qdo-0007gf-Ji
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 05:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5Qd0-00079M-DG
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 05:31:30 -0400
Received: from mail-oo1-xc42.google.com ([2607:f8b0:4864:20::c42]:35614)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5Qcy-0000yW-DY
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 05:31:30 -0400
Received: by mail-oo1-xc42.google.com with SMTP id j19so2493303oor.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 02:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=u7vs3E5v2+jUD7A2WcwSVIjpez4PlW7durX91CB2YE4=;
 b=JDcXinRPfcST7ZhlfTaYuzkT/EmQCn/OZ1gJlrxR2R3DEdX5dx1Z3c7kcs669LnVut
 co1bOipvzBdH7bSe20+YUeaG49Vsp8CYkzDPF4HfU2PJSZKEIIV8OX0BZ53GZ0KB4I/I
 Ita2r72MYREzqmwiPET110NC1yjZgVn4/+nXC9IapyCGvRBBIc6EjWnbmSsv5bMI4iah
 z6/mC96T4WGkcYhb6/l3Q7vGcuXxUC+JFYawi+deySZZSkhyNu/azafBwJ5gI30QkEmI
 9ZFm5JAt93OeHhbRNEJrzKGh5re9q0kZzncsy9vU9n4ZWFeKbkig0dNjsIr3BJK8Dz0j
 tDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u7vs3E5v2+jUD7A2WcwSVIjpez4PlW7durX91CB2YE4=;
 b=Xx29/i4gEkj8TcD+tv9OjJh/AmVCFhsbipV50sJ35AtV024QzAjCdipQ5bkDanKMs6
 fwZ/TpDyvkoy0bFo6ns/OZLnyh1FxI29uPejbmFHIpYf/zj7+QCiu6aObXSWysAL/tRo
 Y/oBTEKHDPgjDEwV8nGkwEhxaOsVLFWclwr1S67hCCAswYMxEUZ9yicn9vGP2A00Un+2
 mIEm6NjCb67W+bKeHEtXypYLA04k7Q4oiu5r6WHoLLj9JFPnknmrGP1j8fpt2/qydsMM
 K4qxsy+VEpQXuYMTcZuFXtwfkuUjHZUOi7VyWLMapFpO8tcHiKPwvnwtK+gVQLudUWRg
 P6nQ==
X-Gm-Message-State: AOAM533eM5wds4AL8kq440Yhw03ztorRc/aiF9KA+lRJlL2+MZohgo5n
 7VNP2qF11oJiUQekKukQoQO84gEn7RydC0Z+dSotBuIv6ws=
X-Google-Smtp-Source: ABdhPJzr/Igg9N4kNLy5uJjq6blCVy91IBUluh5B3U3uuWwvvDiTfz3HHaoVg8XydnXLA4bYNCG5IiOA1obe0rmro6c=
X-Received: by 2002:a4a:4949:: with SMTP id z70mr4324325ooa.85.1597138286271; 
 Tue, 11 Aug 2020 02:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200811012759.16329-1-gromero@linux.ibm.com>
In-Reply-To: <20200811012759.16329-1-gromero@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Aug 2020 10:31:15 +0100
Message-ID: <CAFEAcA9U9Q9QCm+Pk+ktnxxRGrC3F3UdQwp-bvGBZ6x2EY1oMw@mail.gmail.com>
Subject: Re: [PATCH] target/ppc: Integrate icount to purr, vtb, and tbu40
To: Gustavo Romero <gromero@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c42;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 11 Aug 2020 at 02:29, Gustavo Romero <gromero@linux.ibm.com> wrote:
>
> Currently if option '-icount auto' is passed to the QEMU TCG to enable
> counting instructions the VM crashes with the following error report when
> Linux runs on it:
>
> qemu-system-ppc64: Bad icount read
>
> This happens because read/write access to the SPRs PURR, VTB, and TBU40
> is not integrated to the icount framework.
>
> This commit fixes that issue by making the read/write access of these
> SPRs aware of icount framework, adding the proper gen_io_start/end() calls
> before/after calling the helpers to load/store these SPRs in TCG.
>
> Signed-off-by: Gustavo Romero <gromero@linux.ibm.com>
> @@ -284,12 +284,26 @@ static void spr_write_atbu(DisasContext *ctx, int sprn, int gprn)
>  ATTRIBUTE_UNUSED
>  static void spr_read_purr(DisasContext *ctx, int gprn, int sprn)
>  {
> +    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
> +        gen_io_start();
> +    }
>      gen_helper_load_purr(cpu_gpr[gprn], cpu_env);
> +    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
> +        gen_io_end();
> +        gen_stop_exception(ctx);
> +    }

You don't want to call gen_io_end; you just need to ensure that
you end the TB immediately after this insn. See
docs/devel/tcg-icount.rst.

thanks
-- PMM


Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A0AC55179
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 17:04:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B34C247CC
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 17:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NpmfogKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B34C247CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXos9-0000li-EZ
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 13:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXodM-0008Kn-Qv
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 12:49:12 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:45528)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXodL-0002CG-7v
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 12:49:12 -0400
Received: by mail-ej1-x641.google.com with SMTP id dt13so8265667ejb.12
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 09:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W8AIxd2d90pseoCx4PorOoXAmi2ViyGrSqUvQu7W0BI=;
 b=NpmfogKNz+ro3T++l+PUqIxTDxPF3gZSBXXw3ejR2A5lZAsXjon1hurD5/VfDej3R5
 NlKaPEMSg1a7gDWhjgOY8AYMq7eva/fs2Y7i25iK/EJst8RK/3HBEd7WAnkbK9Pl8/lL
 0EThcpfxbyEsSqh0nv0xRaP9C84IQqEc1luqRVj4ke0rK3SMXqFwZSsYwzSfYx2WaAE2
 HdD42kQFwo6G0i/Wex4BXfhYkygw6th/3ib4m1to0RC5/zHBUj5+198PrjQCW9foCiLm
 AdRWr7M2OuYHKODz0w4zdh6UuDwdQyZVshI9xahzs7rDzVVYPva4E3fGe9SKB2g3t9RE
 F2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W8AIxd2d90pseoCx4PorOoXAmi2ViyGrSqUvQu7W0BI=;
 b=VE5uNp3atIguNDqtS8UZ6Sp5uMwe1aqaVv1L2eWCxAYeAUMDausAGiiBAaLhhCpgav
 jVa0V8dIR1p6Z4mIses/DGtowoYdHnDLMkXtvdwbfeYIZDgB3NCsts7dqKiJKd5W3OaR
 cR107qJ2C5d97EigkuZifEQvHuU/Z+LKWx7XOrtgvLTVDBSw38eTANGEuB22tTBWSIiQ
 Hx03/51a5QjMQ26agyeZgbdNevnvuIitv7jQPoao3rRxvIPMoVkipMPX+QUYXBjc5dk6
 T8vFa2+UHxTBiLV9Xa9fqhtfdfZxHEkexYfdN+3T15peD6C0qiuxJTaaq6Qc4kJW9zqc
 nKRQ==
X-Gm-Message-State: AOAM531TsNOSdmG6CNWkGNd39WQUr+KOWkD0kZ0CrpBz7DNVGsq9+I4v
 0ler6S3Lwu7CocfO1RV1ApM/RD7wG138Byza2+J8SQ==
X-Google-Smtp-Source: ABdhPJy3uzoH6YFGPtfNhVh4ddApVkcgInsOFbclhdAtJlWF9KO18kEJVnOgCSofIK71DuPBy4PBDR6QNoEUJGgThx8=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr8186452ejk.407.1603903749610; 
 Wed, 28 Oct 2020 09:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201028032703.201526-1-richard.henderson@linaro.org>
In-Reply-To: <20201028032703.201526-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Oct 2020 16:48:58 +0000
Message-ID: <CAFEAcA9v7VHpy48rRShyei_TQpzt=_HWVitGEuaybpG9w7-y_g@mail.gmail.com>
Subject: Re: [PATCH 00/11] target/arm: Fix neon reg offsets
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 28 Oct 2020 at 03:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Much of the existing usage of neon_reg_offset is broken for
> big-endian hosts, as it computes the offset of the first
> 32-bit unit, not the offset of the entire vector register.
>
> Fix this by separating out the different usages.  Make the
> whole thing look a bit more like the aarch64 code.

I haven't reviewed this yet but it fixes a lot of the
problems I saw in my risu run on an s390x box, and I
don't see any regressions on x86-64. However these still
fail on s390x compared to an x86-64 host:

insn_VPADD_float_f16.risu.bin FAIL
insn_VPMAX_float_f16.risu.bin FAIL
insn_VPMIN_float_f16.risu.bin FAIL
insn_VSDOT_s.risu.bin FAIL
insn_VUDOT_s.risu.bin FAIL

thanks
-- PMM


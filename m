Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4660BC35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:10:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12BB621744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vq6/v1KG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12BB621744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6aux-0000il-7g
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 09:10:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38991)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6aDS-00023R-OK
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:25:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6aDR-0006Hj-Q4
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:25:38 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37643)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6aDR-0006HU-KU
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:25:37 -0500
Received: by mail-ot1-x342.google.com with SMTP id b3so12030533otp.4
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 05:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PzMVoR91HswdwnauVZ684KVvcNe5IwZKVBtZwTajq84=;
 b=Vq6/v1KGVJEsPf8/2h2ExtDqo3KjTARcXNeTRaMDhdaLiJ/Gk5rWlUi13YDBYhYSkq
 yeq8VNZBKFFubhW+JviIEC3qGXiA+657zX7AHVLQs1HC4Ds0l8qHbyUMJ32X3JMF5EC1
 tTBaqIfRSTgxOi+CphAOuckKkncrFowxgOrtKupF6EhVTq0/QECqUHgoAsLhjWPc0bQo
 CqnMnLcX5tTSmGeQTqsiVw1lLir3+QTbOpDaRCKtHfG4xrpM6cTTkbFewYYaQp4R7fFu
 LJ/dlGReXgyZaGKk9DM+klg+BQRR46rIZA/etofaL7hnY2lWPKHyprj/YGPRWiLDmToI
 A4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PzMVoR91HswdwnauVZ684KVvcNe5IwZKVBtZwTajq84=;
 b=h7nJpPSHPF5xS8FQIqYV5GDr7Skqsz4kcXJEsAGbD93jQ9NwHVzvjDJ8uS9IFLqLOt
 l5zvJz0nXfxqyerHUAL0rvx4yRsmvbfj6ojVSb6g3X59HUbGYp1OOzc0aBVw1jdvxNZP
 zSWOdbeZyZm6rFn6IZ79N//litoUinZcB4asNPaWFKK/JkyoP5wD5HRaO8hKE53QBSTR
 X8Fv+cfNlLdW9CZwjKsMTqiNKV3NO7GkhWTFleDpJQVx2+1aIIMAjgPQS1BdQITdeVRk
 B/PQv2p5oZD6xaBn/OUKzSSkI/PfZP1DatdmbyZoo5D7lFMpuxPt27HQgDusAZHxWrAy
 BhYQ==
X-Gm-Message-State: APjAAAU4VUt3NH8ByThNIJXjuMQqE83MVhlN39RV6Yad9llvHwMu/TLN
 cv8qUe5V/7XYLhSPlSeSPj/Koq5qvxDOc5vD0vCMMw==
X-Google-Smtp-Source: APXvYqz+SQgDPQrznzdlMefi/OOH/89uTvSUCCqgFE5U3TLdhxPVo0DrlwxmXMXQJrqqNlR8NMBiWybVmfRlAZDFIVI=
X-Received: by 2002:a05:6830:1184:: with SMTP id
 u4mr42522673otq.221.1582637136635; 
 Tue, 25 Feb 2020 05:25:36 -0800 (PST)
MIME-Version: 1.0
References: <20200224222232.13807-1-richard.henderson@linaro.org>
 <20200224222232.13807-10-richard.henderson@linaro.org>
In-Reply-To: <20200224222232.13807-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2020 13:25:25 +0000
Message-ID: <CAFEAcA---ijYQjSGCU4o3Ju7DO2FDScPEJ+3hqRX-RKeXNPCJw@mail.gmail.com>
Subject: Re: [PATCH v2 09/17] target/arm: Replace ARM_FEATURE_VFP4 with
 isar_feature_aa32_simdfmac
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 24 Feb 2020 at 22:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> All remaining tests for VFP4 are for fused multiply-add insns.
>
> Since the MVFR1 field is used for both VFP and NEON, move its adjustment
> from the !has_neon block to the (!has_vfp && !has_neon) block.
>
> Test for vfp of the appropraite width alongside the test for simdfmac

"appropriate"

> within translate-vfp.inc.c.  Within disas_neon_data_insn, we have
> already tested for ARM_FEATURE_NEON.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


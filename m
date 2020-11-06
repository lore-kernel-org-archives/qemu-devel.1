Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C05DC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 15:32:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA0CF208C7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 15:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N+MzzDre"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA0CF208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb3ic-00012e-JD
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 10:32:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb3h9-0007mo-ME
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 10:30:31 -0500
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:46016)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb3h7-0002DN-Q2
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 10:30:31 -0500
Received: by mail-ej1-x642.google.com with SMTP id dk16so2447676ejb.12
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 07:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Gj7TIZbVpz9+25EPxoPQ0h3niMnwTRMmEv0Csy95OVU=;
 b=N+MzzDreQ8khAfdPv2Ma67CiftIdk3lGSzBhGL1v5IbjNHOzXsd5hrCRWA/7NOMNY0
 kMHrJ7F5GBfjYDjgCHOcTaJM1+FIN0MbdDfyB69H8G1mgX40gXODm1YC8JsMFkT29Kin
 27N62XmhU7Obk3ps8yDwwTEn+eAR18sA1TKt31a8QRKapKZTxzavVWwXXRMZZuwV+WMi
 i7wGUI/szc8RdxeRPuMp8qPSdZc1L6vF2wjbCB/iq9Vqv65hq0OhaBaPxBwv8RuzFayD
 2EywGNZ2w2eERwKXJD3ZK4Mu5+0DhdSy5xezaaqlezd3W0IiqLIo5mUL0LyoM12mn2hy
 wG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Gj7TIZbVpz9+25EPxoPQ0h3niMnwTRMmEv0Csy95OVU=;
 b=bGdtBuBWRPQ01YvWHpBX/j2vSisSWRszAvoPtM+pjRVHxd4Aiw9MeKorp81dKJuEJq
 QFtyFwsgU2aEhvkoFVbIp0nHdoj3U+ZQaIh6Lei3pft/dQxUzvIaDpxKEgep76d/BFM7
 54lVJl8n5OE7C1B+1NXO4NucFTE1sbl2cKBkJAUiaUks5ra8PlDdOxasE+yqvrnnEO5s
 XzNm0L2MRaHqIbSEBO4iuRf94J0d8Cfe1txf+Rfx/XbsN5n8crsbYnxnSvfSzH6zKd9h
 rEerj7BdNT0s5/4Q2xEuxhOBFJXqEAcs+LEg8Z0mWhHXHI3IyqvGR/k21kDgywfTZUe8
 58xg==
X-Gm-Message-State: AOAM530exKOiHruNeGUKCQfyR1bB3l4twKVRw/I7CUw4OfWRgS7+lGo6
 VwgLE5soCuzahRr8/u/uXq23I1OlKEJMypnFbu4P8BQT8Ck=
X-Google-Smtp-Source: ABdhPJz/1mkB3Go+37bHHrZhiA5R654Am3YOwaw8UqD1Ke/KtL0wjGGoFlNpueSsO4qqM2XVC2hlPberRA+lqpXGc1Q=
X-Received: by 2002:a17:906:7254:: with SMTP id
 n20mr2449364ejk.382.1604676627944; 
 Fri, 06 Nov 2020 07:30:27 -0800 (PST)
MIME-Version: 1.0
References: <20201106152738.26026-1-peter.maydell@linaro.org>
In-Reply-To: <20201106152738.26026-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Nov 2020 15:30:17 +0000
Message-ID: <CAFEAcA90fXJPwf_K4bpdsMSgq6FiL-f3q6JFiv3eV8ZXYqQ63A@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] linux/sparc: more get/set_context fixes
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
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
Cc: Giuseppe Musacchio <thatlemon@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Nov 2020 at 15:27, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Based-on: 20201105212314.9628-1-peter.maydell@linaro.org
> ("[PATCH for-5.2 0/3] linux-user: fix various sparc64 guest bugs")
>
> This series fixes a few more issues with our sparc linux-user
> sparc64_get_context() and sparc64_set_context() implementation:
>  * we weren't handling FPU regs correctly, and also the way
>    we coded the handling triggered Coverity warnings
>  * some stray pointless error checks
>  * we shouldn't restore %g7 in set_context
>  * we weren't saving and restoring tstate correctly

The 'v2' in the subject tag is wrong, incidentally; this is
the first version of this series :-)

-- PMM


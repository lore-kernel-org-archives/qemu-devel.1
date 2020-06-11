Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D21BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 09:39:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25FB220656
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 09:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h50EN9bk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25FB220656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjJgF-0000eS-Ad
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 05:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjJfR-0008AE-LZ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 05:38:37 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45440)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjJfQ-00063t-L7
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 05:38:37 -0400
Received: by mail-ot1-x341.google.com with SMTP id m2so4039359otr.12
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 02:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=o2VvQfxFAehKBrNRW46ubZGSOcLPQ4INwX5PdjGMNqQ=;
 b=h50EN9bk7jGbvfQB2FHAe9qcTZA7iiH0sj08SfaO4Usg60N5T3KrGmW540wQQfLebP
 FZ5fzn8jk4TWrVZeNVGnqGBfaKVRf/ktmiXixnAMyrkDn4CvTsmJkneOeM1guEp+AdQf
 OrbPptzjKXnQ13AE1Gpa0jkwi+p02aMtC3Q0hIC+lPCYqFVnvirGFwb0xekQ5QraaZ+S
 JZIbfUJJ5Y7t19L8E07cUZACmFA9OmuaCT2BJWzx0gyHJUgAAOO4oMe+KIpDlWUL42rq
 WruSWjSEm0Ye/KEqnyIYKytHmxCYe+M8GcW7gsfXG4KA6JnbBD6R0REwrnYhk358PdpH
 fNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=o2VvQfxFAehKBrNRW46ubZGSOcLPQ4INwX5PdjGMNqQ=;
 b=liyCQ3k0J3oHZOY9pFxxULjLM0pj9QkP+bvCN2/3lYBWZ/rU4bajnmeUZ9Ye4epGF7
 KqRBPzHAdyvWCONGQH+0xnFAITA+1dZDvPZRUIIKNsKTBB+IDlIYFFfnmXB+o9qyJoi+
 hllz+Ul3y4u2jjL5Q6Zrp5GcrTKNOTn9guU2gLB6LdPGcKR1MtVUQr6TrXE4fvs2CyVA
 iH7OlO9YB6/r4qslGesFcEkk20D+sqV51/Ihsqqy2P5s0kyur4rAwur5wDP/pJOQG8Bq
 lhBcFa439brsYrmm6fQTV1Vv+yQXR+/zKwtQW8ujxCrGbY5dRLhl9SiW8bIBS9qMOy0n
 BO0Q==
X-Gm-Message-State: AOAM53397ByYAE1H0samsiliGj11S7TEEn2254FJZ7cE9nBJpm9aSUnE
 v9p9STGCj0ZpojulsgzmQSlVUNZvG4kcE8Gf3RVDrA==
X-Google-Smtp-Source: ABdhPJzpjolHPQGGWdV0WKkPmncyKJ46oRJ68EC++um5q7CIis0V4ptZ4uMKiMw5aKYZ71SgkVxkX6v0sruh9hrxaFw=
X-Received: by 2002:a05:6830:18da:: with SMTP id
 v26mr6103830ote.135.1591868309193; 
 Thu, 11 Jun 2020 02:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200521192133.127559-1-hskinnemoen@google.com>
 <20200521192133.127559-6-hskinnemoen@google.com>
 <18fa4025-0a2a-4427-b74f-2b1b678e0661@kaod.org>
 <CAFQmdRY9f6tV7VoDOFpRJ0x0hr_0EAaGqZwmXnkJpbvmbF4FVQ@mail.gmail.com>
 <5f0864e4-5e63-4819-1f30-68a5f207e275@kaod.org>
In-Reply-To: <5f0864e4-5e63-4819-1f30-68a5f207e275@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jun 2020 10:38:17 +0100
Message-ID: <CAFEAcA86vzp7hTYzk54+Qu+WQDzB-gLbUsqbB409f9F3ONdekQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] hw/arm: Add NPCM730 and NPCM750 SoC models
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: CS20 KFTing <kfting@nuvoton.com>, qemu-arm <qemu-arm@nongnu.org>,
 Havard Skinnemoen <hskinnemoen@google.com>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 11 Jun 2020 at 07:12, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> Some don't some do. This is a bit confusing.

Probably the usual thing of people not noticing that they
need to do something for big-endian hosts and nobody testing
the minor platforms there.

> Peter, should we fix the boards not doing the tswap in the secondary
> bootloader ?

Yes, we should -- it's an actual bug as well as just not being
very consistent.

> I still have access to a PP64 BE host to test.

In an ideal world the bugs would cause "make check" and/or
"make check-acceptance" to fail on BE hosts :-)

thanks
-- PMM


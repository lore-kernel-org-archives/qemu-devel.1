Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E00C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 11:09:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEDB022D01
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 11:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tDNbLKEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEDB022D01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3HIH-0002UX-0Q
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 07:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3HHY-0001wS-E5
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 07:08:28 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:37179)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3HHW-0001m1-WC
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 07:08:28 -0400
Received: by mail-ot1-x32b.google.com with SMTP id e11so8795592otk.4
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 04:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=fdqcbqsroOwFE/Yn+1gY9ep3zpwD15rjnexm9pr7LyU=;
 b=tDNbLKEkpw1ssT5W0WT1D1jlKrYoL3CON+qynShSues1yllf3Voz2Dix9pkLw9MSVU
 OeqDFAJUeNU4VWW0V4hT4PIgmB7bu0I3jzuMX57OXDdm24tgBj8PZepCPYx1VKdEU7fV
 XXbKpxuC6Y0++3MtzDBHZAInpK9LIXIx9j1xRZ6fhnCa8PQ64V+0omtSFqZ/1Kgg4tjx
 e1cPo4YhVfUhg9V/os+TlO+dlrLftEtZlEh32sgLTnDuuuncJt0GlrUaxyeazjbNWA8d
 kz1SmzEj9DidZE4KkcHrpliyTltUT3/2UP1PXRhbefjFlyjjoUdFOkgfLIKyh0bRYSQI
 t2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=fdqcbqsroOwFE/Yn+1gY9ep3zpwD15rjnexm9pr7LyU=;
 b=DBbJTriHjzsCqRBX8zO18vuvwGthumjULY1Bu5RYuMASdKfVlvp7LEdD/W0ZyVYuV5
 RlNgH8X8k1fXfZBpeYSSXm5eaCViuLS2WRFbFO2gpiU8rWf1d8vuuV7FF5I4gvYCcLVU
 fmw5/yW2NteS+nda33b0kgLaJkdluksGLBVllCxEh0D8fclXLfZzogscrmcbJWkiU3ei
 KBW6wdNCxmufYkevt8vOzhBCj0FSu7WmwOJ/DEOhWSafeyYWxnoMK7iiVZcUj5bB1VB9
 3lTuYXBqBmCR1j30vEO/kpga3xU5Xyr3CeCOv/TIEpcrQooY/LC24waLsesUTBnAITVi
 ZR4Q==
X-Gm-Message-State: AOAM533abz1f3HKGu/yWFKkLo3Y59kFq3FeHV8rsQgoPtdFnL7XpIIpR
 bXv2C2LHS9hyUSVXkXO4XRpy76VmSrD5olcQ4CECZnX6fMk=
X-Google-Smtp-Source: ABdhPJyjwUJBWbl2cIfhFA33M1IOycsgbh2ZI5pB4gLKZDkiMpVmHG8GoyD41lpcCDQ6dnWMMxPJufAle31edh3DJvg=
X-Received: by 2002:a9d:3b61:: with SMTP id z88mr2215512otb.135.1596625704946; 
 Wed, 05 Aug 2020 04:08:24 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 5 Aug 2020 12:08:13 +0100
Message-ID: <CAFEAcA_6zbOfdVi+Tp18seaEy4don1GurVya+E+QXRGrZ_WVLg@mail.gmail.com>
Subject: v8.1M cpu emulation and target-arm feature-identification strategy
To: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32b.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mostly recently we've been aiming for QEMU emulation code in
target/arm to use ID register fields to determine whether a
feature is present or not (the isar_feature_* functions) rather
than the old style of defining ARM_FEATURE_* flags. This seems to
be working out well for A-profile. However, for v8.1M there are
a small handful of minor behaviour differences which don't have an
associated ID register field, but which are instead in the spec
and pseudocode just called out as "if this is a v8.1M CPU".
(The major v8.1M new features do have ID register fields.)

I can think of two ways to handle this:
 (1) define an ARM_FEATURE_V81M flag
 (2) define an isar_feature_aa32_v81m() function which under the
     hood is actually testing for a specific feature which happens
     to be known to be always present in v8.1M, like low-overhead-branches
     (ie ID_ISAR0.CmpBranch >=3)

Any preferences ?

thanks
-- PMM


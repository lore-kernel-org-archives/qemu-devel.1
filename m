Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0669AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:13:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6BCC20707
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PxAWs7Kw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6BCC20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl8ap-00061b-0h
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8OP-0005EZ-KD
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:00:33 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:42814)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8OK-0004dV-28
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:00:33 -0400
Received: by mail-ot1-x334.google.com with SMTP id t6so15455776otk.9
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 03:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ULms4MG592ZkFTneXLq53B4DmO9gU/r0szoDJpXnqZo=;
 b=PxAWs7Kw0+IBm8hKj8lmLAyfJTVlr59GBv41Tg4XKYZYdm5AXVSqB61aj4UYej+5B6
 YEj2nvAwUw/TlssBT115Tv7ITG4AtGSueabhjgk0+r7dErXLo3rNcXacs5I+AIXYKq/3
 HsRs8X14Mwk/iz+uIdx3FqMQGY7ZvyGpiPoz94C8Pf1J+Rc7bNtJecxf4SJbe9C2nfsa
 yskBm+XVjD6T9sEc9K+o+cOmI8hwXSvM6joz4PYg+WzZLPbQwAOMc8wsd562+oBO81It
 s9G6KF9jgi6BalrWzYXRl1U8VwNkA+cncS8nbkbb73zqhPSjAO6BakIG6KHEFl4FgtnW
 oRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ULms4MG592ZkFTneXLq53B4DmO9gU/r0szoDJpXnqZo=;
 b=WpyxeC3aIFbq+iVZzQIh+qvukhqxJvZEyqCZ3AyZxf39Qgdwk1ygV657ju9hjRunKe
 ebIIzA+ANMREi+thimTHhSbFHENFqme2Nplwo+z+H5y+QH1UBRSGKQvZ6T740Atrzesd
 sA2SvHaVqGFyX/lCVDfbM3F7ituXc+rBJ7wwIGAboZVVwaN30mfOyUaJ1Lb/8O/tgM5/
 9civ6Xdztxlg7CLyX1oEFMdd7r3zCSnmr5OOaTU1GjQeny3Ekg3WAA86FgWbmQ7YMZn7
 hQMKswiT1U4HDxNpGY+hrVFKUqj05x4iGbNIny57npysztR5nDYcEYZrVu/roX6ZUEkP
 c3YA==
X-Gm-Message-State: AOAM531Fak3yxFCQnBlZTkH4O4ljmMQebg6ipXml42UL6v0zLj09t5GF
 +pXbmjZ2d7YWJ3bTWkKo1Jxsfz48G3+3wvGBVgaCOg==
X-Google-Smtp-Source: ABdhPJzdaXlV3Lf3rtU7up/zCl+XL1zlGIshD5yzeD+iEsETupMsQWfuD+PEvvy1CKv3vENbb67m2sixf6RPd+nQK0I=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr1652706otn.221.1592301626700; 
 Tue, 16 Jun 2020 03:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200616085813.29296-1-thuth@redhat.com>
In-Reply-To: <20200616085813.29296-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2020 11:00:15 +0100
Message-ID: <CAFEAcA-S1T-XWBkvuthk_HB6TKX57geuKnO51Uwa+fK_usYdAQ@mail.gmail.com>
Subject: Re: [PULL 0/7] fuzzing and other test-related patches
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x334.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Alexander Bulekov <alxndr@bu.edu>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jun 2020 at 09:58, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter,
>
> the following changes since commit 7d3660e79830a069f1848bb4fa1cdf8f666424fb:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2020-06-12 23:06:22 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2020-06-16
>
> for you to fetch changes up to 1ef6bfc23144e0ec7c182301d26b114b3610c8c8:
>
>   configure: Let SLOF be initialized by ./scripts/git-submodule.sh (2020-06-15 18:26:47 +0200)
>
> ----------------------------------------------------------------
> * Latest fuzzer patches from Alexander
> * Fix for the qtest bios-tables-test
> * LGPL information cleanup in qtest code
> * sh4 acceptance test
> * Improved submodule handling for the s390x CI test
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM


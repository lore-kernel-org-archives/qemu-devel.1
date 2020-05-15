Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D18C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 21:33:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 403832070A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 21:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xbmp9DZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 403832070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZhxE-0005K2-JP
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 17:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZhvw-0004QL-Qu
 for qemu-devel@nongnu.org; Fri, 15 May 2020 17:31:57 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:37876)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZhvu-0001MS-16
 for qemu-devel@nongnu.org; Fri, 15 May 2020 17:31:56 -0400
Received: by mail-ot1-x32b.google.com with SMTP id g11so1604848ots.4
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 14:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=s8Ot2IeohQ6h0mOBFL22R4n/wLibTXdY941V7aDwSxU=;
 b=Xbmp9DZKJ9NHCD2W1RpvL92VEF5lQCvcTDYKq4Dg3tnp7B2fILjKRvL3KUMNYA5c/z
 P0lQzoSlmDkxqasx+wa8TQlDSc5/7qOfcQYO7xSuHX3wSxoxxbX0OrPvU1fMdHwNi8ud
 rIhKfNZCBYNrr7gDTxXInFr2YUf1fKNdAAqLSt1kZyRoUNsUpIbjDWsnlBEWdY89s00r
 bD3jUWaN9I0fUUbjIMv4k5ZLOZdRR+/lXWSFYsLCVszDOZrYj1tsqYIb2ZWSWiPFl5KX
 PPzCrKAw1hbor1JOeZgQUvUh/nvGhnvYtmM3wmVvpCrcbrVRiZxRPMDHLQi0fJlv3SNG
 ENCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=s8Ot2IeohQ6h0mOBFL22R4n/wLibTXdY941V7aDwSxU=;
 b=XSPaZ4qqct0oW4bTNAh0glEeuIWhjBfng0x6gGYsptA6o1lPmTj/jx8rpLr7JDehHO
 a+3KxcInqQnYsKl8ZcAYbp384AfgcTu1xNjQOkJoNd6RV4GCMq8iSGVSZG+xoBwhfUD1
 TT9jn1bCQzXAPhyDz/Ba+iJJNtnBxo2YpHWMT+w1Y2h1SvnKUEHhBnEmRzy9cLwFFe10
 6h+v6qXQWMfE9NRhP4e4n4n9lt6QKyer/5qg+d1qQMQ8PwICngXRf3WEu4nKxItb7lvh
 eZ9iWK34OhLuVi03PaShExVvsRSclTR2NoRnAY8hVy/2DaVwDQtqgVv2yTxshkYU9a84
 2xcQ==
X-Gm-Message-State: AOAM531nvnEWNp8WWDA9TMJ/hX72UuM6CKtJW8T5NOZRSMTHGqZ58VH9
 OA3I8PWCbCcIXEJ0yBAoyB9IFShJ4QPOTqq0qBMuzw==
X-Google-Smtp-Source: ABdhPJzOGUg4rvN6AiHF+2JDSgnVJr+rX/oNOQlMZYI3noDrpQL4H0pdPlOQbYzPpd3pP9BrZUYqCO9uXQRr+7f19NY=
X-Received: by 2002:a9d:3623:: with SMTP id w32mr1988187otb.91.1589578311991; 
 Fri, 15 May 2020 14:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200515184722.31182-1-richard.henderson@linaro.org>
In-Reply-To: <20200515184722.31182-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 May 2020 22:31:41 +0100
Message-ID: <CAFEAcA9vkB4YJHVNVpCLeuHaYF9rTLa5nmvHoGrRthmbhGuL9g@mail.gmail.com>
Subject: Re: [PULL 0/4] softfloat patch queue
To: Richard Henderson <richard.henderson@linaro.org>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 May 2020 at 19:47, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> I got distracted this week and never posted my follow-on
> patches.  So flush the queue now and I'll post the other
> patches for review soon.
>
>
> r~
>
>
> The following changes since commit 66706192de113c82ecf849f6943878c453b5d2ba:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-tcg-plugins-150520-2' into staging (2020-05-15 15:47:47 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-fpu-20200515
>
> for you to fetch changes up to 9ecaf5ccec13ff2e8fe1e72f6e0f3367d2169c1c:
>
>   softfloat: fix floatx80 pseudo-denormal round to integer (2020-05-15 11:04:50 -0700)
>
> ----------------------------------------------------------------
> floatx80 x87 pseudo-denormal fixes
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM


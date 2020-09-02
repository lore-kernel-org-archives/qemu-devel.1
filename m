Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D1BC433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:10:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CE382072A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c8MyqbXS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CE382072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDa1m-0007yr-8a
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 17:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDa0s-0007St-Px
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 17:09:50 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:41085)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDa0r-0005qn-4r
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 17:09:50 -0400
Received: by mail-ed1-x544.google.com with SMTP id ay8so429560edb.8
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 14:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YKT+gPDAAQDwsScPLH8X3PfrU7JDA+BygRPS0P1rBJ4=;
 b=c8MyqbXSV8hYyxCKuunUhjr+vhmrqdYIQU3Ky+e2MflEsNSxFEI0mydlVwpMfKQn7Y
 ITbkaU/yXWrwFXdqW9JUGt2CBHkfmp9e50posFJCUMhYXpt67ibNHpTi/E8JZkYNzJx3
 eE1iyS1Kv8hc3wC5+e+renX8b1fHOCRB2nKYLEiCQoRiWQQ0f2KxgCjZGuMImOwNnDBE
 VP1vbp9E5EWe7YLEM0RwJqlEOW4/9WPJ/EC++Aj23g923j3eW2gMhXLUzLGDT9jYkvzV
 +XpNgcVF2CBmzgSxWOZXJghdqdQZhm2/QuGBXn5+9u3/G75zl67qw0Gvl6jh1vpI40Cl
 XFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YKT+gPDAAQDwsScPLH8X3PfrU7JDA+BygRPS0P1rBJ4=;
 b=dYvjZvtrSOU+FdbW9nV/SgmP5DWto9oGK83ncJYpWkFvi+Ce8PXCpNij/vTVi44yrk
 wS0d6dkk0qDLQ2WifetQ+A/zIZuCI5g5g836ZUuohxW870KjNkrbbzMn2eiE7wvuZ7nx
 JBLO016Fe9R4JbbtN+RicDrJYkoUSgXb3npnjQOVRGVxubHxY+Hc1k5AmNbjtRo5xIjA
 ZFyS06mUV3AKZo1TVm2pV5X8QIHjj8gsl4/GK0nbhLyInfLIyMKE4I1LTRmtfhVp+4I2
 m9tbglmVEiLRP40lVmokyck8iTehKIpRRvJsXejPqTReRV9Hhajk+nYWUsoz0b5mVn2E
 80MQ==
X-Gm-Message-State: AOAM533sTvKSUtjo5yBFOV+7boVoEt4WahaVz4U7dZVxFaj+/Ff8xhkx
 w9oOQRJAYPYquuupqxiN3BF0YroXAzb2AixasnOuRQ==
X-Google-Smtp-Source: ABdhPJxsOlXr31tN7gahsyH+8gzu3yHoxKi+pGWGTdpT4Dg5cxsN3Z6maTsuqLatk5kdZFRmcnywtWqbnYngdr+x/LI=
X-Received: by 2002:a50:f28b:: with SMTP id f11mr2021960edm.44.1599080987259; 
 Wed, 02 Sep 2020 14:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200902194546.1870-1-luoyonggang@gmail.com>
In-Reply-To: <20200902194546.1870-1-luoyonggang@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 2 Sep 2020 22:09:36 +0100
Message-ID: <CAFEAcA8W368S_okhAdTJNsQYoZCyLSWaab0q7t6rw+M9bNqRQA@mail.gmail.com>
Subject: Re: [PATCH] osdep: These function are only available on Non-Win32
 system.
To: Yonggang Luo <luoyonggang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x544.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2 Sep 2020 at 21:06, Yonggang Luo <luoyonggang@gmail.com> wrote:
>
> int qemu_lock_fd(int fd, int64_t start, int64_t len, bool exclusive);
> int qemu_unlock_fd(int fd, int64_t start, int64_t len);
> int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive);
> bool qemu_has_ofd_lock(void);

Hi; you seem to have forgotten your signed-off-by: line.

thanks
-- PMM


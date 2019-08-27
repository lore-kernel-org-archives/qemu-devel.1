Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C529C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 09:03:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB2022173E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 09:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DBTVI4tv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2022173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2XNZ-0002rM-0h
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 05:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i2XLQ-00028t-U5
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:00:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i2XLP-0001r1-LR
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:00:52 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:38002)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i2XLP-0001qa-EL
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:00:51 -0400
Received: by mail-oi1-x22d.google.com with SMTP id q8so14077952oij.5
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 02:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zFOM/UOkYmKF9itF+B1AVpc75PISfF5VoW/Mxv57QAY=;
 b=DBTVI4tvfbDka1453dI2m/YD2WrBYE4Md+wo0AbJ2sTRUgK8zdIi6qZdN1mxKYBo2o
 UynSqx81DCTCCh/RycKqh9AdW2ipOAOWi8XuMegPP+CCDgROh9wj51dNtOqalJWl+fib
 Z4krZYAO8IWz5ISHJ4D5xcbA/9/vdYK61nq4HyWgdwhgLisbsOMhC1+M1DHxcZFFjmqf
 f+Fpxo95zcHu1/Rnxh8Drzo0WVQVo0SIjPHsLVj6KDy3w6GpNC2GfhrvO8dbNGQfT4WZ
 pualE5Zf4z3E2s8PtoXQYw4Ry1TKy6uJWpUAHoyyRMuLwj/AK/z5pYmXel2BeE4PItjp
 s2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zFOM/UOkYmKF9itF+B1AVpc75PISfF5VoW/Mxv57QAY=;
 b=BWkRmpErXIiCMcuQMG+oTDa24mFm2o2OizPmzA1yIzxKvooyBUgfCnoZy2ysxMC6To
 LTWPi/XlOEIzjsIFsp2yN73uDZ99v32beArXtBaJOs9JjhFBNEXFDtJEeTaDlcbC4HW1
 pOVbcOTo8RcRS+l0apDPTYLIyezTq5cfyl8YP3SuMwFzRCApcPpL4vPTEc9L32zxlwxg
 gg/hAcPuyIlI9bTM/pvaCVAVMzzmx60rqMejYQoBlNnvnyWdvM4zRj8HxwGqaNhWh7HB
 cldmTJQZDJ97oycTJ4YCSF8102BRjB+/A5a1LSNvYB9TMF68Sd2wLex6ZIVWqypGgQoT
 +6ig==
X-Gm-Message-State: APjAAAU3ZM1+cDdmsIu8IYqO4gFvFenYmHP8ZHuIr8ae7OkTTveHbOgZ
 bu8BF74iqXxMo2738K7GOZ9pQmduVj15y+lPUeNBfg==
X-Google-Smtp-Source: APXvYqykR4sSnt7m/oSJmQ/NaYSSt1lBUj3zVhJi6oH69UHiDOEGFfTh4rm64ZGNOcIEO7OvkF69qPh/y6S6ffJqwIs=
X-Received: by 2002:aca:4a57:: with SMTP id x84mr15582831oia.170.1566896450471; 
 Tue, 27 Aug 2019 02:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190822155302.20916-1-stefanha@redhat.com>
In-Reply-To: <20190822155302.20916-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Aug 2019 10:00:39 +0100
Message-ID: <CAFEAcA_S8TEPXQmgu8DWzD5E1_0Uqof=DFUGQXGKjxmyGQe=GA@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22d
Subject: Re: [Qemu-devel] [PULL 0/2] Block patches
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 22 Aug 2019 at 16:53, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 33f18cf7dca7741d3647d514040904ce83edd73d:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/audio-20190821-pull-request' into staging (2019-08-21 15:18:50 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 5d4c1ed3d46d7e2010b389fe5f3376f605182ab0:
>
>   vhost-user-scsi: prevent using uninitialized vqs (2019-08-22 16:52:23 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM


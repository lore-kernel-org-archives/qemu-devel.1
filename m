Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C7BC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 18:31:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF869223B0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 18:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X0jZPq2b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF869223B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX8Ht-0005XC-TL
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 13:31:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iX8Gq-00054T-BE
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 13:30:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iX8Gp-0004iH-24
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 13:30:36 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:41091)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iX8Go-0004hw-SR
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 13:30:35 -0500
Received: by mail-ot1-x32d.google.com with SMTP id 94so18767600oty.8
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 10:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tvkzCUqwkHBVtx2O+Ab72S/GyYpjB2iA6lyYzRPCioc=;
 b=X0jZPq2bP6znkhcb6cDQuZdWHK2pAtgxh0WL8UNqQcqCeV9Fh3ElJsIAJDZEQ2qa8n
 K6SRXW1jMuZNPa9w7WnJVWL2KWjsYH271VuNWWw7lu+m2v8iua0E3FyGhm3YZABkVexM
 zSFVXVQFtrTcs3S21cBRDM3sos5EWg3tchBjvzoNKLFuWp3eCwh8RfeekEhRgCz5JaWx
 xj0t4ThwdZG69Ms90z4SFeSY0BgecZxjmuxiaxTG+6NLgAS4hZkHyB3g22wI1jQuN0je
 0BNaswQWApBnUUMUUIG3szs5lgRqFgcgw64+jZswL4lJDMD/zA/tPje7xCZJ6MLDAI03
 5LCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tvkzCUqwkHBVtx2O+Ab72S/GyYpjB2iA6lyYzRPCioc=;
 b=gXXeOQZVE2tRB30DkV/YToH0V7vE3HkPoRVnVGYU0VL/34CeXgRH+Z85p0KItd+BOw
 F7j8os1iXLVmL2DfYjl3JLceGk+GaD/jnVTkM0jmcthv5CbhhXdII1Kqwu1XueAL7ZPd
 +kqByC/2gsdKs7fh6UuAZD5o2xy4txHwTG0TAmQbQjGU7sA88Cdgo9f0DeaV9K4Qs8kN
 jNRCn8Z0U09TV41zPzGJpH5MSKmw0YHZPPkqnBAGFbYrRji9hIOnvSJPbENvaSXDxfHE
 kTZHUV0Qq1UwtQ2tktsHf5qa+0yMAXCfIv2IaFCC+Lz68uZcfqjpfbHHsACNKsyaGI+Q
 CQfA==
X-Gm-Message-State: APjAAAXN5uqZEnU2HlgT6U7js+3LmF6c7uaCIjfmkpZVD3F14021OYsd
 XA+HqgYa5IliPvPt0mnVhkNxQER7YWm+R1sEF1nFNw==
X-Google-Smtp-Source: APXvYqxpGMdJp7k3/R/ZRe4MzTaB2yo3wOY2jthE0CrPtnbqji+KKpGbtp3OTZyByo9qec/wArTDnNC/yLqZtSQglzg=
X-Received: by 2002:a9d:6357:: with SMTP id y23mr4858659otk.91.1574188233794; 
 Tue, 19 Nov 2019 10:30:33 -0800 (PST)
MIME-Version: 1.0
References: <1574179728-35535-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1574179728-35535-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Nov 2019 18:30:22 +0000
Message-ID: <CAFEAcA-896ypJfqRhjbfv+q=aygciH_1GV=V8+r30LHjxzk_OQ@mail.gmail.com>
Subject: Re: [PULL 00/12] Misc patches for QEMU 4.2-rc
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32d
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

On Tue, 19 Nov 2019 at 16:10, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 369e8f5bbd8a5301bde6fae22b93fe9288c552a5:
>
>   buildfix: update texinfo menu (2019-11-18 10:33:29 +0000)
>
> are available in the git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 7a3e29b12f5afe0106a5713bb4db6e23dc66ef91:
>
>   mc146818rtc: fix timer interrupt reinjection again (2019-11-19 10:02:13 +0100)
>
> ----------------------------------------------------------------
> * microvm docs and fixes (Sergio, Liam)
> * New processor features for Intel errata (myself, Pawan)
> * Kconfig fixes (myself, Thomas)
> * Revert mc146818rtc change (myself)
> * Deprecate scsi-disk (myself)
> * RTC fix (myself, Marcelo)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM


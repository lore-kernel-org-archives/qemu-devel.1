Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB34C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 20:14:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 325BC206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 20:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f/aTAiw8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 325BC206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwAGr-0008ID-Gz
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 16:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwAFV-0007BL-JJ
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 16:12:57 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35]:38573)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwAFU-0000a1-12
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 16:12:57 -0400
Received: by mail-oo1-xc35.google.com with SMTP id x2so1439588oog.5
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 13:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SDkKvDSwKz0KA99g9jdHBeNxHHL/GJbhP9UmyuPRmdU=;
 b=f/aTAiw8O52M8iDMcjLsvqqK7NnTLpMqellekTjObEZJrwGiFKyAriguoa4Fy4e4nZ
 o6TFA2jsfc5qQ9ENy3KIgH0fFHE1+GSQaXU12MZx1LasUt3f2lLS+lm1DPbMqgV3yecn
 sTHOHbMVWyEMdv0kgLyPlKpn3r/MbfaEf8rBZON3xidBI/eaTxgc7Fzu1D4U7hpsyrvq
 bI044ogMHfs+HRMsZJDGAEXIeuDhxR25gnQ6T+NXr3jx7UGgKREoI7X46O90t+kLrBqN
 TEn9tG60Y7QvoRh69GrwWB6hN/NYT8lxl0vZOOR3Ih/QljyvgsPx7Fcyh3I9jupLMyZy
 vs8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SDkKvDSwKz0KA99g9jdHBeNxHHL/GJbhP9UmyuPRmdU=;
 b=dtWW4mt3m04nUKPiVr36nZXHh8TdfIRt8i3OE6D0OnF12jGRbG12uP9/6SWow7waW4
 KJepWAkLCGU3Ceegq9IAhWAAlNJocetsuygv9S3/KK7NEiKq4MRF+ti6+jeIWLhDRAf2
 Z6PPansDoR7pOiIf9eoM8GBSWsyqwnt0fQOIBCbTQY8MWAQ0pB5wFRUTxhPnZxsN8+rr
 64rPST68f5sWSZmWeY+LkOQLg6VxnqPFN9ne8GCULp66lgM/LNVhYYUEV3cfQaRV/ucL
 LyQLTijUMv9Xx9wf9xwaTE+Kp2WWREm1f7ZGX3nziG49zfq9Tcu8eFYzOyMfBS9/U/qa
 RfDA==
X-Gm-Message-State: AOAM532qKoTMW4kKJdFk3lFo3xV02ZtJCM/ZKDAxYEGLoEBdndmsrU6o
 zuTzKslr+4F3QyNsNpL8cXYTvh8lRyW9lb1CGDHiPg==
X-Google-Smtp-Source: ABdhPJyGtY9WK8SOtiLkEfwrCxaYXhXwR0jhO1MNSiPqSKERm82rewnuZQJBwjR3vVAmtKML/l8aKES3NWNv6ZcsaIM=
X-Received: by 2002:a4a:9653:: with SMTP id r19mr5762203ooi.85.1594930374825; 
 Thu, 16 Jul 2020 13:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200716093119.10740-1-kraxel@redhat.com>
In-Reply-To: <20200716093119.10740-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jul 2020 21:12:44 +0100
Message-ID: <CAFEAcA-0gTGOf+0eQySbVTY+xGLLagCvAKOB+YYDZeW6SJ6TRA@mail.gmail.com>
Subject: Re: [PULL 0/2] Fixes 20200716 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc35.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jul 2020 at 10:34, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 8746309137ba470d1b2e8f5ce86ac228625db940:
>
>   Update version for v5.1.0-rc0 release (2020-07-15 19:08:07 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/fixes-20200716-pull-request
>
> for you to fetch changes up to 4084e35068772cf4f81bbae5174019f277c61084:
>
>   usb: fix storage regression (2020-07-16 10:20:27 +0200)
>
> ----------------------------------------------------------------
> fixes: usb storage regression, vfio display ramfb bug
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM


Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38287C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:01:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0B1D21744
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pcmPmAY9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B1D21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3yFk-0000Qe-9H
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 05:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3yEK-0007g9-Sr
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:00:00 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42017)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3yEJ-0007YU-9Y
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:00:00 -0400
Received: by mail-oi1-x242.google.com with SMTP id j7so1281343oij.9
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 01:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7NZIYldbViZiZ3LhXp9ZCBbNRPWSy3MmTmqfMKoDNwg=;
 b=pcmPmAY9++JvY48gE4gMHUY6mH8jZfwqGtYYqarOAoGCR3gzZgrYa20WjHtdXxc1cR
 UctuvFdZjbWJqasTCd+k1LOmi3EYxPbayUdaLfwadAL9fv+FKyYittVqJ1V6DLbAvY1P
 J8D0K+pBgZl2/tbn/VqP4QsphhmIaoSQi7U+nsqd3A7SbwkR+0IrcwWaoavZxlesOE23
 ij4mu3qQD/Cr9kJi37YL4PEv8ClI+VOWgxuc281bArShraiiQ5O8iUbx2Ui7LXsJV9s5
 hF+OtOBg5XUQSQEzty71r4z+PsnH4SOPDap3P2fu2uYEOxNgvDvESonx2+6J90Q+8gBi
 R+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7NZIYldbViZiZ3LhXp9ZCBbNRPWSy3MmTmqfMKoDNwg=;
 b=nbZhZQlwOmqRJp78YV9BbmSUSyPOG/lr/zKcwm2RGMc76YTFLtNtmodr9cfzFaQZJN
 Ik4QSRqKqsQtq08uiTRRJvLwY1XY7HRTZebfqAt0iopBWEoaeHjhVs9baB8CLF3x8fl9
 bH3IkDmM8hv1hRO+MzmQvxDIcYe/dam+U1CZO5/rwuYNPR7G1vjcelGM9xLr103QX0JR
 btAhx73Qf6eK9PTogCKmbbnRJS6MVpPsHEoDKw4zF0yDXHNFj7psbuTp9nT6I72wkDwu
 nfLop3Ta0yq82x+bUdopCenIdR4edamkMNvDC7Sp5Clyg3W1gcd+A/X2PzVxbZBNBrKV
 MI6w==
X-Gm-Message-State: AOAM531sEE1WOt7r7UrdusJE/hmrolALnnh3S9FCk2paAlqt0UqabcUd
 ub9S91M3OK7W1boqVepMjozHuUEuRbuMWGijlkWxIQ==
X-Google-Smtp-Source: ABdhPJxFl14W/j3P4lPNecuz648cgV1wxK+DjDqJT201dlqS7fp0WthWDcwIiweRrbyBZxhqCjpm06id6vWBg45pCgc=
X-Received: by 2002:aca:50c4:: with SMTP id e187mr9921051oib.146.1596790797716; 
 Fri, 07 Aug 2020 01:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <1596741379-12902-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1596741379-12902-6-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Aug 2020 09:59:46 +0100
Message-ID: <CAFEAcA_mN3XrgxRbhq5U0B=OxBq6T3DXymb4_U-tzOya=W-AbQ@mail.gmail.com>
Subject: Re: [PATCH 005/143] meson: rename .inc.c files to .inc
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Aug 2020 at 20:25, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

What's the rationale for this ? ".inc.c" is the project's
standard naming convention for files which aren't headers
but which are lumps of C code #included into a top level .c
file. The .inc.c deliberately ends '.c' because that way
editors will use the right syntax highlighting for the file.

It would be much better if Meson could cope with our
standard naming convention rather than forcing us to change it.

thanks
-- PMM


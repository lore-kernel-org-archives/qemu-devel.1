Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C13C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:28:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 811A12080C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UJQ7qj+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811A12080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5DTZ-0005N1-Ql
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 15:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5DSt-0004he-HM
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:28:11 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35584)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5DSr-0002N6-V1
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:28:11 -0400
Received: by mail-ot1-x344.google.com with SMTP id 93so8254314otx.2
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 12:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UiDVsbmlKdwRJgOKxiyRc84mI6QF7mNlOarPMfWP7Os=;
 b=UJQ7qj+UXz7LlxOpd9eoy2c0tJiHYLVnzVVfQPil8E6OA6zlFp3TDo7RdB21UDgaHk
 AhxS8P64yFslWj+UG5lz5tkDgRlK7+Equ+53cAKdzS9pDUQaOvRe2GQNuscg+PH8L5nc
 nsGtpO+o9wCLZqcXVflpiGOP6Ni9RkVHqjT+rZHZ8TZVm8Dm/V5B+q6g01kwzBrfZQnP
 0LNZhQoGKNPREtNlVblTxYEmqD2+Hz5U3ZwxmCa3zC6evmq8KC/rkECT1R6beL1y0Wr6
 uvNwC1q9QBHfXjCl8Tkafur+QCruydIJqyW53iqvXvkZ+O6P5mR+79iRE/s06r8XAgKV
 Ttww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UiDVsbmlKdwRJgOKxiyRc84mI6QF7mNlOarPMfWP7Os=;
 b=sHnVjBoHUjDFndIpt4RqMU9wdrLvtpqzBtkpfem2shLt1ft4O+ZALFPIuliyu4lNvy
 XLBnzjhLJpqYiM15RMhre/xleV49OlM2rKjt3X6PQNcAxIBqLrYoN1HAKF7sitZTw7fW
 NSQmao4ycJB9unUFZ4zporhP+DRWrRGrOP9qceqxeWHr/JbYCzdAJ32BwOC6HvIzMzq1
 uaxuFMf6CIhG8WGBbCDFN1DXB9Y9miVnMGDxvva/WSbH0hH6kvMOrtKMvJFbcK87cXuJ
 mVwyRj1/X4UvO5i+TNvmJ4mxZL4Llw/KUTT4VCP46zHohxiY4mkJE75Cw3z36x6yCua0
 31vw==
X-Gm-Message-State: AOAM533co65KBPYO7+3Qpe2c9WqQDSYoXWM5J7d/OhmGMjhKybygkph/
 QB2XklhpmL4AAP9Q8G/GcARH94NhFW3DPkmNeeYHKg==
X-Google-Smtp-Source: ABdhPJyKnM+q+8aYVcSmZEfwTojSprT7V7XKsmQvmmNbDHNTkMKK28f2QNt3wC2hzzgPntErCN4UbAGgF+uNuQH5pO4=
X-Received: by 2002:a05:6830:1305:: with SMTP id
 p5mr2054089otq.135.1597087688815; 
 Mon, 10 Aug 2020 12:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA_icj94N6eotg9W7FutXTY_6U-Ak6pJMyYH0n9eggunrg@mail.gmail.com>
 <6549f29d-f38b-0fc5-8310-e9cbedba3080@redhat.com>
In-Reply-To: <6549f29d-f38b-0fc5-8310-e9cbedba3080@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Aug 2020 20:27:57 +0100
Message-ID: <CAFEAcA-E2iFh1bxLgRarnZWT8h-sXjENh2im4i-=56BNpNMi3w@mail.gmail.com>
Subject: Re: [PATCH 000/147] Meson integration for 5.2
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Aug 2020 at 20:26, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 10/08/20 20:09, Peter Maydell wrote:
> > ModuleNotFoundError: No module named 'pkg_resources'
> >
> > ERROR: meson setup failed
>
> Missing dependency, you have to install python3-setuptools.

since that's a new dependency, is it possible to make it be
diagnosed in a more friendly way than "python barfs out a backtrace" ?

thanks
-- PMM


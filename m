Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50430C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:40:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9589422265
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xFGbjG+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9589422265
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX0rB-0004HW-OI
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 07:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX0pw-0003aE-JC
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 07:38:52 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:40213)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX0pu-0006ol-0H
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 07:38:52 -0400
Received: by mail-ed1-x541.google.com with SMTP id p13so8900809edi.7
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 04:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8S2JinLb9lWGKscLwifjdAqWcMxstZyUBqU3LCeJXGo=;
 b=xFGbjG+WRzcNSnTy97NSIELrWn6WK7B10cNarI3kCpnT+oqrIMJvoz4S2tgUuhlfiI
 WVww3NDiX9aJiF0fhbTaf4l6fAvJQacIhnC7ec4NTMMx7qZClwT01YMmO3XZ22w8J+6M
 rwDu+n+0gYg3a3xWaS33VHtle7E/cEmgxh4f36zuDCRmP2rSMtL71qRue3P4X4Nibz4e
 oXy0dTnCvvu9Ier6WdB9A48xRsWH9fHhfzE98hqwGvb8MvM1LUj72XsZBj3fTdQxon+U
 Zwn7r2RNbU2pW8+JNH8+nsWcBY6M6Wj0aZAJAm7D+Mr/P4hDcDxO8R4TAt8kjaZcy4ZJ
 5vEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8S2JinLb9lWGKscLwifjdAqWcMxstZyUBqU3LCeJXGo=;
 b=oY284JaCYImmJ/ZYpaDDFnJLYxxmmyxpyQOHmhSWRiwWD8zhCZBgKXWTBYYL6YmsFB
 U5+ojwZt+c4MieTO6lfXp48qGs6B63ZMSbPGwqEUbdkNm9LL7ukrX+8/gm/QkRQ6CiGO
 xzOlYxnpNt4PBD6Nf5s9CHQWfWJjyTByQbnXtXjgr/0vqG0uPrTKB1pATSoxNEd7rRWl
 J3nY0Loqu/ui4d/XedQkxE7kDSfgYYH39N7Pk/WjVYl1GRlxJvHIwS3c72mOreGXKAX6
 ioZ3li2qvOKwqVOAeponJ6dzZjdJ+Faa875sEnuPtRuA3z3hCxyuTHvo0NKCwnI/Nfzn
 1JXQ==
X-Gm-Message-State: AOAM533Wc+jMH0IvalOmPJHQbP+3ElbPkamqjWxPoeQFRapTVZ/4fmpD
 T8Z+Btc2D42TUM7avBPRrOJrkO2VRGPC3SDAsZ8kkA==
X-Google-Smtp-Source: ABdhPJwT723/U1O5ibpoIsKlla9tQ1SeiFoAQ3JiLRDP22LIewM89+sVCw1OwOxCLhNZWOnkRTTuB63gCq6omIyW808=
X-Received: by 2002:aa7:c683:: with SMTP id n3mr15018685edq.146.1603712328549; 
 Mon, 26 Oct 2020 04:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <20201020105938.23209-1-thuth@redhat.com>
In-Reply-To: <20201020105938.23209-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Oct 2020 11:38:37 +0000
Message-ID: <CAFEAcA8hxhVgpBdTd24opRKtnYa_73NSuU67Y17F_Rpbup2cFg@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/highbank: Silence warnings about missing
 fallthrough statements
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Rob Herring <robh@kernel.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 20 Oct 2020 at 11:59, Thomas Huth <thuth@redhat.com> wrote:
>
> When compiling with -Werror=implicit-fallthrough, gcc complains about
> missing fallthrough annotations in this file. Looking at the code,
> the fallthrough is very likely intended here, so add some comments
> to silence the compiler warnings.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/arm/highbank.c | 2 ++
>  1 file changed, 2 insertions(+)


Applied to target-arm.next, thanks.

-- PMM


Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B7EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 18:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A546206BE
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 18:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qDypNCIW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A546206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAHdm-0005gR-7s
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 14:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAHcq-0004C8-9h
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 14:55:24 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536]:46918)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAHcm-00033U-5w
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 14:55:23 -0400
Received: by mail-ed1-x536.google.com with SMTP id k25so9003267edj.13
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 11:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tiKIg5m/iDfWS/i5CJrVtMjTNIembrc0Q4vbGWeis60=;
 b=qDypNCIWX5pVuV+Pmp+Z9U5a1ktKHkFtEuy5HzUY9ckx+YaXVZrTUYZPN61mR5iwY4
 Wi63xAnbsgjDyhrtvXjBJ/QY2CWV1VPkbKdpqrp+DsrJiWf4pw3WfQHC/J7maYhdDYpS
 UwhcsrwLBo07BYWlPo9aFICCP+24bOT+3SFq+h5JFFEN/mPym2EA3d4r9/GOxoUczId5
 HPJpAAyjwJiI/3ItfiGiodNuvs61uOH7fYQVk7pD36UXRXtN499isus1dfJFuAQDGBKf
 zh6oRWtfvPfWq09uPbh6ucCFGtdq2IHI3+9msEXVIv2fy8t2lBrJm/IFJelYqYrKe47R
 q04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tiKIg5m/iDfWS/i5CJrVtMjTNIembrc0Q4vbGWeis60=;
 b=FMUxxaR8zkNrCnOCyRc8wbfb9iraErAiGj4t3FmEh5NTd3CnlaNhelLtkGX5vNPULy
 W7j3IVf6+BN73PsfVRUi0MbQUcGBDGn2Z7V1aukpfPwUWrB9BR76jM+Hvp3MxVybk7Ln
 v0RIHl7aU9OnMr+C12nyhnmXay2VYHDe917ai3tdefJRjW43b/pBFP+9bb09U6KvGgCL
 GdM7ysXg+clqOuiYfGl7K33aNl5a+q3LSqY9G97cwJLDEQ6+dMaixsdbXzVMityzqoZ8
 8Er14CA6Jtx7ahnP+r8j/JvW7we+EJjYJfOle3WHSM8V7IWsKtcrLjR59POq9S1fs3fI
 34wQ==
X-Gm-Message-State: AOAM531ArGv1M0kAnq8E7CT/OHaet8jglYkW+nbKMfWyVAhwZfNtgHnm
 +sBOoMdGo4i1AmPyAEf4mXJb9/T094jNOXsZf/3ONw==
X-Google-Smtp-Source: ABdhPJxqR13E41VvlSCSz2ZpyKC/oRHSUgOkbl2WS6AqIX+cL9OQeMTm159K5gmW9Fxiha98vdgipyczMKHyYZn5VZk=
X-Received: by 2002:aa7:d596:: with SMTP id r22mr6892505edq.204.1598295318392; 
 Mon, 24 Aug 2020 11:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597226797.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1597226797.git.qemu_oss@crudebyte.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2020 19:55:07 +0100
Message-ID: <CAFEAcA-W46-R4VXYsKTheGirRCOkom=Za54XBMJWUeb7EEpv8Q@mail.gmail.com>
Subject: Re: [PULL 0/7] 9p performance fix for 5.2 2020-08-12
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 12 Aug 2020 at 13:16, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
>
> The following changes since commit d0ed6a69d399ae193959225cdeaa9382746c91cc:
>
>   Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/cschoenebeck/qemu.git tags/pull-9p-20200812
>
> for you to fetch changes up to da9f2eda2551c1cbd98f72730e5b754f2149a85c:
>
>   9pfs: clarify latency of v9fs_co_run_in_worker() (2020-08-12 09:17:32 +0200)
>
> ----------------------------------------------------------------
> 9pfs: Fix severe performance issue of Treaddir requests.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM


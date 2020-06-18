Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C074BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 10:15:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CA8921974
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 10:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E+qd+c9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CA8921974
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlraE-00021D-OZ
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 06:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlrZW-0001Pd-H4
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 06:15:02 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38097)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlrZU-00034c-Ud
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 06:15:02 -0400
Received: by mail-oi1-x241.google.com with SMTP id c194so4579622oig.5
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 03:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZOgCWDaVqeVjNhGXS/D2YamsCh0AISfE46WA7zq9rFY=;
 b=E+qd+c9CuRmwf9YrCglD4MqWPWNCqMi5Fh+NF/y1/ceW6zDu+qOquD371uRdMEi2GR
 4sH+MMYtRIey1bfr0wRpnHL7VcWsR7iq3v9OKIklnog52FpI1I78NBaqY4xIWIifH8bV
 WgCKzvIJH1oVaE9oJLsrmEEoibcAwbgPz0AvSESHiQQmlqLAZLZOV2e1kkk1F3UqFZAr
 wpxXtTCgpaSFzwss5/264+0PXfJJpXBariX7mTbjQ8KFG+jQMsLbq1bfmvbLY0MGZfxz
 kUGGSPKbxQ1qliX8YK4ScCyAuWMPvuUrcPQLYbq+PUgFVYCYhFy+0lbsnQPREzw8BdzE
 qSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZOgCWDaVqeVjNhGXS/D2YamsCh0AISfE46WA7zq9rFY=;
 b=mz+ZxdfaXNmwoj8IAMq/Ag2niruhcy0p+BdsN6jnnzLe5dhY6dkfrR5HNElEBmx4JW
 /8n1A1i4Qeb4Dx8vpCOIvnU4nUFXuwvBq7A+4Gl9LwCdUTloKWkJeuXLm6Db0YbsVI3O
 Uewxk2Kvf0NS2ClloLUUmeuhryznD/0LK97vqC0BFjK6uncUOvjiMSMAIWEnQGkchTFi
 jezHqS73WPX5S4HMV7rzvNDVgKYtQXQWu383c830XqIYpIjD5Y2FPJSNDoIEFnfYPtMv
 WK0/xDNfWIwY4fXbcDNLdYIcYhDdsznP9KqvUXRVEKd7pf5CddO1caiqACcZSku+OIeZ
 NErQ==
X-Gm-Message-State: AOAM532Yxoji8bah7g3lcQWboclkEaknJIGFAT2jBoalO1k7L2sPgZsr
 f2iXGojliklVsgTv2h7R+GIShm6LePRWN84U01grbw==
X-Google-Smtp-Source: ABdhPJxq0CN9euPc5XzcZnA4xsAI06ZCYJYuJlYW9PMiKmXGuq3nIr/ggugEJlXCJlNaRw7X5qKOXagCJpmyixCJu7Y=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr2219930oia.163.1592475299610; 
 Thu, 18 Jun 2020 03:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqxwC10XHVs4Z-JfE0-WLAU3ztDuU9QKVi31mjr59HWCxg@mail.gmail.com>
In-Reply-To: <CA+XhMqxwC10XHVs4Z-JfE0-WLAU3ztDuU9QKVi31mjr59HWCxg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2020 11:14:48 +0100
Message-ID: <CAFEAcA--iXsUZcKKriV7=1w5f3vC68PL8_GPG9ygLEfj6RWjjQ@mail.gmail.com>
Subject: Re: [PATCH V5] util/oslib-posix : qemu_init_exec_dir implementation
 for Mac
To: David CARLIER <devnexen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jun 2020 at 19:40, David CARLIER <devnexen@gmail.com> wrote:
>
> From 3025a0ce3fdf7d3559fc35a52c659f635f5c750c Mon Sep 17 00:00:00 2001
> From: David Carlier <devnexen@gmail.com>
> Date: Tue, 26 May 2020 21:35:27 +0100
> Subject: [PATCH] util/oslib-posix : qemu_init_exec_dir implementation for Mac
>
> Using dyld API to get the full path of the current process.
>
> Signed-off-by: David Carlier <devnexen@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Thanks for working through the code review process with us.
Since we don't have anything else OSX relevant at the moment
I'll put this into the tree via my target-arm branch just
for convenience's sake (should make it in within a week or so).

thanks
-- PMM


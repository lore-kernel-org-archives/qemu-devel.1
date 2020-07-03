Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438ABC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:49:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 104DA20826
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x5dqCgvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 104DA20826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrM4g-0000xo-CG
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 09:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrM44-000867-Jy
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:49:16 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33032)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrM41-0006vo-Oj
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:49:16 -0400
Received: by mail-ot1-x343.google.com with SMTP id h13so6159689otr.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 06:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eXmdn0F3Q/Cawionph7MsrK/iM3uSTrOvCdn0qlvQxU=;
 b=x5dqCgvIl71coNCGrFxgcRs9Uyz80EEjyeRzQ1ZYE4rARd/VGGq+OtqjllEjKHbWFD
 GaSFvIQvBec4i2Z06jNs+8/7152WVoHqmRzx9YMgzxSU8KnBvhcyNp2DO1G3Hm3/MASL
 xB6pI5d6ABnq+oxkFpc573Rsulr3ghXuxOS0nrw7k/RHbkHzTWM/PU12hC02SDtSBgt4
 VRM0b5UZJ1vYJzqiKzahImQ1N3VdxZa9RnhVIi9SubNHRgfRnPoyEqEb4wXhOR3H7RFz
 twSXe3ELoJ/oz0xYw4yyk0z47cFiEymtcyC+lw0TtW+22rvfLQa4XjoYPj2xD9oupCIu
 Gk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eXmdn0F3Q/Cawionph7MsrK/iM3uSTrOvCdn0qlvQxU=;
 b=DiJmZtwnbkIVJ/x9FKd5UsvVBUwXHDGmIBFDsgQJtoQz90rLyK4y+cJRzwjfADmWpF
 CKHGRyaxWpJvj7ZyqKOV0VgKfWOTxD8s/sk+wyrz5z/h5Y3QDiyH3Su8BJ/kd2kCHYaW
 fLeWtwxt2EtAcRvU/cj3/AAsysfzMCtDopvwdzYo0MNyodyNabi4bbY1RkKMOKMc6uvx
 xHKfEnq7zQSaz2v/owh/MR56oKJywCb6NZX1UZ7xsKuLaNZGc62m0/3BnBZs/Tnj9ejj
 K1aeCVZvQsly+pCQ97tU/2iC+mBS/cGhb0cVERiyjQFMgJjGlKX1TqhcWTpd/ad93x4D
 Zqwg==
X-Gm-Message-State: AOAM531r6eZg6aiMYsCkVI7AHbi3D9PVJvS3v52DZOLGB3tCK28i/S2c
 C3I8G9sBxurqTmCT0eLeuwhQEiQsT10R7L1GWcvmNg==
X-Google-Smtp-Source: ABdhPJz6xSeVuW7My1WlKQSV6e3zVeg0nkTxT2nRCtaeJPf8VzxiyhUlHTumS8UOniPWWJwEztp8i5I/rfsKCxKo/9Y=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr24560002otk.221.1593784152455; 
 Fri, 03 Jul 2020 06:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqxOuWKDangdOwhe3PbKa=411_BRC7WS6dvfJ+HMPw7j0w@mail.gmail.com>
In-Reply-To: <CA+XhMqxOuWKDangdOwhe3PbKa=411_BRC7WS6dvfJ+HMPw7j0w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2020 14:49:00 +0100
Message-ID: <CAFEAcA9CSh56kb9wc8-5uv6jrp-FrSkqwtShLHBhKp5FMHJaOA@mail.gmail.com>
Subject: Re: [PATCH 3/9] Checking mlockall symbol presence
To: David CARLIER <devnexen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
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

On Tue, 30 Jun 2020 at 01:44, David CARLIER <devnexen@gmail.com> wrote:
>
> From ac450c4abe03e0e461fede18727500e616d9f7e2 Mon Sep 17 00:00:00 2001
> From: David Carlier <devnexen@gmail.com>
> Date: Mon, 29 Jun 2020 22:15:21 +0000
> Subject: [PATCH 3/9] Checking mlockall symbol presence.
>
> Signed-off-by: David Carlier <devnexen@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


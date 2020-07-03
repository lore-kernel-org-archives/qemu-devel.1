Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD714C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:51:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 778BA20870
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aGsexeni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 778BA20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrM6f-0002aX-M4
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 09:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrM5z-0001ou-DX
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:51:15 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:40540)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrM5y-00008G-07
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:51:15 -0400
Received: by mail-oi1-x241.google.com with SMTP id t198so14005075oie.7
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 06:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1laTjOxvsyel3DgT9gokiMsrS2tuuAdMfjCDLNi3/z4=;
 b=aGsexenihmwvsdIieMzsQiF/AJKgTMgkWiFm7LlFtNaJGmgv7LJO6aP/LS4TKRxpYM
 V2KFqJwxgGDG+hj0zz6NDSbKMpRyS68+/UHJmnrrIpfaTyCFjOIL9TAojnJHoU9hN+4R
 25rLjM27x2IFlyAi9Qmgvmris2OI3a9VsmKWhW2Lk/f3lbFwuDdE6jzAT1kHjLpSPJP/
 fYbK14Ne4Hnw19rrVXjADchvENxIaUkJ2MIiWhpqpBptCYSES+ln0isrLYpU18JnHxna
 KgfedTGaKaYjOWeiMFvehH7uWr17LoJvfXbpmdhBl5+5Xyo4vHwKxjEtycbWYQFVyY5/
 e/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1laTjOxvsyel3DgT9gokiMsrS2tuuAdMfjCDLNi3/z4=;
 b=TNDpni1ajqlqcSS4fZ/WJzbPQa9nSnsb3IveyNk+BUIhvdtvxmqnUxNYVYxuQm0Zp1
 eSbclrGmZUDifVsja9wzlO+RjQJZPmflKS105vmWyxKuR3UCQuE/h84I6A9OJMdBj2va
 m/JpWq1k6VQtFoLHNiFvCcM2g+WxvpQ6c+2Fb654oKvEHv1CHfp8AKjCEsBZ5MZBecRg
 q906yOAAiaYSRPq7Lkh3d+ZGiQ8pIYwIIws64NSFSX3Iva3xY//0NgFsj/+coW0cO1+a
 vx2UuDb5wUeX/cOE8oQJtYK4HRr13PMOdexda/eV2IiwC5lM6JTb82D73tVZr2x/udG1
 scWw==
X-Gm-Message-State: AOAM5309SPXb85Lpn3zhLAcGjiXisMX96CM8lArUrtk85oIRCFedkJOF
 Gv9QarEN9A0Godm012ydlWVSyRdREAz8TsY2lZ++3w==
X-Google-Smtp-Source: ABdhPJzVSOI76LYrrC5jYW3uGhxjIGYl3x7owFqVPZMVZ4tLNB1QJPTY7WG3wacOBOp4V/Vd2a73ZO7v+FBuk3rDS2M=
X-Received: by 2002:aca:2819:: with SMTP id 25mr21197531oix.48.1593784272914; 
 Fri, 03 Jul 2020 06:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqwUHwc-FPgP-YfKPz5CL8BKSQY+0qTJ5uBRhfu22jsh1g@mail.gmail.com>
In-Reply-To: <CA+XhMqwUHwc-FPgP-YfKPz5CL8BKSQY+0qTJ5uBRhfu22jsh1g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2020 14:51:01 +0100
Message-ID: <CAFEAcA-nUw4=KbhxSTehpOEvPF6fF+WYRHMkXhQcnoBatt-65A@mail.gmail.com>
Subject: Re: [PATCH 2/9] Enabling *pty api
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

On Tue, 30 Jun 2020 at 01:46, David CARLIER <devnexen@gmail.com> wrote:
>
> From 8b205a027dacad08ce9187474d9490667904a4e2 Mon Sep 17 00:00:00 2001
> From: David Carlier <devnexen@gmail.com>
> Date: Mon, 29 Jun 2020 22:14:53 +0000
> Subject: [PATCH 2/9] Enabling *pty api
>
> Signed-off-by: David Carlier <devnexen@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


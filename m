Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BB9C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 13:18:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71B3C2074B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 13:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p7e7BSsv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B3C2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfkKn-0001si-MK
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 09:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jfkJw-0000yQ-7r
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 09:17:40 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33412)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jfkJt-00048N-PP
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 09:17:39 -0400
Received: by mail-oi1-x241.google.com with SMTP id r67so8854275oih.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 06:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4C/5yuYGY2B/jGeB3PtoygER48eV8fi+r8zaeFfcQtI=;
 b=p7e7BSsvddqw8JA2MA9YsWWiamK5h77AHaFDJpG3YnP7Djwk08QmiNuUdDY1mCkDc9
 gh7weaVFWR6uIGpbgn1+GvGVyqf2F1iSrEl97kqENKU1SGGY4JZKRG7WAP7cPEK1jYBm
 E+P6ltggXPUwHyXRukVpqjXAhSJkgLxYpzzEQGZDziCJ5pha33vfmshhPlOOlp6TJWrJ
 EnLbekpBxO680oK76/Rg+cZbwfx/32H/RPlmV1UMr5lNLmuOBT1kBc1nnHx9Ue+7E4o/
 lV5I0RvSPsrz93fPoD8QOjcbLqLy4gGs/n+4ifTbUE6kuasQjr8GOmTxdLKzwLcQGfLr
 YGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4C/5yuYGY2B/jGeB3PtoygER48eV8fi+r8zaeFfcQtI=;
 b=h3f9lXaiRfs7fJm9C37gKdWMYGpvGqknznhcf+/xPteXbJnv/52ErozNXAQ/7P1l59
 BjLBmlfQOW2ZZRkBU6oWCunXSxiJJjsl+7ro+MFq2YMLQpNogehv0iA0Aa/jYMTHoSLh
 V1czJnz+LLg9Fx4nOkL2d9U5JohPHExYNNvbSfxKw25m5pem4y11bxW3wdvSj9lBLQ3s
 wIEh2dYchfJeeESUEdVtuub5oHOkz0IATb0hT62Tv4xW81j/ZqbEY/gnin9tXryRbxaR
 idDduLnYC5ix7mkrSa3cK7dZmo0KcmaH8u58dIKoFVn6u3AWrhG1WWO+szxMkYAH0KST
 6Ijg==
X-Gm-Message-State: AOAM530BfceQd+3QqwOZNNcJgE2Ov/IEKWk40ghmaMm3BitEu1oCAKcR
 xVjFGUwKpldImKyRN5TNcc5s2KTDh+lj/1eLmxOO0KdUTGM=
X-Google-Smtp-Source: ABdhPJxiGAMAehHm0gg0IzJYoxkfSnuB9VDjEJAvAciJZ3ARBM4UZqtZ4QLlJW3CrmFPSGay7Wg9TMtQMKsAcbtwXwM=
X-Received: by 2002:a54:469a:: with SMTP id k26mr14197122oic.163.1591017456195; 
 Mon, 01 Jun 2020 06:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200529230653.GD776951@os.inf.tu-dresden.de>
 <CAFEAcA--vg0iPZmHacGUxkF7tOP9iFeei4rSksQO_fFh3wjtMA@mail.gmail.com>
 <20200601130135.GA284778@os.inf.tu-dresden.de>
In-Reply-To: <20200601130135.GA284778@os.inf.tu-dresden.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jun 2020 14:17:25 +0100
Message-ID: <CAFEAcA_cc+xgmsnrdhkMV2CPdRZMOvD5yB9NON1C4hgfFqbJQg@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Init GIC CPU IF regs for A15/A7
To: Adam Lackorzynski <adam@l4re.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On Mon, 1 Jun 2020 at 14:01, Adam Lackorzynski <adam@l4re.org> wrote:
> Indeed that's another option. Besides that A15+GICv3 currently just
> works with this.

Not sure how...

> So I guess the alternative is to switch to 32bit from EL3 when using an A57?

If you're using KVM then you can use -cpu host,aarch64=off

thanks
-- PMM


Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34457C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:25:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71D87221FF
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JJcDqgz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D87221FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYVLf-0001bO-6X
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 10:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYVAw-0006Lz-Hz
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:14:42 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:41681)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYVAt-0007XR-Jl
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:14:42 -0400
Received: by mail-ed1-x543.google.com with SMTP id l24so6798320edj.8
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 07:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=encGXGDBIxLLYt5MkaJe/Ez6hqIFN5D8qmeAtZb1mM0=;
 b=JJcDqgz1RZsbfxr1SinJqWwxP/VvwjXCZsrm3wUoddKZ7N3XElPj98yXhk/ONeJgLJ
 YVkfnPITkAcWn5aJZY6qJUYQBaGKRQcSDRr6cYgnJ+XACynxTjMKTE6m3LklJqMeG8M9
 QFv0qraHd+DW12wgtT4sxowIZFLIXKn/8t9/YcSBaKuM7VfDLUyeAwfgmHhsKx8EjjwT
 O+wDdocyEmm85uj/NUaCoqotl6Fl0oXVPGVrICTJ+ESmJjWJcjJxXCbDWQcAsZHruFWH
 BMrkfOzo3Mn4StMXJ4Z5G7UwuT3BbDm8My38R2gosege/UR+3Cw9+xVpbKiSBFvUQEWu
 KqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=encGXGDBIxLLYt5MkaJe/Ez6hqIFN5D8qmeAtZb1mM0=;
 b=cYKssKKI8o/JfMVVPUbPw1lCXNxa7/1aGBgsT+iv3OMQV7XChO3cdYoH0rVBq5ukru
 1Dtf9QoGm0WWA3SY0aJLv9ZvsWgYxAs+krwHpysLOk/+eeBDygUj11WfA9zBXWGSj98j
 6KsFXQP6/pHxKoTZQbWeWB9JZWa5lsfuFGWpIESQfgI004d73LPe6eWJuk6n5wND9ouS
 w6Pnf3i+Olc2hf8N+zfuhPxOjptcT3JB8zouRGNopCV5ewcjlMTooW/kzlh71nk/bP3Q
 ZhqCwl4LrI/ic6V25Q7XpNU86ato/0pTFHT2U6Ighwcf70d1brNPNV3tZ16hTjRhDDst
 bM/g==
X-Gm-Message-State: AOAM532+UL5xjecUEPZir6i4LpqhZjJs1rPr4VRUDxcXs5BRcR9K479x
 v304DDeFWBAf1h1FKzxbVhO9ZxP6Ubz8BPytbt/yNw==
X-Google-Smtp-Source: ABdhPJzyoPezK73UrKYz+u9krS5VX86lVAqxiVkCZ6OBo99XF51i9bKoWoQuWA+Xy+cJgp9QPsPLmIoEjiak6JWLkts=
X-Received: by 2002:a05:6402:1482:: with SMTP id
 e2mr2695753edv.36.1604067276872; 
 Fri, 30 Oct 2020 07:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201029202520.9313-1-remi@remlab.net>
In-Reply-To: <20201029202520.9313-1-remi@remlab.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Oct 2020 14:14:24 +0000
Message-ID: <CAFEAcA-YA3JmNP_Q2p=VpvrxCq-MOiQoV8NpJdjO4YZ7iE_+Vw@mail.gmail.com>
Subject: Re: [PATCH 1/1] target/arm: fix handling of HCR.FB
To: =?UTF-8?Q?R=C3=A9mi_Denis=2DCourmont?= <remi@remlab.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x543.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 29 Oct 2020 at 20:25, <remi@remlab.net> wrote:
>
> From: R=C3=A9mi Denis-Courmont <remi.denis.courmont@huawei.com>
>
> HCR should be applied when NS is set, not when it is cleared.
>
> Signed-off-by: R=C3=A9mi Denis-Courmont <remi.denis.courmont@huawei.com>
> ---
>  target/arm/helper.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Applied to target-arm.next, thanks.

Could you cc future patches to qemu-devel as well as
qemu-arm, please? The automatic patch-testing/harvesting
tools and some people only subscribe to the main list.

-- PMM


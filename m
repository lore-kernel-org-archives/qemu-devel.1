Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE688C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:37:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B3AA2074B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OPVeeAXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3AA2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfjh1-00033x-L3
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 08:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jfjg3-0002XH-AL
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:36:27 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36008)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jfjg1-0004EJ-MR
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:36:26 -0400
Received: by mail-ot1-x342.google.com with SMTP id h7so7849960otr.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 05:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oS7X3UM0cDsOHtmoDeeRuhqXolSqqpib7E+LUPLgV+0=;
 b=OPVeeAXOeYf2tbmkOH0K+8hAvHQmqcGzSUWVKXvefBR+5rS8GK0g0GUpDYxgH0/VUK
 t291ziLPuG8XNFVUJxVMvtL9W86QaNls/EcN8IhqCqFEMUw7Z9a86anX87fxJ1GhEtOY
 P+4X0wwXnyg9tGB84Kkgkt/YbcQxCmDH3SUtdAdZtHOSlRw+uql9phA62THfJ3SNm4iq
 Od/eNHVdMrCTuDR3bylOSUiXhNF06iLXicxZw7n9gb5jgs60LdCvC/5cFbGh5x9MuoFh
 VubasIkcqhlDoBC9EhKd+D/xHFiuXDfUMfRyMhdVlweZLAc8dMOHP3T8JTYJhmz8eUlU
 5qcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oS7X3UM0cDsOHtmoDeeRuhqXolSqqpib7E+LUPLgV+0=;
 b=fwzQIMSayO9GZRtfoNQdi0VKOosPmRgQUU04ktXXmcTy9p1yGxAz3toXi3btCZ3Rtg
 AO1v622fJz8V2fJvc9Ft2120YpUpYVGdbuv9yJ3wueRBAbLEr/Jj27ObYUEV9QC5tQWR
 vbLBQv/eH2eL/zQ7hs4HY4mA368LUVXSeh3byIllXvX4kOYCH8/irA1Z9TYJ1/mATy8j
 YmWKxKSn9bYr3r9hbq56jaYKmw7WsM7yUAYgoVrFMPwQJaOGuyrDF+1Sgc2fg7Fko6va
 dN6OjIX14ogMnjRQDoqDKYFZ394lhrS3b2Si5JTh0kHMDRLFEz7w32KwACnZJ2ITVFJe
 gPcg==
X-Gm-Message-State: AOAM530yjmdQnKWYz/fLACSwWnfaHHXLVHF4RdzHFInn76S3nuXL/x1J
 8DM8Vtlq+T2cP1kbR9bi+1GYHCh5j7AAEHUjVSS1GB5uvJw=
X-Google-Smtp-Source: ABdhPJwHv3a+JBxKzkTElY9ZSRpGWNZOKwd/4ywaWaSGZBr0X4QFTXn5ZvRNg6JblbwtCN5dAm3R/WqTeLkhfmUR6+8=
X-Received: by 2002:a9d:b82:: with SMTP id 2mr15678958oth.221.1591014983774;
 Mon, 01 Jun 2020 05:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200529230653.GD776951@os.inf.tu-dresden.de>
In-Reply-To: <20200529230653.GD776951@os.inf.tu-dresden.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jun 2020 13:36:13 +0100
Message-ID: <CAFEAcA--vg0iPZmHacGUxkF7tOP9iFeei4rSksQO_fFh3wjtMA@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Init GIC CPU IF regs for A15/A7
To: Adam Lackorzynski <adam@l4re.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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

On Sat, 30 May 2020 at 00:07, Adam Lackorzynski <adam@l4re.org> wrote:
>
> Initialize the CPU interface registers also
> for Cortex-A15 and Cortex-A7 CPU models, in
> the same way as done for 64bit CPU models.
> This fixes usage of GICv3 in virtualization
> contexts in 32bit configurations.
>
> Signed-off-by: Adam Lackorzynski <adam@l4re.org>

Hi; I'm confused by this patch. The Cortex-A15 and Cortex-A7
do not have or support the GICv3, so why would we need
to set GICv3-specific settings for them?

We're probably missing a sanity-check somewhere
to forbid user attempts to use non-GICv3 CPUs with
the GICv3.

thanks
-- PMM


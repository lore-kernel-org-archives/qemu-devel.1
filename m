Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BE9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 20:21:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75B3120709
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 20:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zOTTd5BX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B3120709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joYN0-0004p0-NC
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 16:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joYMO-0004L7-OL
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 16:20:36 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joYMM-0003eY-NG
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 16:20:36 -0400
Received: by mail-ot1-x342.google.com with SMTP id n24so4273129otr.13
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 13:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iPBsHWmL1uvlRs2k2QY6hU3D66Fjw3PDp54nrLhq66M=;
 b=zOTTd5BXIPO+PkrEVWQIQdsL0vUTCCNeqjVW9RFjK9TP0m/f0vlW8STsDLsnFlkwYP
 zyAweKF4xrwYFOIZXxXoleVuvLrGU9Z4B3RcVyYrcC6yrg1LDLrN1F9y/l6kDLqibGDI
 QM73aP2l6P0tE0H7abgKnoLmsMTFU95qnIGTiFheRZ9aY69yvw01LfLaZZiYWcFjuuUb
 Vi+mDxrnMVvsv1aDLx6RRh/eNcYXnfBA/SDTFYoQQi8xUr9RfU3VPXcJ6qFY258n+qev
 /VpvRP29tIafXXhri1pTrD+1gZCEp7jZSd7BoVKuDsyDOZfVUETyDYxMEPot6Ho/Ftww
 HLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iPBsHWmL1uvlRs2k2QY6hU3D66Fjw3PDp54nrLhq66M=;
 b=DIypiRFEgYl1NginkQN20+iIY0jwe7He5rBSwdou48nOFFzDr66wK2jrTfM3VLgSWW
 QSb0Sit7cAMIVKJ37tb8ndfwL7oJ9RnZLBprBIW5lfs+hCYICtHwRQidHeNKoSG4/Prk
 VBMpvQnT3lD/JS+l5jMpHCS8gYuUR2yniSQFvCDbN7WAoeoGjaOEkrBUHXMI5kS/qpaX
 QNDrd4FyGD+hY/8Ey+vgToWp6LzstF58kOHJ8fcCFjDe8rEO2nJj5B1yKuFGa3/q2UHg
 cNtVHu+MVxII7p4MVyntZnf6ryR88APuU6BYyGNQN3bGfjl70OGzdCys7HvKFrko65mp
 zmFg==
X-Gm-Message-State: AOAM530ML5RYUe1U0i05yW2PKxfZiAA2FW7padwn4t/lf/zkOLikQ0uA
 Kms0uUMRS9CdnBXP2QTqF+Vo7qsn5EXwmZhTTWoHDg==
X-Google-Smtp-Source: ABdhPJyoINNKDZW8f7zMPvPx7srAGUuM26xRLMNN6l7vgyKYQsDgNEtllVtSPbbne9zW6UEKSwG4lpiTGjBBVrFdnIQ=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr27130065otn.221.1593116433368; 
 Thu, 25 Jun 2020 13:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200624230609.703104-1-mst@redhat.com>
In-Reply-To: <20200624230609.703104-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 21:20:22 +0100
Message-ID: <CAFEAcA-+L7kD4F5d58LLexmLKU5_5o0064cpcg4HWg-Z66NN=A@mail.gmail.com>
Subject: Re: [PULL 00/19] virtio,acpi,pci: fixes, cleanups, tools.
To: "Michael S. Tsirkin" <mst@redhat.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 25 Jun 2020 at 00:06, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit d4b78317b7cf8c0c635b70086503813f79ff21ec:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200623' into staging (2020-06-23 18:57:05 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to f6f746db6bae1ba74967fd7bea2bb5e169502948:
>
>   tests: disassemble-asm.sh: generate AML in readable format (2020-06-24 19:03:57 -0400)
>
> ----------------------------------------------------------------
> virtio,acpi,pci: fixes, cleanups, tools.
>
> Fixes, cleanups in ACPI, PCI, virtio.
> A handy script for testing ACPI.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM


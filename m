Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D53EC49ED9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:03:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 573ED20CC7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="grhiSMuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573ED20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8L0x-0004yD-Gz
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 05:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i8KyE-0003FW-S6
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i8KyD-0005TD-Eb
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:00:54 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:37023)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i8KyD-0005ST-0o
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:00:53 -0400
Received: by mail-ot1-x331.google.com with SMTP id s28so25355903otd.4
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 02:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OKAjqj/41klknl2QNfAVWPQR2aLtTz/mhjdc7DMyAyE=;
 b=grhiSMuFCmf832JF9vGDDEmzU4Bw7YjAHjUmG1X6dpmvkMFUHp5Cn/w696KXoBRpgX
 Me50AA5VvakDciC5tuOtEOX5gCratk//qa3MBk/nJ3yKDR72ZFDF9wgMm1zqfc6T17nb
 Udvo6oH7+jQ//+niLY2D3Fwp5gQixXeIKbYJ8Er1f7hSMl3ofNSBJIAHFrA55tU32HS4
 X5Ftie4+Q9GYmk+CnLAZDpVhM03yjQ7/Yjm3ta85ArwkSCq3UGtr7/SPbInyQSVuGwuT
 cY4EQCQkhbJ2sT/3jPwypARibQwAPzwvwLo/g67D0JvaLUAlzzgxA5RtR6qor+PmjC8Q
 kbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OKAjqj/41klknl2QNfAVWPQR2aLtTz/mhjdc7DMyAyE=;
 b=tW3IwP+Lc0+FRnks56D3xsjAsJxQVJVk1JyMoBEYHsEKqLLtNqFV9jBYTTOBBaw+rm
 sRaecdObQQbyn8x3WxP4s4r6pIYsLENIu25+45wWrbfvo2XwC7wPg4EFPLApyNchhHxS
 X872/x/O+njA1tKjdvszFiMlqRlNqmOtqabkQDyV8S43CRl3mG828k8XnWIGpuflpegd
 e3YuAzkYl+CXSesmEO0BrsZMCaKRoqlyCGecq3jsqoc98e8BTVLgTBE9tG1OS3wlTr8e
 ciVr55R9jw7Hu46UziSxdEqMQgN/JInMwNkc/7RA1LukyjuwzZWvB1p/4/KJhIYMQ6d+
 KVtA==
X-Gm-Message-State: APjAAAVKFYZF081PWxEEA/Cf2te+BO0gGQAuQxe08UHcysptumD9g4DC
 V9u38yyeGvljVlXx6Q3v45qjA++5UWhs/fs4vxyXpQ==
X-Google-Smtp-Source: APXvYqymNlziH1XSwE9cKbxq00oSoMUgREY43cmo6WTNG7dfeKO7RRLunw0dwnLvYslTGujBYlc9zHFJwaq1w9fgCO8=
X-Received: by 2002:a9d:68d6:: with SMTP id i22mr26144709oto.232.1568278851677; 
 Thu, 12 Sep 2019 02:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190911155125.11932-1-eric.auger@redhat.com>
 <20190911155125.11932-4-eric.auger@redhat.com>
 <CAFEAcA-tZJ2C8=ZH5e7tXzigPu3SGjSJbnLybZTG+hZO-7ZV0A@mail.gmail.com>
 <1b849672-31a6-3d8d-b8ea-254e737e3b80@redhat.com>
In-Reply-To: <1b849672-31a6-3d8d-b8ea-254e737e3b80@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Sep 2019 10:00:40 +0100
Message-ID: <CAFEAcA-xrPP6=dmaee7PZHOr_Fpw-KsCGY5QKHR94wL1uKWL6A@mail.gmail.com>
To: Auger Eric <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::331
Subject: Re: [Qemu-devel] [RFC v2 3/3] virt: Check
 KVM_CAP_ARM_IRQ_LINE_LAYOUT_2 for smp_cpus > 256
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
Cc: Zenghui Yu <yuzenghui@huawei.com>, Marc Zyngier <maz@kernel.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Sep 2019 at 09:57, Auger Eric <eric.auger@redhat.com> wrote:
>
> Hi Peter,
> On 9/12/19 10:42 AM, Peter Maydell wrote:

> > Is there really no place to put this check in common code?

> Not sure what you mean by common code here? Do you mean in a common code
> for ARM machines (I don't think we have any atm) or directly in
> kvm_init(). I did not want to pollute this latter with this ARM specific
> fix.

I'd just rather we didn't have to have the same "if ..." check
in every arm board that supports KVM.

If kvm_init() happens at a point where we have enough info to
make the check, then you can put the check in kvm_arch_init(),
which is the architecture-specific hook that kvm_init() calls.

thanks
-- PMM


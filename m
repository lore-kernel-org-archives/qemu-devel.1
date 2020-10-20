Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA7BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 03:20:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B600222E9
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 03:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kfr1Lwz/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B600222E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUiCk-0002Js-DK
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 23:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kUiA1-0007XJ-Po; Mon, 19 Oct 2020 23:18:05 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:36253)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kUi9z-0007Fg-Gb; Mon, 19 Oct 2020 23:18:05 -0400
Received: by mail-yb1-xb43.google.com with SMTP id f140so600674ybg.3;
 Mon, 19 Oct 2020 20:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fGCnhvWM4FjynnI+oYyv9G1XvGkzJ7Ii5/lP6+ItKL8=;
 b=Kfr1Lwz/vFfgdZdTDn7NZaNkFgPGYncqfBeqRMWlFIgKqbbsZc2pYlVkBaYG11yU5k
 8/LHHXRzZUcGDAnNkcG3Op7iHDUbCPElZQxaEk75muoglMgmN/IIoLxyYPtiWph0iuOR
 bTSY7odfnEyATNBAjGu+PpnGIVKT1e/ZnBh1IoaifoU6tZ1r0Kk+gGk1fWvZW9z8zqdP
 DASkClBrJhUzCrUUIx/1O7n+1jDvt3f43DewCs9OSJvjRZcTNwgMY0wvhnc2Dd33ewUV
 Pi8AdFKHVXp7DquYE3OrCQz+O4VCptFcqPmu4eETegfljz3dEGnbTKmMoLdWHlQmCm4z
 anew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fGCnhvWM4FjynnI+oYyv9G1XvGkzJ7Ii5/lP6+ItKL8=;
 b=U+NJX63IFceelE00emcVgepGqHdB1S6Su4zbybe31VSVeXBWW3/Tno5ULzpxqF37gJ
 zbn/y7nXKhx470R4altUb+17dm8rxHtsM7rNFdQ1n0/tAQtyXVMnt3ycpWCVXaJ1MHGK
 fZoQgAuMtvfa6lIYkTSvpIJAa4a4qMotB+XYE/kt9IqwkfGawmd6ejpaE04vQKyYuC/G
 jDREF08JDUXKRmBlp8hOMotNuEkZALZGAs21xl89dZWSRYVyTIOt1qjwxf7lDOs/QJRN
 2gxm/B3h8GFn2+7SWdqtRInw84G6j5lSdQeX31mLLjpEqK5PEtuG8pOw8q9O57U5rXYL
 XOuw==
X-Gm-Message-State: AOAM532IEYV9OPswS2p9+o4WqZspbpYjK+Aw89otD7YscWjiejgJFE3k
 oiMtVJ0dN4pVbmpPCbFrDstZ17Pq+RODQXf8xxI=
X-Google-Smtp-Source: ABdhPJww8M8qIHg6QpbpEpGJU8Xc2R37dTPG7k1FA82zi1zmAZnjkAnLJg5Zelc/Wc4CcRhBvV28laWpS9rcXYYolhs=
X-Received: by 2002:a25:c1c1:: with SMTP id r184mr1126766ybf.517.1603163882213; 
 Mon, 19 Oct 2020 20:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602634524.git.alistair.francis@wdc.com>
 <4c6a85dfb6dd470aa79356ebc1b02f479c2758e0.1602634524.git.alistair.francis@wdc.com>
In-Reply-To: <4c6a85dfb6dd470aa79356ebc1b02f479c2758e0.1602634524.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 20 Oct 2020 11:17:50 +0800
Message-ID: <CAEUhbmU-jqu6x+1tYsLAVASFchV-LqwkuWsjMHLa5DLuH0UOZg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] hw/riscv: Add a riscv_is_32_bit() function
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b43;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 14, 2020 at 8:28 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  include/hw/riscv/boot.h | 2 ++
>  hw/riscv/boot.c         | 9 +++++++++
>  2 files changed, 11 insertions(+)
>

Reviewed-by: Bin Meng <bin.meng@windriver.com>
Tested-by: Bin Meng <bin.meng@windriver.com>


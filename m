Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678D1C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:26:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34A6D2070A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKm+I3KN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A6D2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jolZF-0004m5-Gt
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 06:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jolYQ-0003w9-54; Fri, 26 Jun 2020 06:25:54 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:32936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jolYO-0001eq-JP; Fri, 26 Jun 2020 06:25:53 -0400
Received: by mail-yb1-xb41.google.com with SMTP id o4so4256301ybp.0;
 Fri, 26 Jun 2020 03:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TAGDyapLgvqUb1jwBBzGWav8wwRbeRMTnggiJBSyH1U=;
 b=ZKm+I3KNiBSyHki4QCmY5Cf0SHCYTon/dNPszQ4Uq+hhMLicImtFfC7WKxcBwDelwG
 VbZ3n4djS8QHJlZZJy/OaSPZ2+QQtXAP/4FNCWm2AK2uLei4DSu119cAb+8czuhEBKUy
 1mR+YfHcVIiLjeQY7PfNGEe2Q7Bqbpit3wSfbd/habDb4D+0yX6O808pgs6WjwVCWlUN
 XnAbMAVFW8aPh3PGMF2tBsL9h9k60egW+T9rtvsXTxWcMMKbRQObzWKZpT6MeXjEbt66
 Qk6P4HH1/Pdht3ILQfNf0S5Y87+2u11BQXh0e/hTBUhrawfpdLlEO4yhCwcXWz8m4zSB
 uXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TAGDyapLgvqUb1jwBBzGWav8wwRbeRMTnggiJBSyH1U=;
 b=uZMdqTvk4SGxT/eKX4M1++u9qWbOJny+laTfPsEBDylegL2uZ0zGMph3eA0jG3MdUH
 tj49rBtcOZCskD9TbnT8NFI7orGeCutQT7ZXSBN7U2k9l2fZC11CGHEE2rXgVUv+o2Em
 A1pmiAbeWzBCBtNPeceYiX2ZCVY/WEvw4d8oyPf1SRPgbsG58j2/lgjEa1MO0fKkn8Ci
 siGmuUe1N+5XNoDfwKPwxDj5UVu6oFW7bG31eOfWTdro882aJRuF9z7nqMNUcWeGG2mZ
 eoceVrMkwwMsZ//0y3vieT4TCx1t7htiPiztcYWnm00L69RqdZ7B0kfQXFMXeKmij0gD
 xyJQ==
X-Gm-Message-State: AOAM530zCtm9FDZ8c4LLfNR0sQ+ImADRq/jOhRs9BlasgGnP4/WdfrMC
 OTFAgZwFXRQnlN5GqlEcR4Nz2Fw84M95QvIcr4I=
X-Google-Smtp-Source: ABdhPJxr4/rOcWKJROlVfROsEgiZp3qSZ0KB35Z8aRDJ5AXCUtERagKYI24ftG3rRIl5gBI1FDqwLOrIvEVcyxi2wWg=
X-Received: by 2002:a25:fc26:: with SMTP id v38mr2263408ybd.314.1593167150877; 
 Fri, 26 Jun 2020 03:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200626003313.715355-1-atish.patra@wdc.com>
 <20200626003313.715355-2-atish.patra@wdc.com>
In-Reply-To: <20200626003313.715355-2-atish.patra@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 26 Jun 2020 18:25:39 +0800
Message-ID: <CAEUhbmVQmS0v4WGEZAqeKpD0WwMUfdmLGqH6QQLo-_MS0AtZ7w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] riscv: Unify Qemu's reset vector code path
To: Atish Patra <atish.patra@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b41;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alexander Richardson <Alexander.Richardson@cl.cam.ac.uk>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 26, 2020 at 8:33 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> Currently, all riscv machines except sifive_u have identical reset vector
> code implementations with memory addresses being different for all machines.
> They can be easily combined into a single function in common code.
>
> Move it to common function and let all the machines use the common function.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/boot.c         | 45 +++++++++++++++++++++++++++++++++++++++++
>  hw/riscv/sifive_u.c     |  1 -
>  hw/riscv/spike.c        | 41 +++----------------------------------
>  hw/riscv/virt.c         | 40 +++---------------------------------
>  include/hw/riscv/boot.h |  2 ++
>  5 files changed, 53 insertions(+), 76 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@windriver.com>
Tested-by: Bin Meng <bin.meng@windriver.com>


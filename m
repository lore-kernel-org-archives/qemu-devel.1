Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C8DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 06:30:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 995722065F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 06:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uvAvMhXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995722065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZTrw-0005hR-MG
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 02:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jZTqL-0003In-Jx; Fri, 15 May 2020 02:29:13 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:35958)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jZTqK-0000iF-L1; Fri, 15 May 2020 02:29:13 -0400
Received: by mail-yb1-xb42.google.com with SMTP id a10so581971ybc.3;
 Thu, 14 May 2020 23:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zndiXgow/8skrx8wFzYmYDP1ckh6o/SGj7ttunerlk4=;
 b=uvAvMhXrZSpvvfr8p7dXKx0nsUmmHzURe8rDtd0bSn725vWiZWJb+M5e5BxVB2NrVG
 UtiR1Cv6+T3V0otbax5rj0n5HdHDcYFdt1cmjD5CRsXisgbeWE4K/Qam9CtUmuqINr8s
 uaChfbMzIMs3he3R/kX1WzcrPZXNoRJetcLn4rcdDXsO2xLfFvowbR+c0hLQw8hIU1Ja
 klJImxFOrlFr6HnTYZzPzvqf/0F8Tmb69jG+Da8jyO0RTe86nF3i2DwgYu8HUy5REIny
 b2UCKfprlCoq24xjQWcl5V4AixCJ52X1sxKwneTCaBYhqRAU677lPZNBKCM5FgAL07AH
 uLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zndiXgow/8skrx8wFzYmYDP1ckh6o/SGj7ttunerlk4=;
 b=iWLudIWtQiR5zm1YzyjPo9IT6nJEjZbRt3YqatZti88ASIULaJiHgc77GjoIf/3T81
 mLsNvlxQBaB93QGgQ4bWP/LgVeZ0/jjIxnCoi1AiheDY/NbasPpQHMDNT6IPzaGLcF4d
 Z9/5gN52/g4oxUFCHKkvu+9c7IPEZYrRv6VZdpZLZ0lrbTNzX/fDJ78h77PMGdtPzkWc
 +79/yLNubHqtJUzy2RlsA3s0LajIjG1ZT4HduzgITrYw35SkY6g56KjM0WgM0bnNmuRl
 5LDtVr0nxEtsPFE6Oz1WZN/aQwIoodAqGfslmAGm1VPnNt9dKTcS9Md7aN7aA2Ruybq3
 4oQQ==
X-Gm-Message-State: AOAM533ogx8RrXJaRRlyac+w3WbR5lYAD9D67fBlvM+RfIorI80iSLPS
 I/iSZ2AI/ysmgIi5eQFII66EbxGY1OQyeMzruUo=
X-Google-Smtp-Source: ABdhPJzZJvmnuHFQbd5RI60VqnLNVOWG59GsyClT214BDEVlfez8xoYHykhhDvTjlVxFNJrff2BrYbCTsBpEvzKGowc=
X-Received: by 2002:a25:9206:: with SMTP id b6mr3301036ybo.387.1589524150687; 
 Thu, 14 May 2020 23:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588878756.git.alistair.francis@wdc.com>
 <246b1d1fa8d1ad334152ace0cad21e8f40d53e7f.1588878756.git.alistair.francis@wdc.com>
In-Reply-To: <246b1d1fa8d1ad334152ace0cad21e8f40d53e7f.1588878756.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 15 May 2020 14:28:59 +0800
Message-ID: <CAEUhbmXnAcXPsa90JuHaqCu0HHot+dScx+mH8rR=SetxJx-ajA@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] target/riscv: Use a smaller guess size for no-MMU
 PMP
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b42;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 8, 2020 at 3:29 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/pmp.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 0e6b640fbd..5aba4d13ea 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -233,12 +233,21 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
>          return true;
>      }
>
> -    /*
> -     * if size is unknown (0), assume that all bytes
> -     * from addr to the end of the page will be accessed.
> -     */
>      if (size == 0) {
> -        pmp_size = -(addr | TARGET_PAGE_MASK);
> +        if (!riscv_feature(env, RISCV_FEATURE_MMU)) {
> +            /*
> +             * if size is unknown (0), assume that all bytes
> +             * from addr to the end of the page will be accessed.
> +             */
> +            pmp_size = -(addr | TARGET_PAGE_MASK);
> +        } else {
> +            /*
> +             * If size is unknown (0) and we don't have an MMU,
> +             * just guess the size as the xlen as we don't want to
> +             * access an entire page worth.
> +             */

It looks the comment does not match the code logic. This else branch
is the MMU branch.

> +            pmp_size = sizeof(target_ulong);
> +        }
>      } else {
>          pmp_size = size;
>      }
> --

Regards,
Bin


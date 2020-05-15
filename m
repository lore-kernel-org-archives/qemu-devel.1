Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23873C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 05:01:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1C90206F1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 05:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfXbeT2i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C90206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZST1-0004LS-UK
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 01:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jZSSM-0003qX-Ga; Fri, 15 May 2020 01:00:22 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:42096)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jZSSL-0005KB-Lx; Fri, 15 May 2020 01:00:22 -0400
Received: by mail-yb1-xb42.google.com with SMTP id i16so478283ybq.9;
 Thu, 14 May 2020 22:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=p830e/W+LGiBLlUHSSPNRdhNho276/CPRt0muQvm3Es=;
 b=NfXbeT2iUuDKCCi/7x4XyEFfvUzOZ9Pf4DME5oa3b5ssdweLvOvNpt2Cvf/PkusBKn
 hTKEJldlAiFMHL/HdPasuHxv+GlKxkpembvkMHp/ehp1vf5OAhXGRzErGBg4bWH/q2kE
 QsSPpo9esYY9ceGPASOnYocMQBZ+64GQb0c0X2GfRlJmc5oqvlKgjtWwqH0vuDxZ8ukE
 B9j7gI3Opla3C2LOKwFhPWl3yif5AexAaq4sYJYLjJG7CxZkzyrM2ynMTY52++x66iAS
 riag5Mjwv3zL+XdFFD+DKe4ZSnilxC1LrTWVgoX00xrWmae/B0TOku1jZk8mNm4SKKuT
 GTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p830e/W+LGiBLlUHSSPNRdhNho276/CPRt0muQvm3Es=;
 b=rNBeFjtwIsJsM0D5BNAaqy5BtFW/rrrMRNRy04Sc7Oa23FpYYeY3Euo7UR9kWvLYmq
 +epw8/Q1pP8oSMqZZbDGr40iKlGpi1o2UzCfWBydkmKXPRLCd0pBh3N2v1fjif1nujbK
 2BxUVCkcLcQX7F3UjX1lUlklIPSpaac4k5aVrqGSIaAjmQ+zHPuuyDYDaycoEZIrQoiF
 Z7koM1AeVS5/LprFGhqUBcVLpMF3oCFghmdwdoTUsYQ45WxUNwMXjaK6LJhlkAm/ndDZ
 qxA7XN3czs0evq0rML669JHSm4eH84ycq5pCJMEj8OAypfeYaQiLsJJ3Xd6vbXOblC4G
 xjHg==
X-Gm-Message-State: AOAM530bX6nlGu8K7VhAHfxTImqh5dzn9JMyDfUjPSMJLxcLnsVOoMgp
 MoXXKQZ9DLW+A5Gv5pEdgsprZoRGBB+wKaraBAk=
X-Google-Smtp-Source: ABdhPJwJFxOIah1tmiNU5mxIoPz4Gbo4fKotXv3r2BH1sibXUdKWo7vbA/OR+Buh3AO+p9IKsvXU0ZrVpgjTJh8pFC0=
X-Received: by 2002:a25:9206:: with SMTP id b6mr2870099ybo.387.1589518819921; 
 Thu, 14 May 2020 22:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588878756.git.alistair.francis@wdc.com>
 <dc10c6b220154fd448630ef7a790e5d7e59ab45a.1588878756.git.alistair.francis@wdc.com>
 <CAEUhbmVMu4hov1WxafL9+8kET_Q_Q2hMi8JTnbKE78EhU4kaHQ@mail.gmail.com>
 <CAKmqyKP6khvkjPbYuth3cXgyS6Zed8S29tfwW1Yv_x1MmxG4sw@mail.gmail.com>
In-Reply-To: <CAKmqyKP6khvkjPbYuth3cXgyS6Zed8S29tfwW1Yv_x1MmxG4sw@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 15 May 2020 13:00:08 +0800
Message-ID: <CAEUhbmU1ZFuB1cVS9EizoaZmWiG0pzPmPFjHQh8nJVk_nZuAwA@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] riscv/boot: Add a missing header include
To: Alistair Francis <alistair23@gmail.com>
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alistair,

On Thu, May 14, 2020 at 11:38 PM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Thu, May 14, 2020 at 8:34 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > On Fri, May 8, 2020 at 3:24 AM Alistair Francis
> > <alistair.francis@wdc.com> wrote:
> > >
> > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > ---
> > >  include/hw/riscv/boot.h | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> > > index 474a940ad5..9daa98da08 100644
> > > --- a/include/hw/riscv/boot.h
> > > +++ b/include/hw/riscv/boot.h
> > > @@ -21,6 +21,7 @@
> > >  #define RISCV_BOOT_H
> > >
> > >  #include "exec/cpu-defs.h"
> > > +#include "hw/loader.h"
> >
> > Why is this needed? Currently this does not break build.
>
> Currently every c file that includes boot.h also includes loader.h
> before it. Which is why the build works fine. We should be able to
> include just boot.h though so this is a small fixup to allow that.
>

Please include such in the commit message to help people understand.

Reviewed-by: Bin Meng <bin.meng@windriver.com>

Regards,
Bin


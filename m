Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A328C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 06:30:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2A622065F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 06:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkAvkm33"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A622065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZTrU-0005MF-TY
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 02:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jZTqY-0003gC-Jg; Fri, 15 May 2020 02:29:26 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:43685)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jZTqX-0000ny-PF; Fri, 15 May 2020 02:29:26 -0400
Received: by mail-yb1-xb41.google.com with SMTP id x15so564945ybr.10;
 Thu, 14 May 2020 23:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xczrdqwIAlrjpMR2PqQaM5/RVhHQoJnWbvY7Au9+RnQ=;
 b=fkAvkm33WY79kgWkyQ7iK6EB+MHg/IT6SC8nNz1vCfXS15+TGPV2P84eulYb+PoQ1G
 panJcdtGtsVQUgqKGeA2/ZQ2sPeaL78eW9amr1CvnvIAx5yg4KB3feUaMFRZCXtdA4jz
 JUcFCdp6cMFIgi2m0a2CvyYJ7+s+98po/7vm2m8O5oz++Y1yRCDpLvo2IbVselsryrCA
 MMNhprB7dx8wkbXnbMubqXNDM8NATn8BIl4sv2V9YuYEdD6DcQOUorw6Xj51IbIJydDG
 o4G8RzXQe8nEr6ZXAcxPXhbgCmrzHsOEqtJLF5JRpRx2M0mbAOx6U0kLUtksYzB9ACQO
 5q0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xczrdqwIAlrjpMR2PqQaM5/RVhHQoJnWbvY7Au9+RnQ=;
 b=lD5o6hxnsl377MDaaWv4rme53bpbTzVJTcie7lM2+NbejZcjWemMbTudgSmz0ZG5P5
 pj8LB5Ps6qxHwhBf0Dy6hNAzGnqJFHfE6yBTVdLgrUVflG54duxbRB7D6mTcSekIcag7
 057gAeFfA8Mf6Ly/DWCwWmjj2NogX852R/YPnmYTOvqEIHnT7tN+XL2qpcuXHXQ9YDJl
 97SvAdiMFLOVzY/pULLbeHKQVOKlN9a3G+ocXl/dCf/Co6Xgr7DcExYbpt7qa/MIe0BN
 zsX9WqgQXBWlNA9yf0oN4TtW5rM4J7LKOgI2UqBFkHKkGSAN43qx74WTekWB+um6Z2uT
 Sz3g==
X-Gm-Message-State: AOAM530G3+5DbsRHizruFqzCMWT9oUHbvUbD3J9UXNPXiwWx8hszxeDD
 9masCbne0pGJY1puFxO+gHxJdBR/+2fs8jTl/zs=
X-Google-Smtp-Source: ABdhPJwvV4NOyCUkWPdB0acVyI3ryS5jEFz23OrjCkogAz25FpouFYEtifz67XJ7NG8eqYwcqKgwHCWJNzLd1EWzMZs=
X-Received: by 2002:a25:bdc8:: with SMTP id g8mr3051045ybk.122.1589524164506; 
 Thu, 14 May 2020 23:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588878756.git.alistair.francis@wdc.com>
 <12f00eacda584976c310b55f426b2960969231a6.1588878756.git.alistair.francis@wdc.com>
In-Reply-To: <12f00eacda584976c310b55f426b2960969231a6.1588878756.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 15 May 2020 14:29:13 +0800
Message-ID: <CAEUhbmVboOM+PSsAuddM=CxcHfkOBA-bbUp1pRTrRdi5eS4ypA@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] riscv/opentitan: Connect the PLIC device
To: Alistair Francis <alistair.francis@wdc.com>
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

On Fri, May 8, 2020 at 3:22 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/opentitan.c         | 19 +++++++++++++++++--
>  include/hw/riscv/opentitan.h |  3 +++
>  2 files changed, 20 insertions(+), 2 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@windriver.com>


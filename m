Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA19C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 11:20:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 533D620772
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 11:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="mVjXa9CS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 533D620772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJEwW-0006qm-Fq
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 07:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anup@brainfault.org>) id 1jJEvm-0005zh-8V
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 07:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anup@brainfault.org>) id 1jJEvl-0001tz-79
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 07:19:42 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50729)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <anup@brainfault.org>) id 1jJEvk-0001t3-SO
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 07:19:41 -0400
Received: by mail-wm1-x344.google.com with SMTP id t128so2025841wma.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 04:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=geJZCMvrUNcmYjo3qSm1Tn8ThMRGTj/0Gmcabw0Xnqs=;
 b=mVjXa9CS8W+RoZ5UPUCK/Loxk2ZfUaL3YIPeETI00lxRU1iSSiTYxQeWxRkceN6j9c
 gxySPCZNIdAKaHyAkZmY9OD1MI2GUDVsHQ6P0q1O4DnxdV68c/7LZrnajmycZGjgEYnT
 0PSANlg1RyWsxI9dZH0/5jnGqQno58sITAmO+EI38HkLNHmFwCG3bH7CZAGA8ZeSg1y7
 0gTTLV6LLKSM45FwJtehjAb3Yz4yaWJxQMvZKiRKOE/SPI9mbcdGmCnUakpGkismdU/X
 VIjoIFIKxKKpLnePAC0vQ0ReJol0/BEpKtxWFQS+Lq/s6XpVe4feg9oPdl4IPWtiBdV9
 7lrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=geJZCMvrUNcmYjo3qSm1Tn8ThMRGTj/0Gmcabw0Xnqs=;
 b=mjikFQB2sNnjT4+tNVhDDFixoqtbNmw6QLMSP1y8BH5aHVz9xQ2aNIwTDbkPTZJPb6
 n7xGZjED1y2zR3ApNc7Bkq3Yu2UjqzQqRshddEQimWeQoZXKUF8Px62jkVHK3EYrxAbl
 +8Umc3SPO0Sv68tU3p7TS96tVsEYVbM3YI1pQ1W2/MZk7aa+Ait/SIQvw+PY8aGXrQ4D
 Av/bw0I+oaECL2bANgxjjG/o0RsWgrlbN+UssMoprS3aHbcA9zYU/ZeJrQJfRve5i9Xs
 hUsgHf1W0I+7J8wmY3UiyJzSCh6sUuJZ37tYlCxSSAII7ZDto+VGvN/1uqZzeeamMCqd
 Vkbg==
X-Gm-Message-State: ANhLgQ0j5RZ3ovM2zKtbXAfowkZJ/6Zemt8cZcUs/iwIyKP+m1lvVR9p
 /2vRKxPk4eYuqKbvtfkPx/d9Uj9cyPjYYcFeIWITmQ==
X-Google-Smtp-Source: ADFU+vvhzkkJ/9mMg6ecvYk/ZXrRPd048tDsdEcVFwA40WMS9SBPPsUlgchAg12fprxUbITGVRUQduGfcXq1dnx8ITU=
X-Received: by 2002:a1c:6146:: with SMTP id v67mr3100199wmb.78.1585653579430; 
 Tue, 31 Mar 2020 04:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200313034949.3028-1-jiangyifei@huawei.com>
 <20200313034949.3028-3-jiangyifei@huawei.com>
 <CAAhSdy3_BO7pRwvLiS9qd3NLXUCj_MnsxT8JtD0833AnY1DOZQ@mail.gmail.com>
In-Reply-To: <CAAhSdy3_BO7pRwvLiS9qd3NLXUCj_MnsxT8JtD0833AnY1DOZQ@mail.gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 31 Mar 2020 16:49:27 +0530
Message-ID: <CAAhSdy24zBmuJ=BZFMXsHRJr-tLTEZs=C92QsE26KLGxPxd88Q@mail.gmail.com>
Subject: Re: [PATCH RFC 2/9] target/riscv: Add target/riscv/kvm.c to place the
 public kvm interface
To: Yifei Jiang <jiangyifei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: "Zhangxiaofeng \(F\)" <victor.zhangxiaofeng@huawei.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Anup Patel <anup.patel@wdc.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, yinyipeng <yinyipeng1@huawei.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, "dengkai \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 31, 2020 at 2:43 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Fri, Mar 13, 2020 at 9:23 AM Yifei Jiang <jiangyifei@huawei.com> wrote:
> >
> > Add target/riscv/kvm.c to place kvm_arch_* function needed by kvm/kvm-all.c.
> > Meanwhile, add riscv64 kvm support to configure.
>
> This should be for both riscv64 and riscv32. The KVMTOOL compiles perfectly
> fine for riscv32 (although not tested much) so there is no harm is supporting
> both riscv64 and riscv32 from start itself.

For your reference, I have updated KVM RISC-V and KVMTOOL RISC-V repos
at:
https://github.com/kvm-riscv/linux.git (riscv_kvm_master branch)
https://github.com/kvm-riscv/kvmtool.git (riscv_master branch)

Above repos work for both RV32 and RV64 systems.

Regards,
Anup


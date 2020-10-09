Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC42C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:14:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1796D22276
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tYEJZrOl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1796D22276
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQpQC-0000gC-3S
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 06:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kQpPZ-0000Ca-BU; Fri, 09 Oct 2020 06:14:05 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:40396)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kQpPX-0001CD-Ru; Fri, 09 Oct 2020 06:14:04 -0400
Received: by mail-yb1-xb41.google.com with SMTP id n142so6841950ybf.7;
 Fri, 09 Oct 2020 03:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NuQN3GzTaTLEVjmLmeXYzh4mGyUEA6Z6LXCQHNzqEU8=;
 b=tYEJZrOlttnYjDYLEGGi6pE8Erb/myK1caJ6sxmveT3B8un59f5riC6HclA+GHk9ji
 rvdEnyrSbZwhz+1CGsXWZKu5PvY8HYZj29fTTLbBjzJ/njAKBwnf5K8k8QcsY6whF++9
 roE4iuySFwdCYSx2ZLP1AR0i+/qjoleKGliYBUzgZR1J8emeqKn8IvstaLYBLfOkMpyG
 g1hSI5yQ7phC5DeOC6WmIYVujOzjIzWQOwACKqAX8o6vzqYiOP58s+N4TI3YlYJOiKlV
 W0gUYRVGRqjpTfs3e3QS/TzscQ81PpXnGHqHLRcbNLnijG7dfT9Y3KBklr037F3PxNUC
 pNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NuQN3GzTaTLEVjmLmeXYzh4mGyUEA6Z6LXCQHNzqEU8=;
 b=VU8tmBVsyRhY8zsVU3d/TuE1l/WDGajYos15KEvha4kLXYgIlaJQNf2t4hDn8rZ4wd
 nvI8qlxbIAohAoITl2bEErEcGMFW9OZHhYZ9+ioffdt2R27apcmn10c+KWA2xcd0eBiR
 P7DFOrixv0n/OflQd4p9yBSCjRUKaNh77uRibGNjywItSWtaR+pnNdYbej/nPdO0ibkJ
 ALplBa4VMRqnB+GZhKwU3EsnFul/KUiKuoTZJTv7gRWL5nf1wtsYuv7RDEIEpjmKVJ/Q
 A9zrX3mEqAsJnQj1rSj7td3Gcv2A8tu1Hk8lk8s+xSezjXHsXCPFGlGkmWiijld44TpU
 zZUw==
X-Gm-Message-State: AOAM53054zBe/+3TZUSN7EGbugNtqyYSanuGQMDKHLGx5N6sz07jjrBa
 mi5D7gup1Zk3ts2IlczNo9WzmmFjbIrGPPcC6IQ=
X-Google-Smtp-Source: ABdhPJxhav/wiO/AEIJMtzYWKCTW36c3OSneb7A5YOZk9prQxZacYHgd11y0gASGqmbuS80H8Xp/VOIvN/gq97rEumM=
X-Received: by 2002:a05:6902:690:: with SMTP id
 i16mr15806312ybt.122.1602238442487; 
 Fri, 09 Oct 2020 03:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601652616.git.alistair.francis@wdc.com>
 <dc18ce8e762658aa80337a97e6e9c978ab9e1696.1601652616.git.alistair.francis@wdc.com>
In-Reply-To: <dc18ce8e762658aa80337a97e6e9c978ab9e1696.1601652616.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 9 Oct 2020 18:13:51 +0800
Message-ID: <CAEUhbmVdv_7onVjDes6_Tw0h2F4FqVnuiofFkRm5tHLO4GE6Kg@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] hw/riscv: Return the end address of the loaded
 firmware
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

On Fri, Oct 2, 2020 at 11:42 PM Alistair Francis
<alistair.francis@wdc.com> wrote:

It merits some commit message to explain why the return value of
riscv_load_firmware() was changed from firmware entry address to
firmware end address.

>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  include/hw/riscv/boot.h |  8 ++++----
>  hw/riscv/boot.c         | 28 +++++++++++++++++-----------
>  2 files changed, 21 insertions(+), 15 deletions(-)
>

Regards,
Bin


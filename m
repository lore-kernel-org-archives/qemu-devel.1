Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39595C388F9
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 08:57:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B574920706
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 08:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9xtL9NM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B574920706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWyKA-0003Vw-QM
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 04:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kWyIS-0001mu-Pf; Mon, 26 Oct 2020 04:56:08 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:42869)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kWyIR-0005ft-Bu; Mon, 26 Oct 2020 04:56:08 -0400
Received: by mail-yb1-xb44.google.com with SMTP id a12so6990116ybg.9;
 Mon, 26 Oct 2020 01:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YCz9myVoZQ3/1AttAltFyPNFH+Bcxq5YvQZAKEroL6s=;
 b=B9xtL9NMxAG3rk6GptGIOG+wk5apK0o7XYNiXYyTynmUuE7OsXVkEAl4Skw935QUoP
 QNwj7FLuwiPbHadGB+IyMDkJRfxbryNUGJ3sAjkS1oLAiYmkA07UPXUXuJlIz5rI7zAe
 073SPh8UG1WT3Ck/zHFQpm4T4pJn630Fau14k6JMIE9G8dPPiHeMyw12VeJzMVMpCXrd
 3pFzOm1ILYFEmliRq6jrYODaeypyq5lwUvOApbUWe2VrTS4SfBKHreqMHM9LnnwRQOgJ
 wh+570dE5RipnfZZ+0TovTPcK7uFtO0/v4Vf7326h7/ne0KeqmtcBxUVear/qzfSOtX7
 jryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YCz9myVoZQ3/1AttAltFyPNFH+Bcxq5YvQZAKEroL6s=;
 b=RAdWz55xy7rAR6BGyBJUqYKtt7OsKjyL1l3LePqopJCMcXKjA+iqPx8+rAfGwV21mr
 Sd8ygNy64ItHzJNwfiL/ikxNRVWGZPJPXokrpQc88Hyhbfwc8utzlyENFsS9liQVEZKW
 hz8t3hUdHpVPoYikIRQz+EnSCzVAFUcgxvkMLKmV1BmD0HpTDB4wwSVY1pQrpDGXQDOz
 BSJJJBUW/RXduW5Hs/PPjbx61S18gJH0OFYyAAhswimDAAb04nSn0pnmcKI/dgTsk4lh
 oxGNdG6w46vPcYFf9TWnhwVhax7v+31HrfqktLN6vneXkVrZy5uasoMKDGy787b/9njt
 BAbg==
X-Gm-Message-State: AOAM531cuin1CkpNQhoQvIV8PpBm2jaMLZEAoem73B/MfqTHRl0EugCy
 tbgAKOVO4szUGoJXbDEYy7VgfrIhJc6ghevOiD0=
X-Google-Smtp-Source: ABdhPJxsnvK/gxPxP8N4jtkyXZk/+46uZz3U3RvE05HDUrv3JGmtfodxfhzrbUc47TbLKaKrwpn358UHsg/62EWJlIw=
X-Received: by 2002:a25:705:: with SMTP id 5mr19704501ybh.239.1603702566189;
 Mon, 26 Oct 2020 01:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603467169.git.alistair.francis@wdc.com>
 <9ac707eccfca0158a851cecfd83f90ab124cded3.1603467169.git.alistair.francis@wdc.com>
In-Reply-To: <9ac707eccfca0158a851cecfd83f90ab124cded3.1603467169.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 26 Oct 2020 16:55:53 +0800
Message-ID: <CAEUhbmWHW6Z8fjD30XR6vdYLC87WSSEPzvTT2yroD-HZ90-RFw@mail.gmail.com>
Subject: Re: [PATCH v1 04/16] hw/riscv: boot: Remove compile time XLEN checks
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b44;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb44.google.com
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

On Fri, Oct 23, 2020 at 11:44 PM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  include/hw/riscv/boot.h |  8 +++---
>  hw/riscv/boot.c         | 55 ++++++++++++++++++++++-------------------
>  hw/riscv/sifive_u.c     |  2 +-
>  hw/riscv/spike.c        |  3 ++-
>  hw/riscv/virt.c         |  2 +-
>  5 files changed, 39 insertions(+), 31 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@windriver.com>
Tested-by: Bin Meng <bin.meng@windriver.com>


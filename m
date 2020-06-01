Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AF7C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 05:27:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D76E3206E2
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 05:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfrSzywI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76E3206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfcya-0007MT-5o
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 01:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jfcxr-0006uu-Od; Mon, 01 Jun 2020 01:26:23 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:33582)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jfcxq-0007Dt-VB; Mon, 01 Jun 2020 01:26:23 -0400
Received: by mail-yb1-xb41.google.com with SMTP id u17so4603828ybi.0;
 Sun, 31 May 2020 22:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9Wb2j9yzvHWuf0pM7CMkqVJOTXvaQtuUY7pA3ddCFRU=;
 b=KfrSzywIj0SX9n9OuK4skAMDpWOzibPTQkZWyfA18nuq4Q1FH956i9kDNyqu8L3PNB
 AqSAVnoLXyZA1ZHoeCgjZr2LWoFfTk2gawymaQ93DIEbgF6/Fc9sBSZoQ5Fq1h8ibko2
 UD3n7tzbs7g3v6FzBcGiplrkytpzIm4sD2/e+i2OFd+AuaIUsn8oTnjkX5U2cJ+Qzpu6
 6UoTzdWJ3q4808f0aVBwX2lqLIPSvJ9/XQpggWhhJnRsMkE0tRSFdxULD1XFPkZH+57F
 B5K4CfV1KZNauZVx7imdCaMXD8krr0UNEX9sfN0KpGCNCXiW2fEdo4dnrIX6+BI6uUi1
 jRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9Wb2j9yzvHWuf0pM7CMkqVJOTXvaQtuUY7pA3ddCFRU=;
 b=NrvPkjbYFYyDQ50RBRj2ZpQDjIaeOH84QfUmXpFHUJTOqe1jtavIRd6yjmoM3b55qK
 +Np2A2N5ZhRrE/lN9pjzKvl4Tbog46PcQUwFUmDiS1WE3d34Hx0pUaX675MVx8kYriex
 vZ5F7KfeTlPv42HStaCptOPXIy8Rr0HJgAkcsJKgbf02I33bgnzWrMvLqsot3VMOxCs+
 nwrHIsGTJnx4Cyz6aIL3BX8AHy1gWrp2wonNQEZypyEcgprSL3ktc9qdnwvDAikO8078
 HA9z4RBrN3rVHd3tva1NXavLJ57Bm3iACQTj9hPZDqlClL9+pwRagsqaqbAQ8iNOR+qf
 SiGg==
X-Gm-Message-State: AOAM531hHGD+/A/ruWjLPvzqK04A+dm5VqjeMeOIqPoDfhnBB6sJ9e7H
 qkktum9zZnaWOxilJB5pNnVHYrYOFi7uhb0McWymCLXL
X-Google-Smtp-Source: ABdhPJzO5j4b46XNK7v1qQsytDNCLXFrssa32Zg2qBXvLo1flDhoUTORIaqocV2q+CXX1D2PVyyXt3ChE8581Sa/81M=
X-Received: by 2002:a25:da44:: with SMTP id n65mr30122591ybf.387.1590989181357; 
 Sun, 31 May 2020 22:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590704015.git.alistair.francis@wdc.com>
 <a1bd144a1fe3e80a9b512edfe602c9a32e697429.1590704015.git.alistair.francis@wdc.com>
In-Reply-To: <a1bd144a1fe3e80a9b512edfe602c9a32e697429.1590704015.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 1 Jun 2020 13:26:09 +0800
Message-ID: <CAEUhbmU5hsKCunoEs4tqh4_LaSN+xcfCm1u3aHzf5WbY03feGg@mail.gmail.com>
Subject: Re: [PATCH v5 04/11] target/riscv: Don't set PMP feature in the cpu
 init
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

On Fri, May 29, 2020 at 6:22 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> The PMP is enabled by default via the "pmp" property so there is no need
> for us to set it in the init function. As all CPUs have PMP support just
> remove the set_feature() call in the CPU init functions.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.c | 7 -------
>  1 file changed, 7 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@windriver.com>


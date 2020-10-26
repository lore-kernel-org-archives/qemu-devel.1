Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0418BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:00:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 693C220706
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/nhqSW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693C220706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWyMM-0006s8-Bk
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 05:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kWyIV-0001r7-5n; Mon, 26 Oct 2020 04:56:11 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:39061)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kWyIT-0005gy-Lu; Mon, 26 Oct 2020 04:56:10 -0400
Received: by mail-yb1-xb43.google.com with SMTP id 67so7003494ybt.6;
 Mon, 26 Oct 2020 01:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HjiJUXLL3QKDAW9RqrYvTigqUwOF7AvEkONPPdHx1+Y=;
 b=Q/nhqSW6Rq8kCuZHNZpFfq0EJBOK//Z5XnQxM5MnrOGWIK3h1h79kSGM81qoPbvgYE
 bUIotQlbS7ygQjRY5SmicUBfqHXgofMnYNJ9N+dUnpkhBcYy3o9ik8+aWLddEMbpcjIp
 YT9I9OccSZV8S1cJsSOK18ebSlXPwGKjf3v7NriZhCyXqFniET/44M1MHik/kXJYrqGm
 /EYvOXH/hMKs5FXGzpn4AuGvKQ8vAANVQFIghuafy04U0gNDbih4XYapREtWM2jMnQXb
 asnkIv0Ig3wIWwC+MORyGg26J3fDkkPToOVoikY/wueKD1eeJTf4RFiLeVmkGbijKhML
 2FPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HjiJUXLL3QKDAW9RqrYvTigqUwOF7AvEkONPPdHx1+Y=;
 b=CzCQZQQjQISjqMFL2iGFYljmeB8PaJQlvOMeMNs+KrDLOs8+JGfyEN0oORpEoC7QyE
 24DhlcgUm6LBL1KMSarKhmdH6PvHobV09qh/8ztbbska+HJWH9brrussPfzjBsnvFpC8
 2hhjz7KbaZk1ohoKztu5VreH8/ULoJqzApcwGyDIslpxrWRhRDugVop1avOuKax6odg0
 tYXNkyrLn5ZagtxQujP+uTen2LnmxbudPHo80bY4cNhW8c7S31P48ihMKec9CflHSk0t
 m3V6mKG9SEIT3E4KZDyIjtXC/A28bUzSs6JH5K77j9ZTUoXuBr/cJR2qz4a5JmSqjqji
 yF3w==
X-Gm-Message-State: AOAM532Y99NOZDk2eMEhI7oMXhYCiUEyiaRGt9g2XDMR8Ugm6o4pcAGW
 YLiV8YFn6go9DZqMXqxGH8k6hBcF18P0oXT9I3M=
X-Google-Smtp-Source: ABdhPJybpCfGqzL4qJxmpPZDiRa+2ZJlHG4Xahqny8vltmPHh41iES5DThnf5Z/PeUVvyMplUjDlU8oEbSVPSgdUN8Y=
X-Received: by 2002:a25:bacd:: with SMTP id a13mr21907918ybk.387.1603702568503; 
 Mon, 26 Oct 2020 01:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603467169.git.alistair.francis@wdc.com>
 <c1ea88d79c585a0c1af70acd16ce859d6d9154ba.1603467169.git.alistair.francis@wdc.com>
In-Reply-To: <c1ea88d79c585a0c1af70acd16ce859d6d9154ba.1603467169.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 26 Oct 2020 16:55:56 +0800
Message-ID: <CAEUhbmWze5UqEk5yTsz-FmyC-tWjUu3hpXe2q4s3e+=a+SD4BA@mail.gmail.com>
Subject: Re: [PATCH v1 05/16] hw/riscv: virt: Remove compile time XLEN checks
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

On Fri, Oct 23, 2020 at 11:44 PM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/virt.c | 32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@windriver.com>
Tested-by: Bin Meng <bin.meng@windriver.com>


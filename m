Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDA1C388F9
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:03:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9755822242
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvnC2nZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9755822242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWyP5-0001Cj-LM
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 05:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kWyIX-0001wz-QH; Mon, 26 Oct 2020 04:56:13 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:33827)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kWyIW-0005hw-4k; Mon, 26 Oct 2020 04:56:13 -0400
Received: by mail-yb1-xb44.google.com with SMTP id o70so7012247ybc.1;
 Mon, 26 Oct 2020 01:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9pybJr78bVvapfavYXfM6yf471TkTAdxCqgm+6wN/80=;
 b=LvnC2nZGZGTvDlqtsrCOm4NdTWEOC4UctlVXPbEf1QmW2EACmP6m5z1siRzZ+Uj6Fo
 YJXqy40ButO9ZycsYdI4PmGIji4XfycCB5duFYIwFU6W54xBUaUg7kJSwOH0dIiH3lBH
 3H3fszMXmTGebtGseoc82jnNSEn7+XQK+XiogzWdZhJWt2yu36DDnaSF96TIyycubCdo
 NgbCz0H2cIPAKQsubGd0UKPHhkVpkvxXL69l8iZeXZATZr4H8MDdigpJ3pkeePG3ruhr
 mjq0WBbTq8HzN/ozrwuauVKmWABIaRMgkLAoArHG21p7ULhhgs/51ZUU6vlhIwolhxjK
 2AeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9pybJr78bVvapfavYXfM6yf471TkTAdxCqgm+6wN/80=;
 b=tIWu8DUDYktVFtfdhNFzjQDtjdj7ozOeey0PEy9HyezJNOCSpzrbBdZc5NmLcPyzHV
 +7T8HMB9FUZvJjHvj+cGWaaki70aFQJ8c/BQL4kISV9D5OcyOdRukyzWpetAT8d8ZJK8
 nfKxF8seJlFwqlixRu6g3pd3uLbp8JmxH0v1Rp96gV7gwPLayOgnEPrxFLSw583SvDGe
 oLl3SgO2nWoUzjR2S8RqWDK8/BHoaa6S0/Z6HEvfrBJOnmTT1i1QOXIawye5dTg/3k/C
 ZcuQxYmmXfP8JML1agFMXYRZRFOiCj9oMlWJt31UPrpICg7aW7L/3UvmmdcQ7JxYlS/0
 RPZw==
X-Gm-Message-State: AOAM531KYyMZl7QV2lV9OqYj06e2DZr1kNXN8j7NKmMdLPh+lU4EaiKz
 KJJME9tDCBc7OwNAjF5hrSfxg4+Wu80sSPJsNq+d1FXx
X-Google-Smtp-Source: ABdhPJx3WS+2nfhWKc6qL3BKttb2X0IMMC4ILLQGh/puFxOmYURXLnFfWK743bTrc6sFooaxPHU+Y9Lat7uNXuhywns=
X-Received: by 2002:a25:386:: with SMTP id 128mr18346777ybd.122.1603702571032; 
 Mon, 26 Oct 2020 01:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603467169.git.alistair.francis@wdc.com>
 <82ea05de42d429e1bf572cc134d4571d87a4cfc7.1603467169.git.alistair.francis@wdc.com>
In-Reply-To: <82ea05de42d429e1bf572cc134d4571d87a4cfc7.1603467169.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 26 Oct 2020 16:55:59 +0800
Message-ID: <CAEUhbmUvdh_oqhG2X2P0oKBEzjvWT-jsXVXPKNNg2CdGftuXjQ@mail.gmail.com>
Subject: Re: [PATCH v1 06/16] hw/riscv: spike: Remove compile time XLEN checks
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
>  hw/riscv/spike.c | 45 ++++++++++++++++++++++++---------------------
>  1 file changed, 24 insertions(+), 21 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@windriver.com>


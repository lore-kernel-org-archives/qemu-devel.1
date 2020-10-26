Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3783C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:05:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0677C22242
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0XCi7/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0677C22242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWyRT-0003Og-0X
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 05:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kWyIo-0002Ls-KQ; Mon, 26 Oct 2020 04:56:30 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:35821)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kWyIk-0005nV-OF; Mon, 26 Oct 2020 04:56:30 -0400
Received: by mail-yb1-xb41.google.com with SMTP id m188so2002302ybf.2;
 Mon, 26 Oct 2020 01:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8Ngt2yFRuvWjSs8QJgqJkXW0Co7OHWxTNYBAs1hNods=;
 b=b0XCi7/5jnv8wq/TPjlHtveUdrhn4LmreayX1dFCv5OozYjnMs2DDChmXaTba6cBDS
 RI36Wp4msJfh+RXnjL4AMq96Novsh1Z1A3e3A3ffcVFhskLKMuq0A4d2xq8F0P+7Th0G
 fUpGulITT/e+5myG2Gt8acJnD5xJeZfgiV/6XyuHEI9i9dJsy5feD5ibTpuq0XuiRqFF
 NFLvwZBvxIY3839XABaCRXxV4MmB4MeojYHDqPryJf20Kkns5E9mYjIcjbnJAxpZfut5
 CiFgaVA/ytwYD/XR5foAmhjL9o1/iOeKxZNPq7pzDXlkBuka+MAeWMYdk9NlTowLOHpT
 kMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8Ngt2yFRuvWjSs8QJgqJkXW0Co7OHWxTNYBAs1hNods=;
 b=iiepajJwDueHWMsP78ROXKKTSLUG+uuGTK7XI3D0MBCvS8LTss6Z9UHA7i6Fqli8Ey
 TQlRO3bjSaCQ4ohvlPGnZN3nw9fxaZG7/Mjq5TaWsIujwnJ7LRJLck0/ki7xkJxJ2lbG
 DrVgIV+b8Voc9NLHyia3HKXZqcE7a78Ws/hSw+FoWDzM4+C7YMdjC/a4Tkv1TcGxdB0C
 r5aQWoWf9kSNoJIIPf1SasBtpO46O6vtKuLROw89kjBK5Zf/rp10LtHwsyLtZUpxEAt2
 665kkJEYu3SO1JoxgKQyf9VbkYnP4R174x30TXovvYPMrrEEtqQwp/SfLSqmBZKAZJMX
 5mSQ==
X-Gm-Message-State: AOAM533wuu5icc8FgfzMVM+OdXKEMnzDISCWWFgN28Zl1C7T003L4Hw4
 e06yizwKcs8RpVlFoIMIent9cfrFtx31znqVgfk=
X-Google-Smtp-Source: ABdhPJxKe4xwG4o3jhCpw/HNdqifsDeMVYY3RfGl8Z2yEQTwmQZRhBDiMiRh9xhnuXiOyB2okADnetFsN0YJMYtgNrU=
X-Received: by 2002:a25:c1c1:: with SMTP id
 r184mr17070500ybf.517.1603702584070; 
 Mon, 26 Oct 2020 01:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603467169.git.alistair.francis@wdc.com>
 <b586d3c656319962c5cd4d73bd17e6d03bdd1301.1603467169.git.alistair.francis@wdc.com>
In-Reply-To: <b586d3c656319962c5cd4d73bd17e6d03bdd1301.1603467169.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 26 Oct 2020 16:56:13 +0800
Message-ID: <CAEUhbmUGNOB_bA03gmbK_Rf9B4rvYBXRdgZ4Vc_8B1+B0zgd3Q@mail.gmail.com>
Subject: Re: [PATCH v1 10/16] target/riscv: Specify the XLEN for CPUs
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

On Fri, Oct 23, 2020 at 11:45 PM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.c | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@windriver.com>
Tested-by: Bin Meng <bin.meng@windriver.com>


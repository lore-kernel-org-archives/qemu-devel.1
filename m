Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A68C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:10:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03835223AB
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWBRfj5g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03835223AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWyWJ-0001cB-2U
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 05:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kWyIq-0002Mp-Dj; Mon, 26 Oct 2020 04:56:33 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:41968)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kWyIm-0005np-Mb; Mon, 26 Oct 2020 04:56:32 -0400
Received: by mail-yb1-xb42.google.com with SMTP id c129so6991240yba.8;
 Mon, 26 Oct 2020 01:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uhpjNXzuHD18oEPxOlwjoj+3GXofOrzKFBnvXw9mbBU=;
 b=jWBRfj5gZftDZHsN9m2U0XEdaBJKulSVg9E4upk9P+0PulP/F+GtogOMMcuwn3BCzi
 lsrt/4FcRrOm3mmDlIquTnUy4+cmunNbVFF7i6gbei5TQoDnag9EoXojtPsosjVeGEHG
 HoI+yXLRIv9/aibC0yhaAURHUAjEuK6EILgaljZ8PbGsl2A3O/l4uWMc726EceKBD6YW
 LzsA06uuvEbwl+13j2r9yx7DwelrzXbVJwmAtgKSoZ4+mw/5RrloqjtasiWpCU1vo3Cg
 9Yxv1t1YDSfDYnh0i1X91Dr9Mpuul81AOK5pGOp4ftsrmUc0EEZc9gKfHCMnNnYcPvzw
 whWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uhpjNXzuHD18oEPxOlwjoj+3GXofOrzKFBnvXw9mbBU=;
 b=JjVzzQs9Be7rlWQaSh4fMV9q5uMNaN9eyCmfRZEh0G0H2nwQAMtwqRk+UVpjjedURF
 yJt2mx0UqoFSu/kWsY0H2XFii5IA6fKuD2vOgJrsyhNDbKU+dVGnBPJhkqQapF+5W1bt
 WdhzXedTGOEEwlBs3AfVQKqwaP0JeUCSCLTWnMm+OtKs8p/fnzW8ZPQqRItijigSZV7a
 0VqRX2eQTen2qwpGhme+Cn/Q6iCfOJWLMQk3vJF1eYpDclZiqOLK4+Febp2zuP3C6+3Z
 naxOEIIIZVaTaWhMuxvKHt5rOesU0XOfdDDgP5jul6dQxFGldnq7JeBpLPOdG+Ga0XvB
 04Kg==
X-Gm-Message-State: AOAM530ewtZ9+Me2SCH6vxWOWN+kAwfNB7ueJcFy72RyNSXN8Fagn4GP
 vKSEt2LD4SCADzge2fuS5rw87rcspjLomK2qUonJZ3GA
X-Google-Smtp-Source: ABdhPJzgGEXd9Ol0ZLREQIZLgJMARyBFcn+vZwc4oRGcToiRmVTsij+E39MKVClCpUiuffBuF6+1Hh/vko7p6wfNL+E=
X-Received: by 2002:a25:705:: with SMTP id 5mr19705646ybh.239.1603702586882;
 Mon, 26 Oct 2020 01:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603467169.git.alistair.francis@wdc.com>
 <594ed654cb36645d4c1b0aa3596f3e70d2ec5f7f.1603467169.git.alistair.francis@wdc.com>
In-Reply-To: <594ed654cb36645d4c1b0aa3596f3e70d2ec5f7f.1603467169.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 26 Oct 2020 16:56:15 +0800
Message-ID: <CAEUhbmVc6yGVe7VBy-x87+HSMTaRyw2p5+J8bRbGN9uiD7NCaQ@mail.gmail.com>
Subject: Re: [PATCH v1 11/16] target/riscv: cpu: Remove compile time XLEN
 checks
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
>  target/riscv/cpu.h |  6 ++----
>  target/riscv/cpu.c | 17 +++++++++--------
>  2 files changed, 11 insertions(+), 12 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@windriver.com>


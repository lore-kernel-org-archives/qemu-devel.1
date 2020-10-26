Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A52C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 08:57:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 706B520706
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 08:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PanpVx+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706B520706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWyK8-0003Q6-9Y
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 04:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kWyIR-0001ji-4k; Mon, 26 Oct 2020 04:56:07 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:42868)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kWyIO-0005en-Kf; Mon, 26 Oct 2020 04:56:06 -0400
Received: by mail-yb1-xb43.google.com with SMTP id a12so6990020ybg.9;
 Mon, 26 Oct 2020 01:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MKEMOv9vqXWKtvkIigSj+6rFSvUIpO/mtMVTTbCV1z4=;
 b=PanpVx+sxPdQUBx6XnvtwrP4kemSti18wi31NZZUSbM68IpRKOaVhhCNKh0jxyWNzx
 CVr1iZrg6Ha7m/Mg73NjtYp59zKmPbPokPBvq10BJVE4ghnLD8cWAhiR0VtTVzzLjrJ/
 fTFdffmPtrFBLTvRfOgU0lePOzCjL97CvsHSdm9/BA6AI2xGMRM2KWKXi4UrqQ5fEj9G
 0c9ocayN14XVIkVauw0ADo8V7agTkQkAj90A4jE73itL3tVryIX9LL8JfBqazw0mcwLR
 a2x9zwxOSBOjgE//vn++DcelWZFd/g5K1fQ3gFV2Lvz9WfEmzNn0stCSOVvchDIJsnJU
 aqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MKEMOv9vqXWKtvkIigSj+6rFSvUIpO/mtMVTTbCV1z4=;
 b=NEpdfyyCWvHvr6AE5YU77LoZQiBEC2voxHUL+DNSujzMYf/IlU9dKo+fIvx45Y2EzO
 D/dKmG/giQrppDTAxe/VzIgUk8GyGC+rHdahAL5dRsaElRIzavMRJ5WAS5JR+c+TtoR4
 0Mggfjwu/fcRuucK7xzY/IobwlcDCmXSJlcTnbY+OHoHLWhzlmQj9giE3xqrz8GUk7gH
 ca0Tt2XU3PaYhZFnmNjlf8zZF1hEVfk95VdKP281r7dzgLRx1YIVG4cWtkAk5hbIf/Uv
 7VNq3qFiHnfvT0tFYqfv5jaW1dPFM01+1dVbmttTfbkr0IbzvInTWQ1J1dtZEriYKHvo
 lxeQ==
X-Gm-Message-State: AOAM5323mCUhmS84ArWXP8h4jh4zrqMr5fH6M4VZn6Fh/o+6Qtz48qFu
 1cQJSZBL+wpWsa2A8Y2tZWH8Wm7dwZwdd++Z7To=
X-Google-Smtp-Source: ABdhPJzs3AAj2QJ2iTwDt4fRY5NqX+NSvXVlrHuEBasunOSIlBtt2zGHvJ9NHbk5t+7mdBtLn/89hB4odGgLrk3eA0I=
X-Received: by 2002:a25:c1c1:: with SMTP id
 r184mr17069517ybf.517.1603702562902; 
 Mon, 26 Oct 2020 01:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603467169.git.alistair.francis@wdc.com>
 <9710f7917b7a1fcffce2d926005efc3bb84c0152.1603467169.git.alistair.francis@wdc.com>
In-Reply-To: <9710f7917b7a1fcffce2d926005efc3bb84c0152.1603467169.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 26 Oct 2020 16:55:51 +0800
Message-ID: <CAEUhbmUvBBGAy9hOann+7VGMDv0FiPXztAm-8zM9d95h2gCMJA@mail.gmail.com>
Subject: Re: [PATCH v1 03/16] riscv: virt: Remove target macro conditionals
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
>  include/hw/riscv/virt.h | 6 ------
>  hw/riscv/virt.c         | 2 +-
>  2 files changed, 1 insertion(+), 7 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@windriver.com>
Tested-by: Bin Meng <bin.meng@windriver.com>


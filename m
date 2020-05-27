Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02940C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 09:42:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1DA62075A
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 09:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frkT9utE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1DA62075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdsaD-0002Ru-Um
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 05:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jdsZO-0001x4-9Y; Wed, 27 May 2020 05:41:54 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:46011)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jdsZN-0007Xv-Bx; Wed, 27 May 2020 05:41:53 -0400
Received: by mail-yb1-xb42.google.com with SMTP id j8so6991985ybj.12;
 Wed, 27 May 2020 02:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zIJaUdw7Vw66VM7sVarVBPNBETB9RxEw8n3oUeYs0uk=;
 b=frkT9utE8p1+YdZlrNuhXvpRm3tXqI64jZBxXc6hLNgmBb7LC1CMNpUJgLNAJuy8FS
 iCx9iRzL05il4IUEjAFmJ0Xo7jIbywb5irzVzJfePnIzH3x6R7U6dDVSt8hTncVzb5pq
 3LPum00VPm1pHbM/nu8WVDGR0KA7+RZ7DTvdNTlH0b76f9rZL+Cz1cxPgeBOAX4WT+3o
 nJA6jCuK9OjnrwwXst7XOxq2nbchumQDmHmFOalh8hucWZYof2Reua8/DmpJQzqdqctd
 ndqZzuqnLmw8ae7zy0q+s1qLVIubo7rlcb0RyqMTxFsIGQyuEyvglXStywBg9XZVYjrH
 L83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zIJaUdw7Vw66VM7sVarVBPNBETB9RxEw8n3oUeYs0uk=;
 b=Jca6NQDhGm4pLLvEMgGtsTbaY5kuMCsfRNQaUNerGTB5o4jWM6bq/WMFdL7DcRpj+2
 v6HpSrYxRacbNgjBTtLjR4BQX1PVNkvWoN3reVBzA4IzG2wjsn7+tc1LXZWGwA4bugd6
 X4AXtlcG69q27L6MOEY0YIkGy1khGR2qzvikGR7zAjIQr/gSiO/FJcEATRgw7jYjwkqh
 TbJplRLT99r0DkPfwpKkXccxUsGIWKN356nF1oHSGmYR2a2F1ERmtMa0nWm099ilT4Dl
 ZqC8L45BpprrOwqXG0Wq+cvyHFX+5vEIuzX6qCASjndQ506yHSQAymYpFt/4I/uegXNv
 9etQ==
X-Gm-Message-State: AOAM533c/R9/bsrt8Rc5dnnG66N38lav05wQxpP7OwTFLRcUJOmV4dLK
 U1fnFASaqCiXFY6JkDgyakVCWn8X84cp88EgkN4=
X-Google-Smtp-Source: ABdhPJxIfXVRcRn+j1jYASsXDzVaeOqmfOm3so8CyQpYOM56kVZdWBv5X2jMCJSUeeF0pvZgGjcZoMIM6xyoEyisirs=
X-Received: by 2002:a25:6006:: with SMTP id u6mr8954288ybb.387.1590572511638; 
 Wed, 27 May 2020 02:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590533156.git.alistair.francis@wdc.com>
 <50009ff3005847a5958327d5a31ebc70f52e7a4c.1590533156.git.alistair.francis@wdc.com>
In-Reply-To: <50009ff3005847a5958327d5a31ebc70f52e7a4c.1590533156.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 27 May 2020 17:41:39 +0800
Message-ID: <CAEUhbmX=4kzs96QzPiTnge9L+zswr78UuDx1gbCKzgFRVpdNpQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] target/riscv: Drop support for ISA spec version
 1.09.1
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 27, 2020 at 6:55 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> The RISC-V ISA spec version 1.09.1 has been deprecated in QEMU since
> 4.1. It's not commonly used so let's remove support for it.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.h                            |   1 -
>  target/riscv/cpu.c                            |   2 -
>  target/riscv/cpu_helper.c                     |  82 +++++-------
>  target/riscv/csr.c                            | 118 +++---------------
>  .../riscv/insn_trans/trans_privileged.inc.c   |  18 +--
>  target/riscv/monitor.c                        |   5 -
>  target/riscv/op_helper.c                      |  17 +--
>  7 files changed, 56 insertions(+), 187 deletions(-)
>

There are 3 more places in csr.c that need to be removed

./target/riscv/csr.c:651:    if (env->priv_ver < PRIV_VERSION_1_10_0) {
./target/riscv/csr.c:660:    if (env->priv_ver < PRIV_VERSION_1_10_0) {
./target/riscv/csr.c:741:    } else if (env->priv_ver >= PRIV_VERSION_1_10_0) {

Regards,
Bin


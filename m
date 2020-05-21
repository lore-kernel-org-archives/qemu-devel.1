Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE226C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 01:53:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92B4B20709
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 01:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Myd6FQxy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B4B20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbaON-0004zB-P4
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 21:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jbaNq-0003ui-RH; Wed, 20 May 2020 21:52:30 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:35721)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jbaNp-0004oY-GZ; Wed, 20 May 2020 21:52:30 -0400
Received: by mail-yb1-xb41.google.com with SMTP id o134so2009654ybg.2;
 Wed, 20 May 2020 18:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zVR6s9pH1bXn9qLQRLAfcAFr23PTchwaf0rqzxjf/9s=;
 b=Myd6FQxy7rSCkCJAL6MurlzbfCKlWYHLCrS40QnQcrEkoRH1zzdUDEyo7lk3PCbYc4
 njnyx6AIyJNCHT0K0w3lCURtXEHU1CKfiTXqJzggqLL4coF2lVdykEdCfHwPfBYmjztH
 IMhzECja1TgiKgo4DM0Mhma5XXDovc6gbDp54UuAHy7VigI48fa0b9+LyoF99keKOD4W
 DGoUPNCp+vCAxDbhsuaqqUlC4cN98Y5VHdGjtVhNXnQ0YzN6BlUFOfjW1UqjPdEKO6r1
 B9sFUQHMPTR37JDG8EIMZm6sbXkTOJ3iWp+2gAicBGgDJ+ZFIVj/jjzLgEigmAjIc8Ry
 c05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zVR6s9pH1bXn9qLQRLAfcAFr23PTchwaf0rqzxjf/9s=;
 b=hVenqluh0t7n9thFMWJDUcidacPDYhcHWieXMTVeaa+90je+Ou2Xay7ovRj4bP5jc0
 I6SB/AHC0QAObaPvg+/l8AtoLa3iwj95SjLvfJHJhHlIY29ieo5x+fgKfnIbagV/BofZ
 ysLbnmToBQOBwyL4ZSCTWmC0ScEtRHRB9JLLZFPBN+LsK1DhChFBFCPAlDQ654uWZ7j8
 gWo9P8UGt7RHkhlXniL5N0KhoZB5vcMymwvpbSiAJcaEgFQrhiGeSn2j9VZuXj553pW/
 2Ej+g15gsCi07bGk7aeZwgjbXIkk54HY7ivwcxb/dbCTkMP0w4qr3AmsyM5pvdrETo6O
 F34Q==
X-Gm-Message-State: AOAM533M1CxP8baxIqW4FqKrwcJ7IsFVCk5kUUiaU9YqzY0HQU9EGdVA
 UDfTN1pMLhlEV1I2Af7m3X49CoaNv2n4E5q1WLs=
X-Google-Smtp-Source: ABdhPJyYU3/NdtCV60YVTM3/A4znMqG8cmp/tM/ba0Iih1prjG0CDh0NfAGok6K7BzQbipVhaBY9bSWXp+aQf7IlgHc=
X-Received: by 2002:a25:6006:: with SMTP id u6mr3080979ybb.387.1590025947859; 
 Wed, 20 May 2020 18:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589923785.git.alistair.francis@wdc.com>
 <c8b00dc5d38574f05be4c8c15549deb431aeba02.1589923785.git.alistair.francis@wdc.com>
In-Reply-To: <c8b00dc5d38574f05be4c8c15549deb431aeba02.1589923785.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 21 May 2020 09:52:16 +0800
Message-ID: <CAEUhbmVfdwKERmdRzmh30xFOW9Chfu9v8P1LM8nxgK+nLheiTw@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] target/riscv: Use a smaller guess size for no-MMU
 PMP
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 20, 2020 at 5:40 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/pmp.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 0e6b640fbd..607a991260 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -233,12 +233,16 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
>          return true;
>      }
>
> -    /*
> -     * if size is unknown (0), assume that all bytes
> -     * from addr to the end of the page will be accessed.
> -     */
>      if (size == 0) {
> -        pmp_size = -(addr | TARGET_PAGE_MASK);
> +        if (!riscv_feature(env, RISCV_FEATURE_MMU)) {

My previous comments were not fully addressed. I think the logic should be:

if (riscv_feature(env, RISCV_FEATURE_MMU))

Otherwise it does not match your comment and the commit title.

> +            /*
> +             * If size is unknown (0), assume that all bytes
> +             * from addr to the end of the page will be accessed.
> +             */
> +            pmp_size = -(addr | TARGET_PAGE_MASK);
> +        } else {
> +            pmp_size = sizeof(target_ulong);
> +        }
>      } else {
>          pmp_size = size;
>      }

Regards,
Bin


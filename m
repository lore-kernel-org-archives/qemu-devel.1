Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DD0C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 20:20:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CF31204FD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 20:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDrJLU0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF31204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43387 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOT3X-0004BC-B3
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 16:20:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOT2n-0003o7-9b
	for qemu-devel@nongnu.org; Wed, 08 May 2019 16:20:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOT2m-00017j-B4
	for qemu-devel@nongnu.org; Wed, 08 May 2019 16:20:01 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:44278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hOT2m-00016z-1m; Wed, 08 May 2019 16:20:00 -0400
Received: by mail-lf1-x143.google.com with SMTP id n134so13657097lfn.11;
	Wed, 08 May 2019 13:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=c74To35lqowx86X4mBSQThqsM7IlN3Oz7o+zU1qHIgo=;
	b=tDrJLU0diaxbaQXT/ik3EYBDTrhUljZ0kcB3F3lZrwzVNTzE41cEJe0DZU6t+KR8+S
	yo9AMNQiRHEoR1bTsWd8szWCzS2PJluyQf99RgnW4RvNKJxVSrhG7cjkBdX0WqaR+1HZ
	tlDeP9JbrifSbsvuWnSv+DkG2XaH8Lwrttwb9TMCd/ns/qz9HJQy0JcZHjYPqmqYahKU
	JATpxq1/nVrFvajrGYXUVfN1CQPOpZ+rnwsn9x2aN80di3Rpp+rDbnFN5HLdheRYVLT9
	Vde5dYOPG0JctAKsDX5ITLXJPivh9z0yGQN3W7ILEEsn3bHj2Vt+mcevshq89lx/2kVN
	C3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=c74To35lqowx86X4mBSQThqsM7IlN3Oz7o+zU1qHIgo=;
	b=lz4VkgHRrpS6w4gnUKJI5mJt7Hg55h69iPc1pkdGNlOUltxxEpsiBIgtUA3tnD94ph
	j4GfQJlpNzSA3E0H05ef3E9xoI2cB0xPN/DlH/XGVmQufNh3BmGnZnyN7q8m2cu1hSDy
	NiXjskywqAXxzqFif+yQAiQCLg6JsFCTK6AspGPJuYWD3ppdGjH9+y3ldfFXjSj0neuJ
	HqH9efezvzkG9wXYJjJiRhmKzqUZGTG11Fhjp9byAdYqC0NSFmYgV8PtAPsbGeJgcsNV
	Q1f4DpfIrKfooaSrrG8daT3d2HIxastqdPcedVoDo09EIGMmSk/OjFTdcvVRE3SPkzaj
	uQ4A==
X-Gm-Message-State: APjAAAXDFStnpsb+Bq0n6V1S5HrBF8ES4rlZKz7VeX4gjGOlMWvLvpos
	63ZgvJozVLN78T78S9x78RCObJB7mnEgC5RO1Z8=
X-Google-Smtp-Source: APXvYqxieY1iSbmKY+cuNBhIHGpmHwseYZzZg7F4Qrc9EAJpR7yrxBjJd6KxteIuwXxxcVQSn9is1eiotZtAERIg0sA=
X-Received: by 2002:ac2:523a:: with SMTP id i26mr37714lfl.118.1557346798224;
	Wed, 08 May 2019 13:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190508173835.14528-1-jonathan@fintelia.io>
In-Reply-To: <20190508173835.14528-1-jonathan@fintelia.io>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 8 May 2019 13:17:53 -0700
Message-ID: <CAKmqyKO-cWqxKCa0kZ=ivMmZn-0OK6ZVYk_BOM4M3ocRTGhKLw@mail.gmail.com>
To: Jonathan Behrens <jonathan@fintelia.io>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::143
Subject: Re: [Qemu-devel] [PATCH] target/riscv: Only flush TLB if SATP.ASID
 changes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Palmer Dabbelt <palmer@sifive.com>,
	"open list:RISC-V" <qemu-riscv@nongnu.org>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	Jonathan Behrens <fintelia@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 8, 2019 at 10:39 AM Jonathan Behrens <jonathan@fintelia.io> wrote:
>
> There is an analogous change for ARM here:
> https://patchwork.kernel.org/patch/10649857
>
> Signed-off-by: Jonathan Behrens <jonathan@fintelia.io>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 6083c782a1..1ec1222da1 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -732,7 +732,9 @@ static int write_satp(CPURISCVState *env, int csrno, target_ulong val)
>          if (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)) {
>              return -1;
>          } else {
> -            tlb_flush(CPU(riscv_env_get_cpu(env)));
> +            if((val ^ env->satp) & SATP_ASID) {
> +                tlb_flush(CPU(riscv_env_get_cpu(env)));
> +            }
>              env->satp = val;
>          }
>      }
> --
> 2.20.1
>


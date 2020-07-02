Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87EAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 21:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9140F20780
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 21:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMtBCZSQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9140F20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr7CK-00046P-SI
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 17:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jr7Be-0003ep-GR
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 17:56:06 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:43492)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jr7Bc-0003Mj-Ks
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 17:56:06 -0400
Received: by mail-il1-x142.google.com with SMTP id i18so25591277ilk.10
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 14:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/QiJ6ZJ7fHUeAJlnzRgNrMJ3VDVKcFJIOKbZF8VzRWY=;
 b=QMtBCZSQug3uytCBv/CqrYqstv7DYXwwnWfjgYLzjX8FGSmNxwkFE8lvIIITOlwtdz
 Rsvi+pSIA422ZcHic6f2F1zhFdLwMju8aRHPjxZdHQU+rK7GbYrTdIKcmE6LwbC++75W
 TFgwtBQThCqMLuV2b+qOD2blGLtfM9Yh9f+laSIIwtpuF4E+Ob3UmVWz60U+KuUY9cr7
 rfsPnr6hlyJcRuVMXZ67v0MPfI3KiXQbEcOvphi/vwzaWRcXT6amPe0q4yGHfXrFtaKU
 N+EhZHvmOXtsAm6mThKVO+ZlMPAeBYinOxUqJ+T/IYcekd2mJQqJVk3wvA9iY2Z4x47d
 Mqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/QiJ6ZJ7fHUeAJlnzRgNrMJ3VDVKcFJIOKbZF8VzRWY=;
 b=nM66PFImR+kwSM8MP5rj5OqWVZ+A/S98crc90tJ8WgNmEBQEDlifagO1a4ti8Zfre5
 gnj19qQlyMZUB4GJeGPbKUI+6/frhjsEpBUP6tFmnSK74tpAOHCRlfr8vEJMl4Ugkqv4
 qe1jTkOIimgHLhxlKNkYb4yGs+uQvp1P96WAcX9GAyH5c5lryt1DzZ1otao99vtYOe8g
 hb9V3W5IlKwm7ieeEoiVE2xhn5f9BiRFXM5vtmfP+RFLvV7IfwcLi1mNDDwS9J4URvvG
 efhceFXz8IYML7U6Csb1/vSNkH9w8N2JGa4VxrTs1d+9bDzf/Od7/lKVRyT0HCZVKN9l
 LPgw==
X-Gm-Message-State: AOAM533PKFoSyD6Kcru3qH59aRJKfEJvbGHGwJHmu4uC3LWBHznt51aA
 FyRYUmB75Oz3aZUpcuFIc0OBrGLGAH45EUxy6TQ=
X-Google-Smtp-Source: ABdhPJzAVzuuwVKn+9Z23WtH+9HNtJnPfyVsiK8oxBIhWS+FycOd5dupnLcaNtVrSge957H0RY6Veh7Zq/bWvaZ18Kg=
X-Received: by 2002:a92:5f12:: with SMTP id t18mr14889781ilb.267.1593726963295; 
 Thu, 02 Jul 2020 14:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200701165646.1901320-1-richard.henderson@linaro.org>
In-Reply-To: <20200701165646.1901320-1-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 Jul 2020 14:46:16 -0700
Message-ID: <CAKmqyKMu-8aBGp_PYyHzcdkcqAcK+O7+eooUfB2uOkT0utQ=ZQ@mail.gmail.com>
Subject: Re: [PATCH] tcg: Fix do_nonatomic_op_* vs signed operations
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 liuzhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 1, 2020 at 10:00 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The smin/smax/umin/umax operations require the operands to be
> properly sign extended.  Do not drop the MO_SIGN bit from the
> load, and additionally extend the val input.
>
> Reported-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Applied to riscv-to-apply.next

Alistair

> ---
>  tcg/tcg-op.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index e60b74fb82..4b8a473fad 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -3189,8 +3189,9 @@ static void do_nonatomic_op_i32(TCGv_i32 ret, TCGv addr, TCGv_i32 val,
>
>      memop = tcg_canonicalize_memop(memop, 0, 0);
>
> -    tcg_gen_qemu_ld_i32(t1, addr, idx, memop & ~MO_SIGN);
> -    gen(t2, t1, val);
> +    tcg_gen_qemu_ld_i32(t1, addr, idx, memop);
> +    tcg_gen_ext_i32(t2, val, memop);
> +    gen(t2, t1, t2);
>      tcg_gen_qemu_st_i32(t2, addr, idx, memop);
>
>      tcg_gen_ext_i32(ret, (new_val ? t2 : t1), memop);
> @@ -3232,8 +3233,9 @@ static void do_nonatomic_op_i64(TCGv_i64 ret, TCGv addr, TCGv_i64 val,
>
>      memop = tcg_canonicalize_memop(memop, 1, 0);
>
> -    tcg_gen_qemu_ld_i64(t1, addr, idx, memop & ~MO_SIGN);
> -    gen(t2, t1, val);
> +    tcg_gen_qemu_ld_i64(t1, addr, idx, memop);
> +    tcg_gen_ext_i64(t2, val, memop);
> +    gen(t2, t1, t2);
>      tcg_gen_qemu_st_i64(t2, addr, idx, memop);
>
>      tcg_gen_ext_i64(ret, (new_val ? t2 : t1), memop);
> --
> 2.25.1
>
>


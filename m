Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D48C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:50:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFEFB2065D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0D9AmZv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFEFB2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqnA-0000dn-Ro
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jsqQN-0006Zy-Hz; Tue, 07 Jul 2020 12:26:27 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:39106)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jsqQL-000222-NF; Tue, 07 Jul 2020 12:26:27 -0400
Received: by mail-ej1-x641.google.com with SMTP id w6so47230259ejq.6;
 Tue, 07 Jul 2020 09:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oG6J7k0Ps8DofToT31fQoyNV0/N3gLdXSTYbK3NaIF4=;
 b=b0D9AmZv0COoVe+9Wq6wznEnh8jEcTzWh56buCcmrus6Epbhm9wc3EmoxsATDSCzGa
 smItZGNXB80jSb5iYEmnfqBAv1ajsUIL6fBnQ/5IDaJZS55lVfPiEzVdrMgKv321oPOv
 R/tkt/cWa7gFwXcMcz6sbE8fDpbzMe1YnnFaOEra27hB5l+VFh6VYKmfYB52YupLJR5S
 zUnW439xjWaMgJy++g1d+ulayiz+hGIJ6Nu3sDPzAcVtZDkYw8xt/sWRDz9H2TCr3zGB
 9FFKRXPkbjcTaTFnYfLBO3wkzNEIP2EA5Ig7EPB4kMdGiQgIyWEzC6BWW61bX+Q6VSBn
 UxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oG6J7k0Ps8DofToT31fQoyNV0/N3gLdXSTYbK3NaIF4=;
 b=WzK0kKOD8gfeF7BilFeOPqLXWQeMnTT5F/YIAQgTgLsjVtAgnZlKBToCGd7plgKJYR
 4P5u4BQVmR+dCOBxXrtSao6B5Xl+yho2xYM5vMANtvgX+eZIvakQwHcA+8Ki73gkRBj+
 ky/urfQnBhOc3WbO60in02H7LRMHjexjudPPeJAxdesKBvGA9M7JqadBKKEOm6+hUPHS
 pjf6lUxC0lLCggvmdjMa2RSaTlTtjj9j/3BMA1Yr0RRPtPy5TRa6ntfxG43weNiMGUaf
 KA7JGJtsxhs3A4rYbeW8GIoSG75gnipvL2waGdMd4aLf9UaegFOROQzO5RRNwhmO/GSF
 p6fA==
X-Gm-Message-State: AOAM530N9ZIbC/0lYAL1SdiQdXKSmC/uiYOlIGrrL2Xnmd2ZKWq0LHLo
 u+wQeigP5xhEaNphMImPPn3btKFCZ/VQXS1osdQ=
X-Google-Smtp-Source: ABdhPJxTfXLY3rmzm3JrfNlS0XcLfJSnQUmAxKZyxZSbI9nDN2tje8dmgTzdyBrY2IrH8U9AP/VLc//FHtHjiZxCq6w=
X-Received: by 2002:a17:906:194b:: with SMTP id
 b11mr42073054eje.28.1594139183403; 
 Tue, 07 Jul 2020 09:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200703161515.25966-1-Alexander.Richardson@cl.cam.ac.uk>
In-Reply-To: <20200703161515.25966-1-Alexander.Richardson@cl.cam.ac.uk>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 7 Jul 2020 18:26:12 +0200
Message-ID: <CAL1e-=huJ8hLCb7gG=cZ6bXcqMOUSA17NHpnCEED18MR4mKXhw@mail.gmail.com>
Subject: Re: [PATCH] Fix MIPS add.s after
 1ace099f2acb952eaaef0ba7725879949a7e4406
To: Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=aleksandar.m.mail@gmail.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 3, 2020 at 6:33 PM Alex Richardson
<Alexander.Richardson@cl.cam.ac.uk> wrote:
>
> After merging latest QEMU upstream into our CHERI fork, I noticed that
> some of the FPU tests in our MIPS baremetal testsuite
> (https://github.com/CTSRD-CHERI/cheritest) started failing. It turns out
> this commit accidentally changed add.s into a subtract.
>
> Signed-off-by: Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>
> ---

Applied to MIPS + TCG Continuous Benchmarking queue.

>  target/mips/fpu_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
> index 7a3a61cab3..56beda49d8 100644
> --- a/target/mips/fpu_helper.c
> +++ b/target/mips/fpu_helper.c
> @@ -1221,7 +1221,7 @@ uint32_t helper_float_add_s(CPUMIPSState *env,
>  {
>      uint32_t wt2;
>
> -    wt2 = float32_sub(fst0, fst1, &env->active_fpu.fp_status);
> +    wt2 = float32_add(fst0, fst1, &env->active_fpu.fp_status);
>      update_fcr31(env, GETPC());
>      return wt2;
>  }
> --
> 2.27.0
>
>


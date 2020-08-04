Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67A3C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 00:22:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D12520722
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 00:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q4WwY3WA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D12520722
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2kiu-0000jo-Oj
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 20:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pcc@google.com>) id 1k2khx-00009G-2t
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 20:21:33 -0400
Received: from mail-vk1-xa43.google.com ([2607:f8b0:4864:20::a43]:35564)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pcc@google.com>) id 1k2kht-0005ui-2X
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 20:21:32 -0400
Received: by mail-vk1-xa43.google.com with SMTP id i20so310533vkk.2
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 17:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=kGPCxaRkq75wl/3koH786wgCsWo4Ch0XQ6yueKJ/Uuc=;
 b=Q4WwY3WA/mwt/U6iOCh0fTwPt36VN59hm1INGUdt0VPw98QI7L5U0pmUgWOxBJEvM3
 Ic0vc+dq8g+gzgie86f2Zn/32ADPj6FrFqYNCq4i/eP90C0Op27kK81Jr+KbBjDAiiXg
 ufoxlPK8HLpuKyNTh6lkFelB2uQGW9tKb3BTNR6Y+42ySEcN3Df1CEar/Wsq0NP/sI2n
 yz15uhFROpf08lL98SWvHVbxK7IMZtN+w8gkLmJOBi8HZnZkRGSUI3GExPz7yzFvYG5Y
 EzXT282/BwjPAITvf/FcM9kDGP286erjxPRLs4iZZTTW8qra+MsGkFipC4d1ycgACpEd
 RCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=kGPCxaRkq75wl/3koH786wgCsWo4Ch0XQ6yueKJ/Uuc=;
 b=ZQt/kTtfgvuBbOIK6Ut7jDwWo71qeLp/AXss64g0qaRj72lVfCIDE3WJp3EsulyAjn
 +CRX2DuwOhnr66Po3Q3yfTr2hXs/Tzm6JmaifUNKfYaWvRE8TS/EF9JLQV2wO146FhCs
 kl6rgTEP1p3NeOqRn69Qm+PInS5E6kwiV00xcjU2cNEqvGz08FnKF+6sCFRwmvt/tW/f
 qbYC02HGm1J9mdrNiY454wRw967c2ygidbMsGelPcIUA5hUU8sIMeaeucurYVMLU/HUg
 ll/PMfgHBRDxZVpougifThbvW6v4EL6O8NDT+0QNkxlVoZxMo2QTCfL5xX1zhVoRqXUK
 YOxw==
X-Gm-Message-State: AOAM530u7iyNCgoFc8GO1g5HOoxl/DLYmQRVCkjnYccMYGflGJm8s1FL
 o5zk4RfgaPOpav8Drxb9dyVd/z4UM5vAOpqbBKqyCg==
X-Google-Smtp-Source: ABdhPJyhYaOKCK5oH3kvSnX1pheVXrf89WjVPJEXumArEk09KhlmZc3F3axdm3HLENFUPRIJw3HCdRGV3rZU88NFt7s=
X-Received: by 2002:ac5:ccdb:: with SMTP id j27mr13053309vkn.43.1596500485985; 
 Mon, 03 Aug 2020 17:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200803222656.63936-1-pcc@google.com>
In-Reply-To: <20200803222656.63936-1-pcc@google.com>
From: Peter Collingbourne <pcc@google.com>
Date: Mon, 3 Aug 2020 17:21:15 -0700
Message-ID: <CAMn1gO75w=oaCp2TjhFzr2nrbKhHOP6Q20bnvuuAzgSVe+thMg@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Fix decode of {LD,ST}RA[AB] instructions
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a43;
 envelope-from=pcc@google.com; helo=mail-vk1-xa43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 3, 2020 at 3:27 PM Peter Collingbourne <pcc@google.com> wrote:
>
> These instructions use zero as the discriminator, not SP.

Oh, there is no such thing as STRAA/STRAB. I must have been confused
by the name of the function, disas_ldst_pac. I will send a v2 with a
fixed commit message, and another patch to rename the function to
disas_ld_pac.

Peter

>
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> ---
>  target/arm/translate-a64.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 8c0764957c..c996ca1393 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -3429,9 +3429,11 @@ static void disas_ldst_pac(DisasContext *s, uint32_t insn,
>
>      if (s->pauth_active) {
>          if (use_key_a) {
> -            gen_helper_autda(dirty_addr, cpu_env, dirty_addr, cpu_X[31]);
> +            gen_helper_autda(dirty_addr, cpu_env, dirty_addr,
> +                             new_tmp_a64_zero(s));
>          } else {
> -            gen_helper_autdb(dirty_addr, cpu_env, dirty_addr, cpu_X[31]);
> +            gen_helper_autdb(dirty_addr, cpu_env, dirty_addr,
> +                             new_tmp_a64_zero(s));
>          }
>      }
>
> --
> 2.28.0.163.g6104cc2f0b6-goog
>


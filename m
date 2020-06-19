Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F14C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 14:04:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CCB620DD4
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 14:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C7cQKhuO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCB620DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmHdB-0002hJ-U4
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 10:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmHby-0001vD-SS
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 10:03:18 -0400
Received: from mail-oo1-xc42.google.com ([2607:f8b0:4864:20::c42]:37595)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmHbx-0002oL-7S
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 10:03:18 -0400
Received: by mail-oo1-xc42.google.com with SMTP id q188so1913374ooq.4
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 07:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=f0sUEAo6S55R978ViORos1V95RvPg7zCaOE1NxZtGo8=;
 b=C7cQKhuOlm8Mghe9ME8BkY8DgO1wlC9ZCu5y463RM+V2zpT1oh5kc9GCflV2+r2jP5
 U5XNFDJIU/yhrpF4CII05ysH6Kz+5QzgT4dsxibcxEVTI4kgNp0r9pb9qwC+VUdzTUEs
 tafn948AlVKknb3DCOJhN3bKCMLHjU0ew/NmRqRzBd/2qNUV3tH8sKFYIZEVBvj3RBPT
 wWgRx7WZEIL+yhpodoSt35Rt8emA60yeJ2Kcm4tkj/bO0GC5AfUNLf2cv8KcH9B4UhZr
 H3gXQN32cEvlBbt7nHR3a/zSol2kN7eMRT9sscd/iwrnNp7ygmcopqe131Y+2ta9YRl2
 bz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=f0sUEAo6S55R978ViORos1V95RvPg7zCaOE1NxZtGo8=;
 b=F7JLJh2Pl9+sKHh0BaSXQ2B7/zFsROtDoN8MXmtomu7XrwoWMOrF+4rR2Emio57MBF
 jPzOgOwxoWpkmckSWGiIyoqfrY/zrxVBJy4fNArtU1tlLfzxDM8xX/VB5XxDKlEOQ3KV
 +tEZ+1D1kqFbzuN6G2eDht8/ShlccX0aSk8fIyUuv0fIM61xeHb+5p3gvBSjS3+xOEf3
 CYc/DYSFu7MdeiZA/nldDVbHdBkR+h3+HBTa44nfS/hJj/iCsWFtHJhGTmo8s9/eC0bK
 LxpCeSw/ZOvj+XwtN8QS7yonsEx/crssVvu0C3L4611qkzeJyy8NE4byespZyHkfSP3v
 OviA==
X-Gm-Message-State: AOAM530U6Zk1MCWv1vLUQLmB71bWn5/mr8XQOmHbdHSaXr211qPm/Ck7
 gR5kaUP9LOBTtnOdaz0goOXkmCNNi/JcImFLuIO9xDyKswk=
X-Google-Smtp-Source: ABdhPJx+QvHRLh2vdVkI8vGCWGmyFOdR+crR8OaAJUCgtVJrQdothuTE8WxKGO0JVtyduMvtsmYKDDF8y0XlqeJ8DUg=
X-Received: by 2002:a4a:9528:: with SMTP id m37mr3374456ooi.85.1592575395800; 
 Fri, 19 Jun 2020 07:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200603011317.473934-1-richard.henderson@linaro.org>
 <20200603011317.473934-31-richard.henderson@linaro.org>
In-Reply-To: <20200603011317.473934-31-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2020 15:03:04 +0100
Message-ID: <CAFEAcA8SgB6j3F6-HEZot_u13WAgu__W77vJq6FakGMGWzGLEw@mail.gmail.com>
Subject: Re: [PATCH v7 30/42] target/arm: Use mte_check1 for sve LD1R
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c42;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jun 2020 at 02:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-sve.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index e515646db2..4b3b879815 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -4830,16 +4830,16 @@ static bool trans_LD1RQ_zpri(DisasContext *s, arg_rpri_load *a)
>  /* Load and broadcast element.  */
>  static bool trans_LD1R_zpri(DisasContext *s, arg_rpri_load *a)
>  {
> -    if (!sve_access_check(s)) {
> -        return true;
> -    }
> -
>      unsigned vsz = vec_full_reg_size(s);
>      unsigned psz = pred_full_reg_size(s);
>      unsigned esz = dtype_esz[a->dtype];
>      unsigned msz = dtype_msz(a->dtype);
>      TCGLabel *over = gen_new_label();
> -    TCGv_i64 temp;
> +    TCGv_i64 temp, clean_addr;
> +
> +    if (!sve_access_check(s)) {
> +        return true;
> +    }

This cleanup should really be its own patch.

We should probably not call gen_new_label() until after
the sve_access_check() ?

>
>      /* If the guarding predicate has no bits set, no load occurs.  */
>      if (psz <= 8) {
> @@ -4862,7 +4862,9 @@ static bool trans_LD1R_zpri(DisasContext *s, arg_rpri_load *a)
>      /* Load the data.  */
>      temp = tcg_temp_new_i64();
>      tcg_gen_addi_i64(temp, cpu_reg_sp(s, a->rn), a->imm << msz);
> -    tcg_gen_qemu_ld_i64(temp, temp, get_mem_index(s),
> +    clean_addr = gen_mte_check1(s, temp, false, true, msz);
> +
> +    tcg_gen_qemu_ld_i64(temp, clean_addr, get_mem_index(s),
>                          s->be_data | dtype_mop[a->dtype]);
>
>      /* Broadcast to *all* elements.  */
> --

This patch of the change looks good.

thanks
-- PMM


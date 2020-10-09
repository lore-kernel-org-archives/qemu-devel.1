Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE961C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 18:49:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09E3D22284
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 18:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yd7ff15n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E3D22284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQxS8-0002Ro-VY
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 14:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQxQU-0001pP-9W
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 14:47:34 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:33823)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQxQQ-0005Pe-SN
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 14:47:33 -0400
Received: by mail-ed1-x542.google.com with SMTP id x1so10423075eds.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 11:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=b5rbtordpKE2zr2krOgen1nzVjrL0DFjDKxYoYC+96g=;
 b=Yd7ff15nSUpatZCasGoG8iEQNDKfn1FxBfbFo0673OJrx4Pk7WVpZ/aKmzSGv+jzbh
 uSRgkxd0y5Um3l+8X+H9VPwgr2ewdkzSmQsOa46BMqQJB0liRCAfQXAow19pfmRZTs2P
 v0GrNzvI7a5OHi/17DyCLM2alA36ZRAINdIdMsGBdZY7y1Z8a6IIAmAlbusM6dIG3rUW
 zRDXZVriYkcgE0cRLJO8wEjTmd2Ffatlze4M3PiYx3PjnEOyssr3VfTtiNeamo2VPmue
 Wa1mjuabM56asdIu31W69y9f6gYiGmnfZSjX2qq9mjqOcLwdPHj1sz3eHNUWfnq1cHB8
 5U3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b5rbtordpKE2zr2krOgen1nzVjrL0DFjDKxYoYC+96g=;
 b=b7uCJ8Roc3fzWHSOZ/rhm2iqK/UG72HIlqzMq7LXhhNQlgjcBtl2pGQ6jJhNpCvnkW
 Dhv2OwMoqplxO1oJ9J99h7VAoB5JUasAL0fZ9XAo+MNPiJck2EPD3i1HS6FOBbx4vdQI
 qwHCEJ6fyrwO+pXq//yeOWEz9GKPpMofdgNktGIqwGbIPa6Wr1MOlErU/eKCu9DIYFma
 llxQ2rZL6aNviJUqUk7ifHPfo9RNYJ3To/aimsFDqo3AzzAB9vXxFhcN2fPPJQHQdtAO
 lCAltUnGHaaVEeR8omtGFk2rmfx633tW95q2zRTfnK4Rrxh5CCm+cxfo1358bJvTkK8d
 xlsA==
X-Gm-Message-State: AOAM5327BOhu0kIogKv3IyOyazLWSrLsIiObb10QROTwuynZyYCPDUlP
 EUBhW/YuRqG7Y+u/mEvPTtYSW7/cpNghGew41wWB+A==
X-Google-Smtp-Source: ABdhPJwIQ+1Zfi57roIDy7ys9T5E5VoVNL3sUozfrA7iq1T5btSyM47XO0K/G3edwFSRe/cSgsz5rKYRPcq/2msGFgY=
X-Received: by 2002:a50:e68a:: with SMTP id z10mr655256edm.100.1602269248993; 
 Fri, 09 Oct 2020 11:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201009144712.11187-1-peter.maydell@linaro.org>
 <9b6bcfac-922d-675c-d7b4-35491a3efe60@linaro.org>
In-Reply-To: <9b6bcfac-922d-675c-d7b4-35491a3efe60@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Oct 2020 19:47:17 +0100
Message-ID: <CAFEAcA_TZQOFtQn=MhvaF7wvXCgQLHfhpekHb29kb-p8VgWfYA@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Fix SMLAD incorrect setting of Q bit
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 9 Oct 2020 at 18:57, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/9/20 9:47 AM, Peter Maydell wrote:
> > +        /*
> > +         * t1 is the low half of the result which goes into Rd.
> > +         * We have overflow and must set Q if the high half (t2)
> > +         * is different from the sign-extension of t1.
> > +         */
> > +        t3 = tcg_temp_new_i32();
> > +        tcg_gen_sari_i32(t3, t1, 31);
> > +        qf = load_cpu_field(QF);
> > +        one = tcg_const_i32(1);
> > +        tcg_gen_movcond_i32(TCG_COND_NE, qf, t2, t3, one, qf);
> > +        store_cpu_field(qf, QF);
>
> This works, however, QF is not restricted to {0,1}.

I'm not sure if you mean "this code doesn't maintain that
invariant" or "there is no such invariant". If the former,
the declaration of the field in cpu.h disagrees:
    uint32_t QF; /* 0 or 1 */

If the latter, I think the code does preserve the invariant.
Either we set QF to 'one', or we write back the value it had
to start with (which must have been {0,1}, but we don't really
care, because we don't want to touch it.)

> Perhaps this is simpler?
>
>         qf = load_cpu_field(QF);
>         /* t1 is the low half; extract the sign bit */
>         tcg_gen_shri_i32(t3, t1, 31);
>         /* t2 is the high half; must be 0 or -1,
>            and the extension of the sign bit.  adding them
>            must equal 0 (0 + 0 = 0; -1 + 1 = 0). */
>         tcg_gen_add_i32(t3, t3, t2);
>         /* Any non-zero result sets QF */
>         tcg_gen_or_i32(qf, qf, t3);
>         store_cpu_field(qf, QF);

This looks like it can write something to QF that isn't 0 or 1.

thanks
-- PMM


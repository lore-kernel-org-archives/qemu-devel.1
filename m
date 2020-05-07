Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AFEC38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:41:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B893320575
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGYFd8MO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B893320575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWhiD-0003wD-UR
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 10:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent.desnogues@gmail.com>)
 id 1jWhgD-0002eq-3V; Thu, 07 May 2020 10:39:17 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:40980)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent.desnogues@gmail.com>)
 id 1jWhgB-00012B-P4; Thu, 07 May 2020 10:39:16 -0400
Received: by mail-il1-x141.google.com with SMTP id f82so5495994ilh.8;
 Thu, 07 May 2020 07:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hCOO5I/BSp4UILMcui5em2mtGw/peN7kCZALbU8+zZU=;
 b=kGYFd8MODA1NRnNssYU9oFKKNdh/i2NJdD+Wjp9TYo0vs4baiBeLZRrbU0tqQbKVXG
 k9xAUs8rX0wQLr5fqGHCVkQfUracAQwip1CXCoTWn1xgieGvd9jROIFoI6t3uCCA3aFh
 3G72W8VvfGO12vSboqB/4CRQRICGj6KBEyHWeJVy6a4ly1b4m+K9dkiqqcZm9nMibHKl
 eNp95kq3V/RQAOdULaRvmMF40ZHMDlMWU3kfyjbRoJ0RL4H+7G5XmR7W9552irhaV477
 es/cbCb3Os1sdGIYxDRpYp5ZfJrKAH4k8QGg0lDAdKBhe3ohaj5PAeDteTKZWF/hF5l6
 H6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hCOO5I/BSp4UILMcui5em2mtGw/peN7kCZALbU8+zZU=;
 b=TC2Zpl+yKq6P2OQ/ErYVqPha7bxg+GBJMlSxNaWV20+ZnH8jiPv4QYWN4f5lv3a6Wo
 w2NN2Df5CQZOAtTJr/gi5vQbjyKgqMHNOLN0KSF2/pHg2ZDr2H/NuT/x9IFJD7OBGYWj
 FSvh51MgH89G3NQ9nZsO53RsBGLBxdzuw+rUVBH3WRkJdK8Y+uWQIWHePKdx5AfbMee7
 B3LhTYkj7J33HKBcwU8RWnGCjlGPYz0IOlNvHAJdcsg0hMtSrmLIn114X/B7Bt3DixyU
 TfZrmU65p9K7oWDcDE5EPLTG3yn+B/7wQSObJmjLdU12aCSoZytt95F4bW5Gz/CAQ5Up
 wIJA==
X-Gm-Message-State: AGi0Pub4jcoHm+QEhATdOE+wei8q+ATq3HM8vzxeD1N7y1uGcrBDfIBW
 3tBFhZKlq+nQAOx+nZJvMkLuFMU0xEE7Yp8fyg0=
X-Google-Smtp-Source: APiQypK/aEf6jyDD5LHBc8xRwSBi4zBxyl1FY0EHqV26HmXNBWpN/Y0Tb2a+m+o0rbPM/Vtzlxpq4Grrp2WDbOHP6BM=
X-Received: by 2002:a05:6e02:68b:: with SMTP id
 o11mr14351664ils.245.1588862353869; 
 Thu, 07 May 2020 07:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200506183002.3192-1-richard.henderson@linaro.org>
 <20200506183002.3192-5-richard.henderson@linaro.org>
In-Reply-To: <20200506183002.3192-5-richard.henderson@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Thu, 7 May 2020 16:39:02 +0200
Message-ID: <CABoDooPCvC4Y+G4CGBUhPT_ce3rY6_ZZvTnvv8M+sXPkpN4raQ@mail.gmail.com>
Subject: Re: [PULL 04/10] target/arm: Use tcg_gen_gvec_dup_imm
To: Richard Henderson <richard.henderson@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=laurent.desnogues@gmail.com; helo=mail-il1-x141.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On Wed, May 6, 2020 at 8:30 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> In a few cases, we're able to remove some manual replication.
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 10 +++++-----
>  target/arm/translate-sve.c | 12 +++++-------
>  target/arm/translate.c     |  9 ++++++---
>  3 files changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index a896f9c4b8..62e5729904 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
[...]
> @@ -2044,7 +2044,7 @@ static bool trans_DUP_x(DisasContext *s, arg_DUP_x =
*a)
>              unsigned nofs =3D vec_reg_offset(s, a->rn, index, esz);
>              tcg_gen_gvec_dup_mem(esz, dofs, nofs, vsz, vsz);
>          } else {
> -            tcg_gen_gvec_dup64i(dofs, vsz, vsz, 0);
> +            tcg_gen_gvec_dup_imm(esz, dofs, vsz, vsz, 0);

For an indexed DUP, size can be 128-bit so that will fail the first
assert in tcg-op-gvec.c:do_dup.

Thanks,

Laurent


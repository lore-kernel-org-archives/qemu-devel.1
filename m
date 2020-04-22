Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C15C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:20:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 995E620776
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A35fbFmG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995E620776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRI72-000206-O4
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 12:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRI5T-0000CW-Rm
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:19:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRI5S-00057o-TC
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:18:59 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43726)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRI5S-0004qV-Ej
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:18:58 -0400
Received: by mail-wr1-x444.google.com with SMTP id i10so3110377wrv.10
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 09:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=hpgsEjy9MMe1+3vn6+bFysJu3O8VbUl3PxUk99MjPis=;
 b=A35fbFmGdEec21EWyCrihDNfQVrCB4bW5dbm/HFw1nCe0xB9ZUNwAB8uTj33z2DPbD
 bAElOSK1X/oiluKFTgFp65KvtSiputIxHdN/iwocs2hYTmaC2aRC8/OFAzlqCJxUE7jI
 qDWnmtDpy6JKBDnNEaX+IOeQnje7gaEJR28SUgn1J4lPm75+/Fa68K5UxBDDC4Y8V/Lb
 VNX7+U4V1brbEdsJTeApvQhTYEIOznEsa1YrJ/qTiTY0BODoVSS3o7yhIQ/e1NwLweBY
 rQaZ+PfoyvQSpQ/UkP72PkIxnQfQdPcQQ/bqRr2K+hY95ULUK2cScqojH5mMJoONA2sZ
 HE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=hpgsEjy9MMe1+3vn6+bFysJu3O8VbUl3PxUk99MjPis=;
 b=jLwKMKxfd3YhuPEJelEyIHr4geuMY1app9+fzTo9gKCLDF1dSUuG9bcYLjv8LDELQB
 V0o9Y5P95aPvCY9+IYiKPDxEdAIs6+9IQATqeJ7VK6qzVLRDtobLe7+HIvfOwI6O/Sod
 jJRsj/eN1T9IPM+/SvU8ocK7Oe5zkEt9gafzvxTRr9ev/n+hAaYC7d1CDB/HmS08f9o4
 XDZq6q8jHkytZIi68EgChESlv7e0cIMuqcJfUXAbypinzd0x3VhkTfk/WfaY++CTUJHt
 ozi0x7dfH2MYHg7YiGrvh6UvVRrON5k+MTH88xOWWk3WpuM9HDtX7o1S1N9y+st9ql7x
 T67w==
X-Gm-Message-State: AGi0Pua8tie4Rm0SePPkvQIWJtN+zX6Vs6EhnZgWbustrHtfN+v11P9F
 c7ZJ019Cr1TEw4+ZtW6L+sKIQI5binY=
X-Google-Smtp-Source: APiQypIfEtIae3DrcGRWcpuPA1o5XJdPJacC3GE7HwqV2C00aNR6Y1jai+vy7q13KBxJky45k9ZcFQ==
X-Received: by 2002:a5d:4246:: with SMTP id s6mr30804148wrr.421.1587572336743; 
 Wed, 22 Apr 2020 09:18:56 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j4sm8919469wrm.85.2020.04.22.09.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 09:18:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C64661FF7E;
 Wed, 22 Apr 2020 17:18:54 +0100 (BST)
References: <20200422011722.13287-1-richard.henderson@linaro.org>
 <20200422011722.13287-14-richard.henderson@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 13/36] tcg: Use tcg_constant_{i32,i64} with tcg int
 expanders
In-reply-to: <20200422011722.13287-14-richard.henderson@linaro.org>
Date: Wed, 22 Apr 2020 17:18:54 +0100
Message-ID: <87k127cx3l.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::444
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/tcg/tcg-op.h |  13 +--
>  tcg/tcg-op.c         | 216 ++++++++++++++++++++-----------------------
>  2 files changed, 100 insertions(+), 129 deletions(-)
>
> diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
> index 230db6e022..11ed9192f7 100644
> --- a/include/tcg/tcg-op.h
> +++ b/include/tcg/tcg-op.h
<snip>
> @@ -1468,12 +1441,17 @@ void tcg_gen_brcond_i64(TCGCond cond, TCGv_i64 ar=
g1, TCGv_i64 arg2, TCGLabel *l)
>=20=20
>  void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TCGL=
abel *l)
>  {
> -    if (cond =3D=3D TCG_COND_ALWAYS) {
> +    if (TCG_TARGET_REG_BITS =3D=3D 64) {
> +        tcg_gen_brcond_i64(cond, arg1, tcg_constant_i64(arg2), l);
> +    } else if (cond =3D=3D TCG_COND_ALWAYS) {
>          tcg_gen_br(l);
>      } else if (cond !=3D TCG_COND_NEVER) {
> -        TCGv_i64 t0 =3D tcg_const_i64(arg2);
> -        tcg_gen_brcond_i64(cond, arg1, t0, l);
> -        tcg_temp_free_i64(t0);
> +        l->refs++;

Hmm is this a separate fix?

> +        tcg_gen_op6ii_i32(INDEX_op_brcond2_i32,
> +                          TCGV_LOW(arg1), TCGV_HIGH(arg1),
> +                          tcg_constant_i32(arg2),
> +                          tcg_constant_i32(arg2 >> 32),
> +                          cond, label_arg(l));
>      }
>  }
<snip>

otherwise lgtm:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e


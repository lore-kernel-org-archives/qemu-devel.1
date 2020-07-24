Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBB6C433E5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:42:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6DE8206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xvPwuy0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6DE8206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyxxp-0002CI-0K
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 09:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jyxx8-0001kH-7y
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 09:41:34 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:42024)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jyxx6-0003Lu-Ir
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 09:41:33 -0400
Received: by mail-lf1-x142.google.com with SMTP id h8so5203062lfp.9
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 06:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HH6G6dOtVKeIYpkOavEDpRvq2hDyF2yR6eZey8aaUKM=;
 b=xvPwuy0Cx66lrCrUlf9W7STH2rCyeRCM4JZGahRkmIW3Wk4WJPmGl6PvNkV2shWmsX
 cUa0vv1zOVvdUCS31Te/VaxicLWlk0m+EV/q6nZQLLtz3zAwaAZgCFIOtN7KGgMzpgOe
 pqkCWm92m9XYJc+l6HozzwM6ZYXwZOdgptP27Uzek7V9/MsNCkyQa7Kk4/gl5sLkrH2w
 w+0FvHfuJRgff0lzdRV4lPDgyXJHK6FxKgiZPE2ffv3dysMR34r0ShFIccNuiIBzt6BK
 bpmsVibpKYY8xZIvpYTVPbgFoqa5jfFJ7cdl8YZubPxUD303wZ242N8ZHhgmHelErWLq
 97Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HH6G6dOtVKeIYpkOavEDpRvq2hDyF2yR6eZey8aaUKM=;
 b=g1W6T4ASfaV1tomH/aDneuO4SeRgLk5R9l/KnbDPO0OC2pSR/xw7oBO3pn3XLr47b+
 JFUR0PEQc+eUcKObpZ6G56dm4aYz2uu+xmxLteooI8hj8bKVwOG3NdJ/pqevylvpug3Q
 AMvj66JARPjlkKdmyWwjAAvitL4PgheNJbPk4YdeON41QE04T06XV8abxtnkiU2uxZLu
 CPmBxXZdmqyJa8ZV51alpdCZkNsltGluULGf9sQvZ4qGl+Tm9nq7G2oS1JBis/6X1COe
 lbk9OLP3s3hohSbEKsEsfdouxIzEJwfUoYJCEJEZNxl9QdukPKVH880aWYDKpdDWXyqI
 OjnA==
X-Gm-Message-State: AOAM531pQssywKUpU3fXFGZg+aA2z3wgCIkgG23CeWy4h9i95WqBA7f/
 kYRbiQ721V2fXwNKrsjL/1KvJonuhpjOW0zj4XTuYg==
X-Google-Smtp-Source: ABdhPJyuOQ0SUgTOqpKfv2uRbAflRRv7avwNGX3omQZtcpRUSBEGc7CfkuLFcAvpaPsYQCQf5MWTvWl3gO73rSsVmG0=
X-Received: by 2002:ac2:488c:: with SMTP id x12mr4832245lfc.4.1595598088603;
 Fri, 24 Jul 2020 06:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200724064509.331-1-alex.bennee@linaro.org>
 <20200724064509.331-7-alex.bennee@linaro.org>
In-Reply-To: <20200724064509.331-7-alex.bennee@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Fri, 24 Jul 2020 09:41:45 -0400
Message-ID: <CAEyhzFuTMPrbDYwhdLVJ4W-at8VjsbqOUnsCavUXq1rREJxjyA@mail.gmail.com>
Subject: Re: [PATCH v3 06/16] accel/tcg: better handle memory constrained
 systems
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=robert.foley@linaro.org; helo=mail-lf1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>, f4bug@amsat.org,
 "Emilio G. Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Robert Foley <robert.foley@linaro.org>


On Fri, 24 Jul 2020 at 02:49, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> It turns out there are some 64 bit systems that have relatively low
> amounts of physical memory available to them (typically CI system).
> Even with swapping available a 1GB translation buffer that fills up
> can put the machine under increased memory pressure. Detect these low
> memory situations and reduce tb_size appropriately.
>
> Fixes: 600e17b2615 ("accel/tcg: increase default code gen buffer size for=
 64 bit")
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Cc: Christian Ehrhardt <christian.ehrhardt@canonical.com>
>
> ---
> v3
>   - use slightly tweak the logic to taper off more nicely
> ---
>  accel/tcg/translate-all.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 2afa46bd2b1..2d83013633b 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -976,7 +976,12 @@ static inline size_t size_code_gen_buffer(size_t tb_=
size)
>  {
>      /* Size the buffer.  */
>      if (tb_size =3D=3D 0) {
> -        tb_size =3D DEFAULT_CODE_GEN_BUFFER_SIZE;
> +        size_t phys_mem =3D qemu_get_host_physmem();
> +        if (phys_mem =3D=3D 0) {
> +            tb_size =3D DEFAULT_CODE_GEN_BUFFER_SIZE;
> +        } else {
> +            tb_size =3D MIN(DEFAULT_CODE_GEN_BUFFER_SIZE, phys_mem / 8);
> +        }
>      }
>      if (tb_size < MIN_CODE_GEN_BUFFER_SIZE) {
>          tb_size =3D MIN_CODE_GEN_BUFFER_SIZE;
> --
> 2.20.1
>
>


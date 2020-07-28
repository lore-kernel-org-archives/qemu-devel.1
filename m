Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381BEC433EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:46:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 086FA20663
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="afctk2Ld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086FA20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0PwX-0007Au-BA
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 09:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0Pui-0005gu-Ta
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 09:45:05 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:47020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0Pug-0003Nu-Sg
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 09:45:04 -0400
Received: by mail-ot1-x343.google.com with SMTP id v6so4120028ota.13
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 06:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=pM0Sl3/zWeA4rY/5X2IYJAkjqwG5CCy1ozH594oO7Kg=;
 b=afctk2LdSlwMS+eFr0NHAgxfWxg9+v8n/yolwvBd9y307k9iU+YTANcIv9G6gopPvB
 /cj4QOOjfdBNyReGz5RwOg/jf3lKnm/nQICpS9VNZB8ai0r2XioNjY5YC4PuVn5WEPlG
 wpB2o7Ah2vxjEljHj/5OIgpncvKZ0t3bmgdTiWYaueo+ZicLovIZnUoj8gts0L/Ulq6w
 mLFthp0WX/LeXxgt37+8DuA8A0VLilx9IVkLN8jG3NiOpKf+w4XYJyo+JydN0OhnMSRM
 aK5OVHrtyK/K02w0DgYlYWCeAJ1cknEkQG0kfDxztROKeASXw0odBYB48ghWN+jijjIz
 9sOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pM0Sl3/zWeA4rY/5X2IYJAkjqwG5CCy1ozH594oO7Kg=;
 b=iqnG/Wk9fR+RxiIq53J+MjXvO1D7g/hOxZtVgZGVNyS9nL0STStYa/9LfF/IcsTFW8
 HlDa4GXVXs+fKZQ6fRpRxpJSIpO63RPWOWJS+h3geUjtlAi5GA8XbfkEoS4vvpv729ly
 sBWWGDNIN6WfR4lwBmcMhOmjiLARGL4MLLN1MtalH7VJjxWek9W4w/4E9s5WtVd+YxvR
 jGI2deFcjn4VyAeHNezx75HYe8X1X8OX1yxVgbhbDIeQZaLotcB8kPFwzssbcuR8sHpS
 Xj8dWQHsXdyM77T22Ebbl8VEyDkC0sWcVyrImYcSQ93SMtEZy31SZ4Q6rbIs+xyTr1JB
 0G3Q==
X-Gm-Message-State: AOAM531bWXCq72pxU8VnRe92Z2Mdp3koVx9rzkU3jrQAna1+/pSP+GJl
 z72XVrQkRlIOZWTLaQn4OlW7v6VuMQ9f7mGelrCPQw==
X-Google-Smtp-Source: ABdhPJw5ht2MlFDi+wnfbTyw5NbzIPFO/C44zVOrWWVC6VUWPTfTUhXstMWia0Kshp7DYCRzNWKEbGsn2AsTe7sO6o0=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr24310938ota.91.1595943901306; 
 Tue, 28 Jul 2020 06:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200727122357.31263-1-alex.bennee@linaro.org>
 <20200727122357.31263-9-alex.bennee@linaro.org>
In-Reply-To: <20200727122357.31263-9-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2020 14:44:49 +0100
Message-ID: <CAFEAcA8oTrHUzOF5tcqVDNtPWdoG0Yz0GKb2=JuT3O5h5g-YQg@mail.gmail.com>
Subject: Re: [PULL 08/16] linux-user: don't use MAP_FIXED in
 pgd_find_hole_fallback
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Jul 2020 at 13:24, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Plain MAP_FIXED has the undesirable behaviour of splatting exiting
> maps so we don't actually achieve what we want when looking for gaps.
> We should be using MAP_FIXED_NOREPLACE. As this isn't always available
> we need to potentially check the returned address to see if the kernel
> gave us what we asked for.
>
> Fixes: ad592e37dfc ("linux-user: provide fallback pgd_find_hole for bare =
chroots")
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20200724064509.331-9-alex.bennee@linaro.org>

Hi; Coverity thinks this conditional expression is suspicious
(CID 1431059):

>              if (mmap_start !=3D MAP_FAILED) {
>                  munmap((void *) align_start, guest_size);
> -                return (uintptr_t) mmap_start + offset;
> +                if (MAP_FIXED_NOREPLACE || mmap_start =3D=3D (void *) al=
ign_start) {

because it's performing a logical OR operation where the left
operand is an integer constant that's neither 0 nor 1
(it's 1048576). What was this intended to be?

> +                    return (uintptr_t) mmap_start + offset;
> +                }
>              }

thanks
-- PMM


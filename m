Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F0DC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 12:20:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D06520740
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 12:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ykft8NQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D06520740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVaa1-00014Z-Jk
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 07:20:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iVaXc-0007v8-3H
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:17:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iVaXa-0002z0-Sw
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:17:31 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51019)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iVaXa-0002yR-82
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:17:30 -0500
Received: by mail-wm1-x342.google.com with SMTP id l17so9442389wmh.0
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 04:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=aB0UTNSlNIdFk8672z6gWnJR2gKZda/tkrYuL7bXYo4=;
 b=ykft8NQ+xEzcw6q8jRQ8Gg5ivCV4svfeoQZufBSPWgQbHSLuvWv3Ee37bV/s6l3bLH
 CsQFNeCTSx6vY9G84yYLw09V6LgDeFkvXJI6aeSnhOqu8AOrbNhbSnDcUHgmNoRrq+Hx
 cpPunKlbS8ViR2zhtEKKpcIyM93VBIpGuFOOpU7XmjFfDPX0PDNtImfl6KLI1yOsTsnV
 LLM4K/xLozg3s/2BgObad/CkGsmFTcL4wt1ot+Rq7MHB8IVlo2C1VIXhToedGUaKOPwi
 Kp4Zyzp+PBL0NGL3ZVNs7vjjXui9Xo2Gva2l/Tpv0J4QsyKERtM7N07YZ5zvv+4kF13x
 VJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=aB0UTNSlNIdFk8672z6gWnJR2gKZda/tkrYuL7bXYo4=;
 b=o3SXN1ouy3RFUJ88jy/3GJeDSa6d/ubeXzPNYb2emfs2yS79rXiHBKA2o0yH9uAaAS
 LhKYwMq/wTmgQiX/mzbxjo32XDxCBhtOLqwVQuOBYRUO68TkSiSDONMEvNfflKCnlyMb
 obMqSa4HaYvZmRiLCdgFslbRsa7IOmaPaCILpAfZzpSTXUGpvM9bIEs/yHJg8pcrV4wc
 X+/Y3aD0rao6hxka+LYTIl7Dkt1lJRZYprGPVhSfiRijdzHYdVUFfEvgLLyvKuT0/GCz
 qzCrUfGKHfo04GAMQP7UVeoM8bRHkSRvy1KHZtpcTopm/d1VkczsPi1ZtQGkCycZAI2g
 gFdg==
X-Gm-Message-State: APjAAAVuZ/vBgy8kz+V8raQGnlYQO7XJX+kDxD6o4gT0jjk8v3fHS3Ty
 AQF6p0GUNYYwjtb+nY0S1zYhZKgR384=
X-Google-Smtp-Source: APXvYqwSdaX8o0powwS+KP/aax2tg9QwQEG0dzoPm3Idq4thoQY+hbEWixS/Zgz3BMZSOgBQt2PooQ==
X-Received: by 2002:a1c:dc09:: with SMTP id t9mr13849868wmg.65.1573820247679; 
 Fri, 15 Nov 2019 04:17:27 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u7sm12579016wre.59.2019.11.15.04.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 04:17:26 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 904DD1FF87;
 Fri, 15 Nov 2019 12:17:25 +0000 (GMT)
References: <1573792691-398-1-git-send-email-tsimpson@quicinc.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Taylor Simpson <tsimpson@quicinc.com>
Subject: Re: [PATCH] Modify tests to work with clang
In-reply-to: <1573792691-398-1-git-send-email-tsimpson@quicinc.com>
Date: Fri, 15 Nov 2019 12:17:25 +0000
Message-ID: <8736ep72qy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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


Taylor Simpson <tsimpson@quicinc.com> writes:

> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>  tests/tcg/multiarch/float_helpers.c | 13 ++++++++++++-
>  tests/tcg/multiarch/linux-test.c    |  2 +-
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/tests/tcg/multiarch/float_helpers.c b/tests/tcg/multiarch/fl=
oat_helpers.c
> index 8ee7903..437247c 100644
> --- a/tests/tcg/multiarch/float_helpers.c
> +++ b/tests/tcg/multiarch/float_helpers.c
<snip>
> diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/linux=
-test.c
> index 673d7c8..edfc02c 100644
> --- a/tests/tcg/multiarch/linux-test.c
> +++ b/tests/tcg/multiarch/linux-test.c
> @@ -485,7 +485,7 @@ static void test_signal(void)
>      act.sa_flags =3D SA_SIGINFO;
>      chk_error(sigaction(SIGSEGV, &act, NULL));
>      if (setjmp(jmp_env) =3D=3D 0) {
> -        *(uint8_t *)0 =3D 0;
> +        *(volatile uint8_t *)0 =3D 0;

This looks suspicious - volatile is almost never the answer to a
question. What are we trying to achieve here?

>      }
>
>      act.sa_handler =3D SIG_DFL;


--
Alex Benn=C3=A9e


Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE14C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:33:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 405C920872
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 405C920872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDFqJ-0007mt-9x
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 18:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDFoP-0006AF-Aa
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:31:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDFoM-0004gE-OR
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:31:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47234)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDFoM-0004f8-Fr
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:31:02 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 965FD83F3C
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 22:31:01 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id t11so134415wro.10
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 15:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LecQZ+XYNv/1fWQumQ4pMwSpgG9RB0n7ZWKnvYUw9zE=;
 b=biFoL7ZZaARQNwh92INK/DfZGgfIIyKVYDf44RKu+3tU46/QRzrlcgH2yixioCzX1R
 c0fxetbDweVJoEUu966+8Gn6KIRGZlMYkp6OopDwwLiIoIc7OjEKXb9Bi08Og7hOYWcO
 NbZDjNLKLB39g3O2DYXwa/PpBMtAaGT+SCeI9zzVHGKxHz1AP3IDz3RIkxL/nffo8QiK
 YjcPvZu0FY8iSx0wcmevZ5qvhIMBtZ698YMvHxG5sq2O5R37829bpKcxkpMu+fHCl8b0
 6ic+r67gyng+4WEQMw5+llLBevaENE9AnzehaBgIVkC6WZBPHvpBg4yqHE32s/bIxSA0
 c7hw==
X-Gm-Message-State: APjAAAUbWrMBvnlNNhkal9BitDlNlEInSJggC/ovcektT+Sl5FSW5xUh
 rJKyRXj0VLNlWziUKVCL1xLPrOo7mGKFCWHM67+nrLnRmGOcKdZcKqBKZ6Ga/ZBRn+XoyVrRafq
 UNmUkXN+YfXrxetU=
X-Received: by 2002:a7b:c44e:: with SMTP id l14mr352784wmi.54.1569450660403;
 Wed, 25 Sep 2019 15:31:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz5bNaanUMXGRTc58vJxUvyZuqoGSE7E9wtzeLUNg0rsAwBeRDPvDFG4oPRWh3I6jsYiw5gww==
X-Received: by 2002:a7b:c44e:: with SMTP id l14mr352777wmi.54.1569450660246;
 Wed, 25 Sep 2019 15:31:00 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id n8sm897986wma.7.2019.09.25.15.30.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 15:30:59 -0700 (PDT)
Subject: Re: [PATCH v3 07/33] target/alpha: Tidy helper_fp_exc_raise_s
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190924210106.27117-1-alex.bennee@linaro.org>
 <20190924210106.27117-8-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e13cf9f2-f3ab-8f23-e909-e04cdb2bbba2@redhat.com>
Date: Thu, 26 Sep 2019 00:30:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190924210106.27117-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: jsnow@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 f4bug@amsat.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/19 11:00 PM, Alex Benn=C3=A9e wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
>=20
> Remove a redundant masking of ignore.  Once that's gone it is
> obvious that the system-mode inner test is redundant with the
> outer test.  Move the fpcr_exc_enable masking up and tidy.
>=20
> No functional change.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-Id: <20190921043256.4575-8-richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  target/alpha/fpu_helper.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>=20
> diff --git a/target/alpha/fpu_helper.c b/target/alpha/fpu_helper.c
> index 62a066d9020..df8b58963ba 100644
> --- a/target/alpha/fpu_helper.c
> +++ b/target/alpha/fpu_helper.c
> @@ -90,25 +90,18 @@ void helper_fp_exc_raise_s(CPUAlphaState *env, uint=
32_t ignore, uint32_t regno)
>      uint32_t exc =3D env->error_code & ~ignore;
>      if (exc) {
>          env->fpcr |=3D exc;
> -        exc &=3D ~ignore;
> -#ifdef CONFIG_USER_ONLY
> -        /*
> -         * In user mode, the kernel's software handler only
> -         * delivers a signal if the exception is enabled.
> -         */
> -        if (!(exc & env->fpcr_exc_enable)) {
> -            return;
> -        }
> -#else
> +        exc &=3D env->fpcr_exc_enable;
>          /*
>           * In system mode, the software handler gets invoked
>           * for any non-ignored exception.
> +         * In user mode, the kernel's software handler only
> +         * delivers a signal if the exception is enabled.
>           */
> +#ifdef CONFIG_USER_ONLY
>          if (!exc) {
>              return;
>          }
>  #endif
> -        exc &=3D env->fpcr_exc_enable;
>          fp_exc_raise1(env, GETPC(), exc, regno, EXC_M_SWC);
>      }
>  }
>=20


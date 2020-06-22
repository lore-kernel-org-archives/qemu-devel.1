Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1FEC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:53:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B916720732
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HZ0Me/Rg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B916720732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnNp6-0004vW-2V
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 10:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jnNny-00047P-Hw
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:52:14 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:35252)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jnNnw-0000un-Ib
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:52:14 -0400
Received: by mail-lf1-x141.google.com with SMTP id t74so9810436lff.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 07:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OkHCI3G+tmfKmryVrWRt0eFJjAT5vc4d0ymb+Mcrgj8=;
 b=HZ0Me/RgSjGjBKjD9AGyI3aCEEQArVtoLuwo7zvcEFZL+Uv/lfFu9HnUKiyuX+Q1+i
 qOprC7cSCblCQCC1m4WdkYlFFrM2DeinhhYLEKOdr08mTyRkWHpzVY2gpaI37sXX6Zi2
 N7xgcm9zUvKp5uN9VMJUkMwlRaUh9whXuw6UAuzs0e658DI5sDl4byWSPEZgZ6z9G+ep
 LAXgxi/Y1URo1W12jEZ/0Wimwfsyo3EkWLnNKjVnvXv+NqZ9ivwzQO1HC7Eo/eHuMPcX
 DzczowWSdQBJJkyLRg9I061guziqJpTkPgBkeyWS60FQOWIy2Zy6bz4v7R5aJl3y1+uH
 QFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OkHCI3G+tmfKmryVrWRt0eFJjAT5vc4d0ymb+Mcrgj8=;
 b=mtQkDFAs9x2JBRKDotxNTuj0pYFOZ30eJz1sSRnJAO7ZO9b6SYFctkipYs086ZitQB
 uOi8KGU/0wjUANzyDYGNhd9iQDM3SzXqaGemy1L7+vxXrquERZfSzQwiAY+ccPwbNBrb
 44PZQzttD6ur4S2POG4eOy3FbbJpb6xwQo7lvsXbB4yDUzJdlMh45Nfu8NrS3jNKa/ob
 sJJKCRNaE8w9y3Mpj6BtrafOcP+Dg4ucY+x+JasMI4jSekojVscdMwacEJaB3vAa1p41
 mhYAX4p1WwAYclMwNmGlSt3D+EZqY8dcB/hB1ncldaZW9ohrMLMV8iq+/OC9J7P+uE0h
 QAmQ==
X-Gm-Message-State: AOAM531rhgpvL7T18Cka53AI3madsZuP3vaoK2rBBeu2jGCqX1yVnBgP
 O+F3wLDvEJcsFzP3aBW6RWWH4mjQnXAAAgVqQtYGqg==
X-Google-Smtp-Source: ABdhPJxZTqd1x6AJD3XUdEfqsOaXpLO8+OBzQVzya+3HPS4PhvFM9bcrwghCKS0/2MCDsLm35x7A5I4fOAbyWZjBGGk=
X-Received: by 2002:a19:bed7:: with SMTP id o206mr8483630lff.81.1592837527993; 
 Mon, 22 Jun 2020 07:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200622143204.12921-1-alex.bennee@linaro.org>
 <20200622143204.12921-13-alex.bennee@linaro.org>
In-Reply-To: <20200622143204.12921-13-alex.bennee@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Mon, 22 Jun 2020 10:52:12 -0400
Message-ID: <CAEyhzFtEbUfb_zPLrLE3coDXJ2gQbny_fAZ7O8iY9W-BkMk_7A@mail.gmail.com>
Subject: Re: [PATCH v1 12/18] tests/vm: allow us to take advantage of MTTCG
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=robert.foley@linaro.org; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, f4bug@amsat.org,
 "Emilio G. Cota" <cota@braap.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Robert Foley <robert.foley@linaro.org>

On Mon, 22 Jun 2020 at 10:38, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> We currently limit TCG guests to -smp 1 but now we have added some
> aarch64 guests we can do better when running on x86_64 hardware.
> Raise the limit for TCG guests when it is safe to do so.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/vm/basevm.py | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 93859362606..dd96a6d4af6 100644
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -553,6 +553,12 @@ def parse_args(vmcls):
>      def get_default_jobs():
>          if kvm_available(vmcls.arch):
>              return multiprocessing.cpu_count() // 2
> +        elif os.uname().machine =3D=3D "x86_64" and \
> +             vmcls.arch in ["aarch64", "x86_64", "i386"]:
> +            # MTTCG is available on these arches and we can allow more c=
ores.
> +            # But only up to a reasonable limit. User can always overrid=
e
> +            # these limits with --jobs.
> +            return min(multiprocessing.cpu_count() // 2, 8)
>          else:
>              return 1
>
> --
> 2.20.1
>
>


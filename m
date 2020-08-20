Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844EEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:11:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DFF3208A9
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xC4WGR7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DFF3208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8o66-0003dk-KS
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 13:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k8o5Q-0002n0-RG
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:10:48 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f]:35942)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k8o5P-0007xI-3h
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:10:48 -0400
Received: by mail-ej1-x62f.google.com with SMTP id kq25so3407467ejb.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 10:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2J7NlRo1UWCdOsxRzgIGG1Mp9IPn9u5pqb2f0ieyvEM=;
 b=xC4WGR7qiZKnj5fjRwlC1UDNQtS6rOYtWf57HP+JK2NRvdZ/rF2dQPqkNwH+i1Su28
 u16c468rAsI0tdBszI8oLYAmzGLhfsDEHJ6NRDMGv3rz+lrZwC31ykxzRFX4/wEE5VSf
 DzKtxnKV4/yJf95Kznegy8Qe/pr0fvXsHUTkbhCE2L8Q+Euxu6+5ZK+ZjAZBATLX6Mex
 EhndYhlbu5om8vz0VYvTXe9FXlrGtNLuFDu/Tp84ye2Ha0g3i/lOJk32zEVlbwQnWSKN
 Bfm2SikSQ+t/LeuFODdGZ36LWpqJpw4gcXD00xTmY8q1/HO5ay+t6f7hTvVO7NkVfABy
 zmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2J7NlRo1UWCdOsxRzgIGG1Mp9IPn9u5pqb2f0ieyvEM=;
 b=auFAv688stBw/vCbysmmhw64eqmTqSsyswTIIOCclrJX51eN12AKnYw/orAsNKAh6v
 NfDpz2Gnk+/dWOcMUTJUsER8hK4llBsSEElS4ntGH0J2xu6PFrsw91WxyoVFFTEFbuTh
 LmyNiCt48xTLNVT2WZf/AA1iz51xGa4RoGfDivQcLLI+71fto3NU4HA2K6ZYJD05LRUA
 WSMP4r7ftY+0g0t3uqfslvN8TM2FUIAGeqhz/Nw+B8sGo3iEAp2klMyBGJ+/b3XA3CVS
 96E/6v/t+vRVM3PMNTxVgLySkgMYyDzJU14iPv2PYVvhInRbmCS/HcP3icKZlWUOs31Z
 L/pg==
X-Gm-Message-State: AOAM532+0sVZR9IgtOHd0BNr5KFhr5+P5MYoXm8lg7oRsnnYRdCifAue
 Aw0HX7dd3+K5sxRdX1PIxzT4oKrZTbEavjUR0hA45w==
X-Google-Smtp-Source: ABdhPJxXocaeh4PG2q2okmw3NmjHOA8MHVNvEU2GEFD78VGxN+qBxZMT/JWxxKidKTbNUBpkLDcl2A6JypueSRGDE0o=
X-Received: by 2002:a17:906:59b:: with SMTP id 27mr4154364ejn.56.1597943445406; 
 Thu, 20 Aug 2020 10:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200820165543.215372-1-berrange@redhat.com>
In-Reply-To: <20200820165543.215372-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Aug 2020 18:10:34 +0100
Message-ID: <CAFEAcA_a+0N8FXQ4CrBwJ9jt8LptaTO3d=LZ_S2B0H7h1Ev94g@mail.gmail.com>
Subject: Re: [PATCH] configure: add support for psuedo-"in source tree" builds
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62f.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Aug 2020 at 17:56, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> Meson requires the build dir to be separate from the source tree. Many
> people are used to just running "./configure && make" though and the
> meson conversion breaks that.
>
> This introduces some backcompat support to make it appear as if an
> "in source tree" build is being done, but with the the results in the
> "build/" directory. This allows "./configure && make" to work as it
> did historically, albeit with the output binaries staying under build/.

> +if test "$PWD" =3D=3D "$source_path"
> +then
> +    echo "Using './build' as the directory for build output"
> +    rm -rf build
> +    mkdir -p build

Can we put in a mollyguard here so we only blow away build/
if we previously auto-created it? Something like

      if ! -e build || -e build/created-by-configure; then
          rm -rf build
          mkdir -p build
          touch build/created-by-configure
      else
          echo "some helpful error message here"
      fi

(shell syntax probably wrong but you get the idea)

My current setup has multiple build-directories like
build/x86, build/clang, ... and I'd like a guard against
configure blowing them all away if I accidentally run it
from the source tree some day.

thanks
-- PMM


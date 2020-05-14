Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20E8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 10:42:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC72D2053B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 10:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wqUfxbMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC72D2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZBJV-0004KD-QE
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 06:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZBI4-0002ol-HF
 for qemu-devel@nongnu.org; Thu, 14 May 2020 06:40:36 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:40224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZBI3-0003z7-CM
 for qemu-devel@nongnu.org; Thu, 14 May 2020 06:40:36 -0400
Received: by mail-ot1-x334.google.com with SMTP id d26so1949149otc.7
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 03:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sNtx7kYPFLyLSIjcFgDZxU900Ae2zpbYEzzzAvIigx0=;
 b=wqUfxbMDcw5Fe2ORcMnNyaBLEImntOIyWTXml2O70HxVod/k5T1xzZgRFo/pxwqyNm
 xl1XeSqyPyvkkMHWetKFQyBhRTkf7dfzgWIYtr5H9h8cXIDvg05niOVDNEDmmACeKoFU
 HN6eVHTs5I4KSmMmI80i7RY08inuXV0HDqU6es8lY5ZuSlCxaLVpnI4IhrQYzinlK2XB
 Lt0xNWsjpzOvx/e1odULwmeUJmqgqtHyWG0jLj1uelue5oYwRBmcxmhKyJssjNGf9uKg
 kCkWm4Nv3EwV4LIaRdq5Req/Z+DmhGlpIU+3ZeOEH1qCAfILeWCE8t++DS7OgqHahUL6
 P2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sNtx7kYPFLyLSIjcFgDZxU900Ae2zpbYEzzzAvIigx0=;
 b=sPwst809kes++NpaK8VyWJvFkObgnPark1022Kz4eIO6xwXJR8Dp2QRhJ3XqnMpci6
 ebXWT6OArY/aBD/4JTkh7j/BEuymPwBUaWzpbN3gewnWYqQjxiEeJIheIH0gc5W58YX8
 NyEU/kA4f81j3iYuX5wXLjkFKpe4Y5GbBvVP5UI42DwWX48XDxgvMiKhDBqbtbTxoKCZ
 aO4Gs+k+JxwaBWTCNuMsrLfMrgWRByzctv08VEcIjfmVcKptB9yLLpTUAyzj1kCazDck
 mQ4un310Gsykfisyj7x9+t/2Wg/Yggbs9/voubxlAVSmT/QVM9irm/rS2Tp6GsH7o10w
 2D/A==
X-Gm-Message-State: AOAM5336/Lfgj+wzR/MuGLF7zJ9gJ4dTht3kBn2X1TcZQV/RQhoXs+zu
 Va/KPBilHQnhf6s5AlgKj6uiOts9/lhO/0uYthxImg==
X-Google-Smtp-Source: ABdhPJxtNkn7o0CdN3yxAfNx5Z+Sq7gydlWFNZ1gq0MerzrEqgv87ToqJvJKcNQaqczwNAOZs4JqIl/bXBg5AXeChiw=
X-Received: by 2002:a9d:398b:: with SMTP id y11mr3019836otb.135.1589452834197; 
 Thu, 14 May 2020 03:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200513215211.17341-1-jsnow@redhat.com>
In-Reply-To: <20200513215211.17341-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 May 2020 11:40:23 +0100
Message-ID: <CAFEAcA_8oE2qoDrRgTw72=u+4H1DEu0LJ+cnkVaBgjM7bkkcUQ@mail.gmail.com>
Subject: Re: [PATCH v2] configure: prefer sphinx-build to sphinx-build-3
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x334.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 13 May 2020 at 22:52, John Snow <jsnow@redhat.com> wrote:

> +# We require the python3 version of sphinx, but sphinx-build-3 is a
> +# distro package. prefer 'sphinx-build' to find the venv version, if
> +# any, but ensure it is a suitable version.
>  sphinx_build=
> -for binary in sphinx-build-3 sphinx-build
> +sphinx_ok=
> +for binary in sphinx-build sphinx-build-3
>  do
>      if has "$binary"
>      then
> -        sphinx_build=$(command -v "$binary")
> -        break
> +        sphinx_candidate=$(command -v "$binary")
> +        if test_sphinx_build "$sphinx_candidate"
> +        then
> +            sphinx_build=$sphinx_candidate
> +            sphinx_ok=yes
> +            break
> +        fi
>      fi
>  done

Here we look for a sphinx binary that works, and if
we find one then we set sphinx_build to that binary and
set sphinx_ok to 'yes'.

But then (in the part of configure between these two patch hunks)
if the user uses the command line --sphinx-build=foo option we
will reset sphinx_build but don't reset sphinx_ok...

>  # Check if tools are available to build documentation.
>  if test "$docs" != "no" ; then
> -  if has_sphinx_build; then
> -    sphinx_ok=yes
> -  else
> -    sphinx_ok=no
> +
> +  if [ "$sphinx_ok" != "yes" ]; then
> +    if test_sphinx_build "$sphinx_build"; then
> +      sphinx_ok=yes
> +    else
> +      sphinx_ok=no
> +    fi
>    fi

...which means we'll skip this check entirely and won't
test to see whether the user-specified sphinx-build binary works.

> +
>    if has makeinfo && has pod2man && test "$sphinx_ok" = "yes"; then
>      docs=yes
>    else

thanks
-- PMM


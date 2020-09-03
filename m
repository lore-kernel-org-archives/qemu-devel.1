Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0D9C2BC11
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:51:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15E98206A5
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QSboe6dA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E98206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDmqG-0006V5-42
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 06:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDmnJ-0002LE-0P
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:48:41 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f]:33790)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDmnH-0003EV-95
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:48:40 -0400
Received: by mail-ej1-x62f.google.com with SMTP id j11so3249895ejk.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 03:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vZ/bq5FtidHE/Zpa8DUsH9dhTW6NlM/aNQ+mR3sDe1Y=;
 b=QSboe6dAQIcRITVhFhbp6/1M8DZ5eotVtj6JOz5ZStPF3+QxRHeCP3JksqLjG9JBqa
 YGhNTnFUXaiAKMfKS9nx9xrt4vKpQp2hFsyOlxvndn/a6i4+tZBUPKGFoy6CMBSv8uFv
 pwlZoOSbmlRXAvgjDW9Y47xEngrKGU+AAzD5dtRFzPN1aIbrv98NUldFj/I3lfAfn4aN
 M5XuKCKgWXP6Hsyrbng6o7AVddc39l+rfx9zThw/MnBRHDhzqyEeFZh7kh3dCMNZe8jI
 Nb0kj62EOL1DW9NnYI7QNZzpDqd39ZOjen9okIkU/Vkfj+jsGIm/8Fsc8kve06r8WuZb
 b8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vZ/bq5FtidHE/Zpa8DUsH9dhTW6NlM/aNQ+mR3sDe1Y=;
 b=joZIf4VDwA73ObNY8PqdOPQsuBfMQEoel+itQtl7Vbv1V7BMSVFDhCGVEvTaAKZuN5
 yrjYV2qUHv3sjIhfVhF9n5mDTzRcE5S/rAIP9P306Cr3pkYgn9IkOsxm+u2ARkfpnA8A
 tJzxoQV5TO5HXmfDWPfcTGvMUdnG65TC8TSTxxMSw0xBJaZ8AB8XN+E9FuFE3XF5KxwT
 0Gfx8hKCNr2yF6x4ye4k7aYdbSlUolHqVeZyy2MScl7AmN99f3wQaKX3Cn89wJrz3c67
 R6YR7CahNUHQAPHntsFy+Fppz7OZC1qQCKcn31sRn5aHtc0D8O0ekLRdaoC+Z0nePJdn
 Glmw==
X-Gm-Message-State: AOAM530VN4jBk8ET5EomFo3digLZDRuDHJSg4SB2Zds6+JP1OR9sp24B
 mvJ+e0h4ZajyxcyeA/sQKA1vCkpW8L6OaS/l4bFmYg==
X-Google-Smtp-Source: ABdhPJyw7V7ImofCEbLrHDNazydjm71s7JbkgqijbK/2QoY1eHfKtMPN1WtzjRmD6hkGbrLW3YPt6tPj3Wg08KdFxns=
X-Received: by 2002:a17:906:d8ca:: with SMTP id
 re10mr1430475ejb.382.1599130117179; 
 Thu, 03 Sep 2020 03:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200902154932.390595-1-thuth@redhat.com>
 <CAFEAcA89Pjp_k5pJh26juFDO1a3M8H_s0+5cGBoZq5v7=ZYing@mail.gmail.com>
 <cd4a7bf7-c525-1aab-dab6-dcc0d22bf538@redhat.com>
 <20200903054711.q7uvc32qlchtugau@sirius.home.kraxel.org>
In-Reply-To: <20200903054711.q7uvc32qlchtugau@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Sep 2020 11:48:26 +0100
Message-ID: <CAFEAcA_Ur-ZwVg-Y=6zbeUMOisjrXVctcEMtQqsDfSANXn_h+A@mail.gmail.com>
Subject: Re: [PULL v2 00/15] Cirrus-CI improvements, and other CI-related
 fixes, m68k
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 3 Sep 2020 at 06:47, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > Darn. I've added Gerd's patch since it is needed to fix the acceptance
> > tests in the Gitlab-CI. Could we maybe revert the patch that introduced
> > the regression instead, as long as no other proper fix is available? The
> > failing CI is really bugging me.
>
> Well, ddcf607fa3d6 fixes another nasty issue (builds modifying the
> source tree), so reverting that isn't really an option.
>
> We could have configure remove the symlink in case is present.  That way
> old build trees with the symlink already created should work too.  Right
> now only build trees created with ddcf607fa3d6 present are working
> properly.
>
> Untested patch below.
>
> take care,
>   Gerd
>
> diff --git a/configure b/configure
> index b1e11397a827..493b4e86da62 100755
> --- a/configure
> +++ b/configure
> @@ -8107,6 +8107,7 @@ LINKS="$LINKS .gdbinit scripts" # scripts needed by relative path in .gdbinit
>  LINKS="$LINKS tests/acceptance tests/data"
>  LINKS="$LINKS tests/qemu-iotests/check"
>  LINKS="$LINKS python"
> +UNLINK="pc-bios/keymaps"
>  for bios_file in \
>      $source_path/pc-bios/*.bin \
>      $source_path/pc-bios/*.elf \
> @@ -8127,6 +8128,11 @@ for f in $LINKS ; do
>          symlink "$source_path/$f" "$f"
>      fi
>  done
> +for f in $UNLINK ; do
> +    if [ -L "$f" ]; then
> +        rm -f "$f"
> +    fi
> +done

If this is for back-compat with old trees only we should add a
comment that documents that in the final version of this patch.

thanks
-- PMM


Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71651C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 09:22:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 347A92187F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 09:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DDvDMtWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347A92187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2XB1-00045N-Dn
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 04:22:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2XAS-0003eN-03
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 04:21:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2XAQ-0000oi-JC
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 04:21:47 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38283)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2XAQ-0000mU-CD
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 04:21:46 -0500
Received: by mail-ot1-x344.google.com with SMTP id z9so8505380oth.5
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 01:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RQ/wMB7rVIAdQQlLAEM834+QmuDodOIgjnx0dcK2sW0=;
 b=DDvDMtWCtga5e3CXOemgpxABULyrfpSF42/vOxGwz2L4/CMN05CMLPQcUADA1U6wze
 TP9QJcWiUm1cNA/2a0j+nJJwatb9ZFcLIc1Oc83Gb0iidJHH66JoO1qEep8d59bolmWf
 HILhjeSSKiJHzDl4nVbg9e+8+FUALJljTvTfBlIabxWtlic2v+IoFHw9EP5SR3jMJ0y6
 uredYBQ0dVI7abc4mVk6aI01JYrUP+Pm6AyvaO2jOd+pMm6hXk8TTmDCLmF+uVJK++hY
 5Fb/YSxuWdK70YF9bPVxN119acl6HAzfcSwLA5SJCvOsMtPJAiIVQki+K2GriuLmZFUV
 pU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RQ/wMB7rVIAdQQlLAEM834+QmuDodOIgjnx0dcK2sW0=;
 b=Dt12vd7ITe/vCugcVFPpvAQGoBFZ/DtoynuelrUeP2zEvGRT5Y0WX0jE7Rg45h1zdX
 UKt3vSngFfkP0ovLjBqiBtJQwEX7eaZSu/NZP7jAOj5dQybF/Vmr3SObK3Je5lG3gFr1
 2pA1zOP0DlhrhRW+cIIQi2J13mIO5LbxESt4N/wH7bKhDTx6vKcLSqqO0keu8GSMeDSd
 YrXL5HJhXGw4RFDFeN2g2ah17vWMV2nIqFkRxouqkkwt6PwXsg6hohrLwNMkwyWXgbhw
 3sP5IvAjpFe8DDoaIsUZZXZvPRcnPxQqutK/BpLRqYgaBI8XcVCn8oaZp0PQa0eyhYFX
 3RSw==
X-Gm-Message-State: APjAAAXEmzesQWZG748xuKjiK28ed2znT+bumImCNov8jJ9BQ2Io9MME
 CMMmvLiq+UTmwyp8r9k/b8qOsBEDJNopnwAKXj31xg==
X-Google-Smtp-Source: APXvYqzmRBjwwD52alWI0gK2EUAhqGwkFmloSeq/WJjn8HMTX1TgEDnyaJe2xfuKU0DkuR+Cjrz+fR+np33bnE2uTPs=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr1488116otq.135.1581672105445; 
 Fri, 14 Feb 2020 01:21:45 -0800 (PST)
MIME-Version: 1.0
References: <20200213175647.17628-1-peter.maydell@linaro.org>
 <20200213175647.17628-2-peter.maydell@linaro.org>
 <87v9o91xvv.fsf@dusky.pond.sub.org>
In-Reply-To: <87v9o91xvv.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Feb 2020 09:21:34 +0000
Message-ID: <CAFEAcA8ZPrkfzzyxe-im609GQAxEqRz_z3Ar2EFdcFqzyN4p1g@mail.gmail.com>
Subject: Re: [PATCH v2 01/30] configure: Allow user to specify sphinx-build
 binary
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Feb 2020 at 06:33, Markus Armbruster <armbru@redhat.com> wrote:
>
> Does not work out of the box on my Fedora 30 build host, where
> sphinx-build gives me sphinx-build-2.  I have to specify
> --sphinx-build=/usr/bin/sphinx-build-3 to unbreak it.  Which of course
> breaks things when I try to build anything before this commit
>
> The appended patch makes it work out of the box.  Please consider
> squashing it in.
>
> diff --git a/configure b/configure
> index 14172909f0..a9d175c400 100755
> --- a/configure
> +++ b/configure
> @@ -584,7 +584,6 @@ query_pkg_config() {
>  }
>  pkg_config=query_pkg_config
>  sdl2_config="${SDL2_CONFIG-${cross_prefix}sdl2-config}"
> -sphinx_build=sphinx-build
>
>  # If the user hasn't specified ARFLAGS, default to 'rv', just as make does.
>  ARFLAGS="${ARFLAGS-rv}"
> @@ -903,6 +902,7 @@ fi
>
>  : ${make=${MAKE-make}}
>  : ${install=${INSTALL-install}}
> +
>  # We prefer python 3.x. A bare 'python' is traditionally
>  # python 2.x, but some distros have it as python 3.x, so
>  # we check that too
> @@ -915,6 +915,19 @@ do
>          break
>      fi
>  done
> +
> +set -x

I guess the set -x / set +x here are accidentally left in
debug printing?

> +sphinx_build=
> +for binary in sphinx-build-3 sphinx-build
> +do
> +    if has "$binary"
> +    then
> +        sphinx_build=$(command -v "$binary")
> +        break
> +    fi
> +done
> +set +x
> +
>  : ${smbd=${SMBD-/usr/sbin/smbd}}
>
>  # Default objcc to clang if available, otherwise use CC
> @@ -4803,7 +4816,7 @@ has_sphinx_build() {
>      # sphinx-build doesn't exist at all or if it is too old.
>      mkdir -p "$TMPDIR1/sphinx"
>      touch "$TMPDIR1/sphinx/index.rst"
> -    $sphinx_build -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$TMPDIR1/sphinx/out" >/dev/null 2>&1
> +    "$sphinx_build" -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$TMPDIR1/sphinx/out" >/dev/null 2>&1
>  }

This change isn't related to trying sphinx-build-3 --
did you actually need it ?

I did think about quoting when I wrote the patch,
but looking at existing practice we are all over the
place on whether we bother to quote variables containing
program names in configure. I think I ended up following
the same thing we do for $python, which doesn't quote.

Other than that, I'm happy to squash this in, or for
you to squash it in if you are otherwise OK taking
the first chunk of the patchset via your tree now.
(Do you have a preference for whether you take these
patches via your tree or I send them in a docs pullreq?)

thanks
-- PMM


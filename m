Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3B9CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:15:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2706220663
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cOA9UxDr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2706220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO0N6-0000hl-TM
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 10:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iO0Cb-0007UH-4E
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iO0CY-00089E-TH
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:04:28 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38050)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iO0CY-00088u-My
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:04:26 -0400
Received: by mail-wr1-x443.google.com with SMTP id v9so2491880wrq.5
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 07:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=hLRiieVh5w5MhBEjJ9FVa9Xns4wCwew3OwuKnWQYjoc=;
 b=cOA9UxDrdaVnBjtBLoHDik9YDN75HihoWKKn8tC3V1RkVw73tS8zNnj/5/gAylGTvW
 hpHv1d32LAyr53L/eCLzmrnbZw7ViDr7IdzSSszXZ/tYnn6Cuv2lkn7xugdJE7rrGpaz
 xYNzHXodWxYQ4xiXmESGnIvJmPWCLfcMTvnNcqOmliivcQnYslWEFnY/1ySbvKFdQH+8
 IxpWXErNLoAwth2ppeS9ayP7BP5oeI5QWNbahyF8PA31+CLNQCgKE8vF1cc4vE+q/pTJ
 dDqa0BnoT1N6WlMqRhV1/0oBuN1ntf2CUN9Sm0zEw+bi/yrEwr4O/Q46u3j6BTM5q+eP
 OYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=hLRiieVh5w5MhBEjJ9FVa9Xns4wCwew3OwuKnWQYjoc=;
 b=PpywhqwS6VNYWxrCPE7gRX4Yh4tksAR7fOu3lXK7qhn+EuGxGXjZPiqH+pmLGXv/4Q
 4Szt/PneIffH8Q8M4BxYA7326dGsCCPyvte7gq+cVyglEIsiqZXkA8yHM2Yw7Ju6HR0B
 dwjq2Ty8he2Tkrn1jB4thQAmTzeC8lxyO0p6YPlmfqNv9/jMM42B40lDODaemulohu0C
 WiSriKgwlXTyXUuIjfsXNyr1JmGC5m+1bRv4iD3vP7ktIqR6qvPMAVtw4f/v535D1Qbd
 YgOTx8blQOnBTLF+GPcNKrjycA6rqulc54U2qZggQiNUSpIR6EWKnHJs2th22FhF2e7w
 3INQ==
X-Gm-Message-State: APjAAAVmYhd4gp3DMy5HERs4EvAjyLBsbVRyPjePP4BN6H/+Lm7QW3SN
 8lyv8bcvMQfwb1GXfvg6V1J5BQ==
X-Google-Smtp-Source: APXvYqwOB5GTSUU4WK4LXoBH2eVIWxQ5bNQd1xrYgt1ImYrZmFdKagoRiSR/ahIWvOU+Ge+qfeP8og==
X-Received: by 2002:a5d:4a81:: with SMTP id o1mr3187726wrq.225.1572012265077; 
 Fri, 25 Oct 2019 07:04:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r5sm3008144wrs.57.2019.10.25.07.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 07:04:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A0CA11FF87;
 Fri, 25 Oct 2019 15:04:23 +0100 (BST)
References: <20191023154505.30521-1-richard.henderson@linaro.org>
 <20191023154505.30521-4-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 3/7] configure: Detect compiler support for
 __attribute__((alias))
In-reply-to: <20191023154505.30521-4-richard.henderson@linaro.org>
Date: Fri, 25 Oct 2019 15:04:23 +0100
Message-ID: <87tv7wly54.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Such support is present almost everywhere, except for Xcode 9.
> It is added in Xcode 10, but travis uses xcode9 by default,
> so we should support it for a while yet.

We really should get someone who has an AppleID to check what the
support period is because if Apple don't care about Xcode9 anymore I
doubt we should.

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  configure | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/configure b/configure
> index 145fcabbb3..3a9862fe5e 100755
> --- a/configure
> +++ b/configure
> @@ -5518,6 +5518,21 @@ if compile_prog "" "" ; then
>    vector16=3Dyes
>  fi
>
> +########################################
> +# See if __attribute__((alias)) is supported.
> +# This false for Xcode 9, but has been remedied for Xcode 10.
> +# Unfortunately, travis uses Xcode 9 by default.
> +
> +attralias=3Dno
> +cat > $TMPC << EOF
> +int x =3D 1;
> +extern const int y __attribute__((alias("x")));
> +int main(void) { return 0; }
> +EOF
> +if compile_prog "" "" ; then
> +    attralias=3Dyes
> +fi
> +
>  ########################################
>  # check if getauxval is available.
>
> @@ -7083,6 +7098,10 @@ if test "$vector16" =3D "yes" ; then
>    echo "CONFIG_VECTOR16=3Dy" >> $config_host_mak
>  fi
>
> +if test "$attralias" =3D "yes" ; then
> +  echo "CONFIG_ATTRIBUTE_ALIAS=3Dy" >> $config_host_mak
> +fi
> +
>  if test "$getauxval" =3D "yes" ; then
>    echo "CONFIG_GETAUXVAL=3Dy" >> $config_host_mak
>  fi


--
Alex Benn=C3=A9e


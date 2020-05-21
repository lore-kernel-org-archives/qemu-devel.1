Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA6BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 12:56:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53F582072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 12:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tOyv/adW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F582072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbkkW-0003C3-Gw
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 08:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbkju-0002lc-Nr
 for qemu-devel@nongnu.org; Thu, 21 May 2020 08:55:58 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43772)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbkjt-0006oH-Af
 for qemu-devel@nongnu.org; Thu, 21 May 2020 08:55:58 -0400
Received: by mail-oi1-x244.google.com with SMTP id i22so6084809oik.10
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 05:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jlvYop/nsRa1Z2SoUprDziSFSUsm6ehAvHYpB6zvbvE=;
 b=tOyv/adWQbIGcmUxB6y6Uxp0F9TuzbnQzm5DwKuw0ULG1Lj7emX1TxPyts14iFud1J
 NzNa0lZB/yFSWd7+GBzb+YvxYJ1RNkMeqjlOmgQZ+JFV3J7MdMQv3u1wyJMic5aEcphv
 4ZA91G0jM6qBEGm/hezj/anR+ScNRNjoq8tckPQv6oD+NM9SqSKX7LfOIAbP2ckUR1Hz
 Sl/pIsqjgJg8Uqf27v5+bUn9JlZ+AKzEMEpW97bd0F19h9mtrwVbiYcBAuYUfU39ZtrT
 pYJSNE8dWKjjHDy/CeWzYlWcehkRP0cE7tdN3TuPS4cSFBchAekgjNOaGmZ1kGFhaiZA
 KQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jlvYop/nsRa1Z2SoUprDziSFSUsm6ehAvHYpB6zvbvE=;
 b=JWhxO0Td38hTueHwLwQr+/ZlJeudIrZUuqvwQkU1a55LEI0ih9B925F9LTW/H5u/eW
 A7+Sc8fJHUZIGVISXGB8TcIVJgfFZy/QF38OK+pSY8ScgtTdy7HX4uU/bTejFaeruoEH
 R80CzFefJayMS4i1b2hu+ZQoxfrqiQoXcJM9D2fPEeA9avEqglme23f2oamy5SxSxK/T
 R77Cag7R+j0DzVSU/i4BaFNoeGigPOa6ETz38I0j5e2YwcqZB1Da6WMSfvvYmxQXXIAV
 lambLID/0RdEIC3iaLExkAeJv+z7fe8rDpMTYykvUD+DkYJkZzT1SKoiqPbwgh298929
 ueUg==
X-Gm-Message-State: AOAM530oC9vPxqQEphex/NuelRpgqJb9s6bM+miiDVP5HCFT5GI5pGVQ
 kJcmRT8CFICGNzHuY7wO963Wl1gdY6BogTARSbWIhA==
X-Google-Smtp-Source: ABdhPJzGt8imRQS84A8E7OlukTJN4J5WULPfLTTXNNbQi1WzeYLALgD907gXoz8MJW7trYWXZz7oGCmJyX3loQFCbFI=
X-Received: by 2002:aca:ed16:: with SMTP id l22mr6258404oih.146.1590065755716; 
 Thu, 21 May 2020 05:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200521124535.5329-1-pbonzini@redhat.com>
 <20200521124535.5329-5-pbonzini@redhat.com>
In-Reply-To: <20200521124535.5329-5-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2020 13:55:44 +0100
Message-ID: <CAFEAcA_b_hMYQWZP4T=E83tgLH4gwJskF=wnzTb6BmzK9GeHUQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] run-coverity-scan: use docker.py
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 21 May 2020 at 13:45, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Our trusted docker wrapper allows run-coverity-scan to run with both
> docker and podman.
>
> For the "run" phase this is transparent; for the "build" phase however
> scripts are replaced with a bind mount (-v).  This is not an issue
> because the secret option is meant for secrets stored globally in the
> system and bind mounts are a valid substitute for secrets that are known
> to whoever builds the container.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/coverity-scan/coverity-scan.docker |  2 +-
>  scripts/coverity-scan/run-coverity-scan    | 32 ++++++++++++++--------
>  2 files changed, 22 insertions(+), 12 deletions(-)

> @@ -300,12 +312,10 @@ if [ "$DOCKER" = yes ]; then
>      # TODO: This re-downloads the tools every time, rather than
>      # caching and reusing the image produced with the downloaded tools.
>      # Not sure why.
> -    # TODO: how do you get 'docker build' to print the output of the
> -    # commands it is running to its stdout? This would be useful for debug.
> -    DOCKER_BUILDKIT=1 docker build -t coverity-scanner \
> -                   --secret id=coverity.token,src="$SECRET" \
> -                   -f scripts/coverity-scan/coverity-scan.docker \
> -                   scripts/coverity-scan
> +    tests/docker/docker.py --engine ${DOCKER_ENGINE} build \
> +                   -t coverity-scanner -f scripts/coverity-scan/coverity-scan.docker \
> +                   -v "$SECRETDIR:/work" \
> +                   --extra-files scripts/coverity-scan/run-coverity-scan

Generally this script uses a "./" prefix for invoking scripts
that are within the current directory...

>      echo "Archiving sources to be analyzed..."
>      ./scripts/archive-source.sh "$SECRETDIR/qemu-sources.tgz"

...as for instance here. It would be nice to follow that convention.

>      if [ "$DRYRUN" = yes ]; then
> @@ -323,7 +333,7 @@ if [ "$DOCKER" = yes ]; then
>      # Arrange for this docker run to get access to the sources with -v.
>      # We pass through all the configuration from the outer script to the inner.
>      export COVERITY_EMAIL COVERITY_BUILD_CMD
> -    docker run -it --env COVERITY_EMAIL --env COVERITY_BUILD_CMD \
> +    tests/docker/docker.py run -it --env COVERITY_EMAIL --env COVERITY_BUILD_CMD \
>             -v "$SECRETDIR:/work" coverity-scanner \
>             ./run-coverity-scan --version "$VERSION" \
>             --description "$DESCRIPTION" $DRYRUNARG --tokenfile /work/token \

Ditto.

otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


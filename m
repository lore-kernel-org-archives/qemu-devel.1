Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1198DC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 12:44:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE10220575
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 12:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VwXl8z4a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE10220575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT378-0003zH-RR
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 08:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jT36N-0003JM-Gh
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 08:43:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jT36M-0000pZ-1g
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 08:43:11 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36099)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jT36L-0000aI-CV
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 08:43:09 -0400
Received: by mail-ot1-x342.google.com with SMTP id b13so25863301oti.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 05:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Y+nwf/z1BMHN9dalKx30dHYCCG5GwRKrtBopOrckucA=;
 b=VwXl8z4ah/RttyFj+V98sCMt7cSnWqL5mxN851ZlTVY5VuyslpGLvZbs1r4EklGf98
 BjI1L+UjYjn3iUoHLQmlkjnz1/TOmU2qWqJqGDrU29eBp8kM8O38iNxBAeh4GDCfYGqv
 Itg6RWoYQT3eQJY+Uye1VVZumaRZUnYZEOisdi6wE4GHV46n+IzHEe6/Bm4MIIghvCPQ
 H9n4rn2GM0IfPDABHfAMojSreG7+x80drRrIH0d/qWHm6qJd2mRsv4oXgaGdRPxr8ON4
 HC8cp/zBk7GDSqJFoh7Pk4YWQUGHdOs8HJx4NBNLY7TRibGNrC+BHBFUWbaNsWm2/0+z
 wUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y+nwf/z1BMHN9dalKx30dHYCCG5GwRKrtBopOrckucA=;
 b=Moja3n+svgPRpNRLYoa02ns6dTNSfhJsRo3jslopAt/ynbh40/d2ga4b9T9w8GBq+I
 VHuL5gALo2WTKn2p/YUwQbveuKOSKCIgPnkmjLqGnkFtefoq/id66ASrnn7RSQG6oBuR
 dd3T/RLJJTfx/7l3tfFqopcneXCcasMtFbr+tVIsIMkDHB2uoy+7/q31BvsdTPCAybDZ
 jUTmNfnUP2DEbEvcRVGYYr5HjOIOnXc159rUbAaZbYPn7k6Lavzs71KrOJz23RovdHXn
 Y6c9G/ty0rKDY/Tza2fkx3GEdurL2GqqplcALUYQOHbIPYDI7lHVTyWWBgNGpSDINUuS
 otMQ==
X-Gm-Message-State: AGi0PuYeT0Lbll/lQ0U+PtQGScvuGDnY+pWnPQGtJavSO5hH7NvwznCg
 0aa1EKb37/bh3HEFO8Nov8JeYzYDJcyGlXJZ2Qb66w==
X-Google-Smtp-Source: APiQypIMWBC239rZmstAZE7jFrSXF0REynr88sCPEUo1clR31CHqM/8sZ7qijzlAovzaWV+FIlamA/CeiQGkL+k1ouY=
X-Received: by 2002:aca:3441:: with SMTP id b62mr13756780oia.146.1587991387811; 
 Mon, 27 Apr 2020 05:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200422172351.26583-1-pbonzini@redhat.com>
 <20200422172351.26583-5-pbonzini@redhat.com>
In-Reply-To: <20200422172351.26583-5-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2020 13:42:56 +0100
Message-ID: <CAFEAcA_xMOJtDMJYbv+MzQYVeN0T5+q9WRcpjshkTGBrdH1Sfg@mail.gmail.com>
Subject: Re: [PATCH 4/8] run-coverity-scan: use docker.py
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::342
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

On Wed, 22 Apr 2020 at 18:24, Paolo Bonzini <pbonzini@redhat.com> wrote:
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
> This also removes the need for DOCKER_BUILDKIT=1.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

> --- a/scripts/coverity-scan/run-coverity-scan
> +++ b/scripts/coverity-scan/run-coverity-scan
> @@ -197,6 +197,12 @@ while [ "$#" -ge 1 ]; do
>              ;;
>          --docker)
>              DOCKER=yes
> +            DOCKER_ENGINE=auto
> +            shift
> +            ;;
> +        --docker=*)
> +            DOCKER=yes
> +            DOCKER_ENGINE=${1#--docker=}
>              shift

The comment at the top of the file documenting the command line
options needs updating.

We don't accept --foo=bar for anything else: options either take
no argument, or take an argument as a following (ie space separated)
parameter. It would be more consistent with that to have
"--docker-engine foo" as a separate option from "--docker".

Otherwise looks OK.

thanks
-- PMM


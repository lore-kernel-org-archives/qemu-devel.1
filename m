Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B79AC34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 14:37:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AABB20718
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 14:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jgKVWpCw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AABB20718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3hX0-0003Cz-BZ
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 09:37:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j3hWK-0002ip-I8
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 09:37:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j3hWJ-0001G6-AF
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 09:37:12 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:40784)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j3hWJ-0001Ev-4t
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 09:37:11 -0500
Received: by mail-ot1-x32d.google.com with SMTP id i6so16255658otr.7
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 06:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ye9VjUyW9hc0xHKeU7Iorj+XRpmndRsVggv/V9+TmqM=;
 b=jgKVWpCwIymjixjX1sLrdtPJkvJfzC5P5obAr8kPJGfqW+xTfi0IczgdI//l4mkUwk
 MCD1FIrZ7JuKyads2TmgOIJoxuE55mVstq0FEJJ9A/6mD2DU+rk6NIj/fQKYh9t2lEUi
 Ivkh2ys+NHKppEgox0iU6Mk8Gs5ZN5DPDf73wrRBGLWTYbNQlzsSrk5CZ4ZJ3PQQ8ctN
 zKJa6fSutIjfubmPizc0WwBnnLa/TQoA1E8y+tl1G3SYpeZQ1QNfXIQZMxzXiWwWO4C5
 6c9K6SqPQuMDbQ9uEVQQXttCb9vPdQ5kPQFx9bfc5kA+0WdjQzUS0/JTmPFicSHOGVej
 FqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ye9VjUyW9hc0xHKeU7Iorj+XRpmndRsVggv/V9+TmqM=;
 b=J1lHMscDJz2XYF+RPXpN+zy1G5aU/PEiD3DWMf5B5chiap2m+iY40LbQwQAQc7SLW6
 rmjXigacLspX7MfOWofEOXiJZd24pW/JOxO/zb6gMqHhkfcizQl2ifBZfmxudm7hJDtz
 Q88CbndBBJ6SbyOPSL9eMbJPU6LPk4PokDY1x6fmECUPgTE98QUhwFhH4quJ+u3EaFW0
 E3xIGQbQcA+JpB0dfNCwK22ndx+q7jUV8tMS7ewy0Hyqqjyz2sjeXMPli1hpPLcO7kTr
 N6sLoFvjpmHdc2HP2wJauKBd23Fs11rX4PaaWF/V1KFcCLhogdUuc9Vm/O5Gi3rpyGC8
 bMnA==
X-Gm-Message-State: APjAAAUJw52X1gkEKiXdYhOVCi7LgCr3SlfeEA1ZzLjLdTBc6NUDUh4t
 PPjdHhZoHQWCYMqZBme2SzkgTyN+cKzlU//cPoO1hTQT
X-Google-Smtp-Source: APXvYqy5x/Xi+lTtWK/M4g1xjnLGgQMi6K26ApoYnU2F9I2tUN6aVFHu1xkXxNiIaC5HkjHLqqm/VcsDLBqT5uyYKho=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr12487977otd.91.1581950229808; 
 Mon, 17 Feb 2020 06:37:09 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA--P9FLM4qBxf23sLuv5Tz4HRgj7ONC7ODxnfZiLph9TA@mail.gmail.com>
In-Reply-To: <CAFEAcA--P9FLM4qBxf23sLuv5Tz4HRgj7ONC7ODxnfZiLph9TA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2020 14:36:58 +0000
Message-ID: <CAFEAcA-RnKYfJRaGDSFFx=O17mdvsPMEwbfQ1prTrhmrosAGHQ@mail.gmail.com>
Subject: Re: should we have a new 'tools' manual?
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32d
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Feb 2020 at 11:50, Peter Maydell <peter.maydell@linaro.org> wrote:
> but some of our documentation has always been a bit of an awkward
> fit into this classification:
>  * qemu-img
>  * qemu-nbd
>  * virtfs-proxy-helper
> etc. I've tended to put these things into interop/.
>
> The proposal from Dan and David was that we should add a sixth
> top-level manual
>  * QEMU Tools Guide (docs/tools)
>
> which would be a more coherent place for these to live.

OK, consensus seems to be that this is a good idea. Here's
what I specifically intend to move:
 docs/interop/qemu-img.rst
 docs/interop/qemu-nbd.rst
 docs/interop/virtfs-proxy-helper.rst
 docs/interop/qemu-trace-stap.rst
 docs/interop/virtiofsd.rst

Nothing else (in particular including qemu-ga.rst) moves;
none of the as-yet unconverted documents need to move either.

thanks
-- PMM


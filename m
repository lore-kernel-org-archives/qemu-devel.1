Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1382C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:13:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68E0620707
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NgAGX4Jd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E0620707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioU4V-0003JW-Qh
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 10:13:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46798)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ioTjI-0008Ht-TQ
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:51:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ioTjG-0005Uv-JO
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:51:40 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:45518)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ioTjG-0005Uc-Cy
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:51:38 -0500
Received: by mail-oi1-x22a.google.com with SMTP id n16so11948331oie.12
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 06:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RH50i4j+VsFHFOPkDHbmVc2zXv0KAu+dD/umeTjfepE=;
 b=NgAGX4Jdfu2z3KkMW2+Xipz1n/3PjJBsTVzXWKvy12gxulEuHV1OWca37VdB8NxVVC
 jhWA242cdiguhl6sJ4/oKgxLFIo9/Vd4URlJHgQa/f0Q28DCpIY5O+XmKdBD1bNZyj0f
 gDollcUEXN98GCEAvETj5GziEaVUK0ynSP2COuGR3yAhpRCtfD4MvhjE5VF/uZpieki+
 7OQWf+MXcGGOz9XZP4OWSC2I3v8s3nEZ7as4j1/5spWGry9h+pg38NHYwfaWdLaoC3CW
 p+jFn0CKS1NnF2QVYHue+Pyl2peF46wYbH7S8kJpEFPBZxuPrTMdFRL+Zc8tqCQRObUA
 JvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RH50i4j+VsFHFOPkDHbmVc2zXv0KAu+dD/umeTjfepE=;
 b=XMxxBUzOm+LQ/tnxdVS+aGXTb10CbndXggLr7/a+HeCx/396skmBjkYkr5vY3T//u/
 9OpUpyDYGx9ToP9Hp8pUl8Bxmzox76YsDw04uQfyKyLWz5ysk0JznpQe/5MMyLJ9e0HG
 kJLAyS4s+J1+wY5vHC0y6UKXPug3ARXo+CwczOGl+A3w8UkjtinOSBdnrSfPEuwlRdAq
 nUhgQnqWYbeqMU/sqWKQ+5R2cdUk3X/64j6Px7M0f9OCDaXON82BEXgslf/V7fSBRM9X
 /y3Z1gP4Aa55iHlzUFMd4E1ANdGIAn34J4nDPyj5r6K/mH5kiopGSw5aqocGvgaKTPqS
 sYqA==
X-Gm-Message-State: APjAAAXLenHGusQhTsfijnf3K6/LjewFSbYX4YAJsg+qdKlcpwQZ/Qmo
 p0jsUWpSRc+4URQMHv9r9ulDGeVf14YfEcxRbaHcOw==
X-Google-Smtp-Source: APXvYqwqjUascPCGoxYUdYSqKV8WqUuU28/4zssu1sqPS/SS3IkVOgzohzkej1hyV6jpHBJjkCPFDFVV3/LhT+G/CbY=
X-Received: by 2002:aca:f484:: with SMTP id s126mr5154489oih.48.1578322297368; 
 Mon, 06 Jan 2020 06:51:37 -0800 (PST)
MIME-Version: 1.0
References: <20191220192031.2226378-1-ehabkost@redhat.com>
In-Reply-To: <20191220192031.2226378-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jan 2020 14:51:26 +0000
Message-ID: <CAFEAcA-=zYQsW+ysD1j+waz1Y9pRpHHj7T3bCJbhV7z+dpBC8g@mail.gmail.com>
Subject: Re: [PULL 0/3] x86 and machine queue, 2019-12-20
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22a
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Dec 2019 at 19:20, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit aceeaa69d28e6f08a24395d0aa6915b687d0a681:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-12-17' into staging (2019-12-17 15:55:20 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-and-machine-pull-request
>
> for you to fetch changes up to fcd3f2cc124600385dba46c69a80626985c15b50:
>
>   numa: properly check if numa is supported (2019-12-19 14:57:14 -0300)
>
> ----------------------------------------------------------------
> x86 and machine queue, 2019-12-20
>
> Bug fix:
> * Resolve CPU models to v1 by default (Eduardo Habkost)
>
> Cleanup:
> * Remove incorrect numa_mem_supported checks (Igor Mammedov)
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM


Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B756C4CEC8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:30:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BF3920717
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DBoHLcuj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF3920717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8led-0007lL-VR
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 09:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36035)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i8ld3-0006Uw-S7
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:28:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i8ld2-0007SG-O0
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:28:49 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34083)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i8ld2-0007Rz-JI
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:28:48 -0400
Received: by mail-ot1-x343.google.com with SMTP id z26so20186647oto.1
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 06:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SOKPqpnSYa6AcbicJWmH+tLhJmJKoMlZ1hTYP+zvnH8=;
 b=DBoHLcujRjhqFF+I2M0uZ1jek+IVqVIzD8+96YZDrv6iQluTRjfKj989VqMJ514Z9c
 g1cCEcvhFORIYhbnVvHOF59ze3JoJsJhmSqPNaxryXCLcR10QFUfooxv+bzfmnZ4puaV
 nCYuOpxgT+XsQ3VAGHGKpC0WYvjJam2BSpf9YCV5cQdfX83+vQDSa3t5ZT21aD8WYN0J
 SPPxxy6t05MS2q3XqXJXZgbncWidS9JXtxq2Yx+lux07mV1LPRrZ7W68PtU289IbzuJs
 2f6CwTGbFX455s04WgD6C+iitF9ZhS/rbHDWxrOhv3yzv/TBIvEd9zII0O0uDtp/cS6k
 7pkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SOKPqpnSYa6AcbicJWmH+tLhJmJKoMlZ1hTYP+zvnH8=;
 b=q6pL6WeXoULkrcgEFZzzXdSFYdfYqUwpbebyC5keCyGGm2vyZX7qsw/qhV55QJrJWS
 cEF2RYiRVaMP3lh7XCtRchKMURL1NvYljzXlg9t+TG/08dEViubvSznptLFtlN5njs0b
 gLv/Bkx2x93sVQdvW+pTAb+4DisG0ZJvsX7DOlTiOeRq3NMTvfJ3ia1tSjPzhS25KSmK
 QeOfbbmdMTze7yHoTKlSBi7qzUa/w902AvDi8fZdzgSDAQ8xaBnFZ7YaB5B/Lpu4XJtl
 Fc9XrUAQPAaenyu2kTV5pZgBSNqiTFUEf0Yz4EsNLqb48FyUn97MSjjL0L+X3mA9wH/J
 T3yQ==
X-Gm-Message-State: APjAAAUOuYxXaDnbtdraPvRaaoAq1FqC4ETRWKJG3iZd4fo/BeAipMLB
 STpmsWq+DfUJ/oNpJBgSWJ0dGoBsdcXpvKkoWFzTtogotMU=
X-Google-Smtp-Source: APXvYqxdDlfMrY1nbs4gF4SpDb6XaNcL3XhFBpvl3AXqEfKlyJRUlxfJg3vApUTwBEuy7QJdlYX18G/XGNSxjpOmnls=
X-Received: by 2002:a9d:538a:: with SMTP id w10mr6332397otg.91.1568381327472; 
 Fri, 13 Sep 2019 06:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190905131040.8350-1-peter.maydell@linaro.org>
In-Reply-To: <20190905131040.8350-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Sep 2019 14:28:36 +0100
Message-ID: <CAFEAcA_K_mj9A-_sMkK52h82V0CexD2Tc1RCYMxP07oCv2AXGQ@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v3] qemu-ga: Convert invocation
 documentation to rST
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 5 Sep 2019 at 14:10, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The qemu-ga documentation is currently in qemu-ga.texi in
> Texinfo format, which we present to the user as:
>  * a qemu-ga manpage
>  * a section of the main qemu-doc HTML documentation
>
> Convert the documentation to rST format, and present it to
> the user as:
>  * a qemu-ga manpage
>  * part of the interop/ Sphinx manual
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Tested-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---
> Now we're out of release we might as well get this in the tree.
> I saw a new manpage in texi going past the other day so perhaps
> if we have the framework for doing manpages in rst in-tree
> we can avoid adding too many more files we need to convert later.

I'm planning to put this into a target-arm pullreq since
I'm doing one anyway.

thanks
-- PMM


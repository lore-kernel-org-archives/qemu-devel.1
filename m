Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2B1C3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 09:33:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DB9623401
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 09:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qC0LuhD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB9623401
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0jTd-0001p5-5y
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 05:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i0jRR-000151-Si
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 05:31:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i0jRN-0004g5-HJ
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 05:31:36 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40730)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i0jR9-0004Jf-TD
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 05:31:24 -0400
Received: by mail-oi1-x243.google.com with SMTP id h21so3850379oie.7
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 02:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+mvF+u8nRF4B5UCflU874NSkhPdxuLqU4e0/vgUOCL0=;
 b=qC0LuhD/d+eS89XpAInGpPXCd8cGiABMZhzZZW0+qbix5nn9hjRXekPADslooZbqOh
 BDI3iFge6GV5SE3qmhdZggYAdA1WgDjnTgvbc/LyR7pL7fjoREbwuRX/dVwLqN2hh/d4
 boZmxrrpbjuGjNQGIW+sVHBRF4avAekfb8YcTtvoJg9rzINh0S9omsajBpCjD7pQuvZ7
 oWH1jGBb4WSQI6Rql9m406+e8sfup+V3jecHP3eJqdlBaypyVo65LO2cNTfqXF18i7CF
 XQzscBmHLDe3lCvSsw7+RjdxE5HB1xXcI00OIv78tSmG8hjFftei7my0tYjst9iTsXIh
 H6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+mvF+u8nRF4B5UCflU874NSkhPdxuLqU4e0/vgUOCL0=;
 b=PH3GaX9pOPip70MWbC8pwr/dc/nd8CbsA0XtlQmIPLdN7HOGIqvfs1qPhJ14UGdA1C
 jpvO/t8aJrmEWBQvtHSABozPxpT2kzeiFVFDVRxY0O2ygEJd7xMqVlvPshAzg6HYXs9i
 J6Sv//LymQGRnYJxhEwyhumNvx8A0ZZ1E/r/ujwAihxTvz5n4vVLKsaNmfUCMsU+Rao/
 ZwTxyTsXbvL/xbxcC8+PwExaLvdKTV2vjMxZ4dq+ivx7JI18X2u263LqEY8P0JFIOx0d
 mmTeQJxyXoGQKILssbm4SDvKeh/Tcf/FdoU5KIpl1knCF6LrSUi34p1SKScaShU1nRbh
 oiBQ==
X-Gm-Message-State: APjAAAUMVaFxsfFrJw7RbHODNTp1bcqtB5Gsr5ZpcwSaQPeH5iNND9H6
 TAsUxZN2NBif1Y4g84kIOCEgL9Xq6ogAvq6jXgufxA==
X-Google-Smtp-Source: APXvYqy/izIJgUcqOP1MnDX5FoLVj+emD3FWyF8F94KLYcR+Y5XmGF8iDeztmLNlwOLSkRLPgLvySfokrIvnhqGKqkU=
X-Received: by 2002:aca:50cb:: with SMTP id e194mr2906769oib.48.1566466266287; 
 Thu, 22 Aug 2019 02:31:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190821111947.26580-1-laurent@vivier.eu>
In-Reply-To: <20190821111947.26580-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Aug 2019 10:30:55 +0100
Message-ID: <CAFEAcA_redM_6EGE_kMesD3RhKmABvoX0nW5m4X7t8sNBfZbwA@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PULL 00/14] Trivial branch patches
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>,
 Juan Quintela <quintela@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 21 Aug 2019 at 12:20, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 17dc57990320edaad52ac9ea808be9719c91cea6:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-08-20' into staging (2019-08-20 14:14:20 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/trivial-branch-pull-request
>
> for you to fetch changes up to 8a9224a250094222e9ff302b95e379c3e71d3c8a:
>
>   hw/display: Compile various display devices as common object (2019-08-21 13:17:22 +0200)
>
> ----------------------------------------------------------------
> Various trivial fixes
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM


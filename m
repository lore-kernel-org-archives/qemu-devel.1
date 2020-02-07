Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6E2C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:00:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA3ED20715
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wUpaWc7x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3ED20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j02JW-00036z-Rb
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 07:00:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j02IH-0001w2-Jv
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:59:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j02IG-0000f0-IO
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:59:33 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33013)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j02IG-0000c9-CX
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:59:32 -0500
Received: by mail-oi1-x243.google.com with SMTP id q81so1745675oig.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 03:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=E19fk3bg12ZgnPQArsaMN6KJslPcvXLVjVWlcuBwsJM=;
 b=wUpaWc7xs6bHtj2/nm/IJU1mRPx2fvx5LD1rxypRlIn+MdQI4esNOmWN9c+kENGsMn
 nGKLuyO7BTrBpW/93rqS+R8zKToeXI4G27ZeF38obqluLCvYDOKC3envP0nviQtHhISc
 9OGnsUdQBXbIBkI7eMvZFXG7uJwrm/EWrZcKwgr+qlfQzAQk3laBPhPdT6XXA84uDDkR
 eXoq0CFnhSX33FnZ0CXDteP13ZMY1sfFaDrbWnTPuT1dMLoCFz9JEsFJgFaHy9dxq4mb
 gPiPenNpM0FmSdvwG291P0tt3FX/HF71JGImxDZkGKETr88OKVANTvAlmistspr4pz1X
 0LOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=E19fk3bg12ZgnPQArsaMN6KJslPcvXLVjVWlcuBwsJM=;
 b=pKXaXVRUspNNkRmVUz9HQtJrXyxv1I8yz3XF3TfM8QRYHbOeF2I3hEf4e4ZoxgRKdI
 2qzBq0HRKxlo90x2cMRC4bRGAjHZxf23oH6Lbw4ptvFIIa7UnXXEjRooTS/H3W9V5kqY
 LREakNIeE/keusK+P3C3/QSoRa21+5NxmG7d670anXNxPCgjewfj0yMlfvMMReLrexAb
 zdsrv0ohOkm2XQC6ocWoGxlqxg0UVZXM6S/Z5+rPTOqvafhyQMi6Zc2OCqJK5SKq/jVw
 GOcY7zvLQmPTqu9oAiSUnB6kXKmVs0scTZySXI5ekSP+BfvrUOZy6ow7jSS1zlhuI5OL
 roTA==
X-Gm-Message-State: APjAAAXvo9oPhwxhP+uD0BCelmDJQySvKQbjIMrEb1/WRHopXhWcrQ6w
 0qzz2WdmJocxQMhezB9D4b94FZ2Enn+nKZuf01eZsw==
X-Google-Smtp-Source: APXvYqz93zNP00scrm7dM1Uq6SmLyWHXzvnGBPUx6Fzecuid/88xernf64/bq4Dx5WgwC+rsJ1cfFXy/+x3uTfVO+k0=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr1871929oiy.170.1581076771478; 
 Fri, 07 Feb 2020 03:59:31 -0800 (PST)
MIME-Version: 1.0
References: <2357909.uYzqtL8Sc2@desktop2>
In-Reply-To: <2357909.uYzqtL8Sc2@desktop2>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Feb 2020 11:59:20 +0000
Message-ID: <CAFEAcA-4LDRH3A-PVphzQn3F82hODV8f0YsZuVqygn-jFi_p+w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] bcm2835_dma: Fix TD mode
To: Rene Stange <rsta2@o2online.de>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Andrew Baumann <andrew.baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Feb 2020 at 15:41, Rene Stange <rsta2@o2online.de> wrote:
>
> Hi Philippe,
>
> this v2 patch splits the initial fix into two commits as suggested.
>
> Regards,
>
> Rene
>
>
> Rene Stange (2):
>   bcm2835_dma: Fix the ylen loop in TD mode
>   bcm2835_dma: Re-initialize xlen in TD mode
>
>  hw/dma/bcm2835_dma.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Applied to target-arm.next, thanks (with the commit message
tweak suggested by Philippe).

-- PMM


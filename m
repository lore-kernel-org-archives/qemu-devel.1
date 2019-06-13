Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451F4C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:23:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10AD02147A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W/nTY4o1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10AD02147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39666 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbPhe-0006Qq-8V
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 09:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36990)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOva-0002Bw-Cj
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:34:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOvZ-0003OH-CO
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:34:02 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34250)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOvY-0003Kt-0W
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:34:01 -0400
Received: by mail-oi1-x241.google.com with SMTP id j184so1121928oih.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L5Mj2zcynYdUM7i3Dl7BuaC6czDtkwLCAUpOhNmNgEY=;
 b=W/nTY4o1Sp+DHaxLJL9RHCfyPWZ8JH42E8uD3L/xdLWqYEmY5RfTtk+m3UClF0SJem
 3Tx23ZaXYRo7zh76VhZ0cXfShwhLhoUTZtv1psB0vaLzal/C0sPfpxgYe+1sLjzDsW1E
 36tT1fUKX7VDhn2jqYXvyd/eu2+JQeAz3Fr9WCBSlUm9izEq6czw1IXe2RaxExBBOoH2
 PAJtBDFd8Ve3z46CvEWEefEGHKrk657KfSEE9mtPNUpyp06Hrs1nP8Lf+EMHBKl2T9EU
 DaI2o8LWqsFeA2AGTDGxDnEHNGitVtM855iwS0MyZnZ3SQGukdn4WVmYYuhFPb7zQjg9
 vakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L5Mj2zcynYdUM7i3Dl7BuaC6czDtkwLCAUpOhNmNgEY=;
 b=a/Ba4vS/z+hpsUIFRNe3GhX0qbLDW6j981t4qPDZwas66EoUrRdH2WnxRvTOsEyXom
 1hdO4zbuuXKGXIoOhiS40GHrpdQba6ky5o9KT1UqfqKlDrxxiv5rd/vKSLHHRwy08ZHi
 zFTub/FncQlRxMIHQTx+vsoIT/SK3zxfXO/TM6OeY4Ou+WKIMnETf/JMd3IHIlUCLrbb
 iQlEb6f/Jiau3yK9oewJgh+L8m/Ji5XZHtFcVG7uGcMIefIA5XnQQww1X7+TkITQC69P
 mMR7HLws4j9G+Ygd2Q/HkYfjBddHcFezwi12HkXzxWmlUdzr4TRNc6yNMbjz1InmAxRl
 DB/g==
X-Gm-Message-State: APjAAAXlzvL4yoyK43qz9mw+3B1oD2zTP0YXFqDNIJs7ELCCDwNW0B4K
 XelbIbHrmftUFUOxUQGpg3UGWoTffToZjLgofHLfMQ==
X-Google-Smtp-Source: APXvYqyJUp8eYPKohP61sNQIHSrh9VRnonfobjxh2TYVvVE3IOZu7CCQeiaYe7B2DCGwrIobaWJJ9xClvI7MHVz/MQs=
X-Received: by 2002:a05:6808:8f1:: with SMTP id
 d17mr2831584oic.170.1560429235518; 
 Thu, 13 Jun 2019 05:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190607132521.9637-1-peter.maydell@linaro.org>
 <5eec6321-a6ac-0114-3d21-d45bd806b26b@linux.ibm.com>
In-Reply-To: <5eec6321-a6ac-0114-3d21-d45bd806b26b@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jun 2019 13:33:44 +0100
Message-ID: <CAFEAcA_LY=3CpFXMw=ajjU-g4mE7RUGkMi64g5OLj0PazN1Wcg@mail.gmail.com>
To: Sandipan Das <sandipan@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [RISU PATCH] risu: Include <sys/user.h> on ppc64
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

On Mon, 10 Jun 2019 at 05:25, Sandipan Das <sandipan@linux.ibm.com> wrote:
>
>
>
> On 07/06/19 6:55 PM, Peter Maydell wrote:
> > To build the C parts of risu for ppc64le with recent glibc/kernel
> > headers, we need to include sys/user.h to avoid a compile error,
> > because sys/ucontext.h defines a struct which includes a pointer
> > to 'struct pt_regs' but does not provide a definition of that struct.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> LGTM.
>
> Reviewed-by: Sandipan Das <sandipan@linux.ibm.com>

Thanks; pushed to risu master.

-- PMM


Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30523C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:57:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEB1B2171F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JBmFock1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB1B2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iADzN-0000Lb-1d
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 09:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iADy0-00080f-Eq
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:56:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iADxz-00070a-08
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:56:27 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46696)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iADxy-00070I-RQ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:56:26 -0400
Received: by mail-ot1-x343.google.com with SMTP id g19so3068815otg.13
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 06:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gwnUj7pw1NkDh/+EmcJUoBFPLtfBFys7kTec99iXX7A=;
 b=JBmFock1Jdt75aWsqJyRf2krnkqbDbYNstR34HQerP+/UAi1PjjUyd0AsqLGht/ejb
 7VLgRHAF/ci8eEZKxhDy0ZxuwQUCZg5aN4Fg2mcX5W4UITfddKGrYy8bWiUvBVQ5b2YS
 l6GYAfeP1m62JiW4nbKT4CQqdFPzxqrRfgvSFgVee14osH93Uuzf94m/GjLiormnCGmR
 taHA+Ry+so5M9s0UMmObYYCdw6kbY0CKY8t8fkkLt3iHwjyxhxmCP03I90QV774ouZxb
 RbgHtwceBOqSY5pxehUlNCiJQ99Nt208KlJckj10aFbYCjiafMs2CTD7GXL/Toh/AlXd
 GVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gwnUj7pw1NkDh/+EmcJUoBFPLtfBFys7kTec99iXX7A=;
 b=NRHisbcLR/4fCe00WaBXZCes5XzWerXuGeTgcgeoB4jvOPV6wXVZacq30KZCkNlt17
 qUDYq0I68HsnvTcQq7MrVnG2jG5Wpti84Y+Vyr4fyZVJXE5ayVXuk4tBOZBFm6Dk8r+a
 jxqRIujcl/8QYG9wj2cnwzSyXCudmM1ff9NFitTRoRFBCnwIHHVVxfdG4kAFjT4jwokC
 C4hnTgjdzW+IyxRb2LdWdf6hLSMgTlR5V5oy89kd+8++RtDfS2I29wAhvE3oXkmMknr6
 qFlCFDc42TSy/BE6B9nsE2lu1PY/rKpL10/9VSFcdzifnpROBAh8QOYEuSQwUGUAO0EC
 DYmQ==
X-Gm-Message-State: APjAAAVK0Fd/Dy2nGKkJgSFdzbyJ+bhPEnm681R5ceewcH+fB9zFXcQs
 d7BLh6U2lCyoEWY9BEtR0kpZjmhU36WqlxLdgpeoXg==
X-Google-Smtp-Source: APXvYqzZe2LXAnHGhaSoqPEnnAGcdSg1/fiBa5pWJaXSWTFzw0B1g6Yd9LKhoHILLFl9edBsnMH5HPNBlqMzmNaSLC4=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr2876663oti.135.1568728585786; 
 Tue, 17 Sep 2019 06:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190801183012.17564-1-peter.maydell@linaro.org>
 <25efcf4b-8b34-11a0-a6d5-992b363ce474@ilande.co.uk>
In-Reply-To: <25efcf4b-8b34-11a0-a6d5-992b363ce474@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Sep 2019 14:56:14 +0100
Message-ID: <CAFEAcA9JAjv7f1f-=dgjw_7=iB+cr7L3yy7kDXbdECZCdep_ag@mail.gmail.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 0/7] target/sparc: Convert to
 do_transaction_failed hook
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Sep 2019 at 15:34, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> On 01/08/2019 19:30, Peter Maydell wrote:
>
> > This patchset converts the SPARC target away from the old
> > broken do_unassigned_access hook to the new (added in 2017...)
> > do_transaction_failed hook. In the process it fixes a number
> > of bugs in corner cases.

> > Peter Maydell (7):
> >   target/sparc: Factor out the body of sparc_cpu_unassigned_access()
> >   target/sparc: Check for transaction failures in MMU passthrough ASIs
> >   target/sparc: Check for transaction failures in MXCC stream ASI
> >     accesses
> >   target/sparc: Correctly handle bus errors in page table walks
> >   target/sparc: Handle bus errors in mmu_probe()
> >   target/sparc: Remove unused ldl_phys from dump_mmu()
> >   target/sparc: Switch to do_transaction_failed() hook
> >
> >  target/sparc/cpu.h         |   8 +-
> >  target/sparc/cpu.c         |   2 +-
> >  target/sparc/ldst_helper.c | 319 +++++++++++++++++++++----------------
> >  target/sparc/mmu_helper.c  |  57 +++++--
> >  4 files changed, 238 insertions(+), 148 deletions(-)
>
> I've just run this through my SPARC test images with a fairly recent git master and I
> don't see any obvious regressions so:
>
> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>
> Thanks for taking the time to do the conversion for the SPARC target.

Thanks; I've applied the patchset to master.

-- PMM


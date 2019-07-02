Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865B2C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:18:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E0652173E
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VctiGbQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E0652173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiAF2-00044N-CU
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 00:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38186)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <hongbo.zhang@linaro.org>) id 1hi9sK-00068O-O8
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 23:54:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hongbo.zhang@linaro.org>) id 1hi9sD-0005hL-T3
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 23:54:32 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:43602)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
 id 1hi9sA-0005cM-LF
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 23:54:27 -0400
Received: by mail-io1-xd44.google.com with SMTP id k20so7523768ios.10
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 20:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BDB86Swjy48bE1QiXzS97ztQck+19KlDd21qPLXR9cY=;
 b=VctiGbQMHae4VvlV/dV9npuskMfT7KLLe2AeZBhbxahAjAIVG5WhNFLGIJ4fx+/v4M
 OSL33gzt9yycV9VoVK+niWDEc9ar+/itaoNYgnpHWbP+XEWMFy9H0z8sAgKwhOlue0iN
 62kHjvDSmtbi0SmDNgG8l2sPx6/st9v6if2/oriovIQ5G/nGdP/maMdvs5nsagqZVFYD
 HuKs3TMV1OoPnJjOcUCUZPEL39HOIPN/HbhCT7jGgCXQmtCtOmjIj+jv2IGfDJgk2Cpt
 W6/lmQ8fYW636S72yIbCTJaBPhkQjMuR/3QNc4ESRqPRvXPSsvDmTrsYgQcn/O0XTKJH
 ue8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BDB86Swjy48bE1QiXzS97ztQck+19KlDd21qPLXR9cY=;
 b=dpWH+AtTQTpQ4sG4Vfb+YEv3mFPUO2K3pCfXpuwYKVOanDwfIGXS0U1xagj9ixCRSR
 E7G8P2ZgecPcVIottiL+pdGIIvvEu+gO5gdxAIbi4MiZdj7UtzCr3OfzY4xtSdp5v73P
 Oa2IitbCH3tKLCYGRau1lW2oySYTpczPFcJFOkZtz3pLldJEl9QpE3cZGedI79HDQCwC
 +tdLTnKIQxExxzo7w4ZgmyskrC0kGSxqXxMwJc6wywnbzBU4qf/qWQ5dGSbtqZ9vwhNj
 eHMYZ1+euSTUwJMJY+5SYS2pN/yqhF5c1xVUu9hFeIKz83DlbLARcJTOwgROQLrYTHhP
 CoKA==
X-Gm-Message-State: APjAAAUBQDoHD1yVGTqsjKMYE4L1wkKdzxDWXR38qDUukS7or8bDkkKi
 xuPUQtL8VJzigCCYpV5NsoECdgeTbQMcKDcn/BxHZQ==
X-Google-Smtp-Source: APXvYqzXSmVkg7tHbl2Jo2mE+2m+ZBFUMQwxizQkAH33nIrokhWHG5O+lQ7/gJZ6S8H5tWQiSCg4PkqyyvPMS5clvbY=
X-Received: by 2002:a05:6638:3d3:: with SMTP id
 r19mr33913878jaq.53.1562039663430; 
 Mon, 01 Jul 2019 20:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <1561890034-15921-1-git-send-email-hongbo.zhang@linaro.org>
 <CAFEAcA8P-=mbQ4__9OXB078GnrGfm9afH1YBDLkv88mUXmm=PQ@mail.gmail.com>
 <20190701160846.fwjeco3zuobn3pgv@bivouac.eciton.net>
In-Reply-To: <20190701160846.fwjeco3zuobn3pgv@bivouac.eciton.net>
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Tue, 2 Jul 2019 11:54:13 +0800
Message-ID: <CAHmQWvDhRHqR2ZWJj5DdJUaqf118E-83mvpK3gn0P35eQpLBJA@mail.gmail.com>
To: Leif Lindholm <leif.lindholm@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
Subject: Re: [Qemu-devel] [PATCH v9 0/2] Add Arm SBSA Reference Machine
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2 Jul 2019 at 00:08, Leif Lindholm <leif.lindholm@linaro.org> wrote:
>
> Hi Peter,
>
> On Mon, Jul 01, 2019 at 03:54:24PM +0100, Peter Maydell wrote:
> > I've pointed out a number of issues with these patches, but they
> > all turn out to be very minor (mostly fixable by moving code between
> > patch 1 and 2). The other thing we need is a MAINTAINERS section for
> > the new board:
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index cad58b94879..0bf3739f06a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -728,6 +728,13 @@ F: include/hw/arm/fsl-imx6.h
> >  F: include/hw/misc/imx6_*.h
> >  F: include/hw/ssi/imx_spi.h
> >
> > +SBSA-REF
> > +M: Hongbo Zhang <hongbo.zhang@linaro.org>
> > +M: Peter Maydell <peter.maydell@linaro.org>
> > +L: qemu-arm@nongnu.org
> > +S: Maintained
> > +F: hw/arm/sbsa-ref.c
> > +
>
> Sadly, Hongbo is no longer in Linaro (but has generously helped keep
> working on this platform being upstreamed since he left). It is my
> understanding that in his new role, Hongbo does not have the bandwidth
> to keep maintaining this platform once it's in.
>
> Unless I have misunderstood this (Hongbo, please confirm - we would
> certainly love to have your help if you feel that you do have the
> banwidth), could we please add Radek as a maintainer instead?:
>
Yes we can add Radoslaw as maintainer.
As to me, my new role still have relation with Arm and virtualization,
I will keep watching this :)

> M: Radoslaw Biernacki <radoslaw.biernacki@linaro.org>
>
> If you think it could be useful, feel free to add me as a designated
> reviewer:
>
> R: Leif Lindholm <leif.lindholm@linaro.org>
>
> (I would not be offended if you don't, I have plenty to keep me busy :)
>
> >  Sharp SL-5500 (Collie) PDA
> >  M: Peter Maydell <peter.maydell@linaro.org>
> >  L: qemu-arm@nongnu.org
> >
> >
> > So rather than making you do another respin, I'm planning to
> > make the fixes in my target-arm.next tree as I apply the patches.
> > That way we can get this in before softfreeze (which is tomorrow).
>
> Many thanks!
>
> Best Regards,
>
> Leif


Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38194C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 18:27:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03AA2206DB
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 18:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vtP0Ln4Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03AA2206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5D1M-0004Xo-4H
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 13:27:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j5D0c-00042O-ML
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 13:26:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j5D0b-00085y-EH
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 13:26:42 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37444)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j5D0b-00083w-9K
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 13:26:41 -0500
Received: by mail-ot1-x344.google.com with SMTP id b3so2872825otp.4
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 10:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=C5ys/ojIpnhOOyS0/vcCaJX7EerT++OfA+UGm07Sgpc=;
 b=vtP0Ln4QiD3c70Z23ngFcevCTiSwPHH+Ba6M6T4t2GdMz/YXf+hCh9mIj2XAHwqd32
 pZ+yLxVVQJPPu0kJ5jKmtiACVaEKQfqk3r8FiU7XNA3JhYKtpTTwcYpQaIDdVbGJtJBs
 zbRscuLqXdGXNyPGK36IBIn1gpZx11sxwF9a3xyl8z4XizhQW4rrLKD+q+mS25dBt9Js
 GdEIc0/YC95sL4jNGVww6DcL+MVpdsLE2xTVGjqAp0Az/ejx4InX6fPQr6nRLmelPAWs
 bJymtV/7o6l7GgpC2QeYNQqCp05eMbPKU3KYU5iKmsUBDYb8D1hgfQvSh1BNx/jKcchp
 8qSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=C5ys/ojIpnhOOyS0/vcCaJX7EerT++OfA+UGm07Sgpc=;
 b=pAecgDdbR1scU593mihZ8/b8fn6nUNQSMBmTUtnMi2CDpjubz559Jgs8XLDbJ6Ms33
 wnxh+wBUXqfdH+KwNaAgqujT1Xn9WyEYcr2XjB2f0aBsVyDPRkoZBsHMgVs/cRhrwa5u
 YV/9fFtgfNOH8MHv83g6kihcFavQjc1n1X3b0rODoOBkXKTrYm1pp2HdcFU384DeXjiQ
 dzON3d2IBsly1WbmAQPt6rqIS8J0WZYYuvczl2TzeWRcu5hl1QuOv0bN6VfSUybSfAgE
 asEs3FRakQXqlpQnqB/D7XgruGFszJwz+h7Fv9IFHZO52XR90QNKqBTKRmgL9fsvjf/D
 DlkQ==
X-Gm-Message-State: APjAAAVsIOYKaqGpfUSY1Hiy/7ttzCE8v+p1LPa8SSFQGsXIrFfAOwTV
 tJk1p015a57qDBdmCfKFhRvg0RmmwEJLBGnqwqeFmw==
X-Google-Smtp-Source: APXvYqwezU28/Hjz0OhiwwEr+ygF8SULAWwvcDwuKvisX+LaRBZ5QKa5Ptp8WCecpHYi/oj+v0VzScRnc0mixm2ws/I=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr27437259otq.97.1582309597917; 
 Fri, 21 Feb 2020 10:26:37 -0800 (PST)
MIME-Version: 1.0
References: <20200218171702.979F074637D@zero.eik.bme.hu>
 <d9d4fba7-2dcf-8f09-8f3a-7e0408c297b6@linaro.org>
 <alpine.BSF.2.22.395.2002211643480.45267@zero.eik.bme.hu>
 <CAFEAcA-teH7KXACL=5m0-X+g692EXKtqOy9d_uGjw6XA8S3vzA@mail.gmail.com>
 <alpine.BSF.2.22.395.2002211807380.69986@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.22.395.2002211807380.69986@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2020 18:26:26 +0000
Message-ID: <CAFEAcA9-VzUXij1_vFr+d7KuMOw+Tdv0hvxW2WmfGxt=fAKvjg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
 John Arbuckle <programmingkidx@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paul Clarke <pc@us.ibm.com>, Howard Spoelstra <hsp.cat7@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 21 Feb 2020 at 18:04, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> On Fri, 21 Feb 2020, Peter Maydell wrote:
> > I think that is the wrong approach. Enabling use of the host
> > FPU should not affect the accuracy of the emulation, which
> > should remain bitwise-correct. We should only be using the
> > host FPU to the extent that we can do that without discarding
> > accuracy. As far as I'm aware that's how the hardfloat support
> > for other guest CPUs that use it works.
>
> I don't know of a better approach. Please see section 4.2.2 Floating-Point
> Status and Control Register on page 124 in this document:
>
> https://openpowerfoundation.org/?resource_lib=power-isa-version-3-0
>
> especially the definition of the FR and FI bits and tell me how can we
> emulate these accurately and use host FPU.

I don't know much about PPC, but if you can't emulate the
guest architecture accurately with the host FPU, then
don't use the host FPU. We used to have a kind of 'hardfloat'
support that was fast but inaccurate, but it was a mess
because it meant that most guest code sort of worked but
some guest code would confusingly misbehave. Deliberately
not correctly emulating the guest CPU/FPU behaviour is not
something I want us to return to.

You're right that sometimes you can't get both speed
and accuracy; other emulators (and especially ones
which are trying to emulate games consoles) may choose
to prefer speed over accuracy. For QEMU we prefer to
choose accuracy over speed in this area.

thanks
-- PMM


Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C886C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 13:21:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 292F42073F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 13:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rb2FJlEr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292F42073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZama-0008Q1-Al
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 08:21:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37799)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iZalP-0007ns-Tn
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 08:20:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iZalN-0001H1-B2
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 08:20:19 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37313)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iZalF-00015J-Gz
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 08:20:10 -0500
Received: by mail-oi1-x243.google.com with SMTP id 128so8526644oih.4
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 05:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FmLdze7rjZ7eUQLNaj/JqouP8Z3PE4LkshvPw0U7Xmk=;
 b=Rb2FJlEr5v765PTffoOINl1/JdqTH3GRaQboSArUxvPz2AQAtoN80vo1PzO2q3BrUJ
 IjwYGTLWeiCsyOHbvyqXuntxegbsaTYVP00/WmFNLEf0AuFg1Bh/8Bu5NwIOAofVk453
 rM5F5AsfZ/IBnM6RObjdUS4uYmA5tcK6LxVQgS0myypuzog9wt+qwnJ+NEiP6ZbcQBP0
 xpLrTDQ3SLTKoxm5S2VFPExdE15yvg0rwythf+ct8M3v++wBjaELgSY8009LGnd1Y80c
 KPUWqfb3r/EpEFvCPbaRa4DlP9Y241zCfzkCFZz/yWd/DkMXXIikj8pEPLC4DFT2AOyf
 yhyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FmLdze7rjZ7eUQLNaj/JqouP8Z3PE4LkshvPw0U7Xmk=;
 b=FDFL7gBkZ02IPL5hAZu4re+KK4XK81zXOS2B8QBSkmj1ADETUaiq83PC+c1HfxrP9H
 yDemRzHcLa88YZW58rAPYqIz+aogXqciTfZ71bLYBmqbZuJT6GW5jpuXP0gLg4KI+Ov3
 F28eC+/jg2QSnpoNpRR4YniJOIrtTox2t2Pz8psdRj9fpR1rFjOCdN4h0qUEfa3VLEuN
 7PiqlCiuJ5xVHJzosKXRT4LN3hN7wQtTDiCBCfYRy17JXt2+8dA/snr0fZaQpzhecIoZ
 Nb0IMlYARwFJRBW4sgvBUO9YYggnM1sBZLXFQYaq3tyXj5ahIt2cvtn2qHpOv2gXYUVc
 zuCA==
X-Gm-Message-State: APjAAAXeHstk5oHmGG6mnI+qVUVhToOi7kB5srlRO15IoZhNt/8KdFRM
 e0XSLmCT5+DeGbtLtafmgPw9JsDv6kyblDTbnyb1xA==
X-Google-Smtp-Source: APXvYqwAsUV5d4EQeOYGEEE0nq0UKrxnuMO/LdK4L37drDmsPvsJnlRMz0KwnwoxY5/QR+hy3ZBWRFuMReSfrT2ND0U=
X-Received: by 2002:a05:6808:8c2:: with SMTP id
 k2mr1740810oij.163.1574774405542; 
 Tue, 26 Nov 2019 05:20:05 -0800 (PST)
MIME-Version: 1.0
References: <20191123115618.29230-1-maz@kernel.org>
 <8f112583-c29c-11e2-c023-f4eb13831894@linaro.org>
In-Reply-To: <8f112583-c29c-11e2-c023-f4eb13831894@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Nov 2019 13:19:54 +0000
Message-ID: <CAFEAcA8LzPyvav_Ycsq_wRv6Joemt881XBB7rUEu4Sw97WUNGg@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Honor HCR_EL2.TID3 trapping requirements
To: Richard Henderson <richard.henderson@linaro.org>
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
Cc: Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
 QEMU Developers <qemu-devel@nongnu.org>, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 26 Nov 2019 at 10:12, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/23/19 11:56 AM, Marc Zyngier wrote:
> > +static CPAccessResult access_aa64idreg(CPUARMState *env, const ARMCPRegInfo *ri,
> > +                                       bool isread)
> > +{
> > +    if ((arm_current_el(env) < 2) && (arm_hcr_el2_eff(env) & HCR_TID3)) {
> > +        return CP_ACCESS_TRAP_EL2;
> > +    }
> > +
> > +    return CP_ACCESS_OK;
> > +}
> > +
>
> The only thing I would suggest is to call this access_aa64_tid3, because
> tid{0,1,2} also need to be handled in a similar way, and we'll need little
> helper functions for those too.

Good idea, I will make that change also.

-- PMM


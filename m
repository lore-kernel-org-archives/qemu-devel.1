Return-Path: <SRS0=wjfX=SQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345C6C10F13
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 18:12:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01B9520896
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 18:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yEcejka2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B9520896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38584 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFjbp-0006zb-3s
	for qemu-devel@archiver.kernel.org; Sun, 14 Apr 2019 14:12:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hFjaF-0005GC-28
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 14:10:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hFjSj-0004ez-2N
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 14:02:41 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:43798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hFjSi-0004df-Pz
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 14:02:41 -0400
Received: by mail-oi1-x230.google.com with SMTP id t81so11932102oig.10
	for <qemu-devel@nongnu.org>; Sun, 14 Apr 2019 11:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=nO8LYFE/9Hx6rjyYRhGcmZvZ1Aqm8Idj6Hf2lG+zelM=;
	b=yEcejka2gfqFklKrGw/elQHiXiq3/LxcAuF8Pvl2RSg4EV9+d2sVqamdqlFddHpc9y
	bZ7t51GJqJIlPz5zQSbgOFzYkgKcHWZpEyN86wh6H2rharrzfJ9k+HZYP/NO8rokPB9F
	AX8voPLo9AmwJDswnjrWn5dUWhipCWcfaqwVQHcg7evnygAWSzGxY0cAiXCLG9gT0baP
	faCGEVwdKGCcrUL3ABMPf9Txueyoau1gjj+44Vx1AvzeoNsdCbj33thw30xccxEcYyQt
	8FlOTVrme/Av6F2XrPHD97j3RAYWjD4HmwoDCMT+LMvR/TFUf7IMHZ1WixFlCvgctcQn
	lgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=nO8LYFE/9Hx6rjyYRhGcmZvZ1Aqm8Idj6Hf2lG+zelM=;
	b=GJkQpmwbyjeUcpxID+dKKm7kqyz8hkzc4xeY/0Cb8HBuaZwHDQuzW7dUA82M8JyN3L
	98aZ8bEPDBbTrEjQtLX9IPaabEPD6d6XZhIu+AzSyJ14cDKkpjjNjymV+OPd7z2K5yB0
	b0KmWygGI5y+08R21/+BMP6h9N2LrMd5AFgHvO9u+jQKrfhzYdTBl31IF/msnzrb1F9k
	s3zb7w0nC4ZfKLSluh51toAI22wdsy9RVeDtFKUg+BBNoHVCPjgmmn+qQlImxGPYJZTh
	5fEbn0Q01kF7Y9f5hFNSB6aYS78PTZW3Zin0fO20kJywwRTX3sAZ8GMTcRV03mf+txY5
	/AvQ==
X-Gm-Message-State: APjAAAU/LE8Qazs+2WjI9ciRcVuIKcr3qYB9uzgmnb566gLOhsULWvJw
	reMNPKDbi5fy/OGdmmK7pdymvXW4eXPQFppN4LI+dA==
X-Google-Smtp-Source: APXvYqwA0JVZ8kk3iXAK8ibx5AYYsK60KJWPAe6D/89B16hEV7P0/XFfOLqN8s44mWu52rfBvy/WbNji6E4WZvbcVYM=
X-Received: by 2002:aca:c7d3:: with SMTP id x202mr15582972oif.48.1555264959131;
	Sun, 14 Apr 2019 11:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190411153942.4533-1-peter.maydell@linaro.org>
	<53930e87-3bb1-fdd5-a8fe-8603c0adecc2@linaro.org>
In-Reply-To: <53930e87-3bb1-fdd5-a8fe-8603c0adecc2@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 14 Apr 2019 19:02:28 +0100
Message-ID:
 <CAFEAcA-dbGvhgTrBKEtx-CPS7f2NJO5X+dj=mdcm+NrkF=uynQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::230
Subject: Re: [Qemu-devel] [PATCH] target/arm: Implement NSACR gating of
 floating point
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190414180228.VMsta31EawtyeQ7L7eyogo1Sz0sRMw34e41QIg4X-CQ@z>

On Sat, 13 Apr 2019 at 08:07, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/11/19 5:39 AM, Peter Maydell wrote:
> > +static uint64_t cptr_el2_read(CPUARMState *env, const ARMCPRegInfo *ri)
> > +{
> > +    /*
> > +     * For A-profile AArch32 EL3, if NSACR.CP10
> > +     * is 0 then HCPTR.{TCP11,TCP10} ignore writes and read as 1.
> > +     */
> > +    uint64_t value = env->cp15.cptr_el[2];
> > +
> > +    if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
> > +        !arm_is_secure(env) && !extract32(env->cp15.nsacr, 10, 1)) {
> > +        value &= ~(0x3 << 10);
>
> Read as 1, and yet you're clearing the value?  Cut-n-paste error from CPACR?
> Surely better to do nothing on read, but set on write (to either HCPTR or NSACR).

The spec says the HCPTR bits must "behave as RAO/WI, regardless of
their actual value", which I interpret as being 'we must make
read and write do RAO/WI but preserve whatever the underlying
bit values happen to be'. You're right that I've incorrectly
made it clear the bits rather than set them, though.

> > +static uint64_t cpacr_read(CPUARMState *env, const ARMCPRegInfo *ri)
> > +{
> > +    /*
> > +     * For A-profile AArch32 EL3 (but not M-profile secure mode), if NSACR.CP10
> > +     * is 0 then CPACR.{CP11,CP10} ignore writes and read as 0b00.
> > +     */
> > +    uint64_t value = env->cp15.cpacr_el1;
> > +
> > +    if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
> > +        !arm_is_secure(env) && !extract32(env->cp15.nsacr, 10, 1)) {
> > +        value &= ~(0xf << 20);
> > +    }
>
> This one does do the right thing, but better to clear the bits on write to
> NSACR.  This lets you avoid the change to fp_exception_el, and the missing
> change to sve_exception_el.

There's similar wording for the effect of NSACR on CPACR, so
again I think we need to actually make the bits RAZ/WI
regardless of their underlying value, not just force them
to 0.

thanks
-- PMM


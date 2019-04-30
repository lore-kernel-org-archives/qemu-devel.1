Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2DFC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 18:18:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B5B020854
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 18:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbkE8FAe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5B020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51480 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLXKM-0004Xb-LA
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 14:18:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hLXGn-00028Y-Jy
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:14:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hLXGm-0007cG-IP
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:14:21 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:35691)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1hLXGm-0007c8-EF
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:14:20 -0400
Received: by mail-yw1-xc42.google.com with SMTP id n188so4014133ywe.2
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 11:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=OF++BaEMEJ5gY6r5y6fed/DGSTPbm2jtOVugo40BZDo=;
	b=XbkE8FAeeKuLgGflxTdofRTFFHGZmFZoMaXSf+CkLdCr8Y0rRl/FaHR6HiCFI2pg/q
	sCvcVmDE62J4RcyWYx7aVArxaiyundNkkqdKbTsou6B0ENbACxgNqZFntT3m4ohycmbZ
	39ZZZ5LgGlbXE79USd1tmNnGAWzxdKJO6aChITZ0/xtkNBsu2n4KeHaE7VIMoeBOmoH7
	wZ2LTf/rf+f6gip6J3vQsnQYbeJcjOAan8aTEb0cB3Yp/ulrHD0RzmcmrMsuHHiq3i3V
	9uH2FSPG8zDHcXjpZ9LYGIar3Vk6bDsQEOCwyIKuvKO9lcSZ/9Bg5RLQNxTrBh4lvkU8
	Eq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=OF++BaEMEJ5gY6r5y6fed/DGSTPbm2jtOVugo40BZDo=;
	b=s7XNAuinkAzxH/BWuEO3DxHjiEOxFC2g452b0MdFbTG0VTNbVi2mcY0xSAKByCAt8p
	KTAF1QUxtvN862V23XHe6mjRfobBtlpdYCv9DdJeXPYJkHLYBxy+j7aJ71NLUrQFLvjx
	q3ESh9o7QGWMbh130hFP30UJ0p5SBMI8ShOeuqlf5ziyhzaYxt+xiE2eWtjjmtbs5KdW
	QaDrEn8gijEPf+LYcU0RfuOPlivtSLLnVGa3d86LvV13lK6D5WPsk1cxqutoptlBTwFU
	29gTkIx6o7PfAn2ZGWbhqM3QmW7Y1x36MEgVCF/FNP8AqDdjzS8Ca1RCq9HSxvS7kGhz
	LCgg==
X-Gm-Message-State: APjAAAUtWoMzOTCMzGl1YT/H1l0PsGljMhBshK/jTDMhzLxDr2LhStr/
	bXWC3I/ak0AcbQ+IoAjQuVpkpSEdNQfGVyvOgQo=
X-Google-Smtp-Source: APXvYqwIQH4msqJ31+JMY7CqnpYTJwBJDthAJwMp4cDmbEAm/xQdeoy85lWhEaGjc+HDQHD4862jte7bajZYex4P2t4=
X-Received: by 2002:a81:a38a:: with SMTP id
	a132mr12625978ywh.126.1556648059890; 
	Tue, 30 Apr 2019 11:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-24-richard.henderson@linaro.org>
	<CAFEAcA_FZHKXJHg4819JOZkwwhE44Vx874GKrnxRrOau1HhzRw@mail.gmail.com>
	<CAMo8BfJVdDvYWEdN_08ed5OKBGXc+U8kSbmWaSWY9WCuvDj2pw@mail.gmail.com>
	<bd57c22c-1bdc-80b4-0415-565117f6ae3e@linaro.org>
In-Reply-To: <bd57c22c-1bdc-80b4-0415-565117f6ae3e@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 30 Apr 2019 11:14:08 -0700
Message-ID:
 <CAMo8BfJsC9aPYUhi5Rg6SAXT4dhaZaU=dqy=um+aBJtnPMSwdA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c42
Subject: Re: [Qemu-devel] [PATCH 23/26] target/xtensa: Convert to
 CPUClass::tlb_fill
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430181408.y-ByxqIuJ_eHMbal67PG_Bhds6zV9fAqbwfPKTUVs3E@z>

On Tue, Apr 30, 2019 at 10:44 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 4/30/19 10:32 AM, Max Filippov wrote:
> > On Tue, Apr 30, 2019 at 3:11 AM Peter Maydell <peter.maydell@linaro.org> wrote:
> >> ...but now we'll set it to whatever exception_cause_vaddr does,
> >> which is something more complicated based on the state of
> >> env->sregs[PS].
> >>
> >> We'll also end up setting env->sregs[PS] bits and env->pc, which
> >> the old code did not. (In particular since we set the PS_EXCM bit,
> >> the second time we take an exception won't we then end up
> >> setting exception_index to EXC_DOUBLE, not EXC_USER ?)
> >
> > I guess it doesn't matter, because linux-user userspace never handles
> > exceptions. PS, PC and similar must be fixed up by the linux-user
> > exception handler. But I haven't tested it.
>
> It does handle exceptions, in linux-user/xtensa/cpu_loop.c.
> And Peter's right that I should have kept EXC_USER.

PC must also either be preserved or restored from the EPC1
in the cpu_loop for the SYSCALL_CAUSE.

> > Richard, is there a branch with this series available somewhere?
> https://github.com/rth7680/qemu/tree/tcg-tlb-fill

Thanks, I'll try it.

-- 
Thanks.
-- Max


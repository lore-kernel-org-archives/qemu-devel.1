Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096B5C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:05:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB00A217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FRVq/0d2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB00A217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47111 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP8xv-0006ln-4n
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 13:05:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP8vB-0004qk-II
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP8vA-0004xR-4K
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:02:57 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:37385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hP8v9-0004vz-Nv
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:02:55 -0400
Received: by mail-oi1-x244.google.com with SMTP id 143so5054083oii.4
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 10:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=Lwb8/s+ZRAgW4o7G5yBzAhEgsy57ve9R3odI5NEksVM=;
	b=FRVq/0d2OWudKcgGt/fwF5FuPlFdT89dGrPZUnody3iSnNZBv+o5ZFOESVtciZgfgN
	CGuLGz1ZorNSTAyugGlJ3uu02tO2UuXe+0oWp2qMBWba0KuqIkh9UYJ7CspS2BUTUlXb
	ttVBt1cxAySrZ6r8B6mI+PYcIyObW0A6GVOvi09CvY2sX897XTfDPrbxHkVuQirgKmFK
	0LvInelV2GTpSvgJL0ylMbAAecq93OsAR3Dl8H3SzkpnfXMv41lW0s8tnMyMKsXj7zHo
	FxvlNpbSNbMOqiu/Uo236d9XoHE/cdXe+iyqbT4D1aHRhoYTqwDHuGYJZ+4sbDwhWnG8
	HoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=Lwb8/s+ZRAgW4o7G5yBzAhEgsy57ve9R3odI5NEksVM=;
	b=Z3rXxOCa7LWVTra5dmjpmIMC6XRRT3NQlyQXIOBJr2klIn72cESzaaVOWz7O6oXSVO
	istt9gaSWA66XTacprVcYE8//zA+6hoOaGX8cjP+BNQkfYlIMYFa96ZinPPjq+HRudvD
	uOJehktgmmzI8ylMMfrW1tW5DLG3UMKVAOnvJJy5ustjVqxQs8nbZkFVTw3gjVMXIGrQ
	XJFfs2+ToiWrFNm9/gOiAOKo0oocgp/CuL6/8jqiJSnt+LsvPHdBFwhuxyxO48LMTqEo
	sfK8r10z9vrjo/kCEeFtAM5HTLalQBttCH+wI1zwbG8uxWkh+Lpr6VYJJQdOWnUTqgIq
	f2gA==
X-Gm-Message-State: APjAAAX5XyzJBkjxjJvkdOWLqEQDMVsJtXAg76Q+gP59RD+KWRMCQl/u
	TQgGmRMEz+We42ELTlj4FoNVRGMVUgnEFRikUmvQcQ==
X-Google-Smtp-Source: APXvYqzWWfDdz5gck8Ho+Ubc7sSSwhCxkNHeGJmSea02sR58JCWLUVlX2SL/OWIV4TdrcCUcLy3oq2FNg8chbbj1qY8=
X-Received: by 2002:aca:110f:: with SMTP id 15mr5833455oir.163.1557507774085; 
	Fri, 10 May 2019 10:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190509165912.10512-1-alex.bennee@linaro.org>
	<20190509165912.10512-6-alex.bennee@linaro.org>
	<CAFEAcA8Dsdp2rnORnzqemWspfFxfhVwkAz=2EXdupo8iDj_=Hw@mail.gmail.com>
	<87tve2b5z2.fsf@zen.linaroharston>
In-Reply-To: <87tve2b5z2.fsf@zen.linaroharston>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 May 2019 18:02:42 +0100
Message-ID: <CAFEAcA9q9n24wZF9nRM=norAK+tPv9LL4LM4-8gwH8F+0D0umw@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v1 05/23] semihosting: enable chardev
 backed output
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 May 2019 at 17:59, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Thu, 9 May 2019 at 17:59, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
> >>
> >> For running system tests we want to be able to re-direct output to a
> >> file like we do with serial output. This does the wiring to allow us
> >> to treat semihosting like just another character output device.
> >>
> >> diff --git a/qemu-options.hx b/qemu-options.hx
> >> index 51802cbb266..6aa3a08c2fb 100644
> >> --- a/qemu-options.hx
> >> +++ b/qemu-options.hx
> >> @@ -3975,12 +3975,12 @@ STEXI
> >>  Enable semihosting mode (ARM, M68K, Xtensa, MIPS, Nios II only).
> >>  ETEXI
> >>  DEF("semihosting-config", HAS_ARG, QEMU_OPTION_semihosting_config,
> >> -    "-semihosting-config [enable=3Don|off][,target=3Dnative|gdb|auto]=
[,arg=3Dstr[,...]]\n" \
> >> +    "-semihosting-config [enable=3Don|off][,target=3Dnative|gdb|auto]=
[,chardev=3Did][,arg=3Dstr[,...]]\n" \
> >>      "                semihosting configuration\n",
> >>  QEMU_ARCH_ARM | QEMU_ARCH_M68K | QEMU_ARCH_XTENSA | QEMU_ARCH_LM32 |
> >>  QEMU_ARCH_MIPS | QEMU_ARCH_NIOS2)
> >
> > As you can see in the docs here, semihosting is supported on
> > five guest architectures, so we should implement this new
> > feature for all of them, not just arm.
>
> As I've introduced this for testing I see no reason not to add support
> for other architectures. However I was hoping this is something that
> could be done organically as other system tests get enabled.

IME transitions done "organically" really means "slowly, and
nobody ever gets round to actually completing them".
Semihosting is a user-facing feature, so if we want to add
the user feature of allowing output to go to a chardev we
should add it properly, I think.

thanks
-- PMM


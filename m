Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B961BC33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 13:33:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F9A2077B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 13:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fB62mJUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F9A2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irinH-0000bk-Ke
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 08:33:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58068)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1irimT-0008Fv-2Q
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 08:32:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1irimQ-0002Mq-Os
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 08:32:20 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:33602)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1irimQ-0002LG-IJ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 08:32:18 -0500
Received: by mail-ot1-x32e.google.com with SMTP id b18so16115891otp.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 05:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/qC7LfI0GU9GYF/RzGSxqWfl63MVN3CJgjG7Md3SD2k=;
 b=fB62mJUGIxCLCfDTEFnx3mFz9+0c/4Ved8CRsFunCjbUcn8PF6iQjeEvN7awubxuYg
 3JGDhZAt9ogdv2zcAMQIM8DZCLM3hwkOUiGQREDb8dR8t4pb6j74XJH5rU03Fihw/VYT
 0TFoqQfgrcCgEzaPa0+kh0nChlzyb6bn9Xto7kkYT2bK04kxljKuC9NwPqD+EBDDUvNl
 mSc6h+exTEgTh/Y8E3wMRshOVSfRR4ghCafDAX7Eh9C/gZovYcBWK2VjvYaLOR2fVWaN
 HKXwDner1+GQB1GlN+rkP8L81A/nGp4pdr6dhZBb/W0mvTOVaClbx0l0VgwqjgBirxk/
 VWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/qC7LfI0GU9GYF/RzGSxqWfl63MVN3CJgjG7Md3SD2k=;
 b=UGJ8JjbuFU161yR8QegAlwKVm+cS4WXIQauYlMm9BU2WXunCIXABicai7BROKus91X
 xFhYvq73rCAzPmWTN+hrds0ySMMtiU9gKNtMxpJ7JLTSwmqxxWG8rEvl2uF43f1+KwXk
 4rZ9WOjYStkek8Qd8n1lKMyoe4sU60qcNPXYbscX+wSdcc3PwiLG90OZAQS9pcNMXsH1
 +iFQTtl2OnZKaauE+OmPygbQJ11TUiDO8g7pU+9kNVLSYYA6fR0qwOYzBZlMIRtHfAXV
 zqcC7JKwbPTV5SUNMfPVh99WyfDfQZfaZ548Y9G2ee5rDx9V8ipJADrEX5rUob/gV6Ti
 dPfg==
X-Gm-Message-State: APjAAAU7eGn8Y6Sv2vL4ajqkdGQ0KtqU//Qo9xWmm8N9dPA/sW9TEgLE
 S6jXUfaszXlsp/6wX0ljeCjrpc9XZ5HIvvQO+S3xAw==
X-Google-Smtp-Source: APXvYqwjaV3uaYdFtLb1OmV40Z+tpi2faV9rWGGcgVvlfd6pscpJAFJs1+9uHWSX6hp8dXNGwT7GrxvUTXij8qaGFrw=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr2782901ota.232.1579095136812; 
 Wed, 15 Jan 2020 05:32:16 -0800 (PST)
MIME-Version: 1.0
References: <11d88b2741eac3f634d5aed9e3355c974b533f7b.camel@kernel.crashing.org>
 <CAFEAcA-A_caQgwi5DzExdZChoTg-Qa73hq7Ho7dPLiN633Yj1Q@mail.gmail.com>
 <3ab2ca1f7a9b37b201a58f3a817edc5193e8b1f4.camel@kernel.crashing.org>
In-Reply-To: <3ab2ca1f7a9b37b201a58f3a817edc5193e8b1f4.camel@kernel.crashing.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Jan 2020 13:32:05 +0000
Message-ID: <CAFEAcA8mphBky9Q2HTdOpQHiizd+5-o=yRnBbd_k1y6Uk-h8dA@mail.gmail.com>
Subject: Re: Semihosting, arm, riscv, ppc and common code
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Keith Packard <keithp@keithp.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 15 Jan 2020 at 01:17, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2020-01-14 at 09:59 +0000, Peter Maydell wrote:
> > Note that semihosting is not a "here's a handy QEMU feature"
> > thing. It's an architecture-specific API and ABI, which should
> > be defined somewhere in a standard external to QEMU.
>
> There is no such standard for powerpc today that I know of.

So you need to write one down somewhere. You're proposing
an ABI which will be implemented by multiple implementors
and used by multiple consumers. That needs a spec, not
just code. I don't want to see more semihosting implementations
added to QEMU that don't have a specification written
down somewhere.

The riscv single paragraph in their arch spec that vaguely
says "works like arm semihosting" is not sufficient detail, incidentally.

> Keith and I are somewhat of a different mind here. From the perspective
> of the user of that API (picolibc is one), it's easier to deal with a
> single one and have everybody inherit the same bugs.
>
> Now I understand the point of wanting to fix the mistakes made but I
> would suggest we do so by proposing extensions to the existing one to
> do so.

The point about the mistakes is that you can't easily fix
them by adding extensions, because the core of the biggest
mistake is "we didn't provide a good way to allow extensions to
be added and probed for by the user". So we had to implement
an ugly and hard to implement mechanism instead. New
architectures could mandate providing the good way from the start
and avoid the painful-to-implement approach entirely.
(I think RISCV has already missed this window of opportunity,
which is a shame.)

thanks
-- PMM


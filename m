Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C836BC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 09:10:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8692020675
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 09:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uhrwDZBG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8692020675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43566 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQTRk-0006cf-Mr
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 05:10:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQTNe-0003UO-GH
	for qemu-devel@nongnu.org; Tue, 14 May 2019 05:05:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQTNd-0005hq-KD
	for qemu-devel@nongnu.org; Tue, 14 May 2019 05:05:50 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hQTNd-0005f1-8o
	for qemu-devel@nongnu.org; Tue, 14 May 2019 05:05:49 -0400
Received: by mail-oi1-x241.google.com with SMTP id a132so11564199oib.2
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 02:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=lQfHjVoUdY/Zjg/bbAHFtmht1fdfMgXRH2qGBcHEpvE=;
	b=uhrwDZBG2gHuinTkNp5th8+X9YKd+maFSk1QWjRg8oIF9ayjx6qo180vgykJO9XhEJ
	Bs1IxYz/uwYP0J0p97H6tAcwNxBilEleALrmcGlJ1j10l+e2iGQMzeeuZJ2uGA48ceCt
	F7RKo0P8VlQXkIDTUcqX6BeU8tY8Rc/xhPIVtNJEUvCyYv0yEON8po3/PgbI076Sg8ec
	9SKLI+56yaxXQyHpJUSKTXqzdBa2qbCGVcycVanwH/lenyDP2QBlnBHMpgEQKsV6X1mv
	7ILPnrKdPwB1KaXn+ZQZ/iPgpsIIAZOgsg/neUFlnSddqrvirfmJ/3vo+vJC1+9BXB3I
	s7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=lQfHjVoUdY/Zjg/bbAHFtmht1fdfMgXRH2qGBcHEpvE=;
	b=O6WnlevTchu7JZGWrFALx/Pko+WRXk8wPBK99r9fcY21FSYuqurTVcX7HV+F3a30mG
	71nJ3tIxx2tR1U8PNOr8WBCrtJ17morw8DSLvJObElju7cUuz/nMs2Yg07ksLo8og9kL
	7AEOt+zAanCR1KeqGrHbbh4BuxH2u/Yukay7YGSvdoH1z4PjKdhpJSzM86GGdQfIueZU
	xTQTljxh6aBHLFwcSSyKPmjbQxIZMiK+aboGW3Z9f+dZs6NgjfoVF1RY8luj6L86okaC
	DvCI94fyC6+Yqkdbh5CnXgPl9VL+X8Q7Spnusi5Wm2VRQg1cS8t09/2E+YicN4yfysXD
	3qSQ==
X-Gm-Message-State: APjAAAUyEdA3C1HoE6iWJ0giKoWNr2Y3MnV3aPzaC8uhsrLbAOwP8P+j
	Br0mauaksSi2c2yVC3Jp2veJ2lvxkpu+f3ttz9w5DQ==
X-Google-Smtp-Source: APXvYqytDZ/5esP1ofaBsoAxcYWiw+cbSIns04Do8eZn5fnClWYK7A4LMT9RHXqGU2LrK5GIWnzx/HxP5LJSS+BsZfo=
X-Received: by 2002:aca:4e42:: with SMTP id c63mr2265638oib.170.1557824747870; 
	Tue, 14 May 2019 02:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190512083624.8916-1-drjones@redhat.com>
	<fa220ee2-b4bc-cdfa-ddde-90206e417cf3@linaro.org>
In-Reply-To: <fa220ee2-b4bc-cdfa-ddde-90206e417cf3@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 May 2019 10:05:36 +0100
Message-ID: <CAFEAcA96qUkfW1nHxm4U4S8z6B_87E=ZZfyXTgD3r=CVeyJGOg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH 00/13] target/arm/kvm: enable SVE in guests
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
Cc: Andrew Jones <drjones@redhat.com>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
	Andrea Bolognani <abologna@redhat.com>, Dave P Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 May 2019 at 19:46, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/12/19 1:36 AM, Andrew Jones wrote:
> >    CPU type | accel | sve-max-vq | sve-vls-map
> >    -------------------------------------------
> >  1)     max | tcg   |  $MAX_VQ   |  $VLS_MAP
> >  2)     max | kvm   |  $MAX_VQ   |  $VLS_MAP
> >  3)    host | kvm   |  N/A       |  $VLS_MAP
>
> This doesn't seem right.  Why is -cpu host not whatever the host supports?  It
> certainly has been so far.  I really don't see how -cpu max makes any sense for
> kvm.

The point of '-cpu max' is that it works and gives you the
best thing QEMU can support regardless of what accelerator
is in use. This means that you don't need to do tedious
workarounds like "if KVM then -cpu host else -cpu somethingelse".

thanks
-- PMM


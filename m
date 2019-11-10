Return-Path: <SRS0=zNqU=ZC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DAAC43331
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2019 14:34:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C424E2080F
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2019 14:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oM1baNib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C424E2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iToIe-0000H1-07
	for qemu-devel@archiver.kernel.org; Sun, 10 Nov 2019 09:34:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iToHp-0008HR-T0
 for qemu-devel@nongnu.org; Sun, 10 Nov 2019 09:33:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iToHo-0005r2-Gz
 for qemu-devel@nongnu.org; Sun, 10 Nov 2019 09:33:53 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:43310)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iToHo-0005qs-B2
 for qemu-devel@nongnu.org; Sun, 10 Nov 2019 09:33:52 -0500
Received: by mail-oi1-x229.google.com with SMTP id l20so9326059oie.10
 for <qemu-devel@nongnu.org>; Sun, 10 Nov 2019 06:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GnS3rUcrvpkTWlmlofkc+/efjwoJj0HfQBba+64Xmro=;
 b=oM1baNibQ3438q2fJGUt9ZvmPRtOnjqP/+GwK3igCqT0/fIhf/PVLQ6JvnIhXplAf6
 DFuGtcCIeQAQf1oY5WkNWreaYyJ1m338zRA5M2zj4x7pKqcHUYthALknkFAK3+2KQ42l
 0dalNwXpSBHYx7TOnF1gRkrK65EKk6qxb1LWN571kIlZTM1GdZFxOCA/5eMwsU9/2fsC
 iLdF1dU5SgnpH+DElBpEAUmSUmMsfNraNQDmLun0nQtLuck/vuxOXgb6Ygun7LwqrY6S
 4W3xxoO/9vC7txpBggjtS7AjK5hcls5hodFkR8TYXEG1DmSAL1BYJ6x/lY8dvlncgfeF
 eiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GnS3rUcrvpkTWlmlofkc+/efjwoJj0HfQBba+64Xmro=;
 b=NHmJsHpaYN0v6iZAJ+dWUNLaFiMaKKNmMnUfGaN7oK50uqlWttTzXF/5Cifj6mzdqJ
 R+V6i8SUxeYOJaIOa4WJVp3qT0DdR9kOVQsE1n/qhMlOR5F4u2et9rWQlhY1Oks1+o0K
 70ulQYslJk2evceD20tZIqtVLhIgi9cEtJOzgLi6uM/oGsOnRolfXoIY59F/ZJjYn6RT
 HzitUomuini9F2HKYp/xDcMWok8c9kmOyBEp+h6Pe1QX15z4EsgrwWwsdjaqJKLkjsaz
 lOdkqgfHw4QA+BxHz3UI37c2asrSFmk/bv7gSnvYacaeYoCLy/mKp7EqQ5ayA6HHjg7l
 9OeQ==
X-Gm-Message-State: APjAAAVZY1E1QNDU6H7OeuePYtWi0HI5dToK4aClEq8/eDj4KUa7CKwD
 9bbEiUUHftDgwlZSUTSi2awXK+2PI9WNrLztv0x9ew==
X-Google-Smtp-Source: APXvYqzNZmFPtRfjV8Ki0zKNQnGIeSfKKmMss1S1C0/+fQjuERhVF26qCklzIbO4j2NSDZskQM2fWve0aczG16Z5PX4=
X-Received: by 2002:aca:cf12:: with SMTP id f18mr19068344oig.48.1573396430680; 
 Sun, 10 Nov 2019 06:33:50 -0800 (PST)
MIME-Version: 1.0
References: <f5a16b3c-2c17-60e4-e80b-dd20b3c088cc@cs.utexas.edu>
 <CAL1e-=g8c=QJiMm1AvBCNmsTyVWoUAjL0na2HWodHCQPiLdWJw@mail.gmail.com>
 <CAL1e-=j8K+FKj=4pTd8HKkL-D=F+9hY+5bF4ibM8WE+Sp+pk=Q@mail.gmail.com>
 <f300806f-ced2-5926-40ff-4cdd29c5078e@cs.utexas.edu>
 <CAL1e-=hcS8_2Y1YJS01GTwFbMYBJmWopYkSDi_aw6yzOHk=3Lg@mail.gmail.com>
 <CAFEAcA-tNBNGE75+MZ3+r_9iLA-_3+meoseVxhgzJZ5PvDofuA@mail.gmail.com>
 <CAL1e-=jONDYiF+W6cEvrDFN_RkGSS3FVmaaj2-YE0RpO=GOb7w@mail.gmail.com>
In-Reply-To: <CAL1e-=jONDYiF+W6cEvrDFN_RkGSS3FVmaaj2-YE0RpO=GOb7w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 10 Nov 2019 14:33:39 +0000
Message-ID: <CAFEAcA_OGddfM-4kbd+RHz4DA_69E3q-vdYv1Cr5AUDmSYUyiA@mail.gmail.com>
Subject: Re: Looking for issues/features for my first contribution
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::229
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
Cc: Rajath Shashidhara <rajaths@cs.utexas.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 9 Nov 2019 at 21:08, Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
> Given modularity of RasPi, wouldn't it be nice for end users to be able to specify an RTC via command line?

The rtc option specifies properties of the backend of
an rtc device. It doesn't specify what the RTC device
exposed to the guest is. For doing that we use '-device',
but that only works for pluggable devices. In general,
we don't try to model any of that complexity for our
boards, except for the special case where there's a
nice clean interface for what the pluggable device is
(ISA, PCI, USB, etc). You could in theory come up with
a bus class which modelled RasPI pluggable modules and
then implement an RTC that way, but that's a huge amount
of work for a board model which currently is struggling
to get enough developer attention to be usable at all.

> If usage of command line is ruled out, what would be an alternative
> way to integrate particular RTC support in RasPi (for
> any QEMU-supported RTC, not only (for now, just envisioned) DS3231)?

We should just model the devices that the hardware has, so
that when you create a raspi QEMU model you get the same
things that you get if you take a stock raspi board and
power it up. The raspi board model is currently missing
lots and lots of devices, some of which are now
necessary to just be able to boot Linux. So we should
start by getting and keeping it working in a basic form,
before we even think about more obscure optional stuff
like pluggable modules.

One thing we should definitely not do is provide
a model of "some random RTC we happen to have a device
model of", just because we have a model handy. My
experience is that it's really important to stick to
a line of "just model what the real hardware does",
and not put in "QEMU does this other thing" behaviour:
it may seem convenient in the short term but it turns
into a real pain to maintain in the long term. The
actual hardware specs provide a nice clean "this is
what correct behaviour of a model should be" definition.

thanks
-- PMM


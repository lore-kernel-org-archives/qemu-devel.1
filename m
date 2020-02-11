Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D0BC35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 19:15:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 214CE2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 19:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r3gwbyUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214CE2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1azr-00026f-BW
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 14:14:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42057)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ayy-0001di-Uo
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 14:14:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ayw-0005j5-UX
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 14:14:04 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33010)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1ayv-0005eI-6i
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 14:14:01 -0500
Received: by mail-ot1-x341.google.com with SMTP id b18so11301679otp.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 11:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3/v3gfJ3/8xcmUKYJaWsS5mk0HeG31C48A0s8XLNYbk=;
 b=r3gwbyUDzESCTQ4/9IiHMeRJggdIdMPswT52LjYzDmGUmDhNL8z72K8HN7nJwUjxsP
 1zUXdS4uxbWYCvLdRk0mCKnJhKi/yBdAgb+pj/9izxbuvwFzjxiZekz3S3OLVMa1YtmB
 lEeIbQPjbIhHvaytCDEWRXhTt0EfBJArBfhdBxgmNpjzIA/CNQt5yGu5ZasvQfASwvul
 mX+dpk9LaM75ySnkNddBqcKhDh5kgm4rL9J4hhrFGfBx1FA745CWLnQA9oP7vULMHJrP
 G694GQK3vMOBJ2a+gww7j0AVCOV8sEOTgLyXKdo3w6l6cH7x2EzeB7x6TOgwlQSD43sf
 U9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3/v3gfJ3/8xcmUKYJaWsS5mk0HeG31C48A0s8XLNYbk=;
 b=I7BptuYcmtgTjgTTWvW8UGmkCmMSPX6+fybfzrv4riqoQbyY6TLcSrj9dFQP656gXI
 6nDQi/QWQW0JKRs7lK0w9QLcxJANmTFC3WDBcCW2JVo0wvW5CqCxT1yt6aS5h45ts07U
 2xbpeYbC/WpIXldy3PG8i84syT9BwrFPOj0HmrgyTOv33+XDMP5Dv8ZxX3klnaItPYKA
 wb44kem/xnTBaYJfy9RJXwakijQwe4M4vrbdmk1GU67mf5Dg33fJ1dyh2DjrN/+PTeZW
 fCTszcu/kV5UECzK4w17uQoIi1LBqQI2pPMWXvhV4t7L74Rv+zSyYtqJKKHKUyHHIDbK
 apeQ==
X-Gm-Message-State: APjAAAUl6JJ9gg4BXpOKTYogc49xxlZRGcj4Rc2req2egR3zvXv5xoAy
 cE4jDdqmY5/UrovSY2YkDsD9mpJGNX5s6A2fnBqT3w==
X-Google-Smtp-Source: APXvYqzweLrgmOFRPQ/R4wGSjn1yt/wnM6usUmIOWFsXpD0baga6pYO7SZuYE9tnwbAUtLsrkIT6q9SJsoMqlSCqY38=
X-Received: by 2002:a05:6830:1184:: with SMTP id
 u4mr6053662otq.221.1581448439224; 
 Tue, 11 Feb 2020 11:13:59 -0800 (PST)
MIME-Version: 1.0
References: <20200207174548.9087-1-linux@roeck-us.net>
 <158111304888.591.9861885311267533100@a1bbccc8075a>
 <20200207224850.GA10890@roeck-us.net>
 <445cee18-5de3-3da4-fef4-2e3f4530d96b@redhat.com>
In-Reply-To: <445cee18-5de3-3da4-fef4-2e3f4530d96b@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Feb 2020 19:13:48 +0000
Message-ID: <CAFEAcA-0Yea_c_YCGUnGqjsQ72MxzHfdbR2UfJYEPMGzvayKCA@mail.gmail.com>
Subject: Re: [PATCH v2] hw/arm: ast2600: Wire up EHCI controllers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Andrew Jeffery <andrew@aj.id.au>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 11 Feb 2020 at 08:12, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 2/7/20 11:48 PM, Guenter Roeck wrote:
> > On Fri, Feb 07, 2020 at 02:04:09PM -0800, no-reply@patchew.org wrote:
> >> Patchew URL: https://patchew.org/QEMU/20200207174548.9087-1-linux@roec=
k-us.net/
> >>
> >>
> >>
> >> Hi,
> >>
> >> This series failed the docker-mingw@fedora build test. Please find the=
 testing commands and
> >> their output below. If you have Docker installed, you can probably rep=
roduce it
> >> locally.
> >>
> > I forgot to mention that the patch depends on the similar
> > patch for ast2400/ast2500. Sorry for that. Not sure though how
> > to tell that to the test build system.
>
> You mean the "Aspeed: machine extensions and fixes" series?

Seems unlikely given that series is from 2019 and went into
master last year... Probably Guenter means
"ast2400/ast2500: Wire up EHCI controllers"
https://patchew.org/QEMU/20200206183437.3979-1-linux@roeck-us.net/

(which I had dropped from my to-review queue because I'd
misunderstood Cedric's review and was expecting to see
a v2 of that which covered all of ast2400/2500/2600 --
I'll put it back on my list to queue before this one)

thanks
-- PMM


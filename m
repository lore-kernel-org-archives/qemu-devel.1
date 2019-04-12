Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EF2C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 11:56:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3D672171F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 11:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FRvRSIPP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D672171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34812 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEunR-0004As-0u
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 07:56:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEumR-00037P-GP
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEumP-0000he-IZ
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:55:39 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hEumN-0000b4-75
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:55:35 -0400
Received: by mail-ot1-x344.google.com with SMTP id e5so8095985otk.12
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 04:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=QSUhEcrMM6nXjWE7FcZiOeoP+fX/3itFG/b85YS5jwU=;
	b=FRvRSIPPobww6sZaJX1IooydjG0274+F6Rw0ENgYb2LMe+uwfSg0Ge+xy0h8lFWPrN
	1+5KAinNyr5t7o76uNxHsJbDXmxIsg2u7v6ED86RQd5FVLUR0kHhRJbEo2o+yDYNLK8Z
	LGBLX7h0B115MSxH/4heEuaRolYka0jOZI4jhLYekv70s8iWjLzIeLOEFepkXC7gQDg/
	OpekBqqE7632PyF8fnkSMj9Au3OeYG9McxHQ7vOkYSlvM6fknRPwKDFWzLZ2ZB+wNJwx
	Wne0ibYGsyUmRAxf8TZYFMKjI+r24HlhG20XTqRfxdTwI6rXsv7QSoJNHVs7uEYx8neD
	SM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=QSUhEcrMM6nXjWE7FcZiOeoP+fX/3itFG/b85YS5jwU=;
	b=IsDuqzny9VfCcIxR+6usrzNhH8uCvUVRGD/DbZCArctAi49YIIpwVcRtTL5rnmTF0m
	c4HlLGnc468/zx/VkdhQZw/RTy9UUogrn5q5MSj3oUzaqiX+CaTryufQpE7huRtMeDUh
	nGlIbf9yjBB+VRB1mn32YgjupVF2JMxQmqjt0APfqbrYqaA957XesuYQPbiwQhN+yV2J
	eqiQFLeXhUk7DdJMB+RpvgwEYPtJpDd28dKdaeyzeXl2vI1Xfh/ssuCZjMgvazhY/TnM
	9S+9JMrclfM+2JIYxn+B5JWIYtOXP27UUJA1loNheL9z+Px1ulypHs/7NFdkIe3ivBm2
	31Hg==
X-Gm-Message-State: APjAAAXSxcNm6jOq58m4yCGBcKJqrAO0k+Qanuwy1KyGyI3d3DoXp4gG
	ybB2wnVNFl3tP0iYpyAJcSYqwvMsmgh+HOanSfqI9w==
X-Google-Smtp-Source: APXvYqw10q9A1hJVVG0eyIHovUPzKjNwTFDI3HAA1ntNmpODjJxdwdIYfJ7/FtoouOeJZtqeIxu4KjR/qibg8Xv1Bh4=
X-Received: by 2002:a05:6830:1497:: with SMTP id
	s23mr33035642otq.236.1555070127971; 
	Fri, 12 Apr 2019 04:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190328062222.8409-1-joel@jms.id.au>
	<20190328062222.8409-2-joel@jms.id.au>
	<CAFEAcA_K1Rv1G-s=ndVYX6i_BvWME6ToShL6ZBpB4gnE3zdZdA@mail.gmail.com>
	<89438392-9a54-7f43-5dff-6ceeffaf9f3e@kaod.org>
	<CACPK8Xc_WeP3xuimjTBFRArteecikin9Qj8ZoCW-J2qBY4C=5g@mail.gmail.com>
In-Reply-To: <CACPK8Xc_WeP3xuimjTBFRArteecikin9Qj8ZoCW-J2qBY4C=5g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Apr 2019 12:55:16 +0100
Message-ID:
 <CAFEAcA9t+GUG8PK623gb4v6ZBEhDX_7coOPcgLHDnUXTsrcrvg@mail.gmail.com>
To: Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 1/2] hw: timer: Add ASPEED RTC device
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm <qemu-arm@nongnu.org>,
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412115516.zywRFM9zbQa99Zgtecuuz35kudB0nCBnIk-unIgh4hI@z>

On Fri, 12 Apr 2019 at 04:17, Joel Stanley <joel@jms.id.au> wrote:
> vmstate and migration is a foreign concept for the small ARM machines.
> As well as being a developer, I am an end user of Qemu for them (the
> aspeeds, microbit), and the use case is to boot up a firmware and
> check that it does correct thing. I've never considered saving the
> state and resming it, and can't think of a situation where that would
> be done.

It's a really useful debugging tool:
 https://translatedcode.wordpress.com/2015/07/06/tricks-for-debugging-qemu-savevm-snapshots/

thanks
-- PMM


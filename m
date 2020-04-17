Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD62C3815B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 09:22:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBE1E2137B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 09:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fiY1FieJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE1E2137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPNCu-000261-Qb
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 05:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jPNC0-00017x-SS
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 05:21:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jPNBz-0000MN-Lz
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 05:21:48 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:40665)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jPNBz-0000J9-CM
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 05:21:47 -0400
Received: by mail-ot1-x32d.google.com with SMTP id i27so887966ota.7
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 02:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hfE+aGgErRt6URHF6CqLE4wOEBPlVESULxddT3NHPJE=;
 b=fiY1FieJGttPb8A8Op+IKlFSpPWK/MTBi9+mBD4ZvQbEH7jvy4dMIXXzedypdczeHB
 IVzu8kGIeTBqzBRnMBrLZE89fd0Oc2qwyEXmSeYJQMSmTl3gayoOhFa6U6cqWBsFGxTd
 PaQKwM/QFt0O7xJukH0nl1nJkDc7jrdQagpAz/lGDaUSPJbV8AKJrbwjE5rbm7h0X/lI
 8JYizFij/i9Kf2hDyGseMRMW5JVo8uhVmU3jGtSe9sLcTHRWTIFnwK/kbzWaNPdsd+tO
 yjNvba9aTaFUAK6iORQ/3HEgZFuCQCSa7QoJBGcTFwF/NEHyNMamQEV/TVHQF7ctrkKe
 ie7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hfE+aGgErRt6URHF6CqLE4wOEBPlVESULxddT3NHPJE=;
 b=Na8lREAVlfe/2HJ+9BcpJwlJpE//7yCuq3wIRiF165Zz2aYcoodHcX2/9nmvgsNVTY
 r388qZDILwdbyxUir4205r/z3+zcrk+V6sc/tIQ5XZwTZSSvqF44zoX6aLxmRGzRsd4W
 JVrWJArcKvbtGzc1kt8bkc6FCqGDfH/3L70MWGOgVMeZIv786hrTEPm6DoExCmqmvb9q
 Ler7Lgcp6ax/yhBPFCv7kZ1ez9S5QY68taE8HFPncQjWzib62HBbAid6Hw6FLQ6B2N/F
 E2jLc+sbU1sEeE7y5Oqv7KqX7a6Pt0nj2pZNZFGF//k3h9H2lA1KLZDw0gKiTHn/tUkY
 MocA==
X-Gm-Message-State: AGi0PubVNviQeoI8DyGlrTWhFQzgoRx2TIu9E41UFbb6aeIZQnOKoN6Y
 Oz5Lbk7URHTmeI5UbdVmKVliJCxOWUr8Y7RoKRVB5A==
X-Google-Smtp-Source: APiQypKIW3M7KoqhmuFtCjtymoubMgHSNBLoKlgvlMCub6aPjDIe9K7WBXuXIkbtwcO4ch+RdaH97eBRJu16zGe8IGg=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr1774798otj.91.1587115306355; 
 Fri, 17 Apr 2020 02:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200417050514.235060-1-david@gibson.dropbear.id.au>
 <CAFEAcA8qLznGS2YCFxz7QYrhbociZsqzEcxQPdp1rUy4OnnnFQ@mail.gmail.com>
 <20200417091431.GC2102@umbus.fritz.box>
 <20200417091812.GE2102@umbus.fritz.box>
In-Reply-To: <20200417091812.GE2102@umbus.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Apr 2020 10:21:34 +0100
Message-ID: <CAFEAcA8xOqLo==umgMY+N9UvpkH8w61epP52y+vuAaQkyoqxYQ@mail.gmail.com>
Subject: Re: [PULL 0/3] ppc-for-5.0 queue 20200417
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32d
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 Greg Kurz <groug@kaod.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Apr 2020 at 10:18, David Gibson <david@gibson.dropbear.id.au> wrote:
> On Fri, Apr 17, 2020 at 07:14:31PM +1000, David Gibson wrote:
> > But, I guess throw them in if something else does force an rc4.
>
> Oof.  Such as, perhaps the TCG temp leak in slbia.  That one *is* a
> regression :(.

Yeah, but it's basically harmless -- it's invisible unless
you deliberately build with debug, and it would only
cause a problem if guest code had a huge long run of
slbia insns all in a row, which it won't unless it's
being deliberately silly.

thanks
-- PMM


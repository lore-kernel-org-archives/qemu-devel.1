Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B4AC28EBD
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 02:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4643320868
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 02:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xKDGJQqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4643320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45640 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZ4yi-00043X-Bx
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 22:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50407)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hZ4yB-0003dN-Qk
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 22:51:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hZ4yA-00027L-Ln
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 22:51:07 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:38900)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hZ4y9-00021P-2F
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 22:51:06 -0400
Received: by mail-wr1-x431.google.com with SMTP id d18so569082wrs.5
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 19:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iR9Qzpwk7DjB6XO2UJkWE7zhNl2FqiN9AhAoa0DSBIY=;
 b=xKDGJQqw8uCeMlNs1IbX/lnPgWSgB84U7vHPWxlpZarjatI25isaklL0Ys2TtLwWm1
 ghNlRSVSf1fThSiQS3iQ+u8jrMYO5QH1b3EptNJch6OmEl2Eb5jzr9S9NlyH7O4OSAl1
 u0+3iXbqMx8LgPNafpaYvybA/smGQ9C5/2PxJXLoSzAQ0tb7Lv7Zo+HLx7lEKd+6x6sa
 0R6q1JQqNEHUII3pAu3h+kriNAchcnN7VqW0jcXqrfP0M+7Uusz3/dXfqkELvn6FXiSj
 NUzYNWBkYMhk+qt6IJ04XGDT63v+MGEkLRzA+Eqygj5Rzn8EcgGkJX0VKX61o2EuGaPm
 LDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iR9Qzpwk7DjB6XO2UJkWE7zhNl2FqiN9AhAoa0DSBIY=;
 b=g5dsY5J29iYzqUKzxqJmtvzpnkDYpW5Rc4MiL9J1l2iIcYCT6Kw9uXE4iM50V1Ui77
 w7VTFIuEZ8FXOSvzWYz1kphaxS4DUu0pviX+h7kbF79se4DxTi6zsgzL66kLWjVF/gZ9
 XYXfERqqKjlJ8a79K4Y38PPbKraY3dj0+aXXp7hwjx2H1QlLFWd2FXhSwZOq4dcw8Dvs
 ClSA0jHfyDFvzWzrOAojBZeUUpNhmM7j4vfqaVd4rJxYELv1Z4ILbifmtZlorpoZyRD7
 t46rfC7HsdGtc1C//bv74AQS9fejBBoP5oBN1kjKZWETJMoRXT5ZzyNlMBIlNMimCYQI
 1z9g==
X-Gm-Message-State: APjAAAWiXc8KIpzdj8xqshGNdkRfCj0jXV05NNiRSyLBjT4XllY7TwQQ
 Ul13020UONSmJupGfHUIdQD2bYPlddGjjLaMvrS6og==
X-Google-Smtp-Source: APXvYqxO9JGs6jSihPapMPEekjodV6ZXk/uOTtsUDh2KFG39Ou4iaql/Q3pJUGJZ/wRc5Ab9kA23pdeSRbMkq7OttWU=
X-Received: by 2002:adf:9062:: with SMTP id h89mr30956137wrh.20.1559875860223; 
 Thu, 06 Jun 2019 19:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <B1A3E8F6-F8C2-4EDB-A31B-EBB4CA636CA3@decred.org>
 <mhng-6493b48f-57c1-47cd-9157-50cb533f91df@palmer-si-x1e>
In-Reply-To: <mhng-6493b48f-57c1-47cd-9157-50cb533f91df@palmer-si-x1e>
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 6 Jun 2019 21:50:57 -0500
Message-ID: <CAFXwXrkEVJgPEZtvzyekJEZDk90XvntHkdfUe0s37RZ-ir1MKw@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] Fwd: [joel@sing.id.au: atomic failures on
 qemu-system-riscv64]
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>, qemu-devel@nongnu.org,
 marco@decred.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>
> Also, unless I'm misunderstanding something our implementation of LR/SC is
>
pretty broken.  We're just using a CAS to check if the value changed, which
> suffers from the ABA problem that LR/SC is there to fix in the first
> place.  I
> might be missing something here, though, as it looks like MIPS is doing
> essentially the same thing.
>

All of our load-lock/store-conditional implementations do the same.

You are correct that we do not implement the exact correct semantics.
Correct semantics, as far as I know, cannot be modeled without emulating
everything in a serial context, including caches.

We therefore make a considered choice to observe that while ll/sc can be
used to do all kinds of wild and woolly things, no one actually does so.
What people actually do is write portable code, using c/c++ atomic
primitives. And that all of these can be done with cmpxchg, because that's
what x86 has.

Using that choice, we can provide multi-threaded smp emulation that,
demonstrably, works.

>

r~

>

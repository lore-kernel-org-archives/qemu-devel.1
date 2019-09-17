Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74EAC4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 11:41:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A143021670
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 11:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZLqg6w4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A143021670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iABro-0001Ev-SS
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 07:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iABqV-0000fE-N9
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:40:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iABqU-00080U-9Q
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:40:35 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:39719)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iABqU-000805-00
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:40:34 -0400
Received: by mail-oi1-x241.google.com with SMTP id w144so2539050oia.6
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 04:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=52bNtGIFOwjvbHktbq3xfESXLPwfIUL0KJcWa5ILX8k=;
 b=ZLqg6w4JK7ABiw1UZkCy/RCMKlb3IUYEoS6OgfzXNtREC32BWOXZZT/sJ4y6rBo12M
 t88QijHUYiVWD8J+50lqvfyUFs7SXTyAb1OixGajIpy5QULLwrZWuE4gSrnpGojbVXfh
 +WboU4hd0XEBopNACQy9WhXzF2U4FJtOjGxwQagj7hB2+kMPVl0I3dQNsM5LBw3eczeY
 +ZZpVd44xX2WVv9s3Kztxs/1JA8UboDH3MC7Ilc0qZelJvbqmqh3cNYqM3SvvjQXp5NG
 KOXP5W/iz3705EF4HfNnBlu/YiLiKRguRt+Py8bJt13HrLLrjlBLVDUz15L7czpDS9zV
 a5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=52bNtGIFOwjvbHktbq3xfESXLPwfIUL0KJcWa5ILX8k=;
 b=keEDelwGZuDY6zidDP+VpgOT9O1/+vqCnHctiwtoU53k6Sw26GrMJkMTJNUgbXLQ0W
 bTEoY8iTixNO1hDyqNAFvCkn3FtHOSXkz0PqzWn+/QkkYbfgJKtM3vqOU9qVR5e+vS0O
 EidoNis9Y580Sf0qT/YYrpfuVZ5hH69Su2QTU8WQcjmiT99MZpmwIlN2x02Y/y/aDTvr
 9h3jSZBTwYH4ic6w6No9YTnfJxGgjIC/3ngcN/FjXUpduZRTyABdHnGJsnX+aVoXUL4d
 0i4J0gSZ+grUu8oMXv7Gimga3f0yOrfhv0LWHYlVC7OOxMIBCSqS8+U0hELhGLaWpJ1S
 ufDA==
X-Gm-Message-State: APjAAAVTA9Jepe5pnxf5Cm5zoJdh0wyvwHaeKf9V1yHHsnl31mpwDRVV
 yhzTmOUNZuipGRN4Q8BGYj3U5u8g0Js/XP2tcOuyOw==
X-Google-Smtp-Source: APXvYqw2YBma1wZwD+sf+TK9Iab4s/622gEcqlG8VH6Z+oIhg7V1WJo6mh6jdlqoM+860dDA2e5hn0bAmaESR6hZI3I=
X-Received: by 2002:aca:53d4:: with SMTP id h203mr3076510oib.146.1568720432923; 
 Tue, 17 Sep 2019 04:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <83f649c6482bf363c38e7f3778d866f4@linuxsystems.it>
 <9d1ea4ff-a0df-f7c6-54ca-c03b010c5ff1@redhat.com>
In-Reply-To: <9d1ea4ff-a0df-f7c6-54ca-c03b010c5ff1@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Sep 2019 12:40:22 +0100
Message-ID: <CAFEAcA94_kJ=5ABvB6B11U5NKpxka7e11tkB46m7qSMBFQQW9A@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] ELF load command alignment not page-aligned
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Niccol=C3=B2_Belli?= <darkbasic@linuxsystems.it>,
 "open list:sPAPR" <qemu-ppc@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Sep 2019 at 11:49, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Cc'ing PPC folks and Laurent.
>
> On 9/16/19 11:06 PM, Niccol=C3=B2 Belli wrote:
> > Hi,
> > I'm trying to use qemu-user-static to chroot into a foreign amd64
> > environment from my ppc64le host.
> > The host has a 64k page size, while x86_64 uses 4k.
> > I get those errors while loading shared libraries: "ELF load command
> > alignment not page-aligned"
> > Is there any way to fix this? I cannot simply switch to 4k page size
> > because my btrfs filesystem won't mount anymore (it requires the
> > sectorsize to be equal to the page size).

I vaguely recall that the answer is that we don't really
support running a linux-user guest which has a smaller page
size than the host. There are some sort-of-hacks in the code,
so some simple cases might more-or-less work, but I'm not
very surprised that you've run into something that doesn't
work.

Cc:ing Richard who probably has a more accurate answer.

thanks
-- PMM


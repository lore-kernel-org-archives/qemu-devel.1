Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD59C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:37:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87C7D208C0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jKIa5ZzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C7D208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBLup-0003tn-RN
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 12:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iBLng-0005JJ-0B
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:30:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iBLne-0004BS-G6
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:30:27 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42249)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iBLne-0004An-8J
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:30:26 -0400
Received: by mail-wr1-x442.google.com with SMTP id n14so7365750wrw.9
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 09:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=RaeO8JPuCas7oqn9w+8UjKwt+hSLeJZ/0fJKXIthpkA=;
 b=jKIa5ZzWTSz9NXCeezbUix4AtknIb+aqkBoPXZAzeH68V5Ix23kZ8t17ZVuLR60WrB
 mSHQ+y3Xy7LfjTfv74hiIe9poF/o9ygyVU9RvDjy35KHvUBIqxkql52nG6STIv8UDe4Y
 A6Yoe+y5GtLesIZkropaC4wXzvqxzFaQdYFODmx8kV/o/dZ1qTB+ockwAAxFAM58Zb7+
 Bjs1+eJvYJpctE5qkfICYdow8OcRgqGBHfAMWCUkdhL9dUBEU3rB62IazGLldTSyR2ll
 BIycKK0JEewqD+JYd86OuRXrRfzQqGv8PZRhrhGzcPwxts589Mt4QVnURdRNBls+dLZ2
 KU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=RaeO8JPuCas7oqn9w+8UjKwt+hSLeJZ/0fJKXIthpkA=;
 b=fz0RPujzLBDYwe3zJ4hhuvTjQmT2/ionqg4cliYGHrbgrcLh+4bgHTOhBWxy8pKJJ2
 FRb0x/59ZwEZjpjtqLNk/UzHHom36UXz37wEIRImZbHim4+ca2jHArVpFQgJrbdYpHP/
 y/ebvMmajNgF7HU4lk7z5m9h6JaZqQDiyLmppRxFONmMUepOwTG4Gl2JL+bIgqar0+Sl
 +VNUOybPcw8iGs1bOOlz37c6GA5rnUN1vOlMHhA1B69PpURCRUGHA3ae6WzV+zqzcnGF
 +5pPLBj+xycpUWUfMaDtnwCI5h0TT1YYF5TvQaLz4vdsj0j4Q5bWEcru+tIERZikbgSu
 cxCg==
X-Gm-Message-State: APjAAAVndCMJTiyr4+LC6zFeYzkhI5RKL3rZUEsOLv96coCBeL72ylzf
 4+w20Z3tVYz72+nejoN2VPXH5g==
X-Google-Smtp-Source: APXvYqyY2YTQypQ6kGWT6eSGPxZiouG7OMYYcY0OuX8jAQFLX74NQCKF8kP9pWDJM12OHpaNwHLvVg==
X-Received: by 2002:adf:f790:: with SMTP id q16mr13152865wrp.164.1568997024394; 
 Fri, 20 Sep 2019 09:30:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x129sm3457850wmg.8.2019.09.20.09.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 09:30:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E6A1B1FF87;
 Fri, 20 Sep 2019 17:30:22 +0100 (BST)
References: <20190920001413.22567-1-jsnow@redhat.com>
 <20190920001413.22567-4-jsnow@redhat.com>
 <731ae95b-7c70-43ca-bea9-28b00de232d5@redhat.com>
 <c7b12028-0294-0d9c-3e94-60b2ba7d3528@redhat.com>
 <87d0fvym64.fsf@linaro.org>
 <77355885-6422-5a6a-bd32-e3871e35213e@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 3/3] docker: remove unused debian-sid and debian-ports
In-reply-to: <77355885-6422-5a6a-bd32-e3871e35213e@redhat.com>
Date: Fri, 20 Sep 2019 17:30:22 +0100
Message-ID: <87blvfylpd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Fam Zheng <fam@euphon.net>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 9/20/19 6:20 PM, Alex Benn=C3=A9e wrote:
>> John Snow <jsnow@redhat.com> writes:
>>> On 9/20/19 4:49 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> On 9/20/19 2:14 AM, John Snow wrote:
>>>>> These are listed as "partial" images, but have no user.
>>>>> Remove them.
>>>>
>>>> Well, I have WiP users from them. I could restore this content when th=
ey
>>>> are ready... Ports is the base of deprecated Debian archs. On the other
>>>> side Sid is the base for edge development I use from time to time to
>>>> test latest gcc/binutils.
>>>> I'll try to find time to raise WiP branches to PoC.
>>>>
>>>
>>> I think that's the right thing to do. Right now, the docker tests
>>> directory has a lot of stale entries and unusable tests. That might be
>>> fine for the people working on it, but it makes it hard to understand
>>> and use for those of us who only occasionally traipse into the director=
y.
>>>
>>> I'm removing all references to python2 -- but if there's no way for me
>>> to test debian-sid and debian-ports, I can't test changes I need to make
>>> to these "partial images", so they should be removed until they are
>>> consumable.
>>>
>>> While I am sympathetic to the idea of having a library of partial images
>>> to use for future tests, they're prone to rot if there's no way to
>>> exercise them in-tree.
>>
>> Don't forget some "partial" images are only used for building TCG tests
>> - we want to keep them. But as git is forever I can drop the sid/ports
>> stuff for now until Phillipe has something to use them again.
>
> For Sid I have this case:

Does it really need sid to build binutils/gcc?
>
> -- >8 --
> #
> # Docker Renesas RX cross-compiler target
> #
> # This docker target builds on the debian Sid base image.
> #
> # Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9
> #
> # SPDX-License-Identifier: GPL-2.0-or-later
> #
> FROM qemu:debian-sid
>
> MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>     apt install -y --no-install-recommends \
>         wget
> RUN wget -qO - https://ftpmirror.gnu.org/binutils/binutils-2.32.tar.xz \
>     | tar -C /usr/src -xJf - && \
>     cd /usr/src/binutils-2.32 && \
>         CFLAGS=3D-w \
>         ./configure --prefix=3D/usr --disable-nls
> --target=3Drx-unknown-linux && \
>         make && make install && \
>         rm -rf /usr/src/binutils-2.32
>
> RUN git clone -b rx-trunk http://pf.osdn.net/gitroot/y/ys/ysato/gcc.git \
>     /usr/src/gcc
>
> RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>     apt install -y --no-install-recommends \
>         libgmp-dev libmpfr-dev libmpc-dev
>
> RUN cd /usr/src/gcc && \
>     CPPFLAGS=3D-w \
>     ./configure --target=3Drx-unknown-linux \
>         --prefix=3D/usr --disable-nls \
>         --enable-languages=3Dc --disable-shared \
>         --disable-threads --with-uclibc \
>         --disable-libssp --disable-libquadmath \
>         --disable-libgomp --disable-libatomic && \
>     make && make install && \
>     rm -rf /usr/src/gcc
>
> # This image isn't designed for building QEMU but building tests
> ENV QEMU_CONFIGURE_OPTS --disable-system --disable-user
> ---


--
Alex Benn=C3=A9e


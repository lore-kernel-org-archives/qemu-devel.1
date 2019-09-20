Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EDFC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:38:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40BD5208C0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40BD5208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBLvb-0004z9-Aj
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 12:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iBLgo-00021A-Ma
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:23:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iBLgm-0000nd-RT
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:23:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42728)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iBLgm-0000nD-Jw
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:23:20 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0755785542
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 16:23:19 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id j3so2478503wrn.7
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 09:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vC1/bThsnxl3zifbqkqI2EgPJt7hJCdy7szE5bN6Oi8=;
 b=MzxBZmlF/6ptzalFf4KHDlNIdQIOO1aqCrrgH//QNhshmRX0n44k5WpvB6oj3kykD1
 by9bCTGyCOSbA+fM0t+5AflcjaOQTfn1eNn7h68/jgVxe1Kxne6Cw2lrzxYWMb2zMQvB
 kTfNPZoTcbr2094veStSnhov2CEh2cdgyLIydXo2lUI3udVaJPEzCzfWggwJh7UieTZb
 evo5Hv2zeQmPTrv3wZ8w+pkOS83/WeNndJZwyQep3xG/5yzG2zu6t9KdjA/qaLEjB7w4
 kjZOi/vMcL5s9pR/AKfGneYP39RzUDE/UTJKolTPSCv0IRPKylzxEJ7Jk1jHMLVqQzRZ
 wmOw==
X-Gm-Message-State: APjAAAVF2+h4SDCUj8hp65ZoYNAaCW99jK+1Rs/3zKWojykcqW6GxxNq
 cbdq3Ij8x8TZ1YgiFnKgKQ9DCI7vrWuHxlcBpZ/Xdn4GFFJB+inq+BE+pA6hZqrqnp8BiTNAuKM
 yWD6Sy3OO0n3JEC8=
X-Received: by 2002:a7b:c74a:: with SMTP id w10mr4149635wmk.30.1568996597768; 
 Fri, 20 Sep 2019 09:23:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwwkCnDsAhxyUaHomDRT4r/XH8yUNNVRS9qnyItegEUFp6bLqpGp2g9DphcjcERf7h2eYCQyg==
X-Received: by 2002:a7b:c74a:: with SMTP id w10mr4149623wmk.30.1568996597560; 
 Fri, 20 Sep 2019 09:23:17 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id u10sm3141866wrg.55.2019.09.20.09.23.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Sep 2019 09:23:16 -0700 (PDT)
Subject: Re: [PATCH 3/3] docker: remove unused debian-sid and debian-ports
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>
References: <20190920001413.22567-1-jsnow@redhat.com>
 <20190920001413.22567-4-jsnow@redhat.com>
 <731ae95b-7c70-43ca-bea9-28b00de232d5@redhat.com>
 <c7b12028-0294-0d9c-3e94-60b2ba7d3528@redhat.com> <87d0fvym64.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <77355885-6422-5a6a-bd32-e3871e35213e@redhat.com>
Date: Fri, 20 Sep 2019 18:23:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87d0fvym64.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/20/19 6:20 PM, Alex Benn=C3=A9e wrote:
> John Snow <jsnow@redhat.com> writes:
>> On 9/20/19 4:49 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 9/20/19 2:14 AM, John Snow wrote:
>>>> These are listed as "partial" images, but have no user.
>>>> Remove them.
>>>
>>> Well, I have WiP users from them. I could restore this content when t=
hey
>>> are ready... Ports is the base of deprecated Debian archs. On the oth=
er
>>> side Sid is the base for edge development I use from time to time to
>>> test latest gcc/binutils.
>>> I'll try to find time to raise WiP branches to PoC.
>>>
>>
>> I think that's the right thing to do. Right now, the docker tests
>> directory has a lot of stale entries and unusable tests. That might be
>> fine for the people working on it, but it makes it hard to understand
>> and use for those of us who only occasionally traipse into the directo=
ry.
>>
>> I'm removing all references to python2 -- but if there's no way for me
>> to test debian-sid and debian-ports, I can't test changes I need to ma=
ke
>> to these "partial images", so they should be removed until they are
>> consumable.
>>
>> While I am sympathetic to the idea of having a library of partial imag=
es
>> to use for future tests, they're prone to rot if there's no way to
>> exercise them in-tree.
>=20
> Don't forget some "partial" images are only used for building TCG tests
> - we want to keep them. But as git is forever I can drop the sid/ports
> stuff for now until Phillipe has something to use them again.

For Sid I have this case:

-- >8 --
#
# Docker Renesas RX cross-compiler target
#
# This docker target builds on the debian Sid base image.
#
# Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9
#
# SPDX-License-Identifier: GPL-2.0-or-later
#
FROM qemu:debian-sid

MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
    apt install -y --no-install-recommends \
        wget
RUN wget -qO - https://ftpmirror.gnu.org/binutils/binutils-2.32.tar.xz \
    | tar -C /usr/src -xJf - && \
    cd /usr/src/binutils-2.32 && \
        CFLAGS=3D-w \
        ./configure --prefix=3D/usr --disable-nls
--target=3Drx-unknown-linux && \
        make && make install && \
        rm -rf /usr/src/binutils-2.32

RUN git clone -b rx-trunk http://pf.osdn.net/gitroot/y/ys/ysato/gcc.git \
    /usr/src/gcc

RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
    apt install -y --no-install-recommends \
        libgmp-dev libmpfr-dev libmpc-dev

RUN cd /usr/src/gcc && \
    CPPFLAGS=3D-w \
    ./configure --target=3Drx-unknown-linux \
        --prefix=3D/usr --disable-nls \
        --enable-languages=3Dc --disable-shared \
        --disable-threads --with-uclibc \
        --disable-libssp --disable-libquadmath \
        --disable-libgomp --disable-libatomic && \
    make && make install && \
    rm -rf /usr/src/gcc

# This image isn't designed for building QEMU but building tests
ENV QEMU_CONFIGURE_OPTS --disable-system --disable-user
---


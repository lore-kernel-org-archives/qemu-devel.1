Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44589C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A929207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A929207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBM9j-0004hJ-5d
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 12:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54265)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iBLlV-0002wU-B0
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iBLlQ-00031i-De
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:28:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50986)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iBLlQ-00031U-5X
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:28:08 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 972B983F45
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 16:28:06 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id c1so2477762wrb.12
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 09:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Zu3bPOo/xJ8Hl4J7P6fPHUSXQfc6ARL6LzwY0LA4f6o=;
 b=BaXQR49o8T1c+O5Fxb2bfpKv2rk6Z0+3EbnQ4ddBNIxlctk1+/yxSA3MNG4W1VyLX/
 JEUmZwsHjc/kgQBFkCdBbSFul27lMbmi9hjKpx9T415lyidmHdxD0GVN2i+nVJ//wg57
 LYgChz9czPAbzsZzlEpA29CFvWrBEY8xfLRMyHnl+C0vKxm+tHFLp8D3vvQixCo08ocE
 fbHkQKgbWoczqB45bg+bde0zZFIaEJwMcIQA1Ql41aGt4w45PCAmW1RaQ6I6CODW2CWr
 LKHE/Xmtj7XSAVMTDzjTHz7iLSjW5i9gLBA07dHEE2oimQ+P/kyM+k7UPtqmlDbAc6O0
 t4Gg==
X-Gm-Message-State: APjAAAXYL4iRw7IhpKR+Pe8anf9qaSVeHVM52Umx46FB123cyNmZ3k+w
 Q3pQvPlcJqjz4X0AwLP4/iyiidGaq6hpyMYga9Af9cHAx9oVp8kCrxhKAsNfdko6aswdbHzzH03
 qk57UshXkoOe7RgI=
X-Received: by 2002:a5d:5643:: with SMTP id j3mr251902wrw.357.1568996885331;
 Fri, 20 Sep 2019 09:28:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxw+XxzC7kOijzMv2jm4PEnDUYnOHWHaDsI6bhkBN1NF7oT2beDlqbeD6YpAc1q6bGFvBlEUw==
X-Received: by 2002:a5d:5643:: with SMTP id j3mr251890wrw.357.1568996885098;
 Fri, 20 Sep 2019 09:28:05 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id m62sm3145712wmm.35.2019.09.20.09.28.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Sep 2019 09:28:04 -0700 (PDT)
Subject: Re: [PATCH 3/3] docker: remove unused debian-sid and debian-ports
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>
References: <20190920001413.22567-1-jsnow@redhat.com>
 <20190920001413.22567-4-jsnow@redhat.com>
 <731ae95b-7c70-43ca-bea9-28b00de232d5@redhat.com>
 <c7b12028-0294-0d9c-3e94-60b2ba7d3528@redhat.com> <87d0fvym64.fsf@linaro.org>
 <77355885-6422-5a6a-bd32-e3871e35213e@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <4bf8c4ed-806e-6ee8-0031-5ce43dc52803@redhat.com>
Date: Fri, 20 Sep 2019 18:28:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <77355885-6422-5a6a-bd32-e3871e35213e@redhat.com>
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

On 9/20/19 6:23 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 9/20/19 6:20 PM, Alex Benn=C3=A9e wrote:
>> John Snow <jsnow@redhat.com> writes:
>>> On 9/20/19 4:49 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> On 9/20/19 2:14 AM, John Snow wrote:
>>>>> These are listed as "partial" images, but have no user.
>>>>> Remove them.
>>>>
>>>> Well, I have WiP users from them. I could restore this content when =
they
>>>> are ready... Ports is the base of deprecated Debian archs. On the ot=
her
>>>> side Sid is the base for edge development I use from time to time to
>>>> test latest gcc/binutils.
>>>> I'll try to find time to raise WiP branches to PoC.
>>>>
>>>
>>> I think that's the right thing to do. Right now, the docker tests
>>> directory has a lot of stale entries and unusable tests. That might b=
e
>>> fine for the people working on it, but it makes it hard to understand
>>> and use for those of us who only occasionally traipse into the direct=
ory.
>>>
>>> I'm removing all references to python2 -- but if there's no way for m=
e
>>> to test debian-sid and debian-ports, I can't test changes I need to m=
ake
>>> to these "partial images", so they should be removed until they are
>>> consumable.
>>>
>>> While I am sympathetic to the idea of having a library of partial ima=
ges
>>> to use for future tests, they're prone to rot if there's no way to
>>> exercise them in-tree.
>>
>> Don't forget some "partial" images are only used for building TCG test=
s
>> - we want to keep them. But as git is forever I can drop the sid/ports
>> stuff for now until Phillipe has something to use them again.
>=20
> For Sid I have this case:
>=20
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

Oh well nevermind it is old, so it probably now works with debian-10.

I used the Ports base for sparc32 and x32, I don't have them on my
workstation I'll check during the WE.

> MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
> RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>     apt install -y --no-install-recommends \
>         wget
> RUN wget -qO - https://ftpmirror.gnu.org/binutils/binutils-2.32.tar.xz =
\
>     | tar -C /usr/src -xJf - && \
>     cd /usr/src/binutils-2.32 && \
>         CFLAGS=3D-w \
>         ./configure --prefix=3D/usr --disable-nls
> --target=3Drx-unknown-linux && \
>         make && make install && \
>         rm -rf /usr/src/binutils-2.32
>=20
> RUN git clone -b rx-trunk http://pf.osdn.net/gitroot/y/ys/ysato/gcc.git=
 \
>     /usr/src/gcc
>=20
> RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>     apt install -y --no-install-recommends \
>         libgmp-dev libmpfr-dev libmpc-dev
>=20
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
>=20
> # This image isn't designed for building QEMU but building tests
> ENV QEMU_CONFIGURE_OPTS --disable-system --disable-user
> ---
>=20


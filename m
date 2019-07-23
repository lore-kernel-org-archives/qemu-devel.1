Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E72EC7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 13:47:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32E5421738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 13:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E5421738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpv8S-0004cc-Am
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 09:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35585)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hpv8E-0004CH-TS
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 09:47:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hpv8D-0000LD-0B
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 09:47:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33633)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hpv8C-0000Iv-Nt
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 09:47:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so43336588wru.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 06:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8yruLZQFK4FrxWvdT+DeGAXd//UVlze4sM62cEnyljU=;
 b=Vug9O9rMgZ7HhRwo/k6+jdJaHTPc4C05H5YwL7thQwr+lPIHu/IQdXkhjrHDvw+6s+
 NL/Cluh8Ar6eo1K7zfERa1DzpWMrk8amUP+Fa+9T2QOAIp85ka6CzI5Zas5iN9fZWFl/
 cnKd7mW31rZUvEbnbhbzAgxRT5pzFv9DsoYzEZ7FYg6ISZWqUU4WDO6sG4ofLPp5bXC4
 CapdWK6gt0Lha/QXf1ScT8g+CLt9QhDqTbEWMVudCDYJq25ye7+QNEu7XfmCwDXGm82y
 i6BUPsTbnCqHA9qeCFexwNnFi7+VO30sLwv4bPqcP9nVKF3iJ/bYWOYQ6npSH9I1Sono
 hzAw==
X-Gm-Message-State: APjAAAXP4sSegaIFSuv0phF74hKLOEUf8Q8/WsO83gprIbuB5z5klWus
 xWgWZcStiutPHDZcO+0sMGZIw+tk2vo=
X-Google-Smtp-Source: APXvYqzx05IeaSS34bciBdx+XHv8jDfKtbbXfaet4GvFtqS+8+jBwTbb3VKODBiiBfJ5oZ/W0wdy8g==
X-Received: by 2002:a5d:6949:: with SMTP id r9mr77108914wrw.73.1563889623468; 
 Tue, 23 Jul 2019 06:47:03 -0700 (PDT)
Received: from [192.168.1.38] (190.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.190])
 by smtp.gmail.com with ESMTPSA id w25sm40730285wmk.18.2019.07.23.06.47.02
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Jul 2019 06:47:02 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190723103612.5600-1-alex.bennee@linaro.org>
 <CAFEAcA_P_Bk0bNGCW+TwhQGCeqM-XZd3OudKZ4tu0fNThFH5ww@mail.gmail.com>
 <87imrt0y9a.fsf@linaro.org>
 <CAFEAcA-EyEWotUfDcN6TTGapBpBzwaRNUatZDj2tA4kW1aL=xw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <498f8871-8ba9-6971-ecb3-c08389f17d91@redhat.com>
Date: Tue, 23 Jul 2019 15:47:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-EyEWotUfDcN6TTGapBpBzwaRNUatZDj2tA4kW1aL=xw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PULL for 4.1-rc2 00/23] testing updates (green
 CI!)
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/23/19 3:33 PM, Peter Maydell wrote:
> On Tue, 23 Jul 2019 at 12:46, Alex Bennée <alex.bennee@linaro.org> wrote:
>> Odd. Does:
>>
>>   make docker-image-debian10 V=1
>>
>> fail for you?
> 
> Yes. The files apt tries to download do not appear to be
> on the mirror:
> e104462:bionic:all-linux-static$ make docker-image-debian10 V=1
> /home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py build
> qemu:debian10 /home/petmay01/linaro/qemu-for-merges/tests/docker/dockerfiles/debian10.docker
>   --add-current-user
> Sending build context to Docker daemon  3.072kB
> Step 1/7 : FROM debian:buster-slim
>  ---> 7e86f6dc8410
> Step 2/7 : RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >>
> /etc/apt/sources.list
>  ---> Using cache
>  ---> a16e81a24df9
> Step 3/7 : RUN apt update
>  ---> Using cache
>  ---> 272778d384a0
> Step 4/7 : RUN DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata
>  ---> Using cache
>  ---> 0113e60b5abe
> Step 5/7 : RUN DEBIAN_FRONTEND=noninteractive eatmydata     apt
> install -y --no-install-recommends         bison
> build-essential         ca-certificates         clang         flex
>     gettext         git         pkg-config         psmisc
> python         python3-sphinx         texinfo         $(apt-get -s
> build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)
>  ---> Running in 9f66f5f38684
> 
> WARNING: apt does not have a stable CLI interface. Use with caution in scripts.
> [...]
> After this operation, 791 MB of additional disk space will be used.
> Err:1 http://cdn-fastly.deb.debian.org/debian buster/main amd64
> perl-base amd64 5.28.1-4
>   404  Not Found [IP: 151.101.16.204 80]
> Err:2 http://cdn-fastly.deb.debian.org/debian buster/main amd64
> libsystemd0 amd64 240-5
>   404  Not Found [IP: 151.101.16.204 80]
> Err:3 http://cdn-fastly.deb.debian.org/debian buster/main amd64
> gcc-8-base amd64 8.2.0-16
>   404  Not Found [IP: 151.101.16.204 80]
> Err:4 http://cdn-fastly.deb.debian.org/debian buster/main amd64
> libgcc1 amd64 1:8.2.0-16
>   404  Not Found [IP: 151.101.16.204 80]
> Err:5 http://cdn-fastly.deb.debian.org/debian buster/main amd64
> libstdc++6 amd64 8.2.0-16
>   404  Not Found [IP: 151.101.16.204 80]
> Err:6 http://cdn-fastly.deb.debian.org/debian buster/main amd64 libc6
> amd64 2.28-6
>   404  Not Found [IP: 151.101.16.204 80]
> 
> though some are present, eg
> 
> Get:210 http://cdn-fastly.deb.debian.org/debian buster/main amd64
> libatk1.0-data all 2.30.0-2 [145 kB]
> 
>> Can you retry with:
>>
>>   make docker-image-debian10 V=1 NOCACHE=1
> 
> Yes, this works. It looks like docker is caching the
> result of the "apt update" state, when it really needs
> to rerun this every time because the state on the servers
> may have changed.

Yeah, I fixed Ubuntu here:

https://git.qemu.org/?p=qemu.git;a=commitdiff;h=beac6a98f6eb271f2520a329ca051313afd70a69

But failed to explain this reason while trying to fix Debian:

https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg02081.html


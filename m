Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C68C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 13:33:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E743122543
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 13:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ofSA3bkS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E743122543
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpuvF-0006ER-6I
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 09:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60134)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hpuv4-0005pz-Qm
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 09:33:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hpuv3-0008QI-Je
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 09:33:30 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:44885)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hpuv3-0008Pw-Bw
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 09:33:29 -0400
Received: by mail-oi1-x22c.google.com with SMTP id e189so32190752oib.11
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 06:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VFrWbq8fmc/xFasas4ctysLBYsXG+Zj6dCnGW376DZ4=;
 b=ofSA3bkShaiaWnSBTZWDa1tcOvMY5Z4Z76kQyJFlukNQswwpyQIp7TCySvl0hUyfcl
 On/X9JtLsl2FuTYQTBeutBl4Th6zPhB9bdj6BzBxGTYSVHnesF180N32moX0QL/it/nc
 u+KvlD0Yc56YiTvz+dJgdr+Pm6Lwy/x84IE5Mkohz7Z4R2/NnOta9+OzlSTnCjYJXTG6
 YKBRixsUKzYDMkoyVPCCov9+1q8MmOvNh6zKFWp90jyFP8ZaOOQtggNcakGYZeDZxPeJ
 0v114kxIBcyLa+BLa8EYNrQ+NSfxEl3PgQ28Kilh5g1wVz5e0Y+re7oIntIexnSmP6cC
 pPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VFrWbq8fmc/xFasas4ctysLBYsXG+Zj6dCnGW376DZ4=;
 b=hW4eVT7o2UaWssuTA5Pt4V144NUSai9IF94UDBoldTI1elRj2e1LXbDvfGr2iJQtLW
 cxHHzCtSgkFj3hhdoAm+eu+j8eRZUlpGIr/9Nv+9ghKCujjw7gqVonnBWGOQxxj0MCVs
 SoCnOyGZyaAgv2xVUvCJFSEhTL2alyPvRH2J0fzqiLk4q9L1rzLtCYfON8OmTF84Xp9q
 PZzPbp5nDQtaodV92JRwbTmMzO1IexhjyW+vQmRF4dreZahOaWzktGvRstDsdxIN3ktu
 R7P8hAHqhOrjKS6+SE5j7S5wwYcF8GtH4Nim6iXprtnpga10OeSQ21MpseJFeyjvgZlY
 vAgA==
X-Gm-Message-State: APjAAAWGfDVn3NMzM+NA2NURbT+1sDjnX+iwNhRguAG9R2ElxiWWEIMJ
 gqWkbfMxTR81hMdA6Oe33nTY+PMIJh054lYkliYJb3PvfEY=
X-Google-Smtp-Source: APXvYqz/dfvKu5pnZh1idNrKcEkKVIECQrIoyXgcyupqOX9t6GB6cZ9V65fXjfcSk7V33A17lgaLr2+ux6do1quGstA=
X-Received: by 2002:aca:6185:: with SMTP id
 v127mr38397641oib.163.1563888808181; 
 Tue, 23 Jul 2019 06:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190723103612.5600-1-alex.bennee@linaro.org>
 <CAFEAcA_P_Bk0bNGCW+TwhQGCeqM-XZd3OudKZ4tu0fNThFH5ww@mail.gmail.com>
 <87imrt0y9a.fsf@linaro.org>
In-Reply-To: <87imrt0y9a.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jul 2019 14:33:17 +0100
Message-ID: <CAFEAcA-EyEWotUfDcN6TTGapBpBzwaRNUatZDj2tA4kW1aL=xw@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22c
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

On Tue, 23 Jul 2019 at 12:46, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Odd. Does:
>
>   make docker-image-debian10 V=3D1
>
> fail for you?

Yes. The files apt tries to download do not appear to be
on the mirror:
e104462:bionic:all-linux-static$ make docker-image-debian10 V=3D1
/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py build
qemu:debian10 /home/petmay01/linaro/qemu-for-merges/tests/docker/dockerfile=
s/debian10.docker
  --add-current-user
Sending build context to Docker daemon  3.072kB
Step 1/7 : FROM debian:buster-slim
 ---> 7e86f6dc8410
Step 2/7 : RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >>
/etc/apt/sources.list
 ---> Using cache
 ---> a16e81a24df9
Step 3/7 : RUN apt update
 ---> Using cache
 ---> 272778d384a0
Step 4/7 : RUN DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata
 ---> Using cache
 ---> 0113e60b5abe
Step 5/7 : RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata     apt
install -y --no-install-recommends         bison
build-essential         ca-certificates         clang         flex
    gettext         git         pkg-config         psmisc
python         python3-sphinx         texinfo         $(apt-get -s
build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)
 ---> Running in 9f66f5f38684

WARNING: apt does not have a stable CLI interface. Use with caution in scri=
pts.
[...]
After this operation, 791 MB of additional disk space will be used.
Err:1 http://cdn-fastly.deb.debian.org/debian buster/main amd64
perl-base amd64 5.28.1-4
  404  Not Found [IP: 151.101.16.204 80]
Err:2 http://cdn-fastly.deb.debian.org/debian buster/main amd64
libsystemd0 amd64 240-5
  404  Not Found [IP: 151.101.16.204 80]
Err:3 http://cdn-fastly.deb.debian.org/debian buster/main amd64
gcc-8-base amd64 8.2.0-16
  404  Not Found [IP: 151.101.16.204 80]
Err:4 http://cdn-fastly.deb.debian.org/debian buster/main amd64
libgcc1 amd64 1:8.2.0-16
  404  Not Found [IP: 151.101.16.204 80]
Err:5 http://cdn-fastly.deb.debian.org/debian buster/main amd64
libstdc++6 amd64 8.2.0-16
  404  Not Found [IP: 151.101.16.204 80]
Err:6 http://cdn-fastly.deb.debian.org/debian buster/main amd64 libc6
amd64 2.28-6
  404  Not Found [IP: 151.101.16.204 80]

though some are present, eg

Get:210 http://cdn-fastly.deb.debian.org/debian buster/main amd64
libatk1.0-data all 2.30.0-2 [145 kB]

> Can you retry with:
>
>   make docker-image-debian10 V=3D1 NOCACHE=3D1

Yes, this works. It looks like docker is caching the
result of the "apt update" state, when it really needs
to rerun this every time because the state on the servers
may have changed.

thanks
-- PMM


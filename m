Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F6CC35671
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 12:22:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E4642072D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 12:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCaL1u/0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E4642072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Cko-0003BX-Kt
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 07:22:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59285)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6Ciz-0001KM-Fc
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 07:20:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6Civ-0001R7-TW
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 07:20:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22246
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6Civ-0001Qk-Bm
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 07:20:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582546832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/JldZQFMlyuFRPy/ELyegQ3FNnj4q8JIzl+BNryh4+Y=;
 b=eCaL1u/0bPotXAwaMaQm5JIzcO7vUewOn1awbNgQiCwIE5vPVKGgEwoVhco2NMv8SpmdeB
 xsrb4yZObp5AnLQnfiDSqd0pZlM7/cxPYifiwGUWzcRSX2aFdZLutA/MaF5MBHGcflA1ze
 Qw4qrdyTVa5iwL0nLUgH0hOx5RfL/dU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-a9HQWalOOXyH4JOqLqFnyg-1; Mon, 24 Feb 2020 07:20:30 -0500
X-MC-Unique: a9HQWalOOXyH4JOqLqFnyg-1
Received: by mail-wr1-f71.google.com with SMTP id u8so5517741wrp.10
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 04:20:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=knMgWFeO+Qren9deb3GiA/YaOCUVb3Y5M2bOrezSwK8=;
 b=My43W+RzQY5R6/2r0sBpNtHAVckSS+mL0Oq1eGsrgv/BpB4reX2k1uFoYgnPM0NJiC
 khjnM1XsBlb+pm5jtLu7DBAQpquBQxl0eXCKo0T4k/sCZIuLbZJ2Na3V4XYs0wNZDULQ
 9zttmYaTS8EUlREL+GBss6nCYZ0qRX/oFI5pj4h/pgHeAZssUvDkPclw2CQWoW1zkEHY
 KxOX9IdDYc6IlcrC1mKv6izHV/2p60Zpx3g5RZGaYWQjIg/gym5Lx9qhJjFbfnb47tbj
 0Q9TlZQTJmxXJ1t8HC8YrYO0AerPeF9bFV+jk8JYva5y0krN0CaPnz9kppwXRI8w+NqG
 nHWg==
X-Gm-Message-State: APjAAAWleORCQMtCWAsQ0xT4NGODEHbm65T8erh0p8H4IUMY99cZhCRe
 nC2VYhXS+0ebYHjlAbs4kQgAKgVyDFjk8UpGGjeeAmswAvFc6FFni6Pb9/ZRlIQWr6T63+jAwQi
 lcstJbLkY/TS7PKY=
X-Received: by 2002:a05:600c:2c08:: with SMTP id
 q8mr22364111wmg.45.1582546829086; 
 Mon, 24 Feb 2020 04:20:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqzkbAa/4i51P/0YkQif16IqWXYRhzRjW61tTOdi2VlSOVbcMK8MBMiDS4hExEn7InSubrT7Bg==
X-Received: by 2002:a05:600c:2c08:: with SMTP id
 q8mr22364097wmg.45.1582546828910; 
 Mon, 24 Feb 2020 04:20:28 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id c141sm17335607wme.41.2020.02.24.04.20.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2020 04:20:28 -0800 (PST)
Subject: Re: [PATCH] tests/docker: Install tools to cross-debug and build
 Linux kernels
To: qemu-devel@nongnu.org
References: <20200212202738.12986-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4481651f-1c10-ca86-dc57-02aaff7d2a1a@redhat.com>
Date: Mon, 24 Feb 2020 13:20:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212202738.12986-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/12/20 9:27 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
> We often run Linux kernels to test QEMU. We sometimes need
> to build them manually to use non-default features. We only
> miss the tiny 'bc' tool.
>=20
> The ncurses library is helpful to run 'make menuconfig'.
>=20
> Finally, gdb-multiarch allow us to debug a TCG guest when its
> architecture is different than the host.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   tests/docker/dockerfiles/debian10.docker | 3 +++
>   tests/docker/dockerfiles/debian9.docker  | 3 +++
>   2 files changed, 6 insertions(+)
>=20
> diff --git a/tests/docker/dockerfiles/debian10.docker b/tests/docker/dock=
erfiles/debian10.docker
> index 5de79ae552..2fcdc406e8 100644
> --- a/tests/docker/dockerfiles/debian10.docker
> +++ b/tests/docker/dockerfiles/debian10.docker
> @@ -17,14 +17,17 @@ RUN apt update && \
>       DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata && \
>       DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>       apt install -y --no-install-recommends \
> +        bc \
>           bison \
>           build-essential \
>           ca-certificates \
>           clang \
>           dbus \
>           flex \
> +        gdb-multiarch \
>           gettext \
>           git \
> +        libncurses5-dev \
>           pkg-config \
>           psmisc \
>           python3 \
> diff --git a/tests/docker/dockerfiles/debian9.docker b/tests/docker/docke=
rfiles/debian9.docker
> index 8cbd742bb5..92edbbf0f4 100644
> --- a/tests/docker/dockerfiles/debian9.docker
> +++ b/tests/docker/dockerfiles/debian9.docker
> @@ -17,13 +17,16 @@ RUN apt update && \
>       DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata && \
>       DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>       apt install -y --no-install-recommends \
> +        bc \
>           bison \
>           build-essential \
>           ca-certificates \
>           clang \
>           flex \
> +        gdb-multiarch \
>           gettext \
>           git \
> +        libncurses5-dev \
>           pkg-config \
>           psmisc \
>           python3 \
>=20

ping?



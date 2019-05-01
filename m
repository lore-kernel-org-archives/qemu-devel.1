Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA65DC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 11:11:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF4D121670
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 11:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="miw3qdSp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF4D121670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54718 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLn91-0005Zh-QQ
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 07:11:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLn77-0004B2-VG
	for qemu-devel@nongnu.org; Wed, 01 May 2019 07:09:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLn74-0006dj-V1
	for qemu-devel@nongnu.org; Wed, 01 May 2019 07:09:25 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:32968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLn72-0006cb-4S
	for qemu-devel@nongnu.org; Wed, 01 May 2019 07:09:21 -0400
Received: by mail-wm1-x343.google.com with SMTP id b188so1137095wmb.0
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 04:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=CguRcsR5DsNq2P/I2eVEuJnvNrC9viEEZ2SoMJ2fCSw=;
	b=miw3qdSpe/G2p3Tt0/eyx3a5yBWE629vZ6tmyL7C2PEMBVZi9Awd/t9RPbvzhv8HDR
	Lc01eV24m9nINcJCAZkSdHuxRUGmUVF7ijUyNZ+4Ko2tpSjTBTX5R7pq0liMr67wPHwm
	MPtpgvJEeRPNhHRv7INoKPozKPo2sdlnKjR4flPbtvCeR/Nq7YHHANwKnSG7VlJ4rXn9
	a8wuPalg77PDOPtO2t5iyrnsXskQCuUwNs63ytM9UV+WcSL4ffbmrZmBTOLOO7Bgb8tS
	eA/dsuLUNCNesbTi4eGDZteCsFdmbNk0gjY8qh8WUysIYA5jv8XNqUnw6iaqgJWEX44F
	oq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=CguRcsR5DsNq2P/I2eVEuJnvNrC9viEEZ2SoMJ2fCSw=;
	b=pQ1IREvMQClmuE4jqPqcfECrV13UAVTsqNOJ5K+vh4Pn/V5yZkQrrCUxeHdQm3S1bT
	pTBJWblPdOCQm61xre0fDijZ0A8/hE64k3Ml1nsKrqX2+ep+l9Ksyz+icjzSUZVnAzk1
	TsQXBk53erOMAWwbsvXdAH8oEk76PZjQ0x52XW1dVC/lfNDyQxTc7eZB8/psyABFsQty
	VeKFHxFZ+0/6j3ivObfKLBW7mPbQfB4j3MIY+m9Sfb7Npr/IexE9YRmmlkw0zNnYObtp
	IjIbrrH3Mf7IVsYMLDFmB6WO1MT78s1jKA6KhLb8tFePeiVETXbTxDVGaaUu5SrWtb66
	MREg==
X-Gm-Message-State: APjAAAVpT5svmcOjB458DglCpYtGOIXbAiAyErOrBbp7Q5nmLxwg12ta
	PwSzDZn0kWMqAOCQi3Ub78tyFQ==
X-Google-Smtp-Source: APXvYqza2DOUxXUtQAC5FbGZRA1A2p4TsgkAeDnXOSnSKT3/aNNmHMo4aiJBzMPh4FBiqCmdKf5yOQ==
X-Received: by 2002:a1c:24c2:: with SMTP id k185mr6478499wmk.115.1556708957966;
	Wed, 01 May 2019 04:09:17 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	q2sm16213513wrd.48.2019.05.01.04.09.17
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 01 May 2019 04:09:17 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id E78AA1FF87;
	Wed,  1 May 2019 12:09:16 +0100 (BST)
References: <20190428155451.15653-1-thuth@redhat.com>
	<20190428155451.15653-6-thuth@redhat.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
In-reply-to: <20190428155451.15653-6-thuth@redhat.com>
Date: Wed, 01 May 2019 12:09:16 +0100
Message-ID: <875zqu77oj.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v2 5/8] cirrus / travis: Add gnu-sed and
 bash for macOS and FreeBSD
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, Christophe Fergeau <cfergeau@redhat.com>,
	Max Reitz <mreitz@redhat.com>,
	Wainer dos Santos Moschetta <wainersm@redhat.com>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501110916._lRXPNBsg-Z-BWx7zOEceQ5iBt2zpidNtVnzkSo7vQk@z>


Thomas Huth <thuth@redhat.com> writes:

> We are going to enable the qemu-iotests during "make check" again,
> and for running the iotests, we need bash and gnu-sed.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  .cirrus.yml | 4 ++--
>  .travis.yml | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/.cirrus.yml b/.cirrus.yml
> index 47ef5bc604..8326a3a4b1 100644
> --- a/.cirrus.yml
> +++ b/.cirrus.yml
> @@ -7,7 +7,7 @@ freebsd_12_task:
>      cpu: 8
>      memory: 8G
>    install_script: pkg install -y
> -    bison curl cyrus-sasl git glib gmake gnutls
> +    bash bison curl cyrus-sasl git glib gmake gnutls gsed
>      nettle perl5 pixman pkgconf png usbredir
>    script:
>      - mkdir build
> @@ -20,7 +20,7 @@ macos_task:
>    osx_instance:
>      image: mojave-base
>    install_script:
> -    - brew install pkg-config python glib pixman make sdl2
> +    - brew install pkg-config python gnu-sed glib pixman make sdl2
>    script:
>      - ./configure --python=3D/usr/local/bin/python3 || { cat config.log;=
 exit 1; }
>      - gmake -j$(sysctl -n hw.ncpu)
> diff --git a/.travis.yml b/.travis.yml
> index 2e06aee9d0..ba94644192 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -42,6 +42,7 @@ addons:
>      packages:
>        - glib
>        - pixman
> +      - gnu-sed
>
>
>  # The channel name "irc.oftc.net#qemu" is encrypted against qemu/qemu


--
Alex Benn=C3=A9e


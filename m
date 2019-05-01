Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E89C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 08:28:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9FE820835
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 08:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FySIFgo6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9FE820835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40062 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLkbo-0007eh-SO
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 04:28:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLkaa-00071J-Sm
	for qemu-devel@nongnu.org; Wed, 01 May 2019 04:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLkaX-0007Qb-RA
	for qemu-devel@nongnu.org; Wed, 01 May 2019 04:27:40 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLkaX-0007P0-K8
	for qemu-devel@nongnu.org; Wed, 01 May 2019 04:27:37 -0400
Received: by mail-wr1-x441.google.com with SMTP id s15so23804120wra.12
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 01:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=F8wnWsmLPaHuKjq3XTdC0SAm4jjSX8j3K1uKLcEVWdk=;
	b=FySIFgo6cJUe8ImedY+IHUZd7FWzpftWQMq7V7U2ws3sJISlsCKExc992KqVAnlJcV
	YLswicOb6TtmsZS2l1SbEB5hQUdMGZx1+n8aBlmf+jH2grbvSIMagJLHntaps8D+5I3u
	A+zlUuqErzSMH0HJBXk9BIJyz1b4HeigMxqKMPOEcr3tR6hYfmvXBwLz9HRiBsiM/MYy
	OIyVqEbd29Zxl5NJZJEXmOvltmKDnHJY8NOF2dpwvgHcfzBwbs7IOgpYdornlEU16BxZ
	oMb58EXvIqqmsA3dH/Ki1sld+uzHkTVkGKw5eCbA/VdbcRE0sLw9vq9Ig4U5WlTksujF
	g2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=F8wnWsmLPaHuKjq3XTdC0SAm4jjSX8j3K1uKLcEVWdk=;
	b=iJTz7eDt/al5zkLydHub+z4Ef+18+Ny37g0ufKu7jYh4ikO+d6wtTYAS8Yb9cAO6Rz
	RdExbZIT1zaMFbORjztFvUhJQwZnBoIjeZAQvXkWgABCyCoq4uipGwrlVhhxXJjUlZd2
	u0rWacbX204V91S1hqgN9jntfXDF5WQhvUExiKLaXroCmc3tLIP/9KiJLCy7A0aTBMh/
	aZNSBNck+eHaCme3nGvTcjI9nmRuoaoNlRaHgwjCf3GneFqwE4rckBsS8QYg9BcjQzC8
	Z0PAqXOzSrv3dCtFXWA/o/KNGSg1af1IDryBmm7bIkNft7SmJN6/aF5lGma3fZdStcNC
	K3Fw==
X-Gm-Message-State: APjAAAUhJEp+M8TXUTRrhZYlLnE/FwYVTg7On6VzYiLFEF1UloLiNSsm
	DbRyFUHMSf3RNUrYcL2X7fvA/Q==
X-Google-Smtp-Source: APXvYqxbuFXW7vyoZSjYDv7j+DaIBqCCLth+1kNkEF5Ld+ap1hsgNoW22vNQzdAsmvXB90pPS3Kv8g==
X-Received: by 2002:a5d:6a03:: with SMTP id m3mr20585010wru.135.1556699255838; 
	Wed, 01 May 2019 01:27:35 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id o1sm5791078wmh.47.2019.05.01.01.27.35
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 01 May 2019 01:27:35 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id CDEF51FF87;
	Wed,  1 May 2019 09:27:34 +0100 (BST)
References: <20190428155451.15653-1-thuth@redhat.com>
	<20190428155451.15653-4-thuth@redhat.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
In-reply-to: <20190428155451.15653-4-thuth@redhat.com>
Date: Wed, 01 May 2019 09:27:34 +0100
Message-ID: <87ef5i7f61.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v2 3/8] tests/qemu-iotests/check: Pick a
 default machine if necessary
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
Message-ID: <20190501082734.Ou0W6DGi2NpNmO3xU9HDpNKHl8ufBfTj1ZpNonj-jvc@z>


Thomas Huth <thuth@redhat.com> writes:

> qemu-system-arm, qemu-system-aarch64 and qemu-system-tricore do not have
> a default machine, so when running the qemu-iotests with such a binary,
> lots of tests are failing. Fix it by picking a default machine in the
> "check" script instead.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/qemu-iotests/check | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index f9c24b6753..922c5d1d3d 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -130,7 +130,6 @@ export CACHEMODE=3D"writeback"
>  export QEMU_IO_OPTIONS=3D""
>  export QEMU_IO_OPTIONS_NO_FMT=3D""
>  export CACHEMODE_IS_DEFAULT=3Dtrue
> -export QEMU_OPTIONS=3D"-nodefaults -machine accel=3Dqtest"
>  export VALGRIND_QEMU=3D
>  export IMGKEYSECRET=3D
>  export IMGOPTSSYNTAX=3Dfalse
> @@ -564,6 +563,18 @@ then
>  fi
>  export QEMU_PROG=3D"$(type -p "$QEMU_PROG")"
>
> +case "$QEMU_PROG" in
> +    *qemu-system-arm|*qemu-system-aarch64)
> +        export QEMU_OPTIONS=3D"-nodefaults -machine virt,accel=3Dqtest"
> +        ;;
> +    *qemu-system-tricore)
> +        export QEMU_OPTIONS=3D"-nodefaults -machine tricore_testboard,ac=
cel=3Dqtest"
> +        ;;
> +    *)
> +        export QEMU_OPTIONS=3D"-nodefaults -machine accel=3Dqtest"
> +        ;;
> +esac
> +
>  if [ -z "$QEMU_IMG_PROG" ]; then
>      if [ -x "$build_iotests/qemu-img" ]; then
>          export QEMU_IMG_PROG=3D"$build_iotests/qemu-img"


--
Alex Benn=C3=A9e


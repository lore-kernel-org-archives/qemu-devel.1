Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E28C04AA8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 21:32:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D49CD21743
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 21:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OaBVqBax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49CD21743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53851 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLaMR-00009A-Ol
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 17:32:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLaLS-00080v-9Y
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLaLR-000079-94
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:31:22 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33664)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLaLQ-00006l-Um
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:31:21 -0400
Received: by mail-wr1-x441.google.com with SMTP id s18so22745325wrp.0
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 14:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=F8wnWsmLPaHuKjq3XTdC0SAm4jjSX8j3K1uKLcEVWdk=;
	b=OaBVqBaxwdjjYKTJmpX4ngt9Nx7G0/ZI27aC4cqSD/a2KMwb5+w6Nrq/b1tAeh6jZW
	ZeWFZGCQREgYbsh5Oh7YVAd1oo6yjQyirSH5FZowjEoqpQrdNhzsDlqlAf6BRVKZdyPl
	2G9enm8G79gkPEBfc1gci+dFPbL+yl9AY452UZtxR0ciQG/dbdzWB4sJGPmQzAef6iSK
	+aFc9K/k0Es2uP9QG56e4zqDEoKYNh2PzdehPTZZX4toNxrydgW6aj179f2ArgapMbKU
	PHlJRT+Y16NowP89WDF/ifLhVHZzjUhhUNQ9VGQAspFtoWzJuBZgcdBGGRCKzqze2wlr
	0Byg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=F8wnWsmLPaHuKjq3XTdC0SAm4jjSX8j3K1uKLcEVWdk=;
	b=dpF80CUplEj/RxVjz+zuDgwwv8g2s4lqUeL5t27iS9gv/SaGJQdZv5ng+YS3w/UjUC
	bdzmsz+JLQJxoqFc5w/mJRThU2rr6ADWkcR+ZMT4yEMoDnzdDDAB/B5Ms8h/tDjkf6Jz
	kq+XRRXiojik7L48w/0R6hLmBcaKkKDOhBnjMeJixO12giBIpeJ8vrH2Zys9Ges1oMH6
	XhnvHhMFY53ZIYXe7TS/ITHxq4wjVqeMiCm4ey3+MzDCqCkP4F0xpYHDHpc8sefr2uDD
	vLqPdLc1efp4euhQ+fsf9L9IOCLD/5w2L4WQOpRdL/I/FXi70q8vwHbmyzEpOymwivUs
	v8xA==
X-Gm-Message-State: APjAAAXXGvHcxGIiY8cSS2lmIW0Lxvorj9mdQdjLuABmsAtAMCwe8WXa
	62PypbPqsK/pdAeybraZ43cgpg==
X-Google-Smtp-Source: APXvYqwyvM+HGpUKN/bgjcAzcpvwMQW5cj7AW83uoSCBGODdA9V2ZxxQvC5WqmrY3PY51hrsXV7huQ==
X-Received: by 2002:a5d:6a03:: with SMTP id m3mr19061962wru.135.1556659879083; 
	Tue, 30 Apr 2019 14:31:19 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	b11sm6735125wmh.29.2019.04.30.14.31.18
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 30 Apr 2019 14:31:18 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id D63931FF87;
	Tue, 30 Apr 2019 22:31:17 +0100 (BST)
References: <20190424103747.10173-1-thuth@redhat.com>
	<20190424103747.10173-2-thuth@redhat.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
In-reply-to: <20190424103747.10173-2-thuth@redhat.com>
Date: Tue, 30 Apr 2019 22:31:17 +0100
Message-ID: <87h8af6uze.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH 1/6] tests/qemu-iotests/check: Pick a
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
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430213117.u3VZPIv0MBwZMaeFsjat9iuz1a555MavxQaW_-BzbiM@z>


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


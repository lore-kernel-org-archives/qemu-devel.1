Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3AEC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 11:17:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86E5720578
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 11:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rK8Ux5tQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E5720578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46769 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRarg-0007CH-Rt
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 07:17:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hRa8g-0000XH-Og
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hRa8f-00020p-Q3
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:30:58 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53675)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hRa8f-0001zr-HU
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:30:57 -0400
Received: by mail-wm1-x342.google.com with SMTP id 198so6426940wme.3
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 03:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=G+win0ckov66x2GEbSCyJ/DkGwrJ0oCBJF05+YnF758=;
	b=rK8Ux5tQhgRqhvgAsuzTa9XGRXjXP3vcyN6dJkIhfy3pmjDuZYs0+nXYWcvCSeGldM
	rZHMbXsigBxLNt0ArRTjxbM3DVBpM1TWS47MffkAYKRCT2dOp6XTG/NUXOnW35QpzX0o
	/v+/8kQSYarJvUfO3VPEMaH7Yq4/N6dmyd+Q828t7AZjnJni5VkkcnxN8Jrjzm8TNFqM
	kTecD8+lEdXvR3cnePA8Cr8mBZkebE6CyOX1/yFpQ8cbYcOWDsmuENU/DiGb8sKa4M1J
	Jtx3HYekQ8De5hWmdyM9k7nnb5RDe5njfZdBh58O77DCitaeRNQTFnhfNVvYIyABgRaS
	iyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=G+win0ckov66x2GEbSCyJ/DkGwrJ0oCBJF05+YnF758=;
	b=BNm3542Xuo8HBHuAqR/G974Ua8StObOWBfSuS9PK+uOY1Ao8GLIeHq6rx4pwCgZcS1
	C+qn2+yQBW/IvhGgrY/6xKXJjl8UlxLBSC+D9xOdGwsrSyW37e9OdqW1eeUqlaXUsD2i
	lTn0ZVvMEUkyLWwqErKZTst5gaB/VWri2JeD59ndnRtavIUW2saJbS5MaEneBpoir5vw
	IUIUuSjjruCi+Oe7ZZmvmCeRuehqc7aY9fKKoRAzSWZqrL6khNWtVUH8FKNbA/f4NPm1
	wr6snX2k6f6o7sduxDcjPG/Rl3HRaWt3QkxXtaSOFWa80/RaBfYjqmb5eL5af2eT8v7l
	uDZA==
X-Gm-Message-State: APjAAAWWeCbrAvC7AqqITex60i1kMLeaLelsISa4WPCEmXQWeksZxIYp
	8j4PKt7mreoNdPc37ss3KKxzjg==
X-Google-Smtp-Source: APXvYqwA2laY1Bya/ppWIKgqTEdmn5QFO6WWU0ax+KGvDn62WAcpGKsDITJ7WElkNR1bGTLPVcZw6w==
X-Received: by 2002:a1c:3184:: with SMTP id x126mr30330400wmx.20.1558089056121;
	Fri, 17 May 2019 03:30:56 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id z8sm7052832wrs.84.2019.05.17.03.30.55
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 17 May 2019 03:30:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 2E9C91FF87;
	Fri, 17 May 2019 11:30:55 +0100 (BST)
References: <20190517095628.10119-1-mreitz@redhat.com>
	<20190517095628.10119-2-mreitz@redhat.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190517095628.10119-2-mreitz@redhat.com>
Date: Fri, 17 May 2019 11:30:55 +0100
Message-ID: <87y335l6e8.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH 1/4] iotests: Add -display none to the qemu
 options
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Max Reitz <mreitz@redhat.com> writes:

> Without this argument, qemu will print an angry message about not being
> able to connect to a display server if $DISPLAY is not set.  For me,
> that breaks iotests.supported_formats() because it thus only sees
> ["Could", "not", "connect"] as the supported formats.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/qemu-iotests/check | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index f9c24b6753..d6fec4bf3c 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -130,7 +130,7 @@ export CACHEMODE=3D"writeback"
>  export QEMU_IO_OPTIONS=3D""
>  export QEMU_IO_OPTIONS_NO_FMT=3D""
>  export CACHEMODE_IS_DEFAULT=3Dtrue
> -export QEMU_OPTIONS=3D"-nodefaults -machine accel=3Dqtest"
> +export QEMU_OPTIONS=3D"-nodefaults -machine accel=3Dqtest -display none"
>  export VALGRIND_QEMU=3D
>  export IMGKEYSECRET=3D
>  export IMGOPTSSYNTAX=3Dfalse


--
Alex Benn=C3=A9e


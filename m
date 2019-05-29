Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B708C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 09:55:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23967208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 09:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qUWscROZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23967208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50883 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVvJJ-0000I6-Bf
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 05:55:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVvIU-0008Lv-Sq
	for qemu-devel@nongnu.org; Wed, 29 May 2019 05:55:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVvIT-00041l-WA
	for qemu-devel@nongnu.org; Wed, 29 May 2019 05:55:02 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hVvIT-00040r-Le
	for qemu-devel@nongnu.org; Wed, 29 May 2019 05:55:01 -0400
Received: by mail-wm1-x342.google.com with SMTP id d17so1188234wmb.3
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 02:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=jHWmpF5RTq1F5Omm8bcuFJ/wpg7QWbBAR40elBRpqbE=;
	b=qUWscROZUrhgMIY5VPTzu+Df0Vex6iAgWkZcwHQmEj4vtyAWalKo4pxsQSOqdp/xgR
	KgC41ioVQBk+5tc1bkNVh50hj5azn94an5DKYFWWW2nTrabkrkYFjTH/gI0WhyQFPGhc
	3l3seQj8Y4JM5m7HK3abu7DwK/rfYr7bJmckYzOWrZeU4aMd/GMxaCQdZiafppUB0DGR
	yiXwEavpqJcG3k0XaPmJMSHe95PNe1oSDaQjBs+oIbOugl5kOrAwvBuTw29lTEDkDU9f
	Sc2PURBNxaH4fcO5mCt/T0E2e8eK/rEIM3f/4myXrp92lTe03N9VbR9X1p0UplUphpHX
	y0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=jHWmpF5RTq1F5Omm8bcuFJ/wpg7QWbBAR40elBRpqbE=;
	b=k1vcDcB131nq3C2qR+m9SvmAK4VBApktsrWNZlSgzw7yEhi4aKUXkK+Rq5qDsX7vug
	j9EYNb9QxI6fzME7nFjSxoIeACqtQ9khwXHGQUq5yGjwkaSgRJLg6ltl/vGMY16dO9ok
	y65w+0v/oy/NfbRkVcgaH7mnelw9lY7KSjL+VNCPpVHZRzXVp65Y83o4GDeN+iDC6daI
	dUzDwvvUledoM5VTBaB2OgDv4kIjyJSveyxiAXTor6fTLAP8aFDR/owAbBXweoWUW5EX
	dGd5aF+lkIFzEGnlgl+++YaTqHXzlxj5qgZBWBbu2YoFfx20sLxVDX2FsjlEDwLkN32b
	XJsw==
X-Gm-Message-State: APjAAAXh79mMUof4Vx5hb0zcZISEf6z9f0aa/+7dIDFmQ5hGGklz30pE
	yIqblPFDqBPil+YIVGMSnsIZ+A==
X-Google-Smtp-Source: APXvYqwi5a7T6mUpYwKeoxwr/QlkyXOwe4+5dynyDd+nwdSb0mOfU7EIPyZde/yz4rAZ3vgf22ha2A==
X-Received: by 2002:a05:600c:224d:: with SMTP id
	a13mr6163910wmm.62.1559123700053; 
	Wed, 29 May 2019 02:55:00 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id l6sm3883156wmi.24.2019.05.29.02.54.58
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 29 May 2019 02:54:58 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 49FFD1FF87;
	Wed, 29 May 2019 10:54:58 +0100 (BST)
References: <20190504060336.21060-1-philmd@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
In-reply-to: <20190504060336.21060-1-philmd@redhat.com>
Date: Wed, 29 May 2019 10:54:58 +0100
Message-ID: <8736kxshzh.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH] tests/docker: Update the Fedora image to
 Fedora 30
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	=?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Fedora 30 got released:
>
>   https://fedoramagazine.org/announcing-fedora-30/
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Queued to testing/next, thanks.

> ---
> Based-on: <20190408201203.28924-1-marcandre.lureau@redhat.com>
>           qxl: fix -Waddress-of-packed-member
>
> Based-on: <20190503112654.4393-1-laurent@vivier.eu>
>           Pull request trivial branch 2019-05-03
> ---
>  tests/docker/dockerfiles/fedora.docker | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/docker=
files/fedora.docker
> index 69d4a7f5d75..1496b68ba15 100644
> --- a/tests/docker/dockerfiles/fedora.docker
> +++ b/tests/docker/dockerfiles/fedora.docker
> @@ -1,4 +1,4 @@
> -FROM fedora:29
> +FROM fedora:30
>  ENV PACKAGES \
>      bc \
>      bison \


--
Alex Benn=C3=A9e


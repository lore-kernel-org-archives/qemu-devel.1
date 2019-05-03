Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C3DC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 16:47:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEEE8206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 16:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WhLhhnNh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEEE8206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44494 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMbLW-00071C-44
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 12:47:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMbGa-0003UO-5T
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMbGZ-0002Tu-1f
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:42:32 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMbGY-0002Sy-Oo
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:42:30 -0400
Received: by mail-wr1-x441.google.com with SMTP id e28so8700542wra.0
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 09:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=jMN8PPXNkPbwtv72oUPK/tYaPoAYZ62qhOQCcBRcXcw=;
	b=WhLhhnNhrUq07LmkGNJa4OCV9Q/W85ib2TA5W1XjitJdEsGJzexoG5ktYdEJPFtNdA
	8c31hy9EVgdCOfBp0cRR0WvUKxnMrmQH7ZiHmGws3CS/xYSAYaYYqmPGInSjVVOLpF+4
	iGcTKN+Ej0doDsyzqTbr8Zkrj/FZWCoB0hEMmhAuBdmGeViZbuMpMrtzXPe7cI87wov1
	xPk8pIf/hBM+Z24dGQQeEUaVXHONHmQZL4gX/xOsN518uBaPoVkKaSaJPfsBPcjTq4We
	fIPdm+eO/yzE2lHSyTxNdT0LIbn6sIxu773qjWlb+VAvoyCzKrTwJRIx26j17vLM1hPL
	XoUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=jMN8PPXNkPbwtv72oUPK/tYaPoAYZ62qhOQCcBRcXcw=;
	b=SK0FVywujaYx3bNcTMAbsgl5OrrDnH39pP58lJiREuhqJB5ctKACoFW/ZbjgwQc5PS
	BmFA/GqFzkHkW7EONhQyubcgYSI6BUfu+nTczF1qNkI3fM3zZuHgHsE8625Q4TCZPbhq
	luGH7pf1+lQLR1GHR5LU4x6+fKTFXQqdfB7ONVRb8TAErgm7Fc111RgVDbo3J2mk8Can
	t5gtceSL76NmScKSglaDNphQ/vBzZFB7J/FoLHa6HqnxM+P3cbumSFnnzxcDG1fxyuAt
	ij4ouOyO/ECo8x3QomqZok0w6VmHi4TB+bizj+cA2iAc0RWXzrDPL23q27L/UUZRR+G2
	gG9A==
X-Gm-Message-State: APjAAAV5QKdP2aojcvJ/DMFUfwUBZWUeowPnlWT/qXMFH8S63JlJ9Xaa
	NSQcdVe4GvD032d4GMHj0CNjNg==
X-Google-Smtp-Source: APXvYqwyBGt3AqnhKqN+/J7lvmEZ1LzHx/lnreCanWUncEYMFllbl/S2j2c7/eT/AWjkMzNReSfb6Q==
X-Received: by 2002:a5d:5108:: with SMTP id s8mr7045872wrt.99.1556901749369;
	Fri, 03 May 2019 09:42:29 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	c10sm5552103wrd.69.2019.05.03.09.42.28
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 03 May 2019 09:42:28 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 7F6261FF87;
	Fri,  3 May 2019 17:42:28 +0100 (BST)
References: <20190503070241.24786-1-kraxel@redhat.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gerd Hoffmann <kraxel@redhat.com>
In-reply-to: <20190503070241.24786-1-kraxel@redhat.com>
Date: Fri, 03 May 2019 17:42:28 +0100
Message-ID: <87a7g34hhn.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH] tests/docker: add ubuntu 18.04
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
Cc: Fam Zheng <fam@euphon.net>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503164228.vUW4o5Yv5curygQ5Sg8KuWciKkL0HUEXIhFLwnizwi4@z>


Gerd Hoffmann <kraxel@redhat.com> writes:

> Based on the ubuntu.docker file.
> Used to reproduce the build failure Peter was seeing.
> Others might find this useful too ;)
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  tests/docker/dockerfiles/ubuntu1804.docker | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/ubuntu1804.docker
>
> diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/do=
ckerfiles/ubuntu1804.docker
> new file mode 100644
> index 000000000000..2e2900150b09
> --- /dev/null
> +++ b/tests/docker/dockerfiles/ubuntu1804.docker
> @@ -0,0 +1,57 @@
> +FROM ubuntu:18.04
> +ENV PACKAGES flex bison \
> +    ccache \
> +    clang \
> +    gcc \
> +    gettext \
> +    git \
> +    glusterfs-common \
> +    libaio-dev \
> +    libattr1-dev \
> +    libbluetooth-dev \
> +    libbrlapi-dev \
> +    libbz2-dev \
> +    libcacard-dev \
> +    libcap-dev \
> +    libcap-ng-dev \
> +    libcurl4-gnutls-dev \
> +    libdrm-dev \
> +    libepoxy-dev \
> +    libfdt-dev \
> +    libgbm-dev \
> +    libgtk-3-dev \
> +    libibverbs-dev \
> +    libiscsi-dev \
> +    libjemalloc-dev \
> +    libjpeg-turbo8-dev \
> +    liblzo2-dev \
> +    libncurses5-dev \
> +    libncursesw5-dev \
> +    libnfs-dev \
> +    libnss3-dev \
> +    libnuma-dev \
> +    libpixman-1-dev \
> +    librados-dev \
> +    librbd-dev \
> +    librdmacm-dev \
> +    libsasl2-dev \
> +    libsdl2-dev \
> +    libseccomp-dev \
> +    libsnappy-dev \
> +    libspice-protocol-dev \
> +    libspice-server-dev \
> +    libssh2-1-dev \
> +    libusb-1.0-0-dev \
> +    libusbredirhost-dev \
> +    libvdeplug-dev \
> +    libvte-2.91-dev \
> +    libxen-dev \
> +    make \
> +    python-yaml \
> +    sparse \
> +    texinfo \
> +    xfslibs-dev
> +RUN apt-get update && \
> +    apt-get -y install $PACKAGES
> +RUN dpkg -l $PACKAGES | sort > /packages.txt
> +ENV FEATURES clang pyyaml sdl2

Queued to testing/next, thanks.

--
Alex Benn=C3=A9e


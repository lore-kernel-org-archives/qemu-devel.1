Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBC4C004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 15:17:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19210204FD
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 15:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zV3V0IMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19210204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42446 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNItI-0003I4-S2
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 11:17:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hNIsJ-00031A-3y
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:16:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hNIsI-0002HY-8w
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:16:23 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hNIsI-0002Go-1p
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:16:22 -0400
Received: by mail-wm1-x342.google.com with SMTP id o25so1620406wmf.2
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 08:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=fKV+If+l2/ajeRESZnU4iTMAk+nXsKFr2lXM+UBpp6c=;
	b=zV3V0IMtEXoY6iu/5YljUPyMW4WxQqDO4UKA9c+OgQdTUXnQXsOED0epk3mJpEbMTb
	+9DRAW3uANbJxS7FRFfZxrhSCzmF5/kUS6ncETcNkfj8mEjog5A/ol0X4aFGKut2bQp4
	LKkhXaxFxakX4IL0+LdT6ape4UB168mFdLXL6WAWMLioCLR0Fs3MVDDEUnhc9matKMb7
	VU1KDXtYgj/+ckfOPqG3iaVKMy32XLsagAEHpV6UprfwrHfVILXKqvkRTTFswLieLqek
	CQSo1O3Nrp584cIAUu7OSDzy4BODCO/JLeUXGGA9FhMA9L1SzwrFgaUw8mXFuL9SP7R4
	K9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=fKV+If+l2/ajeRESZnU4iTMAk+nXsKFr2lXM+UBpp6c=;
	b=aZ5en4rRvcaxbah95ElDN9rYoDQjjfVKP73Q2lYCxrMtUoPx1kTInUDPGkBNkon91I
	YcBWete7S4VtkdMV0Idz0Hb523X3HZ9h+7YzrDmTFuKaAihwHPSoLm5MVCUQ55mJ7XAN
	KMsKqfEeURB3BmS3KMw8BzLf0D81qn6fBbYFrRxuqKDC+VjdDgI2DZq6+r6Sd/fgOdSh
	0HsXlvLyV1ruoptb1Vvt/dzz4az+9sHkKjZrqdegka7iMKdzyM9vySAITdj25EuiGuX9
	MqxQSajPzGmBTM9kejrqkz1VY3lFKj8uDuSOEGkNXWh2slPAf9E0IbXA3Z7d/W0gutoy
	1acw==
X-Gm-Message-State: APjAAAWvdo9WvSBOUZbVFdabOYNU0V0LEOBhKN2ze0fMZ/wM9xE2e0e9
	vC5gZMvoxQBJMTysPScnWVSYdg==
X-Google-Smtp-Source: APXvYqxdW41NtBnM14JM20UEUdB8ZHC2WTK8ijqUlLrFJ2E1l2IG99ijjFMIBtAiImI8pW7qOW0HdA==
X-Received: by 2002:a1c:67c1:: with SMTP id b184mr13262402wmc.12.1557069379608;
	Sun, 05 May 2019 08:16:19 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	c10sm18037499wrd.69.2019.05.05.08.16.18
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sun, 05 May 2019 08:16:18 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 4FDCE1FF87;
	Sun,  5 May 2019 16:16:18 +0100 (BST)
References: <20190504055440.20406-1-philmd@redhat.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
In-reply-to: <20190504055440.20406-1-philmd@redhat.com>
Date: Sun, 05 May 2019 16:16:18 +0100
Message-ID: <878svlaq4d.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH] tests/docker: Test more components on the
 Fedora default image
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
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
	Eduardo Otubo <otubo@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Juan Quintela <quintela@redhat.com>,
	"Michael R . Hines" <michael@hinespot.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
	=?utf-8?Q?Ma?= =?utf-8?Q?rc-Andr=C3=A9?= Lureau
	<marcandre.lureau@redhat.com>, Junyan He <junyan.he@intel.com>,
	=?utf-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>,
	Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190505151618.6a5_CRW2HjGq8E2TooiykJKpZBtvZ7jaZ0_bCHsSZEw@z>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Install optional dependencies of QEMU to get better coverage.
>
> The following components are now enabled:
>
>   $ ./configure
>   ...
>   Multipath support yes
>   VNC SASL support  yes
>   RDMA support      yes
>   PVRDMA support    yes
>   libiscsi support  yes
>   seccomp support   yes
>   libpmem support   yes
>   libudev           yes
>
> Note: The udev-devel package is provided by systemd-devel.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Queued to testing/next, thanks.

> ---
>  tests/docker/dockerfiles/fedora.docker | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/docker=
files/fedora.docker
> index 69d4a7f5d75..afbba29adaa 100644
> --- a/tests/docker/dockerfiles/fedora.docker
> +++ b/tests/docker/dockerfiles/fedora.docker
> @@ -8,6 +8,7 @@ ENV PACKAGES \
>      bzip2-devel \
>      ccache \
>      clang \
> +    cyrus-sasl-devel \
>      device-mapper-multipath-devel \
>      findutils \
>      flex \
> @@ -23,13 +24,17 @@ ENV PACKAGES \
>      libaio-devel \
>      libasan \
>      libattr-devel \
> +    libblockdev-mpath-devel \
>      libcap-devel \
>      libcap-ng-devel \
>      libcurl-devel \
>      libfdt-devel \
> +    libiscsi-devel \
>      libjpeg-devel \
> +    libpmem-devel \
>      libpng-devel \
>      librbd-devel \
> +    libseccomp-devel \
>      libssh2-devel \
>      libubsan \
>      libusbx-devel \
> @@ -74,10 +79,12 @@ ENV PACKAGES \
>      pixman-devel \
>      python3 \
>      PyYAML \
> +    rdma-core-devel \
>      SDL2-devel \
>      snappy-devel \
>      sparse \
>      spice-server-devel \
> +    systemd-devel \
>      systemtap-sdt-devel \
>      tar \
>      usbredir-devel \


--
Alex Benn=C3=A9e


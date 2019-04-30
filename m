Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50352C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 21:34:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F13C20835
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 21:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="totN1nGW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F13C20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53857 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLaOU-0000p2-7B
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 17:34:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLaNc-0000Vs-Tg
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:33:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLaNb-00015B-RI
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:33:36 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLaNb-00012j-Fk
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:33:35 -0400
Received: by mail-wr1-x441.google.com with SMTP id r7so2934873wrr.13
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 14:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=fF6wSfjA+krUgwjzaRwFAUdGlcJZo1rUWudhIa5spGY=;
	b=totN1nGW5NimlV9BK0T6x+AO5C5rnnxtTLZJdHBmchy8+FXBB5cw08MYD/mOlLIAQR
	rAFOaoVlYhqYv+I2DqDlVptZzLxvjEZtcJ11uZkZmiKFvxWHv+340m6vGi9H004OOWph
	g482+fm7F92NPv4GMhFAOuLojMqQvS7O7wqsye/YzF16SAv8qwqwpsCtgEbjZt1fBMw0
	qBuAxczztk+KvsQ24+GZSypSjVO6TlMzqtzXUleUfGY7MQAtyx5TTgiGJD/nitAo61dG
	ht4IKohTrjINFlN2Ji3u4YIJzD4YVgveWYC59D7QMNTxP4YCGdMAItCtNZzAiIa/LC5S
	BQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=fF6wSfjA+krUgwjzaRwFAUdGlcJZo1rUWudhIa5spGY=;
	b=BiKaIm6Icbl7oUpYju5eIyZW4zP5jaYIqBHJ/fRX7Xn3RQ98QvIWe5ADZN2gWN9jqQ
	LoVWoPqcxahwWreNQO3jX8EjPusYb3BcD7+c18NUi18VUhy1cilnhSl5iuXpaD28vt6g
	JT/4MWPFBh+vKCKivKKNccT1gavuDPrA096UB6HXs6Vsjmjp3/2bt5XbDspE5Sy/8XiI
	1F1y3UNI3l6IYsUhTfjuMbyHplczEDNjYS1sOrYPIZ5g5N1F5xj1p72YGaInXbCnC2ft
	gy6eVj1DS251w/PBjgPfHln1hmY4+dEeKiVIjzRAIG/tXsu4tjyUf0odRIaI+hLE5Z2+
	bW+Q==
X-Gm-Message-State: APjAAAX/dDGNTHHs3OPUrenJxRToUGt5qwv2iDaFhdicUtI6Irhu02Hr
	Bpz4W1RV6WRKJvH+DpmAK3qkkg==
X-Google-Smtp-Source: APXvYqw+JNKS3AViL8P7jYpsz8+1HUgsqtlexmLorH2l+TEwlSOZIMIJsZpqz0dKWO94UYbjZSp/KA==
X-Received: by 2002:adf:ee50:: with SMTP id w16mr118539wro.257.1556660014478; 
	Tue, 30 Apr 2019 14:33:34 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	h81sm5332926wmf.33.2019.04.30.14.33.33
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 30 Apr 2019 14:33:33 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 63B5E1FF87;
	Tue, 30 Apr 2019 22:33:33 +0100 (BST)
References: <20190424103747.10173-1-thuth@redhat.com>
	<20190424103747.10173-4-thuth@redhat.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
In-reply-to: <20190424103747.10173-4-thuth@redhat.com>
Date: Tue, 30 Apr 2019 22:33:33 +0100
Message-ID: <87ftpz6uvm.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH 3/6] tests/qemu-iotests: Do not hard-code
 the path to bash
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
Message-ID: <20190430213333.p3haJncKmhyypVGSShp3L6zIcQ7c_Yyx9fmxLZd5RCk@z>


Thomas Huth <thuth@redhat.com> writes:

> bash is installed in a different directory on non-Linux systems like
> FreeBSD. Do not hard-code /bin/bash here so that the tests can run
> there, too.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/qemu-iotests/239 | 2 +-
>  tests/qemu-iotests/240 | 2 +-
>  tests/qemu-iotests/241 | 2 +-
>  tests/qemu-iotests/243 | 2 +-
>  tests/qemu-iotests/244 | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tests/qemu-iotests/239 b/tests/qemu-iotests/239
> index 6f085d573d..b0991ffe59 100755
> --- a/tests/qemu-iotests/239
> +++ b/tests/qemu-iotests/239
> @@ -1,4 +1,4 @@
> -#!/bin/bash
> +#!/usr/bin/env bash
>  #
>  # Test case for dmg
>  #
> diff --git a/tests/qemu-iotests/240 b/tests/qemu-iotests/240
> index 65cc3b39b1..d3e663ed65 100755
> --- a/tests/qemu-iotests/240
> +++ b/tests/qemu-iotests/240
> @@ -1,4 +1,4 @@
> -#!/bin/bash
> +#!/usr/bin/env bash
>  #
>  # Test hot plugging and unplugging with iothreads
>  #
> diff --git a/tests/qemu-iotests/241 b/tests/qemu-iotests/241
> index 017a736aab..58b64ebf41 100755
> --- a/tests/qemu-iotests/241
> +++ b/tests/qemu-iotests/241
> @@ -1,4 +1,4 @@
> -#!/bin/bash
> +#!/usr/bin/env bash
>  #
>  # Test qemu-nbd vs. unaligned images
>  #
> diff --git a/tests/qemu-iotests/243 b/tests/qemu-iotests/243
> index 5838c6e89c..e563761307 100755
> --- a/tests/qemu-iotests/243
> +++ b/tests/qemu-iotests/243
> @@ -1,4 +1,4 @@
> -#!/bin/bash
> +#!/usr/bin/env bash
>  #
>  # Test qcow2 preallocation
>  #
> diff --git a/tests/qemu-iotests/244 b/tests/qemu-iotests/244
> index d8e7122305..13978f93d2 100755
> --- a/tests/qemu-iotests/244
> +++ b/tests/qemu-iotests/244
> @@ -1,4 +1,4 @@
> -#!/bin/bash
> +#!/usr/bin/env bash
>  #
>  # Test qcow2 with external data files
>  #


--
Alex Benn=C3=A9e


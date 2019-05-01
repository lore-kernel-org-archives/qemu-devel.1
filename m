Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F221FC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 08:31:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEB5220835
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 08:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YXyDIAHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB5220835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40122 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLkdx-0000uI-Uc
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 04:31:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLkav-0007BU-4I
	for qemu-devel@nongnu.org; Wed, 01 May 2019 04:28:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLkar-0007gG-Fl
	for qemu-devel@nongnu.org; Wed, 01 May 2019 04:28:00 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLkar-0007eC-A8
	for qemu-devel@nongnu.org; Wed, 01 May 2019 04:27:57 -0400
Received: by mail-wr1-x443.google.com with SMTP id c12so23818884wrt.8
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 01:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=nDLuVCB+xGNjN5WaZ/GZ7ScMlfclEqJ+faNbI3cqtpE=;
	b=YXyDIAHn5QHBXPc++1/Hs923RCmfXxfjWY1/e3dGAVc6vKIEG47IjAEWnfZNGeIx9C
	v+EmsSjrdToFcp7lcPmR2iKs2OidmahzRi30jDaTUePiQeooxgoAH4a8+874rlZmcVl4
	Tw5coyOrWjhQl244X9difoA/b3yF4vA/FK0PmVggPcj0c4zacvtIgRFjM6IhYk5oLmP1
	HkUECPGSZxeUMFWVPnrH9Nd7IRWIZnwOdZmK2XGu1YvfNnn6kTZMCM+AZC0OeQ5PudNh
	qXmR70zaJsmU6bUg/ATKUafLPEyLwRYaaNUT4fAMytwT5zZhtbgRWBKwdgpvkqpMXa1I
	V+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=nDLuVCB+xGNjN5WaZ/GZ7ScMlfclEqJ+faNbI3cqtpE=;
	b=C191TwmYe3qUWEvFjHa+0XZmLERSMotUJCE9HmQKyEXMrrkZmYvR3jARNiqDRQsgxd
	AN9ucqr4F0VKV+0gtV9rOBbf6ejnSQiSIQU70zkasW/8KZwh7cghXfgZpFRC3FynUNI6
	cfPEQTwr7zggIsdHn/YRC71BUAqKLnpzs7x9kHUuzyUN4aHxjiZ43sZlvuqn08fJi/Nd
	SVYtcErZLJ2yQCe3A0wlrk626cASwHjaT9Ca9ma4KeD/gTjFZtoDaDjO2ZQjOXf+lFVG
	ODfBTNzkuUSIv5bH7gAvb21r+eaydui1tTkzmYah5ZIBN0xhFaI8TkL90iMkkFhLS3MP
	4SWA==
X-Gm-Message-State: APjAAAXhCRZwZpwcY56jvkgbjO20Tj/rIzyfrQV+oAOL01IRt3X4oV0O
	XWrMfv7OQJi1T40ohD0TO05/Yg==
X-Google-Smtp-Source: APXvYqzJG3QxWsFSTTEE4B+bDiF8dtz+bl8+bWWCgQZ71fEH2JlF1j89IoBnbqeh0cr68rSSsGFM9Q==
X-Received: by 2002:a05:6000:11ce:: with SMTP id
	i14mr19618173wrx.37.1556699273603; 
	Wed, 01 May 2019 01:27:53 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	n63sm4701250wmn.38.2019.05.01.01.27.52
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 01 May 2019 01:27:52 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 9711D1FF87;
	Wed,  1 May 2019 09:27:52 +0100 (BST)
References: <20190428155451.15653-1-thuth@redhat.com>
	<20190428155451.15653-5-thuth@redhat.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
In-reply-to: <20190428155451.15653-5-thuth@redhat.com>
Date: Wed, 01 May 2019 09:27:52 +0100
Message-ID: <87d0l27f5j.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v2 4/8] tests/qemu-iotests: Do not
 hard-code the path to bash
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
Message-ID: <20190501082752.X1mybpon4_9XJHpUBvp8UBToU3TIOml_Dlz89j87EIM@z>


Thomas Huth <thuth@redhat.com> writes:

> bash is installed in a different directory on non-Linux systems like
> FreeBSD. Do not hard-code /bin/bash here so that the tests can run
> there, too.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
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


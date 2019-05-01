Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AC5C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 16:39:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 437092064A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 16:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TWfw935L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 437092064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36459 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLsGo-0004Gl-Ck
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 12:39:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLsES-00033w-7Z
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:37:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLsEO-0004bd-Bf
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:37:19 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLsEI-0003wx-0j
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:37:12 -0400
Received: by mail-wr1-x443.google.com with SMTP id l2so9537741wrb.9
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 09:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=8mb48VPq7KVrOHKEVZWyCDgxHi63oQEkLPNhdxhe5lE=;
	b=TWfw935LtDtL737z3VVDt7zuSZaPTezbKsgXGug5RKv4tegKaaUttUbIPyw42zMrUK
	xr3sm+ZsEyhsHmr3sI/ROxifw96ToQfYpXCTL2miEsKVrWPHzvo2KFwZKawN7oi4TaVn
	sEw1zrTEVYY33pgGVUUjks+0JXCBeS/TlW5yIC4LwNJhfoTNz14AvSZ+SIuxnHH6Oncq
	KlHug25lJ7XSiNVAoZ6EbujfDMzcm3erfafneBXvHDlys3wB2pvCa3iVebJcMBO8oXtP
	8B5Qt5saTLOo/AK9VFSCjYfx8kA5MyIIoBrGJyt2jcmlDpTBeB18j6B6P5Q3c9KVD/wC
	heMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=8mb48VPq7KVrOHKEVZWyCDgxHi63oQEkLPNhdxhe5lE=;
	b=HUN3dYEoHJIVx3+WGTuonhivDkeiUODX1AUaCaRawYQxp1kFmQF5DYQm/W6VxvzRM4
	ofkM8dz4kfYKrA0bB1wKUM984tfYgvmIxSMf/IPuLT4GK1kU4ugAoiKUziw7StwWNB5n
	6fkmgsL6jAHCgxtbD4z2I1dGFAU+rSX1J3JKVGlMHe7VJEii1U02A6rHsAf0QY2c1JTa
	uFysXDbxocDhJMZoNJ40O/P0CIlzhmZwuhNUE03CGY/GSBQ1x1ARXM1eMUqMd0Uh4ltA
	8DKdQZfe2JCLDfedwAUv8rmPoIE2Z2aA7/aNP58vkUxsevC2SsCuIKtfVa0s9QrugzBk
	xtbg==
X-Gm-Message-State: APjAAAUibFxx5kVzp10hSGWLsdwprlkKpuOgyGzfp+cBw4Zuuu0ro9HK
	c/MKtOycudgXvWmI+SVkJUAH2g==
X-Google-Smtp-Source: APXvYqw/GAyxEyu8evRJEOdHS7IVGlKYoV7E/T1bHHwu7DpHsO3g1HfLgnCkQ0Kn18dZ9RdcSLWETA==
X-Received: by 2002:adf:9792:: with SMTP id s18mr21762036wrb.133.1556728623755;
	Wed, 01 May 2019 09:37:03 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id j10sm5174775wrb.0.2019.05.01.09.37.02
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 01 May 2019 09:37:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 9C73D1FF87;
	Wed,  1 May 2019 17:37:02 +0100 (BST)
References: <20190428155451.15653-1-thuth@redhat.com>
	<20190428155451.15653-8-thuth@redhat.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
In-reply-to: <20190428155451.15653-8-thuth@redhat.com>
Date: Wed, 01 May 2019 17:37:02 +0100
Message-ID: <87sgty5dxt.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v2 7/8] tests/qemu-iotests/group: Re-use
 the "auto" group for tests that can always run
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
Message-ID: <20190501163702.NewiqtPOv4834i_9J4KEbZfyVFZxV22RRa7TY0WDi5g@z>


Thomas Huth <thuth@redhat.com> writes:

> Currently, all tests are in the "auto" group. This is a little bit pointl=
ess.
> OTOH, we need a group for the tests that we can automatically run during
> "make check" each time, too. Tests in this new group are supposed to run
> with every possible QEMU configuration, for example they must run with ev=
ery
> QEMU binary (also non-x86), without failing when an optional features
> is

I'm curious as to what tests fail on non-x86? I was under the naive
impression that at least for Linux all the file-system relevant bits
where fairly uniformly implemented.

> missing (but reporting "skip" is ok), and be able to run on all kind of h=
ost
> filesystems and users (i.e. also as "nobody" or "root").
> So let's use the "auto" group for this class of tests now. The initial
> list has been determined by running the iotests with non-x86 QEMU targets
> and with our CI pipelines on Gitlab, Cirrus-CI and Travis (i.e. including
> macOS and FreeBSD).
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>



> ---
>  tests/qemu-iotests/group | 169 +++++++++++++++++++++------------------
>  1 file changed, 91 insertions(+), 78 deletions(-)
>
> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> index bae7718380..4d0b6ae256 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -1,8 +1,21 @@
>  #
>  # QA groups control file
>  # Defines test groups
> +#
> +# Some notes about the groups:
> +#
>  # - do not start group names with a digit
>  #
> +# - quick : Tests in this group should finish within some few seconds.
> +#
> +# - img : Tests in this group can be used to excercise the qemu-img tool.
> +#
> +# - auto : Tests in this group are used during "make check" and should be
> +#   runnable in any case. That means they should run with every QEMU bin=
ary
> +#   (also non-x86), with every QEMU configuration (i.e. must not fail if
> +#   an optional feature is not compiled in - but reporting a "skip" is o=
k),
> +#   and work all kind of host filesystems and users (e.g. "nobody" or "r=
oot").
> +#
>
>  #
>  # test-group association ... one line per test
> @@ -32,11 +45,11 @@
>  023 rw auto
>  024 rw backing auto quick
>  025 rw auto quick
> -026 rw blkdbg auto
> +026 rw blkdbg
>  027 rw auto quick
>  028 rw backing auto quick

028 failed on an armhf host for me.

>  029 rw auto quick
> -030 rw auto backing
> +030 rw backing
<snip>
> +245 rw
> +246 rw quick
>  247 rw auto quick

And 247

> -248 rw auto quick
> +248 rw quick


--
Alex Benn=C3=A9e


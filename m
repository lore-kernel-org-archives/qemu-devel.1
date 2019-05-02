Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36548C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 17:38:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0445E20652
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 17:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gS9TxcxN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0445E20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56542 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMFfY-0007rD-VR
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 13:38:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMFeM-00072Z-D4
	for qemu-devel@nongnu.org; Thu, 02 May 2019 13:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMFeL-0005mk-BH
	for qemu-devel@nongnu.org; Thu, 02 May 2019 13:37:38 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55138)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMFeL-0005lX-4L
	for qemu-devel@nongnu.org; Thu, 02 May 2019 13:37:37 -0400
Received: by mail-wm1-x342.google.com with SMTP id b10so4011254wmj.4
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 10:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=8EprSsILvaAOq1CH1gcyjd56cor3ORw8ywifqlso6/E=;
	b=gS9TxcxNsJr8naZedxEvjfeA7GYd/YL2GRpu2NFgglpF+J1bFdFSUwQanWCiShdRO9
	3PsrC9uKKRv6T2+EWLUbMrDo082R8H87MP+AVW9hZAabNLplomq6Kr2Ij0JZuCa7nVhg
	55dM2ZEasbKS5WNjuGsT/Cuh+hLTJ0S2qFpqSTB1iqUPrhIPSe/t4s6UfeRSNu56HCAh
	n8DddLsCpsyuaNsDuQ8PHLNsX/V2AMNUET+GfO20xWgH/rf3zkL4athFYRZ7y72HW2X9
	+82aTLAfY6pGkxOyerF5FP0Pkte+D0HEORkd0DYKF0JB5vFrsX/VNWUmFXYZ+BD6cs6Q
	hnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=8EprSsILvaAOq1CH1gcyjd56cor3ORw8ywifqlso6/E=;
	b=k9wWE2b5Ej86pj7bBbOkf/UDK4IMZ5cstj8ki8zLhunL86JpZLZCaOkGpmgyPQgf8O
	KxIYCZFON647zMUrPerKgctCqXmHAD1YYR2fs79NvtvNKA0y+yuGpd1mscvGy7OelM47
	aCFGI4FK9Hxhex1RASSD5unfZHp2O77oPSRUFHTs3V+hOGFv3n7glIrNFIJ1dfvp+2HP
	i7QQNvruTVK+ZRYURmMVBT50nUVbWhGrObx2D/4GIwAK6NAnsJO5+onPGzz+S3ar4bk9
	NpRcAwspQ2xnv8dUFWVwN8OhPkINZ3JPXzOQaqaGOsHGjCpD6ZYaPXvydoZGeysI1JT5
	cGjg==
X-Gm-Message-State: APjAAAWxtm7sDyn4HJ4iO9SzdsWd3RiClfIOXmvRQDueQKyEyaTznEeF
	leE7s/7hDWh9OhkGGyF7Bdkidg==
X-Google-Smtp-Source: APXvYqw/6/xvnD6qLvfzQpugFgG8HTZz8MDxfPq2UjOSDesvxGOjUKBE7I3Huo7H8eL8tpVsW3cBrQ==
X-Received: by 2002:a1c:720b:: with SMTP id n11mr3130454wmc.81.1556818655415; 
	Thu, 02 May 2019 10:37:35 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	p67sm9398888wmp.22.2019.05.02.10.37.34
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 10:37:34 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 3490C1FF87;
	Thu,  2 May 2019 18:37:34 +0100 (BST)
References: <20190502084506.8009-1-thuth@redhat.com>
	<20190502084506.8009-2-thuth@redhat.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
In-reply-to: <20190502084506.8009-2-thuth@redhat.com>
Date: Thu, 02 May 2019 18:37:34 +0100
Message-ID: <87y33o4v1d.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v3 1/7] tests/qemu-iotests/005: Add a
 sanity check for large sparse file support
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
	qemu-devel@nongnu.org, Christophe Fergeau <cfergeau@redhat.com>,
	Max Reitz <mreitz@redhat.com>,
	Wainer dos Santos Moschetta <wainersm@redhat.com>,
	Philippe =?utf-8?Q?M?= =?utf-8?Q?athieu-Daud=C3=A9?=
	<philmd@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
	Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502173734.8xG99k0fAWpGt5NkILlexIEgQLBwAC4ZzH7i7waaW9o@z>


Thomas Huth <thuth@redhat.com> writes:

> "check -raw 005" fails when running on certain filesystems - these do not
> support such large sparse files. Use the same check as in test 220 to
> skip the test in this case.
>
> Suggested-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/qemu-iotests/005 | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/tests/qemu-iotests/005 b/tests/qemu-iotests/005
> index 2fef63af88..9c7681c19b 100755
> --- a/tests/qemu-iotests/005
> +++ b/tests/qemu-iotests/005
> @@ -55,6 +55,15 @@ if [ "$IMGPROTO" =3D "sheepdog" ]; then
>      _notrun "image protocol $IMGPROTO does not support large image sizes"
>  fi
>
> +# Sanity check: For raw, we require a file system that permits the creat=
ion
> +# of a HUGE (but very sparse) file. Check we can create it before contin=
uing.
> +if [ "$IMGFMT" =3D "raw" ]; then
> +    if ! truncate --size=3D5T "$TEST_IMG"; then
> +        _notrun "file system on $TEST_DIR does not support large enough =
files"
> +    fi
> +    rm "$TEST_IMG"
> +fi
> +
>  echo
>  echo "creating large image"
>  _make_test_img 5000G


--
Alex Benn=C3=A9e


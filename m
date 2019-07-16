Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C523C76195
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 11:02:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F0152173B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 11:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Okf3mvEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F0152173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnLEW-00017A-Aa
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 07:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58631)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hnLEE-0000NB-6a
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 07:02:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hnLED-0006z2-5T
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 07:02:38 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:43160)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hnLEC-0006yE-U6
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 07:02:37 -0400
Received: by mail-wr1-x42a.google.com with SMTP id p13so20420198wru.10
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 04:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=uCxvwRf0zmjRkSLeCfxV8X0vFoSit2gTQJPmCMs82IM=;
 b=Okf3mvEU9cNLis5MwkStH5924vr/c5qozsOpk3LV5xLT4ib/meNgsrD1CkLl1p3feH
 Kyv17J8OkpRt9INXhI3pFrNx4udvZzA7Cf1s0Q0YRkN2BxRTZy7FuOdcfTt7daEbfGWM
 2MjbfKBD+24vOLcN4nKG3wKteYvRpoXBBzfxFWbzH4Skz0k9i87aUQ/0cwtIR2GJmz+h
 lB16XytWvXHh+9PK8k+7w158tvVpj6BwJ+LCZvgGb4MfcMzObCPCNwyraboxADHEK6yI
 3tAT9IN4/QeZ/5RZdXTnN/JnC2ZhcmGKV6tm8JmcRdKtygADa21Xs9u4UZF3NbFvYvT9
 b84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=uCxvwRf0zmjRkSLeCfxV8X0vFoSit2gTQJPmCMs82IM=;
 b=oeo8AB+BdaYsbB2Y6w5zVeTP+BS5dGwU1FmmXwHssziS53dLKLWf2j0+H8+UN6OcBv
 NQ7JEMq5oH0JrmERVa08gv5LpvO8xDow70lVDpS+Ag6ZFY6P/HnUNb4unplhdxocA3Q8
 r1OZFJrJOlK/pYXtCsZ+Ee/T2TfyGgMaPc/qf4g42BiDB1hqLcAz7P0Jge4vF73nduGs
 t9pE9Ec40cBArl22nVcAtqaIr9Rf/2S7gGFz+NaYsB45FjasfChq8So/kcHJbmR5jQoR
 8MUI4fP/rs7yke5Oz27bboWuyK0kbfj45FtsAYJjU81bhOqAUd83g13k08+HZOHZzX+K
 aUkw==
X-Gm-Message-State: APjAAAWV+zyFgAormlbxbAW73QBMjDULrokRy7qTKpLLHAEs+ocClIq9
 71eefXDFSkuYHNXXluCG2jKxMA==
X-Google-Smtp-Source: APXvYqymhpFy26WsrvFSXLEklx0lkkdyKuGrrrx8eGFu5Zetfhi1S9joB6cG1FVdOQUpKLFxes/Nyw==
X-Received: by 2002:adf:ed41:: with SMTP id u1mr34014283wro.162.1563274955436; 
 Tue, 16 Jul 2019 04:02:35 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id x11sm14759752wmi.26.2019.07.16.04.02.34
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 16 Jul 2019 04:02:34 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2CE791FF87;
 Tue, 16 Jul 2019 12:02:34 +0100 (BST)
References: <20190715174817.18981-1-philmd@redhat.com>
User-agent: mu4e 1.3.3; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
In-reply-to: <20190715174817.18981-1-philmd@redhat.com>
Date: Tue, 16 Jul 2019 12:02:34 +0100
Message-ID: <87d0iautrp.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v2 0/9] tests/docker: Debian & MXE
 fixes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Helge Deller <deller@gmx.de>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?utf-8?Q?C?= =?utf-8?Q?=C3=A9dric?= Le Goater <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>, Laszlo Ersek <lersek@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Few more patches to be able to MXE-build the NSIS installers.
>
> The Fedora kludge is not meant for merge, but might be useful to
> test this series.

Queued to 2-9 to testing/next, thanks.

>
> Based-on: 20190712111849.9006-1-alex.bennee@linaro.org
> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg03014.html
>
> Philippe Mathieu-Daud=C3=A9 (9):
>   tests/docker: Kludge to build the Fedora image
>   tests/docker: Install Sphinx in the Debian images
>   tests/docker: Install the NSIS tools in the MinGW capable images
>   tests/docker: Set the correct cross-PKG_CONFIG_PATH in the MXE images
>   tests/docker: Install texinfo in the Fedora image
>   buildsys: The NSIS Windows build requires the documentation installed
>   buildsys: The NSIS Windows build requires qemu-nsis.bmp installed
>   tests/docker: Let the test-mingw test generate a NSIS installer
>   NSIS: Add missing firmware blobs
>
>  Makefile                                           | 3 ++-
>  qemu.nsi                                           | 3 +++
>  tests/docker/dockerfiles/debian-win32-cross.docker | 6 ++++++
>  tests/docker/dockerfiles/debian-win64-cross.docker | 6 ++++++
>  tests/docker/dockerfiles/debian10.docker           | 1 +
>  tests/docker/dockerfiles/debian9.docker            | 1 +
>  tests/docker/dockerfiles/fedora.docker             | 5 ++++-
>  tests/docker/test-mingw                            | 1 +
>  8 files changed, 24 insertions(+), 2 deletions(-)


--
Alex Benn=C3=A9e


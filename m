Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128E6C4363C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 18:11:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C3D5207BC
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 18:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="njCen4dB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C3D5207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKQI9-00060D-Gw
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 14:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kKQFS-0003C1-Q7
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 14:09:12 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39165)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kKQFQ-0003df-Ol
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 14:09:10 -0400
Received: by mail-wm1-x344.google.com with SMTP id b79so393423wmb.4
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 11:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=jqtNFdr8809VewkDShG7r+AYOEpg/oywk7J4pfqbz7A=;
 b=njCen4dBuHnz5iYVAMAvoCeoy/aalO3Ulqy1LFny8xoGxcseAs7SMkvCabarEIyt1B
 JnY2AusVN6yaZFdmTxo1kqxCzWMdGqqVORHYeVriCS1G2AdQyMy6+lwycNQfbaQI3tZN
 EnsmYzfSMTS8BMmGaBHiuM1Z5YOtitrBF7Z8FPpXlO8N2C5pjjRHIegLAgl3BnxMgacm
 LZM7qI4U8WhZKQjOveMn/FcXJMZYFYh0L6QDdMNDIqAoPrg4c2+WDaoh0KoRer2Y8r7m
 /a9b6fUeFG9UFiaWmaJBNFCnuEGBgSoj3Y/7JALbYnwJPfgQHlTJ4qBw2cIkFuFkfwOj
 jxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=jqtNFdr8809VewkDShG7r+AYOEpg/oywk7J4pfqbz7A=;
 b=II7tLR0KtZbm260jENQZD4J4/dbvz7nNu+eeVMU1XVZk8SWHCLJcUKsrCoBH9NorbS
 +wK+s9JD/YwAt+ZMe76bRHNknmxonDbMYXFE1Dm0Wl0F4gPp9BICVbymC+VQbN6C9PTl
 5pe+ueMqBlh3gJEEsAEzmtuaA9wKnuC+HwJV8FBFVw0Jqh3fTVRKNezRm8P7Ta8U1rKK
 I+TgzLWNjVXoB4RQ4P730UY+/99Ad0agCuKTNMYBE7+Sc+prluq5MwBgUcjsiagXYz78
 3Ff2cUKRwGTQR83HdDyM8UtwKFALVdOGjL+ATCj6LSflA5ktnw72WktlY1KQcuJJvlUf
 7fxA==
X-Gm-Message-State: AOAM532L8Ye6XPaencpUcZdwMzgOpZs5yIphCsi3eS8IfSmjbwd3iw6h
 h0t5Z1LwIpjhe7b4i3rAmPxWkM4R7vQAaA==
X-Google-Smtp-Source: ABdhPJykxChrQEn/mDOBBfo+ZSSyO8sqaYgHaDEC9sJcFIpRJwlRWrjFAUz2aLUThKxhMH5Woe6snw==
X-Received: by 2002:a1c:31c6:: with SMTP id x189mr592937wmx.83.1600711745223; 
 Mon, 21 Sep 2020 11:09:05 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c205sm505313wmd.33.2020.09.21.11.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 11:09:04 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 94AD51FF7E;
 Mon, 21 Sep 2020 19:09:03 +0100 (BST)
References: <20200921174320.46062-1-thuth@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 0/7] Do not support Debian 9 and Python 3.5 anymore
In-reply-to: <20200921174320.46062-1-thuth@redhat.com>
Date: Mon, 21 Sep 2020 19:09:03 +0100
Message-ID: <87r1qvngsg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: =?utf-8?Q?Daniel_P_=2E?= =?utf-8?Q?_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> Debian 9 is EOL now, and according to our support policy, we do not
> support it anymore. Let's switch the corresponding CI builds to
> either Fedora (for a more recent version of the MinGW compilers) or
> Debian 10 instead.
>
> Together with the Travis patch series that I recently posted ("Update
> Travis from Xenial to Bionic and Focal"), our CI should now be free of
> distros that we do not support anymore. And all supported build systems
> now use at least Python 3.6, so we can drop the support for Python 3.5.
>
> Based-on: <20200918103430.297167-1-thuth@redhat.com>

I'm inclined to take all of these but I'll take all the CI based ones
now and add the 3.6 bump if there is more review/acks for it.

>
> Thomas Huth (7):
>   tests/docker: Use Fedora containers for MinGW cross-builds in the
>     gitlab-CI
>   gitlab-ci: Remove the Debian9-based containers and containers-layer3
>   tests/docker: Update the tricore container to debian 10
>   shippable.yml: Remove the Debian9-based MinGW cross-compiler tests
>   tests/docker: Remove old Debian 9 containers
>   gitlab-ci: Increase the timeout for the cross-compiler builds
>   configure: Bump the minimum required Python version to 3.6
>
>  .gitlab-ci.d/containers.yml                   | 38 +++++-----------
>  .gitlab-ci.d/crossbuilds.yml                  |  5 ++-
>  .gitlab-ci.yml                                |  1 -
>  .shippable.yml                                |  4 --
>  configure                                     |  4 +-
>  tests/docker/Makefile.include                 |  2 +-
>  .../dockerfiles/debian-tricore-cross.docker   |  2 +-
>  .../dockerfiles/debian-win32-cross.docker     | 38 ----------------
>  .../dockerfiles/debian-win64-cross.docker     | 45 -------------------
>  tests/docker/dockerfiles/debian9-mxe.docker   | 21 ---------
>  tests/docker/dockerfiles/debian9.docker       | 32 -------------
>  .../dockerfiles/fedora-win32-cross.docker     | 42 +++++++++++++++++
>  .../dockerfiles/fedora-win64-cross.docker     | 38 ++++++++++++++++
>  13 files changed, 98 insertions(+), 174 deletions(-)
>  delete mode 100644 tests/docker/dockerfiles/debian-win32-cross.docker
>  delete mode 100644 tests/docker/dockerfiles/debian-win64-cross.docker
>  delete mode 100644 tests/docker/dockerfiles/debian9-mxe.docker
>  delete mode 100644 tests/docker/dockerfiles/debian9.docker
>  create mode 100644 tests/docker/dockerfiles/fedora-win32-cross.docker
>  create mode 100644 tests/docker/dockerfiles/fedora-win64-cross.docker


--=20
Alex Benn=C3=A9e


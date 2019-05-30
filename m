Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE3CC28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 09:38:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9890625657
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 09:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MsEIgQWt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9890625657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50031 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWHVd-00073C-RO
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 05:38:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWHRc-00042U-AG
	for qemu-devel@nongnu.org; Thu, 30 May 2019 05:33:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWHRb-0007ev-7I
	for qemu-devel@nongnu.org; Thu, 30 May 2019 05:33:56 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWHRb-0007cz-0F
	for qemu-devel@nongnu.org; Thu, 30 May 2019 05:33:55 -0400
Received: by mail-wm1-x344.google.com with SMTP id f204so3511288wme.0
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 02:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=cTi15vGZMWIuIPasT+GSS62Y+NmfDeniWY0X2jEDd8g=;
	b=MsEIgQWt9gcSuLvQVFUFn8lP0Vi4WHg6xD/+8ii+jZ7vr+f5fU6KvLYiP3aser87QJ
	hbYliKrXmjEuVQgTd66EiG5eTNp4mOHLoyAi96zjVwa/u7k9dY2NB/joW2RX4rlQbmN9
	e4+W5bj7PUeEUOWiYQi0mcGuL9CrVJz0mkIO4UNq9YWJJeLyd39FLDcgiCH5+YGpRugG
	eAG6ceBGDGElY7Cjm/diZTOl8Qfs4wbt0xDPgMgxDKrxhbOlDK/KuH/kEYMYaTAx3j1P
	EA3zz3Kn4iiaeOg/I2OJ8FOfyvrACBr7TPlzvC5PubSxx8YYaj5+nfBwwnBGHKiAiy4p
	t7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=cTi15vGZMWIuIPasT+GSS62Y+NmfDeniWY0X2jEDd8g=;
	b=dNkP1bdiXUbcH+xkYws1ntBz/ryxVBjx0oas3VJTAgw1YBxj/LmzXwuo09eCbIoJWj
	/vDIDD1XwuQKFJ0+G39WY5gcr7COZuo4eIc4hGZFSBbJnh+9aE3v9pPhKaKTORIgqf1v
	tWMLjaN7xaI6Nl0040kpkGUmXZ83/ejLrcFfD15zcOZxiNi11b7oXv51hSE7chDNlxW5
	ZGgJzi7dfjSyrQwoULe56dsfjp15X48fnWTc8EkzVEbgp6fSdaEVLycNdmObZhag0GGg
	GwtypetUkzgjYjUVSqwmBXSv2yV5mS8LoWTvC1YZZOJY+fvBsdz8y8cZwM1dmT4Mqx8b
	h3XA==
X-Gm-Message-State: APjAAAWmLTpdSzH1zFIEN6sRqOVYVFKVUSOLApHG1RQBHWltS/n9Ks3I
	Zgh9ZGBK5Dr68yEf1+TI6nAwKg==
X-Google-Smtp-Source: APXvYqw+0ariAC3KFPFpADx4Iqxn1YpEfV7dhdQ7EJoRXiCKpujYOdVCh4xYnYUSsscMXiCrDx4LBw==
X-Received: by 2002:a1c:63d7:: with SMTP id x206mr1667000wmb.19.1559208833106; 
	Thu, 30 May 2019 02:33:53 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id r8sm2609874wrr.63.2019.05.30.02.33.51
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 30 May 2019 02:33:52 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 804AE1FF87;
	Thu, 30 May 2019 10:33:51 +0100 (BST)
References: <20190520124716.30472-1-kraxel@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gerd Hoffmann <kraxel@redhat.com>
In-reply-to: <20190520124716.30472-1-kraxel@redhat.com>
Date: Thu, 30 May 2019 10:33:51 +0100
Message-ID: <878suo5ls0.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v3 00/14] tests/vm: serial console
 autoinstall, misc fixes.
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
	qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Gerd Hoffmann <kraxel@redhat.com> writes:

> This patch series changes the way virtual machines for test builds are
> managed.  They are created locally on the developer machine now.  The
> installer is booted on the serial console and the scripts walks through
> the dialogs to install and configure the guest.
>
> That takes the download.patchew.org server out of the loop and makes it
> alot easier to tweak the guest images (adding build dependencies for
> example).
>
> The install scripts take care to apply host proxy settings (from *_proxy
> environment variables) to the guest, so any package downloads will be
> routed through the proxy and can be cached that way.  This also makes
> them work behind strict firewalls.
>
> There are also a bunch of smaller tweaks for tests/vm to fix issues I
> was struggling with.  See commit messages of individual patches for
> details.

Queued to testing/next, thanks.

One of the machines I'm testing on seems to have problems with getting
the installer working over the serial link but it works on my main dev
box and others have it working as well so I suspect it might be a local
problem.

>
> v3:
>  - python3 fixes.
>  - openbsd: configure memory limits.
>  - freebsd: configure autoboot delay.
>
> Gerd Hoffmann (14):
>   scripts: use git archive in archive-source
>   tests/vm: python3 fixes
>   tests/vm: send proxy environment variables over ssh
>   tests/vm: use ssh with pty unconditionally
>   tests/vm: run test builds on snapshot
>   tests/vm: proper guest shutdown
>   tests/vm: add vm-boot-{ssh,serial}-<guest> targets
>   tests/vm: add DEBUG=3D1 to help text
>   tests/vm: serial console support helpers
>   tests/vm: openbsd autoinstall, using serial console
>   tests/vm: freebsd autoinstall, using serial console
>   tests/vm: netbsd autoinstall, using serial console
>   tests/vm: fedora autoinstall, using serial console
>   tests/vm: ubuntu.i386: apt proxy setup
>
>  tests/vm/basevm.py        | 144 ++++++++++++++++++++++++-----
>  scripts/archive-source.sh |  72 +++++++--------
>  tests/vm/Makefile.include |  25 ++++-
>  tests/vm/fedora           | 187 ++++++++++++++++++++++++++++++++++++++
>  tests/vm/freebsd          | 179 ++++++++++++++++++++++++++++++++++--
>  tests/vm/netbsd           | 187 ++++++++++++++++++++++++++++++++++++--
>  tests/vm/openbsd          | 158 +++++++++++++++++++++++++++++---
>  tests/vm/ubuntu.i386      |   4 +
>  8 files changed, 858 insertions(+), 98 deletions(-)
>  create mode 100755 tests/vm/fedora


--
Alex Benn=C3=A9e


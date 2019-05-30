Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6934FC28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 09:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34D2C2567F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 09:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tM3QDgYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D2C2567F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50132 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWHcD-0003sD-Gs
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 05:44:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWHb3-0003GE-R1
	for qemu-devel@nongnu.org; Thu, 30 May 2019 05:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWHb2-0002QQ-Dd
	for qemu-devel@nongnu.org; Thu, 30 May 2019 05:43:41 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWHb2-0002Ot-7K
	for qemu-devel@nongnu.org; Thu, 30 May 2019 05:43:40 -0400
Received: by mail-wr1-x443.google.com with SMTP id d18so3742883wrs.5
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 02:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=p6q3T5Fo6eW67L07uFEmWtEWZRxiJK3l5INPTyrpzec=;
	b=tM3QDgYETXnF2a/KOocWGtjvkjquxki+ST24ty+Rt7/tYX8qwMH/HKCpK0xlPHMbeW
	bUG5tq70bCJBlUr3WwHG6O0YNLX6Xp9NjMjUscNm1pVV1MNZqOS2BuHp9+wo9Y1aqEBx
	yXfrXGtWiaaXyo3oATfc2VvCbmcgUmNupoEiWMI9Pz+5BD62YNUxtoqZrfh2whuyFcE9
	m0lmIzhZAUYiZF2AXarv6/Rzw1Ubcn+OjKRZ3ZShgniX/KD0dI4wmte17oqdbds2FDNE
	4C1H+JX3I88VetB1Avmx3MfI6yw9j/nw754U8Q0wAJ20dTneVs98ts/2+dnNliDRkL63
	k+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=p6q3T5Fo6eW67L07uFEmWtEWZRxiJK3l5INPTyrpzec=;
	b=ShuN/dXlAUE0GTx/maszo91aGcHP2kKux6rDvhGWB1it7mNMMU5dza5ENjsD6/mvrP
	eRV2PDloi8YlIDunOTHHAtwxD6trqPd4zQbYTYAxhK+gxvqw4ZoQ8pToilnriCUHfM3M
	jfh5TrdT9Otgcnt9RgDjLNMDdqN31VRcFSDXT5jmlEhcAba+/CC+yDBuptFoORkdshtJ
	52VWctD7ujR8TCRtWAQaohtQ2u0iTqLv7HPHRi7bofoq6oh57lfYACrJI4RvTi1XrBOX
	kkvw92wv3Z4+sgdYe2G/upniT3ZJPWxbMMkZOkZ5KfoaFDEEJzvLD2hTuS8GPauJ8+M7
	szCQ==
X-Gm-Message-State: APjAAAVqRS5v59n4d/tKNwufTpFvJY84EDEx1YXCTMYXO9gyJOgiwgBG
	rSmhILljP5EAHgN49YZJ+sEjwt8X88Q=
X-Google-Smtp-Source: APXvYqy6+fmTfvAsZiz3WQAehaHLXyiZ0LoM2ozc8UqCmdiVgZ/G2vgxZE7ERo8xiEQAwc6SzDvWRQ==
X-Received: by 2002:adf:ab45:: with SMTP id r5mr1942196wrc.100.1559209418077; 
	Thu, 30 May 2019 02:43:38 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id s8sm2192713wra.55.2019.05.30.02.43.37
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 30 May 2019 02:43:37 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id BD7AE1FF87;
	Thu, 30 May 2019 10:43:36 +0100 (BST)
References: <20190520124716.30472-1-kraxel@redhat.com>
	<155835775478.22.12860360999794172452@5d2e01a8a801>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <155835775478.22.12860360999794172452@5d2e01a8a801>
Date: Thu, 30 May 2019 10:43:36 +0100
Message-ID: <877ea85lbr.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


no-reply@patchew.org writes:

> Patchew URL: https://patchew.org/QEMU/20190520124716.30472-1-kraxel@redha=
t.com/
>
>
>
> Hi,
>
> This series seems to have some coding style problems. See output below for
> more information:
>
> Subject: [Qemu-devel] [PATCH v3 00/14] tests/vm: serial console autoinsta=
ll, misc fixes.
> Message-id: 20190520124716.30472-1-kraxel@redhat.com
> Type: series
>
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>
> From https://github.com/patchew-project/qemu
>    1b46b4daa6..6d8e75d41c  master     -> master
> From https://github.com/patchew-project/qemu
>  * [new tag]               patchew/20190520124716.30472-1-kraxel@redhat.c=
om -> patchew/20190520124716.30472-1-kraxel@redhat.com
> Switched to a new branch 'test'
> 6f7f5d5a99 tests/vm: ubuntu.i386: apt proxy setup
> ef70a753bb tests/vm: fedora autoinstall, using serial console
> 0debc608fb tests/vm: netbsd autoinstall, using serial console
> 5e005a2c07 tests/vm: freebsd autoinstall, using serial console
> bff0400f4e tests/vm: openbsd autoinstall, using serial console
> 59085882aa tests/vm: serial console support helpers
> 27ef52c336 tests/vm: add DEBUG=3D1 to help text
> 128b742fc5 tests/vm: add vm-boot-{ssh, serial}-<guest> targets
> 2eb095b079 tests/vm: proper guest shutdown
> 4f3a1fed99 tests/vm: run test builds on snapshot
> d3850e7e8e tests/vm: use ssh with pty unconditionally
> 9d18c76436 tests/vm: send proxy environment variables over ssh
> 9bb50d9be2 tests/vm: python3 fixes
> 76e6f4270e scripts: use git archive in archive-source
>
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> 1/14 Checking commit 76e6f4270ef3 (scripts: use git archive in archive-so=
urce)
> ERROR: code indent should never use tabs
> #41: FILE: scripts/archive-source.sh:36:
> +^Igit submodule deinit $sub_deinit$
>
> ERROR: code indent should never use tabs
> #68: FILE: scripts/archive-source.sh:56:
> +^I-*)$
>
> ERROR: code indent should never use tabs
> #69: FILE: scripts/archive-source.sh:57:
> +^I    sub_deinit=3D"$sub_deinit $sm"$
>
> ERROR: code indent should never use tabs
> #70: FILE: scripts/archive-source.sh:58:
> +^I    git submodule update --init "$sm"$
>
> ERROR: code indent should never use tabs
> #71: FILE: scripts/archive-source.sh:59:
> +^I    test $? -ne 0 && error "failed to update submodule $sm"$
>
> ERROR: code indent should never use tabs
> #72: FILE: scripts/archive-source.sh:60:
> +^I    ;;$
>
> ERROR: code indent should never use tabs
> #73: FILE: scripts/archive-source.sh:61:
> +^I+*)$
>
> ERROR: code indent should never use tabs
> #74: FILE: scripts/archive-source.sh:62:
> +^I    echo "WARNING: submodule $sm is out of sync"$
>
> ERROR: code indent should never use tabs
> #75: FILE: scripts/archive-source.sh:63:
> +^I    ;;$
>
> total: 9 errors, 0 warnings, 93 lines checked

I'll fix these up but it might be worth seeing how that crept into your
editor? I'll include an update to editorconfig while I'm at it.

--
Alex Benn=C3=A9e


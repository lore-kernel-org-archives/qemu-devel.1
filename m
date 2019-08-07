Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C6FC433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 12:40:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2F5B21BF6
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 12:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BAecCQOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F5B21BF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvLF8-0003F5-5L
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 08:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45973)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hvLEb-0002lp-EG
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 08:40:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hvLEa-0006yt-B1
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 08:40:05 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34302)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hvLEa-0006xk-0x
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 08:40:04 -0400
Received: by mail-wm1-x344.google.com with SMTP id e8so1279023wme.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 05:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ncMG+qVQw7DsSkLYvlYjsLOcG4Qxwsrf2tQhwZ3fD+o=;
 b=BAecCQOYZcL4ziXy3m/D8SNe1McDjrK5xFlPwax/4//mgk5JhH5QGjXhKwljXqAxln
 NyTGEzcs4g425v347kzpLDBMugdeXr8TOIVqac59F7XkJKf1wShwTdeqNINpGVEm+/Uc
 JJaFDqKoBmz/cAvOAwbFoFo4pekpehBhwi4DGwKGIv9IJsGiXu34ZPPVhhWJyqrKIFcc
 yI/EXUkYloZFsV7Gsc4rgf7Z70U8WJhbtGfGPVP8XWdX0Eo6MgSNqQq/jF5ROy8rbjkJ
 gwQHF+1cQJiLQUVbGKSRkNT0Z4rLOnwcHwFz3CFPZTRrOCQUbV+JteWxWwr+ZRm3Dlp3
 3Rkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ncMG+qVQw7DsSkLYvlYjsLOcG4Qxwsrf2tQhwZ3fD+o=;
 b=amvUEkAWIyfA/GiYpqHzjY0uOR2MojB1um+i6S1gf2Vm9pcF0gPEf4SPTD/Ryb4xa5
 oaD7ezBILIEVn6+X6mVx4nUZyCo1g0Y66PCJVB1fRq6oOKmkPAJIBB0wjBADSuJwdiwt
 xiL/zyCbK4ZKUl4OP2/FnYJ/aE2TJxn6mJA38iQ2+e3RTsX0RAF9cee9sDUY4R3LQxmD
 kxADC+1cLUR95AfkZM5zcoH5e0++I2DZovJiaiH/VCD2qpk0sbmaH2jUShibXejrNl1g
 R32Dos2lShgjpkntVjBMeGIyevvLYC9Cw0k5req1fxNXIBmTOkzR60Emrw6WYwh0AadQ
 vkKg==
X-Gm-Message-State: APjAAAWu3taBTaKHK/P2iBOWd88yCSW0GpmGL9LuoHwUqLjcswoDE8kF
 +1YAVoU4NrIcZmryjzgVwU59RJ4Dqvs=
X-Google-Smtp-Source: APXvYqzt0VH7j7YU++im/A2NauYoJwXzZcxm5M/CD6uf/tnW87T0SFB0l8z5xSLr5EeWXnZs/GulbA==
X-Received: by 2002:a05:600c:24cb:: with SMTP id
 11mr4446700wmu.94.1565181601650; 
 Wed, 07 Aug 2019 05:40:01 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id r5sm98888940wmh.35.2019.08.07.05.40.00
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 07 Aug 2019 05:40:00 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8C2751FF87;
 Wed,  7 Aug 2019 13:40:00 +0100 (BST)
References: <20190730123759.21723-1-pbonzini@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
In-reply-to: <20190730123759.21723-1-pbonzini@redhat.com>
Date: Wed, 07 Aug 2019 13:40:00 +0100
Message-ID: <87r25xi1y7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 0/3] tests/tcg: disentangle makefiles
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> The tests/tcg rely a lot on per-target informations from
> the QEMU makefiles, but most of the definitions in there
> aren't really relevant to TCG tests.
>
> This series is just a cleanup, but it could also be
> a useful start in making it possible to compile tests/tcg
> out of QEMU's tree, and/or making it a submodule, and/or
> unifying the system emulation tests with kvm-unit-tests.

Hmm something is throwing off configure and making it use my login shell
instead of /bin/sh:

  libpmem support   no
  libudev           yes
  default devices   yes
  ~/lsrc/qemu.git/tests/tcg/configure.sh (line 63): 'case' builtin not insi=
de of switch block
    case $arch in
    ^
  <W> fish: Error while reading file /home/alex/lsrc/qemu.git/tests/tcg/con=
figure.sh

>
> Paolo
>
> Paolo Bonzini (3):
>   tests/tcg: use EXTRA_CFLAGS everywhere
>   tests/tcg: cleanup Makefile inclusions
>   tests/tcg: move configuration to a sub-shell script
>
>  Makefile                                  |   1 +
>  Makefile.target                           |   3 -
>  configure                                 | 155 ++------------------
>  tests/Makefile.include                    |  25 ++--
>  tests/tcg/Makefile.include                |  88 ------------
>  tests/tcg/Makefile.prereqs                |  18 +++
>  tests/tcg/Makefile.probe                  |  31 ----
>  tests/tcg/Makefile.qemu                   |  95 +++++++++++++
>  tests/tcg/{Makefile =3D> Makefile.target}   |  15 +-
>  tests/tcg/aarch64/Makefile.include        |   8 --
>  tests/tcg/aarch64/Makefile.softmmu-target |   4 +-
>  tests/tcg/aarch64/Makefile.target         |  12 +-
>  tests/tcg/alpha/Makefile.include          |   2 -
>  tests/tcg/alpha/Makefile.softmmu-target   |   4 +-
>  tests/tcg/arm/Makefile.include            |   8 --
>  tests/tcg/arm/Makefile.softmmu-target     |   6 +-
>  tests/tcg/configure.sh                    | 228 ++++++++++++++++++++++++=
++++++
>  tests/tcg/cris/Makefile.include           |   6 -
>  tests/tcg/hppa/Makefile.include           |   2 -
>  tests/tcg/i386/Makefile.include           |   9 --
>  tests/tcg/i386/Makefile.softmmu-target    |  12 +-
>  tests/tcg/i386/Makefile.target            |  13 +-
>  tests/tcg/m68k/Makefile.include           |   2 -
>  tests/tcg/minilib/Makefile.target         |   2 +-
>  tests/tcg/mips/Makefile.include           |  20 ---
>  tests/tcg/ppc/Makefile.include            |  10 --
>  tests/tcg/riscv/Makefile.include          |  10 --
>  tests/tcg/s390x/Makefile.include          |   2 -
>  tests/tcg/sh4/Makefile.include            |   4 -
>  tests/tcg/sparc64/Makefile.include        |   2 -
>  tests/tcg/x86_64/Makefile.softmmu-target  |  36 +++++
>  tests/tcg/x86_64/Makefile.target          |   7 +-
>  tests/tcg/xtensa/Makefile.include         |  11 --
>  tests/tcg/xtensa/Makefile.softmmu-target  |   4 +-
>  34 files changed, 435 insertions(+), 420 deletions(-)
>  delete mode 100644 tests/tcg/Makefile.include
>  create mode 100644 tests/tcg/Makefile.prereqs
>  delete mode 100644 tests/tcg/Makefile.probe
>  create mode 100644 tests/tcg/Makefile.qemu
>  rename tests/tcg/{Makefile =3D> Makefile.target} (90%)
>  delete mode 100644 tests/tcg/aarch64/Makefile.include
>  delete mode 100644 tests/tcg/alpha/Makefile.include
>  delete mode 100644 tests/tcg/arm/Makefile.include
>  create mode 100644 tests/tcg/configure.sh
>  delete mode 100644 tests/tcg/cris/Makefile.include
>  delete mode 100644 tests/tcg/hppa/Makefile.include
>  delete mode 100644 tests/tcg/i386/Makefile.include
>  delete mode 100644 tests/tcg/m68k/Makefile.include
>  delete mode 100644 tests/tcg/mips/Makefile.include
>  delete mode 100644 tests/tcg/ppc/Makefile.include
>  delete mode 100644 tests/tcg/riscv/Makefile.include
>  delete mode 100644 tests/tcg/s390x/Makefile.include
>  delete mode 100644 tests/tcg/sh4/Makefile.include
>  delete mode 100644 tests/tcg/sparc64/Makefile.include
>  create mode 100644 tests/tcg/x86_64/Makefile.softmmu-target
>  delete mode 100644 tests/tcg/xtensa/Makefile.include


--
Alex Benn=C3=A9e


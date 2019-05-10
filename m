Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286CEC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 10:37:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D724E2175B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 10:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CG4Mp6TW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D724E2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40838 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP2uM-0002SZ-Sk
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 06:37:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hP2tJ-0001mi-Tz
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:36:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hP2tI-00009m-In
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:36:37 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:32908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hP2tI-00007p-C0
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:36:36 -0400
Received: by mail-wm1-x342.google.com with SMTP id c66so1008540wme.0
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 03:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=zL0HfdXj5UJR09d/1wah2l7x4DyuET1nQE6879mt9wk=;
	b=CG4Mp6TW2M0u9KhdxDQkGFrt2/plWl2x2S+8LfF06nxwCHQsj6fIjGh+I4gKI9p+LW
	fij84Hj7VgPW7DJ8pP+r1zF1YCZLP8+EJSaoHA/JY4UYjbl/Uj9YjJ589yYhNKY5upS4
	3ocNhtLIahxK2Q9twKMgB9dLT0P6gBed1f+d94c6M8qTMcWamOHkKr/ceba0AOfNt8OD
	ECzE4jqhlxjv1+WOoFbIVJDfc/RaF0tQWez9/SFOQh7Viyb5xaPOSGfAxuiC8lW3UHuw
	N/9NOlp7DgexYUTaNum7D028Dmh8Jphf1aJGbSbV10SA+9T5G7+Il4O8VQMEBkrBFNoH
	W0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=zL0HfdXj5UJR09d/1wah2l7x4DyuET1nQE6879mt9wk=;
	b=lt3NKOOsa9KZiJ73/UQSRkSjV7xEVOjIrHGnI1QLZRcKHZVGmDO07Ais2jD2Q84E8Z
	mZEyRMKCgDKZOAtFCAoDrrTbtPR+6IRdN5N/vAZ8sbkVz5fMO4GUdKt2k1eEI/EbOaUL
	QgFIMei40c2OvUAQbitFmykqi+LUKYeG3IoEWzVbtap95xzg9HRv55/3cC0lZE7QErfV
	C3VrRSoOQyxsBw1qGd8H0R9f6EXuRxeVU0iz8HxRogUMR4d0MsTr2/9gyIAoIZOY6kQW
	XMTydDjBZ/j2bDoQECxGNn8qPmFRBNkE1QgZP43u1jb0edZ+XdDIYcBCPBDBwKQe7erO
	wefg==
X-Gm-Message-State: APjAAAUPV1H6k0HIHow6GOpY14vD6aR4A5OuGwuOgANPe3+oA25Bw7TS
	NRSEf/nFwyarJMAMTky/ZYOgSg==
X-Google-Smtp-Source: APXvYqw7UEYAklpnSjb3qTOoVC5Vbju3Pnn1a8MvbyEYSA7n+A2OK9o8n9FWzLOO3/qC/X7C+3VBJQ==
X-Received: by 2002:a1c:e144:: with SMTP id y65mr6363416wmg.147.1557484594980; 
	Fri, 10 May 2019 03:36:34 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	q26sm4656151wmq.25.2019.05.10.03.36.34
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 10 May 2019 03:36:34 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id AFD4D1FF87;
	Fri, 10 May 2019 11:36:33 +0100 (BST)
References: <20190430165234.32272-1-alex.bennee@linaro.org>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190430165234.32272-1-alex.bennee@linaro.org>
Date: Fri, 10 May 2019 11:36:33 +0100
Message-ID: <87muju4mvi.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v5 00/15] demacro softmmu (plus
 tests/coverage)
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
Cc: qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, cota@braap.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Hi,
>
> This is the latest iteration of the softmmu demacro series. The main
> changes from the last submission are some updates from Richard.

Ping Emilio/Mark

Would you be able to re-run your tests to check there are no other
regressions? I can then get the PR prepared for merging ;-)

> Some
> are merged into the main demacro patch (mostly casting cleanups) and
> then a series of 3 patches to out of line some of the less hot code to
> keep the main access functions a reasonable size. For example:
>
>   readelf -s aarch64-softmmu/accel/tcg/cputlb.o | ag helper |\
>     ag -v atomic | ag mmu | tr -s ' ' | cut -d ' ' -f 4,9 | sort -n
>
> Before:
>
>   16 helper_be_ldsl_mmu
>   16 helper_le_ldsl_mmu
>   18 helper_be_ldsw_mmu
>   18 helper_le_ldsw_mmu
>   18 helper_ret_ldsb_mmu
>   535 helper_ret_ldub_mmu
>   556 helper_ret_ldb_cmmu
>   586 helper_ret_stb_mmu
>   679 helper_le_ldul_mmu
>   681 helper_be_ldul_mmu
>   685 helper_le_ldq_mmu
>   688 helper_be_ldq_mmu
>   688 helper_le_lduw_mmu
>   693 helper_le_ldl_cmmu
>   701 helper_le_ldq_cmmu
>   701 helper_le_ldw_cmmu
>   703 helper_be_ldl_cmmu
>   704 helper_be_ldq_cmmu
>   708 helper_be_lduw_mmu
>   713 helper_be_ldw_cmmu
>   943 helper_le_stw_mmu
>   944 helper_le_stl_mmu
>   952 helper_be_stl_mmu
>   952 helper_le_stq_mmu
>   959 helper_be_stw_mmu
>   960 helper_be_stq_mmu
>
> After:
>
>   5 helper_be_ldul_mmu
>   5 helper_be_lduw_mmu
>   5 helper_le_ldul_mmu
>   5 helper_le_lduw_mmu
>   5 helper_ret_ldub_mmu
>   14 helper_be_ldl_cmmu
>   14 helper_be_ldw_cmmu
>   14 helper_le_ldl_cmmu
>   14 helper_le_ldw_cmmu
>   16 helper_be_ldsl_mmu
>   16 helper_le_ldsl_mmu
>   18 helper_be_ldsw_mmu
>   18 helper_le_ldsw_mmu
>   18 helper_ret_ldsb_mmu
>   783 helper_ret_stb_mmu
>   785 helper_ret_ldb_cmmu
>   881 helper_be_ldq_mmu
>   881 helper_le_ldq_mmu
>   889 helper_le_ldq_cmmu
>   897 helper_be_ldq_cmmu
>   1150 helper_be_stw_mmu
>   1150 helper_le_stw_mmu
>   1151 helper_be_stq_mmu
>   1151 helper_le_stl_mmu
>   1151 helper_le_stq_mmu
>   1159 helper_be_stl_mmu
>
> I've also moved the existing system memory test and made it multiarch
> and added the bootstrapping for aarch64 system tests. I would like to
> add support for Big Endian as well but I didn't want to delay the
> posting of the series. It would also be nice to exercise the
> ioread/write paths and other handling but I leave this as an exercise
> for later.
>
> There are also some minor tweaks for the code coverage reports now I'm
> running with out-of-tree builds.
>
> Alex Benn=C3=A9e (11):
>   tests/tcg/multiarch: add support for multiarch system tests
>   tests/tcg/multiarch: add hello world system test
>   tests/tcg/aarch64: add system boot.S
>   tests/tcg/multiarch: move the system memory test
>   tests/tcg/minilib: support %c format char
>   tests/tcg/multiarch: expand system memory test to cover more
>   accel/tcg: demacro cputlb
>   accel/tcg: remove softmmu_template.h
>   Makefile: fix coverage-report reference to BUILD_DIR
>   Makefile: include per-target build directories in coverage report
>   Makefile.target: support per-target coverage reports
>
> Richard Henderson (4):
>   cputlb: Move TLB_RECHECK handling into load/store_helper
>   cputlb: Drop attribute flatten
>   cputlb: Do unaligned load recursion to outermost function
>   cputlb: Do unaligned store recursion to outermost function
>
>  Makefile                                      |   4 +-
>  Makefile.target                               |  16 +
>  accel/tcg/cputlb.c                            | 626 +++++++++++++++---
>  accel/tcg/softmmu_template.h                  | 454 -------------
>  tests/tcg/Makefile                            |   1 +
>  tests/tcg/aarch64/Makefile.softmmu-target     |  32 +
>  tests/tcg/aarch64/system/boot.S               | 200 ++++++
>  tests/tcg/aarch64/system/kernel.ld            |  22 +
>  tests/tcg/i386/Makefile.softmmu-target        |   2 +-
>  tests/tcg/i386/system/memory.c                | 243 -------
>  tests/tcg/minilib/printf.c                    |   6 +-
>  .../multiarch/system/Makefile.softmmu-target  |  14 +
>  tests/tcg/{i386 =3D> multiarch}/system/hello.c  |   0
>  tests/tcg/multiarch/system/memory.c           | 427 ++++++++++++
>  14 files changed, 1267 insertions(+), 780 deletions(-)
>  delete mode 100644 accel/tcg/softmmu_template.h
>  create mode 100644 tests/tcg/aarch64/Makefile.softmmu-target
>  create mode 100644 tests/tcg/aarch64/system/boot.S
>  create mode 100644 tests/tcg/aarch64/system/kernel.ld
>  delete mode 100644 tests/tcg/i386/system/memory.c
>  create mode 100644 tests/tcg/multiarch/system/Makefile.softmmu-target
>  rename tests/tcg/{i386 =3D> multiarch}/system/hello.c (100%)
>  create mode 100644 tests/tcg/multiarch/system/memory.c


--
Alex Benn=C3=A9e


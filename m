Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830F4C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 22:03:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DCB621880
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 22:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9qFyXWH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DCB621880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52207 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTZKC-0003pl-Hv
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 18:03:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hTZJH-0003WG-KZ
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:02:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hTZJG-0005aZ-77
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:02:07 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46249)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hTZJG-0005a1-0N
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:02:06 -0400
Received: by mail-ot1-x341.google.com with SMTP id j49so3519467otc.13
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 15:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=7r/5uPcVmJemqjzKDiLhtYwSYbSN9zV9HPKQAQ+x3tQ=;
	b=E9qFyXWHIg0s2PBYSdCLlBCOEyUggmPez+wJHNFMKL7BlAhcxidTl4B2sFx4Y/+kB2
	5Lm9iz61tsUqrJuDnc1mgjE39iu6wXdXC4f9nA1B+hVr+zZgM8TieMEWqy/8OsEiz4iV
	acYJJ9ku5NqkpftRCi2x7UyFPiHBgihlbycAbb68ziCq9FuL4atxQ9XdCpVtp2Vh/T+i
	Gwy3zHzBZgGEmTUcaa8E5IRS7mu20A41oz0ogWILPcgm8tFEnMV5eVX8ou7kPhygWdn/
	KwdTTIzx/jxet1LaWkQ98H/WZH5gO07V91aiVEgLhjWgcbZveV9wW2+uxUxEh4zpnvJf
	Ympg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=7r/5uPcVmJemqjzKDiLhtYwSYbSN9zV9HPKQAQ+x3tQ=;
	b=r13OxE45KVbS5OQgtXNevU+VbcNA81rLsXVQ1Tne2XVDhd1wm6EU1BAHqNSP1lFxWU
	n/ye23r+S6trF5bayR2bKp5JtZ2qFxexMWblkd05ILxLo3IBN1mUGhDX2aA45Fwsxqsy
	vXYjU+QFkkhdKJ887BFidVs8R9Mo+GVlFpJ7GNeNPNoVM7zw1eQlj0t81uz9bB9G8GZ/
	8uEKeNEA0pquvjFyqT/Ze2t0QaxzzyDmqeKVh8pdTb0lLELdF/8MneK9kUjtXnf7GcVw
	kA7AigdALx8oFWqhcPMn/5L44hwYQWPiJNIyNwebcsT1oq/0GhOI5B773yDdKntmgBxe
	NJIQ==
X-Gm-Message-State: APjAAAXlqWjGOr3sM6T2QlxKgjC4CA+0LyX0rrkLBejNDgm0S8VxuBCN
	xIpg56pzdsIn/2VkASMSAcev10h/NaAuAkfUn7Hj7uyB
X-Google-Smtp-Source: APXvYqwl4m1C2HHCLHOpfLw5NqsBK42TWSzqO2alyC0JAcnVsTaNJuIyblfNuWLF3DTafrQ1g9EXbtUej46dk0XB4eE=
X-Received: by 2002:a9d:61d5:: with SMTP id h21mr22868660otk.306.1558562525347;
	Wed, 22 May 2019 15:02:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Wed, 22 May 2019 15:02:04
	-0700 (PDT)
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Wed, 22 May 2019 15:02:04
	-0700 (PDT)
In-Reply-To: <1558551522-24147-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1558551522-24147-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 23 May 2019 00:02:04 +0200
Message-ID: <CAL1e-=iST3GRbiYXKgQZFQ+ZXJcN6kLYgZ32DWhRnpyBYrV+VQ@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PULL v2 00/11] MIPS queue for May 19th, 2019 - v2
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 22, 2019 9:15 PM, "Aleksandar Markovic" <
aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit
a4f667b6714916683408b983cfe0a615a725775f:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190521-3'
into staging (2019-05-21 16:30:13 +0100)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-may-19-2019-v2
>
> for you to fetch changes up to 9a89468145b8a3e53e508992f54061427c52780f:
>
>   BootLinuxSshTest: Test some userspace commands on Malta (2019-05-22
20:10:46 +0200)
>
> ----------------------------------------------------------------
>

Peter,

Please put this pull request on hold, there are some reservations from test
group about patch 11/11, that came just hours after I sent this pull
request.

Yours,
Aleksandar

> MIPS queue for May 19th, 2019 - v2
>
> v1-v2:
>    - fixed missing invocations in patch on ST.<B|H|W|D> that caused
>      clang build error
>    - added a patch on acceptance test for Malta
>
> overall content:
>
>    * Improved usage of object_initialize() and object_initialize_child()
>    * Added an acceptance test for Malta board
>    * Better handling of memory pages (flag PAGE_EXEC)
>    * A set of fixes for emulation of MSA ASE on big endian hosts
>    * Better handling of 'div by zero' cases of MSA ASE instructions
>
> ----------------------------------------------------------------
>
> Jakub Jerm=C3=A1=C5=99 (1):
>   mips: Decide to map PAGE_EXEC in map_address
>
> Mateja Marjanovic (7):
>   target/mips: Make the results of DIV_<U|S>.<B|H|W|D> the same as on
>     hardware
>   target/mips: Make the results of MOD_<U|S>.<B|H|W|D> the same as on
>     hardware
>   target/mips: Fix MSA instructions LD.<B|H|W|D> on big endian host
>   target/mips: Fix MSA instructions ST.<B|H|W|D> on big endian host
>   target/mips: Refactor and fix COPY_S.<B|H|W|D> instructions
>   target/mips: Refactor and fix COPY_U.<B|H|W> instructions
>   target/mips: Refactor and fix INSERT.<B|H|W|D> instructions
>
> Philippe Mathieu-Daud=C3=A9 (3):
>   hw/mips: Use object_initialize() on MIPSCPSState
>   hw/mips: Use object_initialize_child for correct reference counting
>   BootLinuxSshTest: Test some userspace commands on Malta
>
>  MAINTAINERS                              |   1 +
>  hw/mips/boston.c                         |  25 +-
>  hw/mips/cps.c                            |  20 +-
>  hw/mips/mips_malta.c                     |  17 +-
>  target/mips/helper.c                     |  13 +-
>  target/mips/helper.h                     |  16 +-
>  target/mips/msa_helper.c                 | 191 ++++++++++-----
>  target/mips/op_helper.c                  | 388
+++++++++++++++++++++++++++----
>  target/mips/translate.c                  |  59 ++++-
>  tests/acceptance/linux_ssh_mips_malta.py | 229 ++++++++++++++++++
>  tests/requirements.txt                   |   1 +
>  11 files changed, 817 insertions(+), 143 deletions(-)
>  create mode 100644 tests/acceptance/linux_ssh_mips_malta.py
>
> --
> 2.7.4
>
>

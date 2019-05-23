Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E5CC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 17:32:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E39A120657
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 17:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Upyh2ci/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39A120657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41117 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTraE-0007Al-96
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 13:32:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hTrYl-0006Di-NC
	for qemu-devel@nongnu.org; Thu, 23 May 2019 13:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hTrYj-0001W7-F2
	for qemu-devel@nongnu.org; Thu, 23 May 2019 13:31:19 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:37964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hTrYj-0001VP-7Y
	for qemu-devel@nongnu.org; Thu, 23 May 2019 13:31:17 -0400
Received: by mail-ot1-x341.google.com with SMTP id s19so6183713otq.5
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 10:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=clVrA6rIPZQBqWjmmJ++R40bxGoKGYEOdR5siX9qp6U=;
	b=Upyh2ci/APasqvjksS3CuyEZrNzc5iSJ3Kh5C+A2xGZ6wXBEUTHwEjj5V5YuGrAuxV
	ccwjyQ30SXNX4txVIyK/Iin5uuPNm7OY7vQPoCAz5jE99U6KpxJu4Fk8GWXZv82Rcgb7
	4/cbJnVFATTHieaA1+hlVi6Jk3Qs9sYW1FQltygspc+pk7WIPhNJhCMQamu2MUBhIRce
	SWlIZxdlNm9gEGrEz6hZ52/ZJTgw5oJjFARij+BhwBL0Q+OabVsBuvNVUOqPB6I0Rkbn
	IgvnVp6SZ/IHzVnXGRKzvKPHfc9ra38zowdsKVlt+B7BKJbI18ESLEjcLGq3lcVxjd7J
	qeoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=clVrA6rIPZQBqWjmmJ++R40bxGoKGYEOdR5siX9qp6U=;
	b=kCtTw4dMrE6ib4zjlpjRO5Ahw5N/3ytJGnvcDpovGkkaAplbOsBnH0YuKqtRvQ7WVc
	R2qHTLecnu1GkkqYd4cUCUfpN2X4AAid4XFSXibdGeEMHIIXybfeqT2TOGKcKVi14U8G
	yon7G7CYYUWJlbe9jVwUiLUcXEnv8dkpxc/8YYOxiVo9NlIpr4/XQa+NCFrlGF7Ccn2k
	oxx04gIk0Ds8xlPpaZfftSE4ACmUUP0DFTaCILx8gF1VH7GEBAkrfrLucUUKcYFhHDKz
	8vo4D1MZGf0Odv2Oqt1CoQD4brVIDA/UKBGmSiYc5zCd6/i5ceQTy07mLPxXWHkSMMPR
	F4RQ==
X-Gm-Message-State: APjAAAXj7YmSrkBfEpsWwnV1GaXtdfz9xBLdHk2dhmJwppIKccNv8BQl
	zqazAbwGpQpmhjxkTCZNfMiZfSHQtrXQ2fqXzje/uA/X
X-Google-Smtp-Source: APXvYqyeO/mF4ea8eCOzYpcCjiUXsGyzZffediGFSPXElkSBupMu6deSEDnlIUeZ2DQ3Y1Bu+kfCh5nFUdFyXaDu7GI=
X-Received: by 2002:a05:6830:160a:: with SMTP id
	g10mr224348otr.121.1558632676216; 
	Thu, 23 May 2019 10:31:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Thu, 23 May 2019 10:31:15
	-0700 (PDT)
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Thu, 23 May 2019 10:31:15
	-0700 (PDT)
In-Reply-To: <155862937270.24.3313016521227492517@549697c9ad12>
References: <20190523144336.13960-1-laurent@vivier.eu>
	<155862937270.24.3313016521227492517@549697c9ad12>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 23 May 2019 19:31:15 +0200
Message-ID: <CAL1e-=j0tsaCs+QkRkcn+M62HJpsD-PtXWvZfPSnPNtn=64hfg@mail.gmail.com>
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PULL 00/10] Linux user for 4.1 patches
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
Cc: arikalo@wavecomp.com, aurelien@aurel32.net, riku.voipio@iki.fi,
	laurent@vivier.eu, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 23, 2019 6:51 PM, <no-reply@patchew.org> wrote:
>
> Patchew URL:
https://patchew.org/QEMU/20190523144336.13960-1-laurent@vivier.eu/
>
>
>
> Hi,
>
> This series seems to have some coding style problems. See output below fo=
r
> more information:
>
> Message-id: 20190523144336.13960-1-laurent@vivier.eu
> Type: series
> Subject: [Qemu-devel] [PULL 00/10] Linux user for 4.1 patches
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
>    d418238dca..8dc7fd56dd  master     -> master
> From https://github.com/patchew-project/qemu
>  * [new tag]               patchew/
20190523144336.13960-1-laurent@vivier.eu -> patchew/
20190523144336.13960-1-laurent@vivier.eu
> Switched to a new branch 'test'
> 4770ccf734 linux-user: Pass through nanosecond timestamp components for
stat syscalls
> 1b5b9faa88 linux-user: Align mmap_find_vma to host page size
> 874caa8bfb linux-user: Fix shmat emulation by honoring host SHMLBA
> d907278358 linux-user: Add support for setsockopt() options
IPV6_<ADD|DROP>_MEMBERSHIP
> 57d45df330 linux-user: Sanitize interp_info and, for mips only, init
field fp_abi
> 7267248384 linux-user: Add support for SIOC<G|S>IFPFLAGS ioctls for all
targets
> 0eac2d71cc linux-user: Add support for SIOCSPGRP ioctl for all targets
> f0e6b29b94 linux-user: Fix support for SIOCATMARK and SIOCGPGRP ioctls
for xtensa
> bd5d878a8c linux-user: add pseudo /proc/hardware for m68k
> 1384b0eeee linux-user: add pseudo /proc/cpuinfo for sparc
>
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> 1/10 Checking commit 1384b0eeeeb5 (linux-user: add pseudo /proc/cpuinfo
for sparc)
> 2/10 Checking commit bd5d878a8cee (linux-user: add pseudo /proc/hardware
for m68k)
> 3/10 Checking commit f0e6b29b94d6 (linux-user: Fix support for SIOCATMARK
and SIOCGPGRP ioctls for xtensa)
> 4/10 Checking commit 0eac2d71ccfa (linux-user: Add support for SIOCSPGRP
ioctl for all targets)
> 5/10 Checking commit 72672483844f (linux-user: Add support for
SIOC<G|S>IFPFLAGS ioctls for all targets)
> 6/10 Checking commit 57d45df3304f (linux-user: Sanitize interp_info and,
for mips only, init field fp_abi)
> 7/10 Checking commit d907278358c4 (linux-user: Add support for
setsockopt() options IPV6_<ADD|DROP>_MEMBERSHIP)
> WARNING: architecture specific defines should be avoided
> #70: FILE: linux-user/syscall.c:1929:
> +#if __UAPI_DEF_IPV6_MREQ
>
> total: 0 errors, 1 warnings, 29 lines checked
>

This warning was known to us, but we can't do anything about it, the line
in question is a =E2=80=9Cnecessary evil=E2=80=9D .

> Patch 7/10 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 8/10 Checking commit 874caa8bfb4f (linux-user: Fix shmat emulation by
honoring host SHMLBA)
> WARNING: Block comments use a leading /* on a separate line
> #54: FILE: linux-user/elfload.c:2070:
> +            /* The same thing again, but with extra
>
> total: 0 errors, 1 warnings, 221 lines checked
>
> Patch 8/10 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 9/10 Checking commit 1b5b9faa88bd (linux-user: Align mmap_find_vma to
host page size)
> 10/10 Checking commit 4770ccf73400 (linux-user: Pass through nanosecond
timestamp components for stat syscalls)
> ERROR: code indent should never use tabs
> #105: FILE: linux-user/syscall_defs.h:1203:
> +^Iabi_ulong  target_st_atime_nsec;$
>
> ERROR: code indent should never use tabs
> #108: FILE: linux-user/syscall_defs.h:1205:
> +^Iabi_ulong  target_st_mtime_nsec;$
>
> ERROR: code indent should never use tabs
> #111: FILE: linux-user/syscall_defs.h:1207:
> +^Iabi_ulong  target_st_ctime_nsec;$
>
> ERROR: code indent should never use tabs
> #120: FILE: linux-user/syscall_defs.h:1239:
> +^Iabi_ulong^Itarget_st_atime_nsec;$
>
> ERROR: code indent should never use tabs
> #124: FILE: linux-user/syscall_defs.h:1242:
> +^Iabi_ulong^Itarget_st_mtime_nsec;$
>
> ERROR: code indent should never use tabs
> #128: FILE: linux-user/syscall_defs.h:1245:
> +^Iabi_ulong^Itarget_st_ctime_nsec;$
>
> ERROR: code indent should never use tabs
> #137: FILE: linux-user/syscall_defs.h:1324:
> +^Iabi_ulong^Itarget_st_atime_nsec;$
>
> ERROR: code indent should never use tabs
> #141: FILE: linux-user/syscall_defs.h:1327:
> +^Iabi_ulong^Itarget_st_mtime_nsec;$
>
> ERROR: code indent should never use tabs
> #145: FILE: linux-user/syscall_defs.h:1330:
> +^Iabi_ulong^Itarget_st_ctime_nsec;$
>
> ERROR: code indent should never use tabs
> #161: FILE: linux-user/syscall_defs.h:1348:
> +^Iabi_ulong^Itarget_st_atime_nsec;$
>
> ERROR: code indent should never use tabs
> #164: FILE: linux-user/syscall_defs.h:1350:
> +^Iabi_ulong^Itarget_st_mtime_nsec;$
>
> ERROR: code indent should never use tabs
> #167: FILE: linux-user/syscall_defs.h:1352:
> +^Iabi_ulong^Itarget_st_ctime_nsec;$
>
> ERROR: code indent should never use tabs
> #171: FILE: linux-user/syscall_defs.h:1355:
> +^Iabi_ulong^I__unused1[2];$
>
> ERROR: code indent should never use tabs
> #180: FILE: linux-user/syscall_defs.h:1383:
> +^Iunsigned int^Itarget_st_atime_nsec;$
>
> ERROR: code indent should never use tabs
> #184: FILE: linux-user/syscall_defs.h:1386:
> +^Iunsigned int^Itarget_st_mtime_nsec;$
>
> ERROR: code indent should never use tabs
> #188: FILE: linux-user/syscall_defs.h:1389:
> +^Iunsigned int^Itarget_st_ctime_nsec;$
>
> ERROR: code indent should never use tabs
> #192: FILE: linux-user/syscall_defs.h:1391:
> +^Iunsigned int^I__unused1;$
>
> ERROR: code indent should never use tabs
> #193: FILE: linux-user/syscall_defs.h:1392:
> +^Iunsigned int^I__unused2;$
>
> total: 18 errors, 0 warnings, 211 lines checked
>
> Patch 10/10 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>
> =3D=3D=3D OUTPUT END =3D=3D=3D
>
> Test command exited with code: 1
>
>
> The full log is available at
>
http://patchew.org/logs/20190523144336.13960-1-laurent@vivier.eu/testing.ch=
eckpatch/?type=3Dmessage
.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com

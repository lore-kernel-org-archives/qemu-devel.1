Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74974C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:26:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BFD620753
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ith/4CTW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BFD620753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDvNx-0004IE-Eh
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jDvFE-0005SS-TA
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:17:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jDvFD-0007Qt-Kv
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:17:48 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:46663)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jDvFD-0007GP-E5
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:17:47 -0400
Received: by mail-oi1-x236.google.com with SMTP id x5so1297765oic.13
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 12:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Nh1gca7DWlva8jvc916/+LZBDcoP04sdDF28s1vKbHM=;
 b=Ith/4CTWEe1CLR6rFVVlOxewPLRzl6ScW6hua8JA4Yya7x6Q6FFxBdmVlklTsvxJcN
 ypwZ+2qXSOkOrO5tb+qtHc9cOgIb/sc2TgtoBaGCL8fcy8t4rFiHApWrWnQ9VT532jQQ
 yJTyLlBmsWsOsp3RSGrnIQLPD89SwUbTkt7pUGLESMD2oCbXpEiG4u7VEwAURDdgrxhX
 2G/mq40Y7b+Z5cfYqoq4ZDvyjZsSzGGHwMhGBCKpmmsmK5Osh7Z8w5wdYFUaqsLRO8ga
 wZVhqz5MKZIM3dDjjzcuJWKZwXKbROCN+5AVSTVUXFiaUFuEOiZWn+4nJ0z2/7wikNLK
 ClDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Nh1gca7DWlva8jvc916/+LZBDcoP04sdDF28s1vKbHM=;
 b=heTRqiy62HAccKi/o2Aiq+QeHpkS7tWZ8mCI6WqloKun6TqLAixHtoZe9Z95H9IzWc
 TnLdjmfgBwmAHdIqu/2/2d1fU4S0xETwmEe9fOyp0ZUlfGFzLcgYFG7gubK62mvK2Rd0
 /BrPMeNDcAwt+qOcZV2OLXJtv7j9A4/s+kX92mtXmHJW5SV/9I+M7Q4g1jf21Xo7J10A
 Xl1hPRPSEbP9UN0O3zocUF0v0jKVoc4+pZfPksDWJxQrPSUkmeg4QJQ5sycKZkIh0eog
 oUcuE4ZxKRf4SimUll0iqU9NqKy0RBwzOGoWqEUUT915VHh3I5x7lBjUQ9l2OBp2aElU
 5CwQ==
X-Gm-Message-State: ANhLgQ1rTUNtSEff2TJcyGsMr9pyiySLYFM2Qvi4eZgLf1QkzUDvr45c
 gQ6UtsJP2Qtv4L6Z6ok3W9nb1FQGN/xlxYBfxqDtEh7/YlmWPw==
X-Google-Smtp-Source: ADFU+vvaK4bv1s8wKLpzam6ryuI+zRzkFUQZn755av2/RnlYNMEM6i61u1yhWva4wBkec5uZf0fmrtAXoS5YsHcuM04=
X-Received: by 2002:aca:c608:: with SMTP id w8mr770628oif.163.1584386266444;
 Mon, 16 Mar 2020 12:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200316161550.336150-1-laurent@vivier.eu>
In-Reply-To: <20200316161550.336150-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Mar 2020 19:17:35 +0000
Message-ID: <CAFEAcA8L7S9LmXKr5mb5XmMiqUy_M4hCSL2jzxovoFNQdpHeeA@mail.gmail.com>
Subject: Re: [PULL 00/38] Linux user for 5.0 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::236
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 16 Mar 2020 at 17:43, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 373c7068dd610e97f0b551b5a6d0a27cd6da4506:
>
>   qemu.nsi: Install Sphinx documentation (2020-03-09 16:45:00 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-5.0-pull-request
>
> for you to fetch changes up to 63e05b3db1e5f0560ae579050c53d1ee36ed5aca:
>
>   linux-user, openrisc: sync syscall numbers with kernel v5.5 (2020-03-16 14:20:07 +0100)
>
> ----------------------------------------------------------------
> update syscall numbers to linux 5.5 (with scripts)
> add futex_time64/clock_gettime64/clock_settime64
> add AT_EXECFN
> Emulate x86_64 vsyscalls

Compile failure, aarch32:

/home/peter.maydell/qemu/linux-user/syscall.c: In function 'do_sys_futex':
/home/peter.maydell/qemu/linux-user/syscall.c:6946:16: error: implicit
declaration of function 'sys_futex_time64'; did you mean
'safe_futex_time64'? [-Werror=implicit-function-declaration]
         return sys_futex_time64(uaddr, op, val, timeout, uaddr2, val3);
                ^~~~~~~~~~~~~~~~
                safe_futex_time64


Compile failure, x86-64 with clang:

/home/petmay01/linaro/qemu-for-merges/linux-user/syscall.c:1291:24:
error: unused function 'copy_to_user_timezone'
[-Werror,-Wunused-function]
static inline abi_long copy_to_user_timezone(abi_ulong target_tz_addr,
                       ^
1 error generated.
/home/petmay01/linaro/qemu-for-merges/rules.mak:69: recipe for target
'linux-user/syscall.o' failed


thanks
-- PMM


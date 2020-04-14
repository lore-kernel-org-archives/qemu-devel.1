Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20944C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:59:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE1FA20678
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D24lYO9L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE1FA20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOuA-0003B3-V1
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37007)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jOOri-0007yD-Gp
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:56:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jOOrg-0007hU-Nv
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:56:50 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:32774)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jOOrg-0007g1-9B
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:56:48 -0400
Received: by mail-wr1-x432.google.com with SMTP id a25so15230148wrd.0
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 09:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Kwhcd4ao8KZE2oh4LBzjIZDy02XxpUQ+XZGRqkE2bM4=;
 b=D24lYO9LA6Zi8eB6fHmZupn5l5XpVE8KKpSOS382/t4sWIDaf/DzpTV5d/CPTz62TK
 O5R2pMv/6xtmd9jLPi5nu30ihm1YtMSg+xLY49GMIFiXlMV2erRXOICyGKEnp0kI2YZ9
 1bAAHhUdvpzimlN4c3H+4C0Eq8Ci2QIiq8bKvH92L3sLJE/dG2pLtT6kR46reP8cCm8t
 aNPZ7x0d0Y4rGlnQ4WmBc0MEcrjQFI3ovmQ+pnMBsTYdH63E84rnnINOCRHoxXbRkJW5
 h+niQiPwv4YF46iiYdetesHQqE9K480jAvowssHEwA9F62mft3N2pzaiRek1whmkYN0R
 iO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Kwhcd4ao8KZE2oh4LBzjIZDy02XxpUQ+XZGRqkE2bM4=;
 b=S07apVR87DGSO6y5GHLiDXGTATgZ0YJkiDzdWlDJz5l4IJC4kSPvndlC6o3N8HnP29
 LyW1pPiJgWl3wVlLDI3vuCvqeEFPni6VtIvkU+uELTMaRzC/Pht8z9gyedjRHsRayiS7
 fP+YwygaSU1hXJLCI/fZCBMmg/+VcAGt/i2M1loIVWjRIJudCsm9M3/YOjZI60Lr2y+N
 a2UZr22twIprdLrba0qPrMCIaVhQdn1VSl2kUfhJaFajAmI3p67Ckd0/AUIXzci57y0Z
 aa6u7N8VIXwyJn3Lw5lQVio+/uE5l3TNcxUrysE8UgeemaBPdesQ95HCR6KMrRGKxy21
 qVVg==
X-Gm-Message-State: AGi0PuYduf5/iZzKB2ZSyWfZll8mgbx7ZTYqkpnGbUBx/D0QVOPDPQWc
 Pj2r0cbTbOor/v0xZZGkNjXbEA==
X-Google-Smtp-Source: APiQypJbLPNyb+r/b0vYmWEp7sAGoz+qkcaWd+VYSAKXf6jOz7SVFwKv7wLZSVeL9ElPHUrqwAOwPQ==
X-Received: by 2002:adf:e450:: with SMTP id t16mr20903795wrm.301.1586883406229; 
 Tue, 14 Apr 2020 09:56:46 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f2sm19771931wro.59.2020.04.14.09.56.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 09:56:45 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 73C261FF7E;
 Tue, 14 Apr 2020 17:56:44 +0100 (BST)
References: <3be54f78-cf6d-af3b-6e1f-e91d146c6a3a@amsat.org>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: m68k: gdbstub crashing setting float register on cfv4e cpu
In-reply-to: <3be54f78-cf6d-af3b-6e1f-e91d146c6a3a@amsat.org>
Date: Tue, 14 Apr 2020 17:56:44 +0100
Message-ID: <87sgh680qb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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
Cc: Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> gdbstub/m68k seems broken with floats, previous to refactor commit
> a010bdbe719 ("extend GByteArray to read register helpers").
>
> HEAD at 6fb1603aa2:
>
> $ qemu-system-m68k -s -S -cpu cfv4e
>
> ---[GUEST]---
>
> (gdb) set architecture m68k:cfv4e
> The target architecture is assumed to be m68k:cfv4e
> (gdb) target remote 172.17.0.1:1234
> Remote debugging using 172.17.0.1:1234
> (gdb) info float
> fp0            -nan(0xfffffffffff7f) (raw 0xffffffffffffff7f)
> fp1            -nan(0xfffffffffff7f) (raw 0xffffffffffffff7f)
> fp2            -nan(0xfffffffffff7f) (raw 0xffffffffffffff7f)
> fp3            -nan(0xfffffffffff7f) (raw 0xffffffffffffff7f)
> fp4            -nan(0xfffffffffff7f) (raw 0xffffffffffffff7f)
> fp5            -nan(0xfffffffffff7f) (raw 0xffffffffffffff7f)
> fp6            -nan(0xfffffffffff7f) (raw 0xffffffffffffff7f)
> fp7            -nan(0xfffffffffff7f) (raw 0xffffffffffffff7f)
> fpcontrol      0x0                 0
> fpstatus       0x0                 0
> fpiaddr        0x0                 0x0
> (gdb) set $fp0=3D1
> Remote communication error.  Target disconnected.: Connection reset by
> peer.

With my sha1 debugging test case I get different results depending on
the cpu type:

  /home/alex/lsrc/qemu.git/tests/guest-debug/run-test.py --gdb /home/alex/s=
rc/tools/binutils-gdb.git/builds/all/install/bin/gdb --qemu /home/alex/lsrc=
/qemu.git/builds/user.static/m68k-linux-user/qemu-m68k --qargs "" --bin tes=
ts/tcg/m68k-linux-user/sha1 --test /home/alex/lsrc/qemu.git/tests/tcg/multi=
arch/gdbstub/sha1.py
  GNU gdb (GDB) 10.0.50.20200414-git
  Copyright (C) 2020 Free Software Foundation, Inc.
  License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.h=
tml>
  This is free software: you are free to change and redistribute it.
  There is NO WARRANTY, to the extent permitted by law.
  Type "show copying" and "show warranty" for details.
  This GDB was configured as "x86_64-pc-linux-gnu".
  Type "show configuration" for configuration details.
  For bug reporting instructions, please see:
  <http://www.gnu.org/software/gdb/bugs/>.
  Find the GDB manual and other documentation resources online at:
      <http://www.gnu.org/software/gdb/documentation/>.

  For help, type "help".
  Type "apropos word" to search for commands related to "word"...
  Executed .gdbinit
  Reading symbols from tests/tcg/m68k-linux-user/sha1...
  Remote debugging using localhost:1234
  warning: Register "fp0" has an unsupported size (96 bits)
  warning: Register "fp1" has an unsupported size (96 bits)
  warning: Register "fp2" has an unsupported size (96 bits)
  warning: Register "fp3" has an unsupported size (96 bits)
  warning: Register "fp4" has an unsupported size (96 bits)
  warning: Register "fp5" has an unsupported size (96 bits)
  warning: Register "fp6" has an unsupported size (96 bits)
  warning: Register "fp7" has an unsupported size (96 bits)
  Remote 'g' packet reply is too long (expected 148 bytes, got 180 bytes): =
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000408009f000000000800003407fff00=
00ffffffffffffffff7fff0000ffffffffffffffff7fff0000ffffffffffffffff7fff0000f=
fffffffffffffff7fff0000ffffffffffffffff7fff0000ffffffffffffffff7fff0000ffff=
ffffffffffff7fff0000ffffffffffffffff000000000000000000000000
  ATTACHED: m68k
  GDB Exception: <class 'gdb.error'>
  All tests complete: 1 failures
  SHA1=3D15dd99a1991e0b3826fede3deffc1feba42278e6

And with:

  /home/alex/lsrc/qemu.git/tests/guest-debug/run-test.py --gdb /home/alex/s=
rc/tools/binutils-gdb.git/builds/all/install/bin/gdb --qemu /home/alex/lsrc=
/qemu.git/builds/user.static/m68k-linux-user/qemu-m68k --qargs "-cpu cfv4e"=
 --bin tests/tcg/m68k-linux-user/sha1 --test /home/alex/lsrc/qemu.git/tests=
/tcg/multiarch/gdbstub/sha1.py
  GNU gdb (GDB) 10.0.50.20200414-git
  Copyright (C) 2020 Free Software Foundation, Inc.
  License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.h=
tml>
  This is free software: you are free to change and redistribute it.
  There is NO WARRANTY, to the extent permitted by law.
  Type "show copying" and "show warranty" for details.
  This GDB was configured as "x86_64-pc-linux-gnu".
  Type "show configuration" for configuration details.
  For bug reporting instructions, please see:
  <http://www.gnu.org/software/gdb/bugs/>.
  Find the GDB manual and other documentation resources online at:
      <http://www.gnu.org/software/gdb/documentation/>.

  For help, type "help".
  Type "apropos word" to search for commands related to "word"...
  Executed .gdbinit
  Reading symbols from tests/tcg/m68k-linux-user/sha1...
  Remote debugging using localhost:1234
  0x80000340 in _start ()
  ATTACHED: m68k
  Breakpoint 1 at 0x80001dda: file /home/alex/lsrc/qemu.git/tests/tcg/multi=
arch/sha1.c, line 137.

  Program received signal SIGILL, Illegal instruction.
  0x80019b70 in _dl_aux_init ()
  FAIL: break @ 0x80019b70 <_dl_aux_init+4> ({void (SHA1_CTX *)} 0x80001dd6=
 <SHA1Init> 0 hits)
  Single stepping until exit from function _dl_aux_init,
  which has no line number information.

  Program terminated with signal SIGILL, Illegal instruction.
  The program no longer exists.
  GDB Exception: <class 'gdb.error'>
  All tests complete: 2 failures
  qemu: uncaught target signal 4 (Illegal instruction) - core dumped

--=20
Alex Benn=C3=A9e


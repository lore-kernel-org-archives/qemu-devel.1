Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43A0C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 11:11:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F69A2077B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 11:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MJkFscJi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F69A2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is345-0000we-LJ
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 06:11:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53110)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1is33U-0000Xc-Uh
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 06:11:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1is33T-0008Ad-Hs
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 06:11:16 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:56108)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1is33T-00089B-88
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 06:11:15 -0500
Received: by mail-wm1-x344.google.com with SMTP id q9so3291170wmj.5
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 03:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=vwKkwwZvkQ7PyrNEpph6YyojvX4SfdtqoLmrhNzwR5Y=;
 b=MJkFscJiydEMTMGWHh1pUBB8QyKZQTtmtqKskSyRNeNIT4mA/YJT3qQT++sKq/5GZk
 YIrern6r+g/bRFaEmMS2ozAZVIKWy7k79yKBWqFE58cLn/1foJ9A/bN1+/cfw8ZT8qij
 BJknawQ+38naUyJaRGM4pvP2TRvz0igqCX6P/uxCIulN4tIZ4utTbtScgMESFib16QWA
 qOIuNVMK5YBqE/9FMmsJkN83c5doCUjiydZsU1lRAmLj3a3IaoOUhiTtxGf8oG3L+enl
 6w9B+Saz5YUxTftNXW3VwH+jrn3dBl+tM2ze6GNJaCZKA/WEGeQWb7rmBvvUJNoP/Xwl
 bNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=vwKkwwZvkQ7PyrNEpph6YyojvX4SfdtqoLmrhNzwR5Y=;
 b=uZV3wv7THyhAMvyECHJFYaq6cU5119rCyV22bOr975EZ6iYNTicbF/EyoW6zQl2HfY
 eoEaWUuY2ttGTJMUOOt9fTknhaKvNi+QMgMmZv58fyjIKXgHbERLdWa3I9bKo3HZIUnL
 RXEkbbSZYVpuX3+sewKFCo9DHLlUBWOOrRBOahJjm3f7Tp/aICBigyoG9+CT4G6KtxvI
 2PpVSTXYdeioPQC/GL6z4HMuhsrjnikPkxkaWtGgPQDlrI5OZNeMmP7b2k4Lj71+9m/G
 I2hx6VX0koiY1tUjOCrZD/MTpYM90RaWtDMiiHJU1KU3/99VQFdr46r40URzE5HZUhi1
 JJCw==
X-Gm-Message-State: APjAAAUr4edTr5a5zOHlEwxFEw9zy6UuvcAQsu+iMHLAUPtilv4tCZao
 XqsSNjufRkQq3VOKthnQzeymrg==
X-Google-Smtp-Source: APXvYqzO6+yw+4wEvS32XyWTUuxwj+l3Y18uqPmZH3wZHP+uOtFQ/6QeFY73JREieQwgpsVfs7RJ6Q==
X-Received: by 2002:a7b:c934:: with SMTP id h20mr5412046wml.103.1579173073908; 
 Thu, 16 Jan 2020 03:11:13 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q3sm3855854wmc.47.2020.01.16.03.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 03:11:12 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AAF7B1FF87;
 Thu, 16 Jan 2020 11:11:11 +0000 (GMT)
References: <157709434917.12933.4351155074716553976.stgit@pasha-Precision-3630-Tower>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
Subject: Re: [for-5.0 PATCH 00/11] Support for reverse debugging with GDB
In-reply-to: <157709434917.12933.4351155074716553976.stgit@pasha-Precision-3630-Tower>
Date: Thu, 16 Jan 2020 11:11:11 +0000
Message-ID: <87o8v3lkq8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru,
 pbonzini@redhat.com, crosthwaite.peter@gmail.com, ciro.santilli@gmail.com,
 jasowang@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, maria.klimushenkova@ispras.ru, mst@redhat.com,
 kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com,
 dovgaluk@ispras.ru, mreitz@redhat.com, artem.k.pisarenko@gmail.com,
 dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pavel Dovgalyuk <pavel.dovgaluk@gmail.com> writes:

> GDB remote protocol supports reverse debugging of the targets.
> It includes 'reverse step' and 'reverse continue' operations.
> The first one finds the previous step of the execution,
> and the second one is intended to stop at the last breakpoint that
> would happen when the program is executed normally.
>
> Reverse debugging is possible in the replay mode, when at least
> one snapshot was created at the record or replay phase.
> QEMU can use these snapshots for travelling back in time with GDB.
>
> Running the execution in replay mode allows using GDB reverse debugging
> commands:
>  - reverse-stepi (or rsi): Steps one instruction to the past.
>    QEMU loads on of the prior snapshots and proceeds to the desired
>    instruction forward. When that step is reaches, execution stops.
>  - reverse-continue (or rc): Runs execution "backwards".
>    QEMU tries to find breakpoint or watchpoint by loaded prior snapshot
>    and replaying the execution. Then QEMU loads snapshots again and
>    replays to the latest breakpoint. When there are no breakpoints in
>    the examined section of the execution, QEMU finds one more snapshot
>    and tries again. After the first snapshot is processed, execution
>    stops at this snapshot.
>
> The set of patches include the following modifications:
>  - gdbstub update for reverse debugging support
>  - functions that automatically perform reverse step and reverse
>    continue operations
>  - hmp/qmp commands for manipulating the replay process
>  - improvement of the snapshotting for saving the execution step
>    in the snapshot parameters
>
> The patches are available in the repository:
> https://github.com/ispras/qemu/tree/rr-191223

So I tried with your additional patch. Launching QEMU as:

  ./aarch64-softmmu//qemu-system-aarch64 -monitor none \
     -display none -M virt -cpu max -display none \
     -semihosting-config enable=3Don \
     -kernel ./tests/tcg/aarch64-softmmu/memory \
     -icount shift=3D5,rr=3Dreplay,rrfile=3Drecord.bin \
     -s -S -d trace:gdbstub\*

And gdb:

  gdb tests/tcg/aarch64-softmmu/memory \
    -ex "target remote localhost:1234"

I get the following log:

  (gdb) x/3i $pc
  =3D> 0x400037b0 <__start>:        adr     x0, 0x40003000 <vector_table>
     0x400037b4 <__start+4>:      msr     vbar_el1, x0
     0x400037b8 <__start+8>:      adrp    x0, 0x40200000
  (gdb) p/x $x0
  $1 =3D 0x0
  (gdb) si
  92              msr     vbar_el1, x0
  (gdb) p/x $x0
  $2 =3D 0x40003000
  (gdb) rsi
  warning: Remote failure reply: E14

  Program stopped.
  __start () at /home/alex.bennee/lsrc/qemu.git/tests/tcg/aarch64/system/bo=
ot.S:92
  92              msr     vbar_el1, x0
  (gdb) p/x $x0
  $3 =3D 0x40003000

So it doesn't seem to be working.

>
> ---
>
> Pavel Dovgaluk (11):
>       replay: provide an accessor for rr filename
>       qcow2: introduce icount field for snapshots
>       migration: introduce icount field for snapshots
>       qapi: introduce replay.json for record/replay-related stuff
>       replay: introduce info hmp/qmp command
>       replay: introduce breakpoint at the specified step
>       replay: implement replay-seek command
>       replay: flush rr queue before loading the vmstate
>       gdbstub: add reverse step support in replay mode
>       gdbstub: add reverse continue support in replay mode
>       replay: describe reverse debugging in docs/replay.txt
>
>
>  MAINTAINERS               |    1=20
>  accel/tcg/translator.c    |    1=20
>  block/qapi.c              |   18 ++
>  block/qcow2-snapshot.c    |    9 +
>  block/qcow2.h             |    3=20
>  blockdev.c                |   10 +
>  cpus.c                    |   19 ++-
>  docs/interop/qcow2.txt    |    4 +
>  docs/replay.txt           |   33 +++++
>  exec.c                    |    8 +
>  gdbstub.c                 |   64 ++++++++-
>  hmp-commands-info.hx      |   14 ++
>  hmp-commands.hx           |   53 +++++++
>  include/block/snapshot.h  |    1=20
>  include/monitor/hmp.h     |    4 +
>  include/sysemu/replay.h   |   24 +++
>  migration/savevm.c        |   17 ++
>  qapi/Makefile.objs        |    2=20
>  qapi/block-core.json      |    8 +
>  qapi/block.json           |    3=20
>  qapi/misc.json            |   18 --
>  qapi/qapi-schema.json     |    1=20
>  qapi/replay.json          |  121 +++++++++++++++++
>  replay/Makefile.objs      |    1=20
>  replay/replay-debugging.c |  325 +++++++++++++++++++++++++++++++++++++++=
++++++
>  replay/replay-internal.h  |    6 +
>  replay/replay.c           |   22 +++
>  stubs/replay.c            |   10 +
>  28 files changed, 761 insertions(+), 39 deletions(-)
>  create mode 100644 qapi/replay.json
>  create mode 100644 replay/replay-debugging.c


--=20
Alex Benn=C3=A9e


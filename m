Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411B0C76190
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 12:51:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FD5622CB9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 12:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bcWv3Nso"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD5622CB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqzhS-0005eq-56
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 08:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52486)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hqzhG-0005Dl-Gg
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:51:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hqzhF-0002c0-9C
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:51:42 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39734)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hqzhF-0002ae-18
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:51:41 -0400
Received: by mail-wm1-x341.google.com with SMTP id u25so37236739wmc.4
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 05:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=yxFhi+v4IC2UcxjejYMfLiCZ7feHlM7zFzXNrJnON5w=;
 b=bcWv3NsomKmRBz5mrgi7PCPaqH6XVam4w8C2VP0SmY/xx6OEN7TZSfWxP+CfW7DW9Y
 hL9vyh1abk1nJ0hlzBn5dCBVOI7tAWwn99wTAdhCfamcUGYkpk0d9TdnPCDEbjDFEcGq
 8h5Zx/y3tvUoTAo3XDdug8EULU7kcUvHx9Ogu0xv6bM+/3tkT4++y77vZ1WnVj4Krq4Y
 Uce2N0dRPWq3uDNfGrWxzhnrIK8jNJRIwJNpNTvkDAgMO6PdwogZ9r1GLKbThFV4xTTF
 qJEJvf0CCyNSSpV82i4QkwjL4TTiMZOmYnPdlEIoXnnsntStD2Gy+L87CpRYWy5poBvi
 xUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=yxFhi+v4IC2UcxjejYMfLiCZ7feHlM7zFzXNrJnON5w=;
 b=t4YlU/8mmMrlCy/hOg5atDdGcczk9W6e0Acy8D7hbweb7e5IRLXFlpXQA+y20VULVm
 tKkwUMbm/odboE6MhQ96qDLRHrz14lrmruLvZY4wQPuz4ZpwEZ1CzS0Wq84gZyNkuSN5
 TMkRp+k8ErVwDvqXVr9wtwTMcpe/5OpOjEWvAxSXi5Hsw9JvBEV5fGnCBKsGPFdsepMf
 bIHfqY4H6wN4SdUuZQU4xl9As7nFkg5qkVxMVqWbiEhOztrNx0Uzv13HfDWw1Cv20xsn
 +AycXt/6ilMvHPtmcXWvqEbkoZKZFbYRybcVfOwyB1iC4q4FhXawdqeopdAXCXJa3dSV
 9vUQ==
X-Gm-Message-State: APjAAAXbmeCDywc18OFWVdvzjmGjBKkBlDnlrM0BUIdp0F0VFGp4ngM5
 jtmiQtEGp1UPpclgpibSpoMS5ufxz7E=
X-Google-Smtp-Source: APXvYqy+bGBXjaFrwKlkyLmjGBzqvmAfLzQvohLtnZMX7grqqiTlaN3+LfRITbjXjil7WoRB+qTukw==
X-Received: by 2002:a05:600c:228f:: with SMTP id
 15mr79371125wmf.60.1564145499791; 
 Fri, 26 Jul 2019 05:51:39 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id z1sm55504610wrv.90.2019.07.26.05.51.39
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 05:51:39 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CE8061FF87;
 Fri, 26 Jul 2019 13:51:38 +0100 (BST)
References: <20190720010235.32444-1-vandersonmr2@gmail.com>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190720010235.32444-1-vandersonmr2@gmail.com>
Date: Fri, 26 Jul 2019 13:51:38 +0100
Message-ID: <87tvb9gdr9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v4 0/7] Measure Tiny Code Generation Quality
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
Cc: vandersonmr <vandersonmr2@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


vandersonmr <vandersonmr2@gmail.com> writes:

> This patch is part of Google Summer of Code (GSoC) 2019.
> More about the project can be found in:
> https://wiki.qemu.org/Internships/ProjectIdeas/TCGCodeQuality
>
> The goal of this patch is to add infrastructure to collect
> execution and JIT statistics during the emulation with accel/TCG.
> The statistics are stored in TBStatistic structures (TBStats)
> with each TB having its respective TBStats.
>
> We added -d tb_stats and HMP tb_stats commands to allow the control
> of this statistics collection. And info tb, tbs, and coverset commands
> were also added to allow dumping and exploring all this information
> while emulating.

Hmm with:

  -d tb_stats:10:all

I'm seeing the following bt:

  Thread 4 "qemu-system-aar" received signal SIGABRT, Aborted.
  [Switching to Thread 0x7fffe5285700 (LWP 898)]
  __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/unix/sysv/linux/raise.c:50
  50      ../sysdeps/unix/sysv/linux/raise.c: No such file or directory.
  (gdb) bt
  #0  0x00007ffff51787bb in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/=
unix/sysv/linux/raise.c:50
  #1  0x00007ffff5163535 in __GI_abort () at abort.c:79
  #2  0x0000555555bab663 in OP_E (bytemode=3D2, sizeflag=3D3) at /home/alex=
/lsrc/qemu.git/disas/i386.c:5094
  #3  0x0000555555ba972f in print_insn (pc=3D140735911299712, info=3D0x7fff=
e5281c00) at /home/alex/lsrc/qemu.git/disas/i386.c:4071
  #4  0x0000555555ba8623 in print_insn_i386 (pc=3D140735911299712, info=3D0=
x7fffe5281c00) at /home/alex/lsrc/qemu.git/disas/i386.c:3705
  #5  0x0000555555881241 in get_num_insts (code=3D0x7fffa2000a80 <code_gen_=
buffer+33557075>, size=3D88) at /home/alex/lsrc/qemu.git/disas.c:575
  #6  0x00005555558d89f1 in tb_gen_code (cpu=3D0x555556a1f6a0, pc=3D1844674=
3524230025728, cs_base=3D0, flags=3D2415924229, cflags=3D-16252928) at /hom=
e/alex/lsrc/qemu.git/accel/tcg/translate-all.c:1881
  #7  0x00005555558d4984 in tb_find (cpu=3D0x555556a1f6a0, last_tb=3D0x0, t=
b_exit=3D0, cf_mask=3D524288) at /home/alex/lsrc/qemu.git/accel/tcg/cpu-exe=
c.c:409
  #8  0x00005555558d524f in cpu_exec (cpu=3D0x555556a1f6a0) at /home/alex/l=
src/qemu.git/accel/tcg/cpu-exec.c:731
  #9  0x0000555555884806 in tcg_cpu_exec (cpu=3D0x555556a1f6a0) at /home/al=
ex/lsrc/qemu.git/cpus.c:1435
  #10 0x000055555588505c in qemu_tcg_cpu_thread_fn (arg=3D0x555556a1f6a0) a=
t /home/alex/lsrc/qemu.git/cpus.c:1743
  #11 0x0000555556010875 in qemu_thread_start (args=3D0x555556a75450) at /h=
ome/alex/lsrc/qemu.git/util/qemu-thread-posix.c:502
  #12 0x00007ffff530bfa3 in start_thread (arg=3D<optimized out>) at pthread=
_create.c:486
  #13 0x00007ffff523a4cf in clone () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone.S:95


>
> Collecting these statistics and information is useful to understand
> qemu performance and to help to add the support for traces to QEMU.
>
> vandersonmr (7):
>   accel: introducing TBStatistics structure
>   accel: collecting TB execution count
>   accel: collecting JIT statistics
>   accel: replacing part of CONFIG_PROFILER with TBStats
>   log: adding -d tb_stats to control tbstats
>   monitor: adding tb_stats hmp command
>   monitor: adding info tbs, tb, and coverset
>
>  accel/tcg/Makefile.objs      |   2 +-
>  accel/tcg/tb-stats.c         | 489 +++++++++++++++++++++++++++++++++++
>  accel/tcg/tcg-runtime.c      |   7 +
>  accel/tcg/tcg-runtime.h      |   2 +
>  accel/tcg/translate-all.c    |  93 ++++++-
>  accel/tcg/translator.c       |   6 +
>  disas.c                      | 108 ++++++++
>  hmp-commands-info.hx         |  23 ++
>  hmp-commands.hx              |  17 ++
>  include/disas/disas.h        |   1 +
>  include/exec/exec-all.h      |  15 +-
>  include/exec/gen-icount.h    |   9 +
>  include/exec/tb-context.h    |  12 +
>  include/exec/tb-hash.h       |   7 +
>  include/exec/tb-stats.h      | 113 ++++++++
>  include/qemu/log-for-trace.h |   2 +
>  include/qemu/log.h           |  16 ++
>  linux-user/exit.c            |   4 +
>  monitor/misc.c               | 111 ++++++++
>  tcg/tcg.c                    | 114 +++-----
>  tcg/tcg.h                    |  12 +-
>  util/log.c                   |  99 ++++++-
>  22 files changed, 1144 insertions(+), 118 deletions(-)
>  create mode 100644 accel/tcg/tb-stats.c
>  create mode 100644 include/exec/tb-stats.h


--
Alex Benn=C3=A9e


Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA263C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 19:51:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80A34205C9
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 19:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="V05zwEXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A34205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58830 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGqav-00071c-SQ
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 15:51:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lfy@google.com>) id 1hGqZX-00066y-On
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:50:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lfy@google.com>) id 1hGqZW-0004zx-EB
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:50:19 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:33734)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lfy@google.com>) id 1hGqZW-0004zI-1Y
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:50:18 -0400
Received: by mail-ot1-x333.google.com with SMTP id j10so21832240otq.0
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 12:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=j4g0IMdZs1+FLZbabdMFJTLqFcGkSuXgE/dfpVZkE8Y=;
	b=V05zwEXwRmee5LHp2ScpDp439YO6NL8joLQGfwahrPAIAlseo8lKpS8kB7m+xsSvR3
	4BetJ4JLWYZL9HSDGh56TkU1Q1g3TaNXVryi6ZBNkXurCRD8h6o1Yi9tIhPtcT9MeiIG
	bsTNp3IAPicNi+5dBH/bxtjim/GKM7jep84omD7QpAsrTVj+y6wZvdr8MNiWXmeeqZOl
	LAn400w3/25qPGG0uJh9+UjlxKPnmYesV95+g2ysB9PVoefYBZm/QrE9dp9PNf9Pw1ob
	DUDQAwSn6uYYm/78D47CuER3f9DlPIgLgSsT3cKpVaC57W2dqzUyPQwLk/cWTdzAZC2F
	fNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=j4g0IMdZs1+FLZbabdMFJTLqFcGkSuXgE/dfpVZkE8Y=;
	b=dh4SCskWITnJ45WSyUxXLznjC0wEh+T7OgvFR5Y878ReuLeFLETKQLc18M+22vzmFY
	tz5j3Yn2fzt0FGAVTfYjWuRLx4mJSNTAky23atLPlNMqqYf45CLmg2BlMg1T5jFrwEAJ
	bl5RQWwDSsmARn8OrXvZA4JHbU6Gcgt4/crYrLiRwxOohnZ9RC/MxTduesc+tbcumV0a
	YvE7KwfyAIa8UyVtDbYaVP0uhQBnvQtuAEkUzdZU8YIVEBIYeJg/FXdNF9rzeneOxhkL
	ApSb1EsMUctxlgQNWUZIqE/hongEw8S0CZKEWRBeRZ41L4Ujd1Rpm2dNrjanU07t9xm7
	Afrg==
X-Gm-Message-State: APjAAAWra/4dI1dbSxkg8KcshzHICysj/v2Q72uK7o4RoOxhFMNpmaDj
	J2ZJcvc96DqrSKjU4/uQ6B/kA6YZkuroOoup3dYa/iO8pci1jg==
X-Google-Smtp-Source: APXvYqw2seqkatdKLJGOu7CsJFlYClbQEgvzitdUAYCy9zyU0m0pFOCSoXocdPYxOX9XZIZuqlh4bagADUPPYEb1RZk=
X-Received: by 2002:a9d:2c28:: with SMTP id f37mr56711572otb.126.1555530615178;
	Wed, 17 Apr 2019 12:50:15 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 17 Apr 2019 12:50:04 -0700
Message-ID:
 <CAEkmjvU2chrbUnbV9GHidwrVb5roP+XCu0CmygaQnaFQAw8ALQ@mail.gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::333
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: [Qemu-devel] tsan: many race conditions involving mmio
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
From: Frank Yang via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Frank Yang <lfy@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417195004.m4E9_SA1bL8XeuJx_KD0ShqFfvVhmiXnxKaAck-_6j8@z>

What's a quick fix for stuff like this?

WARNING: ThreadSanitizer: data race (pid=168036)
  Write of size 8 at 0x7b900017a100 by thread T1 (mutexes: write M2141):
    #0 free
/toolchain/llvm/projects/compiler-rt/lib/tsan/rtl/tsan_interceptors.cc:715:3
(qemu-system-x86_64+0x484028)
    #1 phys_sections_free
/usr/local/google/home/lfy/emu/external/qemu/objs/../exec.c:1455:5
(qemu-system-x86_64+0x523608)
    #2 address_space_dispatch_free
/usr/local/google/home/lfy/emu/external/qemu/objs/../exec.c:3236
(qemu-system-x86_64+0x523608)
    #3 flatview_destroy
/usr/local/google/home/lfy/emu/external/qemu/objs/../memory.c:290:9
(qemu-system-x86_64+0x5bfcd1)
    #4 call_rcu_thread
/usr/local/google/home/lfy/emu/external/qemu/objs/../util/rcu.c:284:13
(qemu-system-x86_64+0xb23274)
    #5 qemu_thread_trampoline
/usr/local/google/home/lfy/emu/external/qemu/objs/../util/qemu-thread-posix.c:551:17
(qemu-system-x86_64+0xb033c6)

  Previous read of size 8 at 0x7b900017a100 by thread T14:
    #0 address_space_lookup_region
/usr/local/google/home/lfy/emu/external/qemu/objs/../exec.c:431:37
(qemu-system-x86_64+0x51b9b8)
    #1 address_space_translate_internal
/usr/local/google/home/lfy/emu/external/qemu/objs/../exec.c:447
(qemu-system-x86_64+0x51b9b8)
    #2 flatview_do_translate
/usr/local/google/home/lfy/emu/external/qemu/objs/../exec.c:616:15
(qemu-system-x86_64+0x51b318)
    #3 flatview_translate
/usr/local/google/home/lfy/emu/external/qemu/objs/../exec.c:680:15
(qemu-system-x86_64+0x52bf20)
    #4 address_space_translate
/usr/local/google/home/lfy/emu/external/qemu/objs/../include/exec/memory.h:1896
(qemu-system-x86_64+0x52bf20)
    #5 address_space_lduw_internal_cached
/usr/local/google/home/lfy/emu/external/qemu/objs/../memory_ldst.inc.c:264
(qemu-system-x86_64+0x52bf20)
    #6 address_space_lduw_le_cached
/usr/local/google/home/lfy/emu/external/qemu/objs/../memory_ldst.inc.c:315:12
(qemu-system-x86_64+0x52c44b)
    #7 lduw_le_phys_cached
/usr/local/google/home/lfy/emu/external/qemu/objs/../memory_ldst.inc.c:334
(qemu-system-x86_64+0x52c44b)
    #8 virtio_lduw_phys_cached
/usr/local/google/home/lfy/emu/external/qemu/objs/../include/hw/virtio/virtio-access.h:166:12
(qemu-system-x86_64+0x65c97b)
    #9 vring_avail_idx
/usr/local/google/home/lfy/emu/external/qemu/objs/../hw/virtio/virtio.c:240
(qemu-system-x86_64+0x65c97b)
    #10 virtio_queue_empty
/usr/local/google/home/lfy/emu/external/qemu/objs/../hw/virtio/virtio.c:392
(qemu-system-x86_64+0x65c97b)
    #11 virtio_queue_host_notifier_aio_poll
/usr/local/google/home/lfy/emu/external/qemu/objs/../hw/virtio/virtio.c:2427
(qemu-system-x86_64+0x65c97b)
    #12 run_poll_handlers_once
/usr/local/google/home/lfy/emu/external/qemu/objs/../util/aio-posix.c:502:13
(qemu-system-x86_64+0xaffd63)
    #13 try_poll_mode
/usr/local/google/home/lfy/emu/external/qemu/objs/../util/aio-posix.c:587
(qemu-system-x86_64+0xaffd63)
    #14 aio_poll
/usr/local/google/home/lfy/emu/external/qemu/objs/../util/aio-posix.c:618
(qemu-system-x86_64+0xaffd63)
    #15 iothread_run
/usr/local/google/home/lfy/emu/external/qemu/objs/../iothread.c:64:9
(qemu-system-x86_64+0xa53344)
    #16 qemu_thread_trampoline
/usr/local/google/home/lfy/emu/external/qemu/objs/../util/qemu-thread-posix.c:551:17
(qemu-system-x86_64+0xb033c6)

Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82B0C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:09:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FD8920738
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:09:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD8920738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpXzw-0002Fd-QF
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 10:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jpXzH-0001kp-HK; Sun, 28 Jun 2020 10:08:51 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:38356)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jpXzE-0002qg-Q4; Sun, 28 Jun 2020 10:08:50 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 13EAC746307;
 Sun, 28 Jun 2020 16:08:45 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E31E574594E; Sun, 28 Jun 2020 16:08:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E10477456F8;
 Sun, 28 Jun 2020 16:08:44 +0200 (CEST)
Date: Sun, 28 Jun 2020 16:08:44 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v5 09/11] macio: Add dummy screamer register area
In-Reply-To: <alpine.BSF.2.22.395.2006281406340.95193@zero.eik.bme.hu>
Message-ID: <alpine.BSF.2.22.395.2006281555030.21756@zero.eik.bme.hu>
References: <cover.1592315226.git.balaton@eik.bme.hu>
 <ecaaee4ba802b7a53de03e401c4d68e94de554f5.1592315226.git.balaton@eik.bme.hu>
 <3012998c-8345-f654-1de1-dd623ef375e8@ilande.co.uk>
 <alpine.BSF.2.22.395.2006281406340.95193@zero.eik.bme.hu>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/28 08:37:51
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Here it is with --enable-debug and additional screamer debug:

SCREAMER: screamer_read: addr 0000000000000000 -> 0
SCREAMER: screamer_write: addr 0000000000000000 val 11
SCREAMER: screamer_control_write: val 17
SCREAMER: basic rate: 44100
DBDMA[10]: writel 0x000000000000080c <= 0x00000010
DBDMA[10]: channel 0x10 reg 0x3
DBDMA[10]: dbdma_cmdptr_load 0x00000010
DBDMA[10]: writel 0x0000000000000800 <= 0xf0000000
DBDMA[10]: channel 0x10 reg 0x0
DBDMA[10]:  Clearing RUN !
DBDMA[10]:  clearing PAUSE !
DBDMA[10]:   -> ACTIVE down !
DBDMA[10]:  new status=0x00000000
SCREAMER: DMA TX flush!
DBDMA[10]: readl 0x0000000000000804 => 0x00000000
DBDMA[10]: channel 0x10 reg 0x1
DBDMA[10]: writel 0x0000000000000800 <= 0xf0008000
DBDMA[10]: channel 0x10 reg 0x0
DBDMA[10]:  Setting RUN !
DBDMA[10]:  clearing PAUSE !
DBDMA[10]:  -> ACTIVE up !
DBDMA[10]:  new status=0x00008400
DBDMA[10]: readl 0x0000000000000804 => 0x00008400
DBDMA[10]: channel 0x10 reg 0x1
DBDMA: -> DBDMA_run_bh
DBDMA[10]: channel_run
DBDMA[10]: dbdma_cmd 0x555556aac340
DBDMA[10]:     req_count 0x8000
DBDMA[10]:     command 0x0000
DBDMA[10]:     phy_addr 0x00000100
DBDMA[10]:     cmd_dep 0x00000000
DBDMA[10]:     res_count 0x0000
DBDMA[10]:     xfer_status 0x0000
DBDMA[10]: * OUTPUT_MORE *
DBDMA[10]: start_output
DBDMA[10]: addr 0x100 key 0x0
SCREAMER: DMA TX defer interrupt!
DBDMA: <- DBDMA_run_bh
SCREAMER: Processing deferred buffer
SCREAMER: DMA TX transfer: addr 100 len: 8000  bpos: 0

Thread 1 "qemu-system-ppc" received signal SIGSEGV, Segmentation fault.
0x0000000094ff7c19 in ?? ()

(gdb) bt
#0  0x0000000094ff7c19 in  ()
#1  0x0000555555acb1e2 in pmac_screamer_tx_transfer (io=0x555556ab1a98) at hw/audio/screamer.c:79
#2  0x0000555555acb4dd in screamerspk_callback (opaque=0x555556aad630, avail=16384) at hw/audio/screamer.c:155
#3  0x0000555555a6af3d in audio_run_out (s=0x555556b12bd0) at audio/audio.c:1181
#4  0x0000555555a6b886 in audio_run (s=0x555556b12bd0, msg=0x55555609d4a9 "alsa run (prepared)") at audio/audio.c:1372
#5  0x0000555555d00ce9 in alsa_poll_handler (opaque=0x555557959c60) at audio/alsaaudio.c:199
#6  0x0000555555e57079 in aio_dispatch_handler (ctx=0x5555567257f0, node=0x555557a0c6b0) at util/aio-posix.c:328
#7  0x0000555555e57232 in aio_dispatch_handlers (ctx=0x5555567257f0) at util/aio-posix.c:371
#8  0x0000555555e57288 in aio_dispatch (ctx=0x5555567257f0) at util/aio-posix.c:381
#9  0x0000555555e6d373 in aio_ctx_dispatch (source=0x5555567257f0, callback=0x0, user_data=0x0) at util/async.c:306
#10 0x00007ffff7cc6665 in g_main_context_dispatch () at /lib64/libglib-2.0.so.0
#11 0x0000555555e74898 in glib_pollfds_poll () at util/main-loop.c:219
#12 0x0000555555e74912 in os_host_main_loop_wait (timeout=28915159) at util/main-loop.c:242
#13 0x0000555555e74a17 in main_loop_wait (nonblocking=0) at util/main-loop.c:518
#14 0x0000555555981d35 in qemu_main_loop () at qemu/softmmu/vl.c:1664
#15 0x0000555555df59dc in main (argc=17, argv=0x7fffffffdf28, envp=0x7fffffffdfb8) at qemu/softmmu/main.c:49
(gdb) up
#1  0x0000555555acb1e2 in pmac_screamer_tx_transfer (io=0x555556ab1a98) at hw/audio/screamer.c:79
79	    io->dma_end(io);
(gdb) p/x *io
$1 = {opaque = 0xa2140923, channel = 0x79130821, addr = 0x14137e1f, len = 0x0, is_last = 0x0, is_dma_out = 0x3408f81a, dma_end = 0x94ff7c19, processing = 0x19,  dma_mem = 0x53f5351b, dma_len = 0xc7f99f1e, dir = 0x21fbe921}

Looks like dma_end is not pointing to the expected end procedure. Maybe something has overwritten it?

Regards,
BALATON Zoltan


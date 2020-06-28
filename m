Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06F0C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 12:27:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 741EF20702
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 12:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741EF20702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpWPO-0005zn-N1
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 08:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jpWOB-0005Sq-3y; Sun, 28 Jun 2020 08:26:27 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:60239)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jpWO7-0006Al-LJ; Sun, 28 Jun 2020 08:26:25 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 3DCE3746331;
 Sun, 28 Jun 2020 14:26:11 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0ACC474632C; Sun, 28 Jun 2020 14:26:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 08D1774632B;
 Sun, 28 Jun 2020 14:26:11 +0200 (CEST)
Date: Sun, 28 Jun 2020 14:26:11 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v5 09/11] macio: Add dummy screamer register area
In-Reply-To: <3012998c-8345-f654-1de1-dd623ef375e8@ilande.co.uk>
Message-ID: <alpine.BSF.2.22.395.2006281406340.95193@zero.eik.bme.hu>
References: <cover.1592315226.git.balaton@eik.bme.hu>
 <ecaaee4ba802b7a53de03e401c4d68e94de554f5.1592315226.git.balaton@eik.bme.hu>
 <3012998c-8345-f654-1de1-dd623ef375e8@ilande.co.uk>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: Howard Spoelstra <hsp.cat7@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jun 2020, Mark Cave-Ayland wrote:
> Again I'm wary of adding empty devices here as the main issue around the screamer
> code (and why it has not been submitted upstream) is that it can cause random hangs
> for MacOS on startup. Does it regress any MacOS 9 through 10.5 boot tests?
>
> FWIW I've rebased the latest version of my screamer branch at
> https://github.com/mcayland/qemu/commits/screamer to git master if you want to see if
> any noise comes out.

It seems the dummy screamer patch is not enough so I've tried on top of 
your screamer branch now. It does not make sound but it crashes (this is 
with --audio-drv-list=alsa in case that matters):

17609@1593346435.329466:cuda_packet_receive length 5
17609@1593346435.329467:cuda_packet_receive_data [0] 0x01
17609@1593346435.329469:cuda_packet_receive_data [1] 0x22
17609@1593346435.329470:cuda_packet_receive_data [2] 0x8a
17609@1593346435.329471:cuda_packet_receive_data [3] 0x01
17609@1593346435.329472:cuda_packet_receive_data [4] 0x29
17609@1593346435.329473:cuda_receive_packet_cmd handling command GET_SET_IIC
CUDA: unimplemented GET_SET_IIC write 0x45 3
17609@1593346435.329476:i2c_event start(addr:0x50)
smbus: error: Unexpected send start condition in state -1
17609@1593346435.329478:cuda_packet_send length 3
17609@1593346435.329479:cuda_packet_send_data [0] 0x01
17609@1593346435.329480:cuda_packet_send_data [1] 0x00
17609@1593346435.329482:cuda_packet_send_data [2] 0x22
17609@1593346435.329483:cuda_delay_set_sr_int
17609@1593346435.329514:cuda_data_recv recv: 0x01
17609@1593346435.329516:cuda_delay_set_sr_int
17609@1593346435.329548:cuda_data_recv recv: 0x00
17609@1593346435.329550:cuda_delay_set_sr_int
17609@1593346435.329588:cuda_data_recv recv: 0x22
17609@1593346435.329590:cuda_delay_set_sr_int
17609@1593346435.366095:cuda_delay_set_sr_int
DBDMA[10]: writel 0x000000000000080c <= 0xffe40020
DBDMA[10]: channel 0x10 reg 0x3
DBDMA[10]: dbdma_cmdptr_load 0xffe40020
DBDMA[10]: writel 0x0000000000000800 <= 0xf0000000
DBDMA[10]: channel 0x10 reg 0x0
DBDMA[10]:  Clearing RUN !
DBDMA[10]:  clearing PAUSE !
DBDMA[10]:   -> ACTIVE down !
DBDMA[10]:  new status=0x00000000
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
DBDMA[10]: dbdma_cmd 0x555556802c50
DBDMA[10]:     req_count 0x6238
DBDMA[10]:     command 0x1000
DBDMA[10]:     phy_addr 0xffe32c00
DBDMA[10]:     cmd_dep 0x00000000
DBDMA[10]:     res_count 0x0000
DBDMA[10]:     xfer_status 0x0000
DBDMA[10]: * OUTPUT_LAST *
DBDMA[10]: start_output
DBDMA[10]: addr 0xffe32c00 key 0x0
DBDMA: <- DBDMA_run_bh

Thread 1 "qemu-system-ppc" received signal SIGSEGV, Segmentation fault.
0x0000555555a13216 in pmac_screamer_tx_transfer (io=0x5555568083a8) at 
hw/audio/screamer.c:79
79	    io->dma_end(io);

#0  0x0000555555a13216 in pmac_screamer_tx_transfer (io=0x5555568083a8) at hw/audio/screamer.c:79
#1  0x00005555559dc7bb in audio_run_out (s=0x555556868dc0) at audio/audio.c:1181
#2  0x00005555559dc7bb in audio_run (s=0x555556868dc0, msg=msg@entry=0x555555e69664 "alsa run (prepared)") at audio/audio.c:1372
#3  0x0000555555bab458 in alsa_poll_handler (opaque=0x55555770eb50) at audio/alsaaudio.c:199
#4  0x0000555555cad63b in aio_dispatch_handler (ctx=ctx@entry=0x555556487860, node=0x55555770e700) at util/aio-posix.c:328
#5  0x0000555555cadf0c in aio_dispatch_handlers (ctx=0x555556487860) at util/aio-posix.c:371
#6  0x0000555555cadf0c in aio_dispatch (ctx=0x555556487860) at util/aio-posix.c:381
#7  0x0000555555cbe60e in aio_ctx_dispatch (source=<optimized out>, callback=<optimized out>, user_data=<optimized out>) at util/async.c:306
#8  0x00007ffff7cc6665 in g_main_context_dispatch () at /lib64/libglib-2.0.so.0
#9  0x0000555555cc3938 in glib_pollfds_poll () at util/main-loop.c:219
#10 0x0000555555cc3938 in os_host_main_loop_wait (timeout=<optimized out>) at util/main-loop.c:242
#11 0x0000555555cc3938 in main_loop_wait (nonblocking=nonblocking@entry=0) at util/main-loop.c:518
#12 0x0000555555932a49 in qemu_main_loop () at qemu/softmmu/vl.c:1664
#13 0x000055555585138e in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at qemu/softmmu/main.c:49

Does the same on master with your patches and my series.

Regards,
BALATON Zoltan


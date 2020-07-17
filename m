Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D5AC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 17:20:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52D0220704
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 17:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ie58hXXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52D0220704
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwU27-0006e2-JI
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 13:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwU1S-0005wX-4F; Fri, 17 Jul 2020 13:19:46 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:40471)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwU1P-0005r6-Sm; Fri, 17 Jul 2020 13:19:45 -0400
Received: by mail-ej1-x644.google.com with SMTP id o18so11647710eje.7;
 Fri, 17 Jul 2020 10:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=d18oQfmzx1Zi6yKmQ2ydWRnM5m1FMy+yxBjSGhi73ik=;
 b=Ie58hXXPG4OEHN8L1fW+TWsaKIdj75mHEVpYkwSITnBMTqUTLsr5cKt0xsVZ0Hm2+R
 Fh6UWsYZIFzTIGAMqYdi06rhcVoH06nt1qTd0/O36G0lNjIb0Afzfi/fU+Dm9HOsRzjr
 1RsW7dyRurSAMH4UZPGv4DnEcoBJlh4pmOxYvDbQ3RnVrnbEAS3Vm1c+t+URvAP/JsMK
 vwLxX54b+56viTdIqK7yQTITA5o8pm/g7zBzQsSYEn46LypTKRlOgxjDBsDaxPLIfkwp
 VIjCekrsVgrFZ92IXjvUY1fnQPHC7igde0MtBbNWdYVvYiydEIsPFQrLAX2IPxQnSTm8
 pGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=d18oQfmzx1Zi6yKmQ2ydWRnM5m1FMy+yxBjSGhi73ik=;
 b=OQH6GCNfowV3rgORdLcxauQ7+PbPG+8qTLhEpI++buO/sRnQJbe/Hc+nEwYN9Z8oMt
 9ihelCYH18/qBnxSfwm8ohqoNOYNagjpKKcUx+S6jPFolzcwqxK0F5tvgxqIdnrog2Z8
 mrbEQcqxvvOj0/BGI5GiBOXhX2++Rs/ulMC/y03WRWiWm90pBeq/OiAQx/kaTYxXK/GG
 nrPPpOxfcEhelZsL9RUawWgTV5Zhyy0NOUG7fi1HrI1qa1PByW1d2F2YbZtaSF5t0T+X
 5bg26G1M/kbSIBrw69rEprUNDmlV1FDy7CEvFlx4wk/J9Mfwdu61VAj3iqkPJuOH8e8g
 ACeQ==
X-Gm-Message-State: AOAM533rmfToR+TNcDEyJicf2RP7VP9B+0066S/S5MoXoywz/woOquQ7
 fUNNQMpo4WT++JO0HVBOrbXFkoZC3tQ=
X-Google-Smtp-Source: ABdhPJyjCjsbv+k0pA6OGRcH25A2uZUtJMMdn7wWnPVUXIh5fnpGCLePdVAUTnMEZtcipXNCPUE0wQ==
X-Received: by 2002:a17:906:c943:: with SMTP id
 fw3mr9284676ejb.55.1595006381352; 
 Fri, 17 Jul 2020 10:19:41 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id v25sm8818378edr.74.2020.07.17.10.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2020 10:19:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH-for-5.1] hw/ide: Do not block for AIO while resetting a
 drive
Date: Fri, 17 Jul 2020 19:19:38 +0200
Message-Id: <20200717171938.1249-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

libFuzzer triggered the following assertion:

  cat << EOF | qemu-system-i386 -M pc-q35-5.0 \
    -nographic -monitor none -serial none \
    -qtest stdio -trace ide\*
  outl 0xcf8 0x8000fa24
  outl 0xcfc 0xe106c000
  outl 0xcf8 0x8000fa04
  outw 0xcfc 0x7
  outl 0xcf8 0x8000fb20
  write 0x0 0x3 0x2780e7
  write 0xe106c22c 0xd 0x1130c218021130c218021130c2
  write 0xe106c218 0x15 0x110010110010110010110010110010110010110010
  EOF
  ide_exec_cmd IDE exec cmd: bus 0x56170a77a2b8; state 0x56170a77a340; cmd 0xe7
  ide_reset IDEstate 0x56170a77a340
  Aborted (core dumped)

  (gdb) bt
  #1  0x00007ffff4f93895 in abort () at /lib64/libc.so.6
  #2  0x0000555555dc6c00 in bdrv_aio_cancel (acb=0x555556765550) at block/io.c:2745
  #3  0x0000555555dac202 in blk_aio_cancel (acb=0x555556765550) at block/block-backend.c:1546
  #4  0x0000555555b1bd74 in ide_reset (s=0x555557213340) at hw/ide/core.c:1318
  #5  0x0000555555b1e3a1 in ide_bus_reset (bus=0x5555572132b8) at hw/ide/core.c:2422
  #6  0x0000555555b2aa27 in ahci_reset_port (s=0x55555720eb50, port=2) at hw/ide/ahci.c:650
  #7  0x0000555555b29fd7 in ahci_port_write (s=0x55555720eb50, port=2, offset=44, val=16) at hw/ide/ahci.c:360
  #8  0x0000555555b2a564 in ahci_mem_write (opaque=0x55555720eb50, addr=556, val=16, size=1) at hw/ide/ahci.c:513
  #9  0x000055555598415b in memory_region_write_accessor (mr=0x55555720eb80, addr=556, value=0x7fffffffb838, size=1, shift=0, mask=255, attrs=...) at softmmu/memory.c:483

Looking at bdrv_aio_cancel:

2728 /* async I/Os */
2729
2730 void bdrv_aio_cancel(BlockAIOCB *acb)
2731 {
2732     qemu_aio_ref(acb);
2733     bdrv_aio_cancel_async(acb);
2734     while (acb->refcnt > 1) {
2735         if (acb->aiocb_info->get_aio_context) {
2736             aio_poll(acb->aiocb_info->get_aio_context(acb), true);
2737         } else if (acb->bs) {
2738             /* qemu_aio_ref and qemu_aio_unref are not thread-safe, so
2739              * assert that we're not using an I/O thread.  Thread-safe
2740              * code should use bdrv_aio_cancel_async exclusively.
2741              */
2742             assert(bdrv_get_aio_context(acb->bs) == qemu_get_aio_context());
2743             aio_poll(bdrv_get_aio_context(acb->bs), true);
2744         } else {
2745             abort();     <===============
2746         }
2747     }
2748     qemu_aio_unref(acb);
2749 }

Our context is already referenced but we don't have a getter,
neither a block driver state. Maybe because we are called from
a vCPU context? Avoid this case by calling the pending callback
directly. In this case this is WIN_FLUSH_CACHE. I'm not sure for
the other READ/WRITE commands.

Reported-by: Alexander Bulekov <alxndr@bu.edu>
Fixes: bef0fd5958 ("ide: convert ide_sector_read() to asynchronous I/O")
BugLink: https://bugs.launchpad.net/qemu/+bug/1878255
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
RFC because I don't understand AIO operations well.
After RFC Cc: qemu-stable@nongnu.org

ide_is_pio_out() verifies a PIO OUT checking:

  s->end_transfer_func == ide_dummy_transfer_stop

An alternative might be:

    if (s->pio_aiocb && s->end_transfer_func == ide_dummy_transfer_stop) {
        /* If there is a pending AIO callback, invoke it now. */
        blk_aio_cancel_async(s->pio_aiocb);
        s->pio_aiocb = NULL;
    }

Or if we want to limit to WIN_FLUSH_CACHE:

    if (s->pio_aiocb && s->bus->error_status & IDE_RETRY_FLUSH) {
        /* If there is a pending AIO callback, invoke it now. */
        blk_aio_cancel_async(s->pio_aiocb);
        s->pio_aiocb = NULL;
    }

Cc: Stefan Hajnoczi <stefanha@redhat.com>

Last minute chat:
19:01 <stefanha> f4bug: use bdrv_aio_cancel_async() if possible because it won't block the current thread.
19:02 <stefanha> f4bug: For example, in device emulation code where the guest has requested to cancel an I/O request it's often possible to use the async version.
19:02 <stefanha> f4bug: But in synchronous code like device reset it may be necessary to use the synchronous (blocking) bdrv_aio_cancel() API instead. :(
19:14 <stefanha> f4bug: The way to decide is: will the current function return to the event loop and is there someone who will handle the request completion callback when cancel finishes?
19:14 <stefanha> f4bug: If the next line of code requires the request to finished then async cancel cannot be used.
19:15 <stefanha> f4bug: On the other hand, if the function can return and it's okay for the request to cancel at some future time then you can use async.

So I'll revisit this patch :)
---
 hw/ide/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index d997a78e47..e3a9ce7d25 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -1315,7 +1315,8 @@ static void ide_reset(IDEState *s)
     trace_ide_reset(s);
 
     if (s->pio_aiocb) {
-        blk_aio_cancel(s->pio_aiocb);
+        /* If there is a pending AIO callback, invoke it now. */
+        blk_aio_cancel_async(s->pio_aiocb);
         s->pio_aiocb = NULL;
     }
 
-- 
2.21.3



Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D1FC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:05:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09E1F20721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E1F20721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdb3-0000vJ-UF
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 12:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdVv-0001LH-Ke; Mon, 04 May 2020 12:00:15 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:44231)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdVt-0005lV-Uh; Mon, 04 May 2020 12:00:15 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N2Unv-1j9WfG1KZj-013rJ2; Mon, 04 May 2020 18:00:09 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 10/19] Compress lines for immediate return
Date: Mon,  4 May 2020 17:59:47 +0200
Message-Id: <20200504155956.380695-11-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504155956.380695-1-laurent@vivier.eu>
References: <20200504155956.380695-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:P3N0uPLKPJIb/bYPaYgYpjNUyt9xBCp395PXu7WsdQuBoNJVehR
 6WgBSJvxyQ37otDgds89Sws2H8XT4bwPBc/ceKs5LTuOMRB65BqAqYdT8FZX3lTrpKSnXO3
 dmeS/1NO3joi1SMpq3IHgKZoXFQAcL+PhCRuMofyw/ovpCEHa9tdi5oBHUDO5ZqeluY0iKL
 Ge4g+zitlB+N8wsLcanwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d7zq/M5tqUs=:yU6zU9nspbu1zWVEQUNzoh
 HzsvuIR0ZpP7IL60AePDoyGy4r0+mMUyzP+VNTKxLxBsiy4HchpUHwA4dEUj7MjyfzFyLULLp
 5g5xC/7YAIR3d5a6pFIIIo1DxKdIjFqQ+AlOdKap1vTU/qHbZzGI5Y73YUxmgVEs4G59rT5HS
 z9pmqXAxZRHk61bl3/WAo9rADcJE/dUKPzLyMDaonl10KLfeoGTWM0iuLJY6aifaV5Pi2xC8f
 sD8HrmHiwqJvKC8vRqiomKf+NUXNdqzknAkeEbEhv0XscDeKYwJSEG0t9lFxbm0Wv1FFrMxim
 fwsPvyfHmkpkenxQXjGbN5ybD81xGY3RJVuWouf3ZN1xIFaFEfHcbCaCZZdwwsEVs6vGrCm8t
 zDV5QMHnCFG7WTquEfH9SH4dOLrOjRNXxfmEX3cMM74TBsGSgnTM6oL/I2iBMNk55vlcAmyIB
 if7MaFYU67fUznL2n+IL/UlYrmrW9dN6KR+JTkEjiKWVqdu4N5RPrAaKW0eNAoLTDbRKxIKRM
 vC53GtD74y7l7NExqM7I1pOFjDhnZJH9TWvimM3tipetUHE0ofWBqeaoSZga7UomTb4h5+BKB
 6j5L4ht5U91eIJhHw1m3JCGvYehvJBM0Ey6LmkGvSJECkOgJxELTgtJ4Rv/ESRFvJWxM7+R1Q
 Om2kiWhUI/Pjg+RIHl5/4Fym2K5UlI3svRd/ckHMBFosY/8l5adDTNlBKYVal7SWTKIy7OJtj
 lwsFk+yW/olasbbXt4LvhWw4HGvjjhhJo9pVvW1FYVF1hubmMo+RdADAHbMggTiqzEy9H5tdx
 tVH3FVIdAFX5BxrSVnOo+fnke1kT9grthJovbUs19bxYt73lE1Ncu8Y3cK4U8T9TN8t+2jz
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 11:59:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Simran Singhal <singhalsimran0@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Simran Singhal <singhalsimran0@gmail.com>

Compress two lines into a single line if immediate return statement is found.

It also remove variables progress, val, data, ret and sock
as they are no longer needed.

Remove space between function "mixer_load" and '(' to fix the
checkpatch.pl error:-
ERROR: space prohibited between function name and open parenthesis '('

Done using following coccinelle script:
@@
local idexpression ret;
expression e;
@@

-ret =
+return
     e;
-return ret;

Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20200401165314.GA3213@simran-Inspiron-5558>
[lv: in handle_aiocb_write_zeroes_unmap() move "int ret" inside the #ifdef]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 block/file-posix.c      | 8 +++-----
 block/nfs.c             | 3 +--
 block/nvme.c            | 4 +---
 block/vhdx.c            | 3 +--
 hw/audio/ac97.c         | 4 +---
 hw/audio/adlib.c        | 5 +----
 hw/display/cirrus_vga.c | 4 +---
 migration/ram.c         | 4 +---
 ui/gtk.c                | 3 +--
 util/qemu-sockets.c     | 5 +----
 10 files changed, 12 insertions(+), 31 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index bf09ad8bc0d0..05e094be295c 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1617,13 +1617,12 @@ static int handle_aiocb_write_zeroes_unmap(void *opaque)
 {
     RawPosixAIOData *aiocb = opaque;
     BDRVRawState *s G_GNUC_UNUSED = aiocb->bs->opaque;
-    int ret;
 
     /* First try to write zeros and unmap at the same time */
 
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
-    ret = do_fallocate(s->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
-                       aiocb->aio_offset, aiocb->aio_nbytes);
+    int ret = do_fallocate(s->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+                           aiocb->aio_offset, aiocb->aio_nbytes);
     if (ret != -ENOTSUP) {
         return ret;
     }
@@ -1631,8 +1630,7 @@ static int handle_aiocb_write_zeroes_unmap(void *opaque)
 
     /* If we couldn't manage to unmap while guaranteed that the area reads as
      * all-zero afterwards, just write zeroes without unmapping */
-    ret = handle_aiocb_write_zeroes(aiocb);
-    return ret;
+    return handle_aiocb_write_zeroes(aiocb);
 }
 
 #ifndef HAVE_COPY_FILE_RANGE
diff --git a/block/nfs.c b/block/nfs.c
index 2393fbfe6bcc..18c0a7369454 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -623,8 +623,7 @@ static int nfs_file_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     bs->total_sectors = ret;
-    ret = 0;
-    return ret;
+    return 0;
 }
 
 static QemuOptsList nfs_create_opts = {
diff --git a/block/nvme.c b/block/nvme.c
index 7b7c0cc5d673..eb2f54dd9dc9 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -575,11 +575,9 @@ static bool nvme_poll_cb(void *opaque)
 {
     EventNotifier *e = opaque;
     BDRVNVMeState *s = container_of(e, BDRVNVMeState, irq_notifier);
-    bool progress = false;
 
     trace_nvme_poll_cb(s);
-    progress = nvme_poll_queues(s);
-    return progress;
+    return nvme_poll_queues(s);
 }
 
 static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
diff --git a/block/vhdx.c b/block/vhdx.c
index 45be0a43218c..aedd78260455 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -411,8 +411,7 @@ int vhdx_update_headers(BlockDriverState *bs, BDRVVHDXState *s,
     if (ret < 0) {
         return ret;
     }
-    ret = vhdx_update_header(bs, s, generate_data_write_guid, log_guid);
-    return ret;
+    return vhdx_update_header(bs, s, generate_data_write_guid, log_guid);
 }
 
 /* opens the specified header block from the VHDX file header section */
diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 1ec87feec0cb..8a9b9924c495 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -573,11 +573,9 @@ static uint32_t nam_readb (void *opaque, uint32_t addr)
 static uint32_t nam_readw (void *opaque, uint32_t addr)
 {
     AC97LinkState *s = opaque;
-    uint32_t val = ~0U;
     uint32_t index = addr;
     s->cas = 0;
-    val = mixer_load (s, index);
-    return val;
+    return mixer_load(s, index);
 }
 
 static uint32_t nam_readl (void *opaque, uint32_t addr)
diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index d6c1fb0586c6..7c3b67dcfb8c 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -120,13 +120,10 @@ static void adlib_write(void *opaque, uint32_t nport, uint32_t val)
 static uint32_t adlib_read(void *opaque, uint32_t nport)
 {
     AdlibState *s = opaque;
-    uint8_t data;
     int a = nport & 3;
 
     adlib_kill_timers (s);
-    data = OPLRead (s->opl, a);
-
-    return data;
+    return OPLRead (s->opl, a);
 }
 
 static void timer_handler (void *opaque, int c, double interval_Sec)
diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 0d391e1300aa..1f29731ffe11 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -2411,12 +2411,10 @@ static uint64_t cirrus_linear_bitblt_read(void *opaque,
                                           unsigned size)
 {
     CirrusVGAState *s = opaque;
-    uint32_t ret;
 
     /* XXX handle bitblt */
     (void)s;
-    ret = 0xff;
-    return ret;
+    return 0xff;
 }
 
 static void cirrus_linear_bitblt_write(void *opaque,
diff --git a/migration/ram.c b/migration/ram.c
index 04f13feb2e77..06cba8863280 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2135,9 +2135,7 @@ int ram_postcopy_send_discard_bitmap(MigrationState *ms)
     }
     trace_ram_postcopy_send_discard_bitmap();
 
-    ret = postcopy_each_ram_send_discard(ms);
-
-    return ret;
+    return postcopy_each_ram_send_discard(ms);
 }
 
 /**
diff --git a/ui/gtk.c b/ui/gtk.c
index 030b251c6109..83f2f5d49b2a 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1650,8 +1650,7 @@ static GSList *gd_vc_menu_init(GtkDisplayState *s, VirtualConsole *vc,
                      G_CALLBACK(gd_menu_switch_vc), s);
     gtk_menu_shell_append(GTK_MENU_SHELL(view_menu), vc->menu_item);
 
-    group = gtk_radio_menu_item_get_group(GTK_RADIO_MENU_ITEM(vc->menu_item));
-    return group;
+    return gtk_radio_menu_item_get_group(GTK_RADIO_MENU_ITEM(vc->menu_item));
 }
 
 #if defined(CONFIG_VTE)
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index bcc06d0e01c7..86c48b9fa5de 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -765,15 +765,12 @@ static int vsock_connect_addr(const struct sockaddr_vm *svm, Error **errp)
 static int vsock_connect_saddr(VsockSocketAddress *vaddr, Error **errp)
 {
     struct sockaddr_vm svm;
-    int sock = -1;
 
     if (!vsock_parse_vaddr_to_sockaddr(vaddr, &svm, errp)) {
         return -1;
     }
 
-    sock = vsock_connect_addr(&svm, errp);
-
-    return sock;
+    return vsock_connect_addr(&svm, errp);
 }
 
 static int vsock_listen_saddr(VsockSocketAddress *vaddr,
-- 
2.26.2



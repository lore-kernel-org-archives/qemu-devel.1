Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBF7C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 11:26:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72CCC2082C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 11:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72CCC2082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55690 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdCGL-0003HA-L6
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 07:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44020)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <anthony.perard@citrix.com>) id 1hdCDN-0001ld-UJ
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 07:23:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1hdCDM-00070t-BA
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 07:23:49 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:60646)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1hdCDM-0006zD-2N
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 07:23:48 -0400
Authentication-Results: esa4.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa4.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: 0YgI770VsdhoIsphZWcQsKcBuzjS8UWsFf1zYfmmFTerRJBZpdH3Nf+9s4UWKHZShSF14ImmcB
 /ywwj7hsJ6tXiTtcUPx0/rK19zftTQnCI4eWjBFGTn3jyI0Q6XAPgBo6BfWETnS8xXlz6GqSfQ
 q/lh0RoR6DAoNC1jhXHn9BCAD3JL24Yo0Rq4euZ+H7gweGm4dctu76L4ECTuURCOp0eTNUed+6
 79K0L+sOuXsp6q04UVCEcdOLd0SC9+llZydC1lxgM3wHNtgX7B22OEh3dKtXCDytK0bdEsEyib
 h9Y=
X-SBRS: 2.7
X-MesageID: 1889399
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.63,389,1557201600"; 
   d="scan'208";a="1889399"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Date: Tue, 18 Jun 2019 12:23:41 +0100
Message-ID: <20190618112341.513-5-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190618112341.513-1-anthony.perard@citrix.com>
References: <20190618112341.513-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.155.144
Subject: [Qemu-devel] [PATCH v2 4/4] xen: Avoid VLA
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
Cc: Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Paul Durrant <paul.durrant@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avoid using a variable length array.

We allocate the `dirty_bitmap' buffer only once when we start tracking
for dirty bits.

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---

Notes:
    v2:
    - Allocate the bitmap buffer only once when we start tracking dirty bits.
      (instead of at every function call)
    
    Was suggested by Peter here:
    <CAFEAcA88+A2oCkQnxKDEdpmfCZSmPzWMBg01wDDV68bMZoY5Jg@mail.gmail.com>
    "should we try to stop using variable length arrays?"

 hw/i386/xen/xen-hvm.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index ae3deb4ef3..469f1260a4 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -119,6 +119,8 @@ typedef struct XenIOState {
     DeviceListener device_listener;
     hwaddr free_phys_offset;
     const XenPhysmap *log_for_dirtybit;
+    /* Buffer used by xen_sync_dirty_bitmap */
+    unsigned long *dirty_bitmap;
 
     Notifier exit;
     Notifier suspend;
@@ -464,6 +466,8 @@ static int xen_remove_from_physmap(XenIOState *state,
     QLIST_REMOVE(physmap, list);
     if (state->log_for_dirtybit == physmap) {
         state->log_for_dirtybit = NULL;
+        g_free(state->dirty_bitmap);
+        state->dirty_bitmap = NULL;
     }
     g_free(physmap);
 
@@ -614,7 +618,7 @@ static void xen_sync_dirty_bitmap(XenIOState *state,
 {
     hwaddr npages = size >> TARGET_PAGE_BITS;
     const int width = sizeof(unsigned long) * 8;
-    unsigned long bitmap[DIV_ROUND_UP(npages, width)];
+    size_t bitmap_size = DIV_ROUND_UP(npages, width);
     int rc, i, j;
     const XenPhysmap *physmap = NULL;
 
@@ -626,13 +630,14 @@ static void xen_sync_dirty_bitmap(XenIOState *state,
 
     if (state->log_for_dirtybit == NULL) {
         state->log_for_dirtybit = physmap;
+        state->dirty_bitmap = g_new(unsigned long, bitmap_size);
     } else if (state->log_for_dirtybit != physmap) {
         /* Only one range for dirty bitmap can be tracked. */
         return;
     }
 
     rc = xen_track_dirty_vram(xen_domid, start_addr >> TARGET_PAGE_BITS,
-                              npages, bitmap);
+                              npages, state->dirty_bitmap);
     if (rc < 0) {
 #ifndef ENODATA
 #define ENODATA  ENOENT
@@ -646,8 +651,8 @@ static void xen_sync_dirty_bitmap(XenIOState *state,
         return;
     }
 
-    for (i = 0; i < ARRAY_SIZE(bitmap); i++) {
-        unsigned long map = bitmap[i];
+    for (i = 0; i < bitmap_size; i++) {
+        unsigned long map = state->dirty_bitmap[i];
         while (map != 0) {
             j = ctzl(map);
             map &= ~(1ul << j);
@@ -677,6 +682,8 @@ static void xen_log_stop(MemoryListener *listener, MemoryRegionSection *section,
 
     if (old & ~new & (1 << DIRTY_MEMORY_VGA)) {
         state->log_for_dirtybit = NULL;
+        g_free(state->dirty_bitmap);
+        state->dirty_bitmap = NULL;
         /* Disable dirty bit tracking */
         xen_track_dirty_vram(xen_domid, 0, 0, NULL);
     }
-- 
Anthony PERARD



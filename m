Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712A7C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:30:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 281732083B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXC/57e2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 281732083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlucK-00038e-Jx
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 09:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jluVW-0006zR-UL
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:23:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32181
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jluVT-0005p3-Nj
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592486583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=/kEiaq0IrQZNKeI0/BswEAzv4Zf9MTTd1ITASsYEk9Q=;
 b=PXC/57e2jYmlOKJAFE3JSIUE9aaeu6ie5fMTTjOpjeCecqQLxhaGhuAXlCNZ+3Cw79/7f+
 Kg/FX3iqmbDGZkEb0vGRUPS9oc4Pb7xHdGz95wO4kgAZiLC01xgOY0axbmZqmkAgSDufL5
 Ly2EblyZNBhaXqHRrDzdYwf04q5AtcI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-BkCQPqehMnGicrpe9I8jBQ-1; Thu, 18 Jun 2020 09:22:59 -0400
X-MC-Unique: BkCQPqehMnGicrpe9I8jBQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99CE21937FF0;
 Thu, 18 Jun 2020 13:22:51 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-109.pek2.redhat.com
 [10.72.12.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F2D64CF92A;
 Thu, 18 Jun 2020 13:22:49 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL V2 17/33] net: cadence_gem: Fix up code style
Date: Thu, 18 Jun 2020 21:21:32 +0800
Message-Id: <1592486508-6135-18-git-send-email-jasowang@redhat.com>
In-Reply-To: <1592486508-6135-1-git-send-email-jasowang@redhat.com>
References: <1592486508-6135-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:21:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

Fix the code style for register definitions.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/cadence_gem.c | 204 ++++++++++++++++++++++++++-------------------------
 1 file changed, 103 insertions(+), 101 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 247a52f..22d0d16 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -43,110 +43,112 @@
     } \
 } while (0)
 
-#define GEM_NWCTRL        (0x00000000/4) /* Network Control reg */
-#define GEM_NWCFG         (0x00000004/4) /* Network Config reg */
-#define GEM_NWSTATUS      (0x00000008/4) /* Network Status reg */
-#define GEM_USERIO        (0x0000000C/4) /* User IO reg */
-#define GEM_DMACFG        (0x00000010/4) /* DMA Control reg */
-#define GEM_TXSTATUS      (0x00000014/4) /* TX Status reg */
-#define GEM_RXQBASE       (0x00000018/4) /* RX Q Base address reg */
-#define GEM_TXQBASE       (0x0000001C/4) /* TX Q Base address reg */
-#define GEM_RXSTATUS      (0x00000020/4) /* RX Status reg */
-#define GEM_ISR           (0x00000024/4) /* Interrupt Status reg */
-#define GEM_IER           (0x00000028/4) /* Interrupt Enable reg */
-#define GEM_IDR           (0x0000002C/4) /* Interrupt Disable reg */
-#define GEM_IMR           (0x00000030/4) /* Interrupt Mask reg */
-#define GEM_PHYMNTNC      (0x00000034/4) /* Phy Maintenance reg */
-#define GEM_RXPAUSE       (0x00000038/4) /* RX Pause Time reg */
-#define GEM_TXPAUSE       (0x0000003C/4) /* TX Pause Time reg */
-#define GEM_TXPARTIALSF   (0x00000040/4) /* TX Partial Store and Forward */
-#define GEM_RXPARTIALSF   (0x00000044/4) /* RX Partial Store and Forward */
-#define GEM_HASHLO        (0x00000080/4) /* Hash Low address reg */
-#define GEM_HASHHI        (0x00000084/4) /* Hash High address reg */
-#define GEM_SPADDR1LO     (0x00000088/4) /* Specific addr 1 low reg */
-#define GEM_SPADDR1HI     (0x0000008C/4) /* Specific addr 1 high reg */
-#define GEM_SPADDR2LO     (0x00000090/4) /* Specific addr 2 low reg */
-#define GEM_SPADDR2HI     (0x00000094/4) /* Specific addr 2 high reg */
-#define GEM_SPADDR3LO     (0x00000098/4) /* Specific addr 3 low reg */
-#define GEM_SPADDR3HI     (0x0000009C/4) /* Specific addr 3 high reg */
-#define GEM_SPADDR4LO     (0x000000A0/4) /* Specific addr 4 low reg */
-#define GEM_SPADDR4HI     (0x000000A4/4) /* Specific addr 4 high reg */
-#define GEM_TIDMATCH1     (0x000000A8/4) /* Type ID1 Match reg */
-#define GEM_TIDMATCH2     (0x000000AC/4) /* Type ID2 Match reg */
-#define GEM_TIDMATCH3     (0x000000B0/4) /* Type ID3 Match reg */
-#define GEM_TIDMATCH4     (0x000000B4/4) /* Type ID4 Match reg */
-#define GEM_WOLAN         (0x000000B8/4) /* Wake on LAN reg */
-#define GEM_IPGSTRETCH    (0x000000BC/4) /* IPG Stretch reg */
-#define GEM_SVLAN         (0x000000C0/4) /* Stacked VLAN reg */
-#define GEM_MODID         (0x000000FC/4) /* Module ID reg */
-#define GEM_OCTTXLO       (0x00000100/4) /* Octects transmitted Low reg */
-#define GEM_OCTTXHI       (0x00000104/4) /* Octects transmitted High reg */
-#define GEM_TXCNT         (0x00000108/4) /* Error-free Frames transmitted */
-#define GEM_TXBCNT        (0x0000010C/4) /* Error-free Broadcast Frames */
-#define GEM_TXMCNT        (0x00000110/4) /* Error-free Multicast Frame */
-#define GEM_TXPAUSECNT    (0x00000114/4) /* Pause Frames Transmitted */
-#define GEM_TX64CNT       (0x00000118/4) /* Error-free 64 TX */
-#define GEM_TX65CNT       (0x0000011C/4) /* Error-free 65-127 TX */
-#define GEM_TX128CNT      (0x00000120/4) /* Error-free 128-255 TX */
-#define GEM_TX256CNT      (0x00000124/4) /* Error-free 256-511 */
-#define GEM_TX512CNT      (0x00000128/4) /* Error-free 512-1023 TX */
-#define GEM_TX1024CNT     (0x0000012C/4) /* Error-free 1024-1518 TX */
-#define GEM_TX1519CNT     (0x00000130/4) /* Error-free larger than 1519 TX */
-#define GEM_TXURUNCNT     (0x00000134/4) /* TX under run error counter */
-#define GEM_SINGLECOLLCNT (0x00000138/4) /* Single Collision Frames */
-#define GEM_MULTCOLLCNT   (0x0000013C/4) /* Multiple Collision Frames */
-#define GEM_EXCESSCOLLCNT (0x00000140/4) /* Excessive Collision Frames */
-#define GEM_LATECOLLCNT   (0x00000144/4) /* Late Collision Frames */
-#define GEM_DEFERTXCNT    (0x00000148/4) /* Deferred Transmission Frames */
-#define GEM_CSENSECNT     (0x0000014C/4) /* Carrier Sense Error Counter */
-#define GEM_OCTRXLO       (0x00000150/4) /* Octects Received register Low */
-#define GEM_OCTRXHI       (0x00000154/4) /* Octects Received register High */
-#define GEM_RXCNT         (0x00000158/4) /* Error-free Frames Received */
-#define GEM_RXBROADCNT    (0x0000015C/4) /* Error-free Broadcast Frames RX */
-#define GEM_RXMULTICNT    (0x00000160/4) /* Error-free Multicast Frames RX */
-#define GEM_RXPAUSECNT    (0x00000164/4) /* Pause Frames Received Counter */
-#define GEM_RX64CNT       (0x00000168/4) /* Error-free 64 byte Frames RX */
-#define GEM_RX65CNT       (0x0000016C/4) /* Error-free 65-127B Frames RX */
-#define GEM_RX128CNT      (0x00000170/4) /* Error-free 128-255B Frames RX */
-#define GEM_RX256CNT      (0x00000174/4) /* Error-free 256-512B Frames RX */
-#define GEM_RX512CNT      (0x00000178/4) /* Error-free 512-1023B Frames RX */
-#define GEM_RX1024CNT     (0x0000017C/4) /* Error-free 1024-1518B Frames RX */
-#define GEM_RX1519CNT     (0x00000180/4) /* Error-free 1519-max Frames RX */
-#define GEM_RXUNDERCNT    (0x00000184/4) /* Undersize Frames Received */
-#define GEM_RXOVERCNT     (0x00000188/4) /* Oversize Frames Received */
-#define GEM_RXJABCNT      (0x0000018C/4) /* Jabbers Received Counter */
-#define GEM_RXFCSCNT      (0x00000190/4) /* Frame Check seq. Error Counter */
-#define GEM_RXLENERRCNT   (0x00000194/4) /* Length Field Error Counter */
-#define GEM_RXSYMERRCNT   (0x00000198/4) /* Symbol Error Counter */
-#define GEM_RXALIGNERRCNT (0x0000019C/4) /* Alignment Error Counter */
-#define GEM_RXRSCERRCNT   (0x000001A0/4) /* Receive Resource Error Counter */
-#define GEM_RXORUNCNT     (0x000001A4/4) /* Receive Overrun Counter */
-#define GEM_RXIPCSERRCNT  (0x000001A8/4) /* IP header Checksum Error Counter */
-#define GEM_RXTCPCCNT     (0x000001AC/4) /* TCP Checksum Error Counter */
-#define GEM_RXUDPCCNT     (0x000001B0/4) /* UDP Checksum Error Counter */
-
-#define GEM_1588S         (0x000001D0/4) /* 1588 Timer Seconds */
-#define GEM_1588NS        (0x000001D4/4) /* 1588 Timer Nanoseconds */
-#define GEM_1588ADJ       (0x000001D8/4) /* 1588 Timer Adjust */
-#define GEM_1588INC       (0x000001DC/4) /* 1588 Timer Increment */
-#define GEM_PTPETXS       (0x000001E0/4) /* PTP Event Frame Transmitted (s) */
-#define GEM_PTPETXNS      (0x000001E4/4) /* PTP Event Frame Transmitted (ns) */
-#define GEM_PTPERXS       (0x000001E8/4) /* PTP Event Frame Received (s) */
-#define GEM_PTPERXNS      (0x000001EC/4) /* PTP Event Frame Received (ns) */
-#define GEM_PTPPTXS       (0x000001E0/4) /* PTP Peer Frame Transmitted (s) */
-#define GEM_PTPPTXNS      (0x000001E4/4) /* PTP Peer Frame Transmitted (ns) */
-#define GEM_PTPPRXS       (0x000001E8/4) /* PTP Peer Frame Received (s) */
-#define GEM_PTPPRXNS      (0x000001EC/4) /* PTP Peer Frame Received (ns) */
+#define GEM_NWCTRL        (0x00000000 / 4) /* Network Control reg */
+#define GEM_NWCFG         (0x00000004 / 4) /* Network Config reg */
+#define GEM_NWSTATUS      (0x00000008 / 4) /* Network Status reg */
+#define GEM_USERIO        (0x0000000C / 4) /* User IO reg */
+#define GEM_DMACFG        (0x00000010 / 4) /* DMA Control reg */
+#define GEM_TXSTATUS      (0x00000014 / 4) /* TX Status reg */
+#define GEM_RXQBASE       (0x00000018 / 4) /* RX Q Base address reg */
+#define GEM_TXQBASE       (0x0000001C / 4) /* TX Q Base address reg */
+#define GEM_RXSTATUS      (0x00000020 / 4) /* RX Status reg */
+#define GEM_ISR           (0x00000024 / 4) /* Interrupt Status reg */
+#define GEM_IER           (0x00000028 / 4) /* Interrupt Enable reg */
+#define GEM_IDR           (0x0000002C / 4) /* Interrupt Disable reg */
+#define GEM_IMR           (0x00000030 / 4) /* Interrupt Mask reg */
+#define GEM_PHYMNTNC      (0x00000034 / 4) /* Phy Maintenance reg */
+#define GEM_RXPAUSE       (0x00000038 / 4) /* RX Pause Time reg */
+#define GEM_TXPAUSE       (0x0000003C / 4) /* TX Pause Time reg */
+#define GEM_TXPARTIALSF   (0x00000040 / 4) /* TX Partial Store and Forward */
+#define GEM_RXPARTIALSF   (0x00000044 / 4) /* RX Partial Store and Forward */
+#define GEM_HASHLO        (0x00000080 / 4) /* Hash Low address reg */
+#define GEM_HASHHI        (0x00000084 / 4) /* Hash High address reg */
+#define GEM_SPADDR1LO     (0x00000088 / 4) /* Specific addr 1 low reg */
+#define GEM_SPADDR1HI     (0x0000008C / 4) /* Specific addr 1 high reg */
+#define GEM_SPADDR2LO     (0x00000090 / 4) /* Specific addr 2 low reg */
+#define GEM_SPADDR2HI     (0x00000094 / 4) /* Specific addr 2 high reg */
+#define GEM_SPADDR3LO     (0x00000098 / 4) /* Specific addr 3 low reg */
+#define GEM_SPADDR3HI     (0x0000009C / 4) /* Specific addr 3 high reg */
+#define GEM_SPADDR4LO     (0x000000A0 / 4) /* Specific addr 4 low reg */
+#define GEM_SPADDR4HI     (0x000000A4 / 4) /* Specific addr 4 high reg */
+#define GEM_TIDMATCH1     (0x000000A8 / 4) /* Type ID1 Match reg */
+#define GEM_TIDMATCH2     (0x000000AC / 4) /* Type ID2 Match reg */
+#define GEM_TIDMATCH3     (0x000000B0 / 4) /* Type ID3 Match reg */
+#define GEM_TIDMATCH4     (0x000000B4 / 4) /* Type ID4 Match reg */
+#define GEM_WOLAN         (0x000000B8 / 4) /* Wake on LAN reg */
+#define GEM_IPGSTRETCH    (0x000000BC / 4) /* IPG Stretch reg */
+#define GEM_SVLAN         (0x000000C0 / 4) /* Stacked VLAN reg */
+#define GEM_MODID         (0x000000FC / 4) /* Module ID reg */
+#define GEM_OCTTXLO       (0x00000100 / 4) /* Octects transmitted Low reg */
+#define GEM_OCTTXHI       (0x00000104 / 4) /* Octects transmitted High reg */
+#define GEM_TXCNT         (0x00000108 / 4) /* Error-free Frames transmitted */
+#define GEM_TXBCNT        (0x0000010C / 4) /* Error-free Broadcast Frames */
+#define GEM_TXMCNT        (0x00000110 / 4) /* Error-free Multicast Frame */
+#define GEM_TXPAUSECNT    (0x00000114 / 4) /* Pause Frames Transmitted */
+#define GEM_TX64CNT       (0x00000118 / 4) /* Error-free 64 TX */
+#define GEM_TX65CNT       (0x0000011C / 4) /* Error-free 65-127 TX */
+#define GEM_TX128CNT      (0x00000120 / 4) /* Error-free 128-255 TX */
+#define GEM_TX256CNT      (0x00000124 / 4) /* Error-free 256-511 */
+#define GEM_TX512CNT      (0x00000128 / 4) /* Error-free 512-1023 TX */
+#define GEM_TX1024CNT     (0x0000012C / 4) /* Error-free 1024-1518 TX */
+#define GEM_TX1519CNT     (0x00000130 / 4) /* Error-free larger than 1519 TX */
+#define GEM_TXURUNCNT     (0x00000134 / 4) /* TX under run error counter */
+#define GEM_SINGLECOLLCNT (0x00000138 / 4) /* Single Collision Frames */
+#define GEM_MULTCOLLCNT   (0x0000013C / 4) /* Multiple Collision Frames */
+#define GEM_EXCESSCOLLCNT (0x00000140 / 4) /* Excessive Collision Frames */
+#define GEM_LATECOLLCNT   (0x00000144 / 4) /* Late Collision Frames */
+#define GEM_DEFERTXCNT    (0x00000148 / 4) /* Deferred Transmission Frames */
+#define GEM_CSENSECNT     (0x0000014C / 4) /* Carrier Sense Error Counter */
+#define GEM_OCTRXLO       (0x00000150 / 4) /* Octects Received register Low */
+#define GEM_OCTRXHI       (0x00000154 / 4) /* Octects Received register High */
+#define GEM_RXCNT         (0x00000158 / 4) /* Error-free Frames Received */
+#define GEM_RXBROADCNT    (0x0000015C / 4) /* Error-free Broadcast Frames RX */
+#define GEM_RXMULTICNT    (0x00000160 / 4) /* Error-free Multicast Frames RX */
+#define GEM_RXPAUSECNT    (0x00000164 / 4) /* Pause Frames Received Counter */
+#define GEM_RX64CNT       (0x00000168 / 4) /* Error-free 64 byte Frames RX */
+#define GEM_RX65CNT       (0x0000016C / 4) /* Error-free 65-127B Frames RX */
+#define GEM_RX128CNT      (0x00000170 / 4) /* Error-free 128-255B Frames RX */
+#define GEM_RX256CNT      (0x00000174 / 4) /* Error-free 256-512B Frames RX */
+#define GEM_RX512CNT      (0x00000178 / 4) /* Error-free 512-1023B Frames RX */
+#define GEM_RX1024CNT     (0x0000017C / 4) /* Error-free 1024-1518B Frames RX */
+#define GEM_RX1519CNT     (0x00000180 / 4) /* Error-free 1519-max Frames RX */
+#define GEM_RXUNDERCNT    (0x00000184 / 4) /* Undersize Frames Received */
+#define GEM_RXOVERCNT     (0x00000188 / 4) /* Oversize Frames Received */
+#define GEM_RXJABCNT      (0x0000018C / 4) /* Jabbers Received Counter */
+#define GEM_RXFCSCNT      (0x00000190 / 4) /* Frame Check seq. Error Counter */
+#define GEM_RXLENERRCNT   (0x00000194 / 4) /* Length Field Error Counter */
+#define GEM_RXSYMERRCNT   (0x00000198 / 4) /* Symbol Error Counter */
+#define GEM_RXALIGNERRCNT (0x0000019C / 4) /* Alignment Error Counter */
+#define GEM_RXRSCERRCNT   (0x000001A0 / 4) /* Receive Resource Error Counter */
+#define GEM_RXORUNCNT     (0x000001A4 / 4) /* Receive Overrun Counter */
+#define GEM_RXIPCSERRCNT  (0x000001A8 / 4) /* IP header Checksum Err Counter */
+#define GEM_RXTCPCCNT     (0x000001AC / 4) /* TCP Checksum Error Counter */
+#define GEM_RXUDPCCNT     (0x000001B0 / 4) /* UDP Checksum Error Counter */
+
+#define GEM_1588S         (0x000001D0 / 4) /* 1588 Timer Seconds */
+#define GEM_1588NS        (0x000001D4 / 4) /* 1588 Timer Nanoseconds */
+#define GEM_1588ADJ       (0x000001D8 / 4) /* 1588 Timer Adjust */
+#define GEM_1588INC       (0x000001DC / 4) /* 1588 Timer Increment */
+#define GEM_PTPETXS       (0x000001E0 / 4) /* PTP Event Frame Transmitted (s) */
+#define GEM_PTPETXNS      (0x000001E4 / 4) /*
+                                            * PTP Event Frame Transmitted (ns)
+                                            */
+#define GEM_PTPERXS       (0x000001E8 / 4) /* PTP Event Frame Received (s) */
+#define GEM_PTPERXNS      (0x000001EC / 4) /* PTP Event Frame Received (ns) */
+#define GEM_PTPPTXS       (0x000001E0 / 4) /* PTP Peer Frame Transmitted (s) */
+#define GEM_PTPPTXNS      (0x000001E4 / 4) /* PTP Peer Frame Transmitted (ns) */
+#define GEM_PTPPRXS       (0x000001E8 / 4) /* PTP Peer Frame Received (s) */
+#define GEM_PTPPRXNS      (0x000001EC / 4) /* PTP Peer Frame Received (ns) */
 
 /* Design Configuration Registers */
-#define GEM_DESCONF       (0x00000280/4)
-#define GEM_DESCONF2      (0x00000284/4)
-#define GEM_DESCONF3      (0x00000288/4)
-#define GEM_DESCONF4      (0x0000028C/4)
-#define GEM_DESCONF5      (0x00000290/4)
-#define GEM_DESCONF6      (0x00000294/4)
+#define GEM_DESCONF       (0x00000280 / 4)
+#define GEM_DESCONF2      (0x00000284 / 4)
+#define GEM_DESCONF3      (0x00000288 / 4)
+#define GEM_DESCONF4      (0x0000028C / 4)
+#define GEM_DESCONF5      (0x00000290 / 4)
+#define GEM_DESCONF6      (0x00000294 / 4)
 #define GEM_DESCONF6_64B_MASK (1U << 23)
-#define GEM_DESCONF7      (0x00000298/4)
+#define GEM_DESCONF7      (0x00000298 / 4)
 
 #define GEM_INT_Q1_STATUS               (0x00000400 / 4)
 #define GEM_INT_Q1_MASK                 (0x00000640 / 4)
-- 
2.5.0



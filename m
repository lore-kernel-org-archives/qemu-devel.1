Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E386BC432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 12:50:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B06F52071A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 12:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwdmmMN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B06F52071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZaIZ-0005af-Ta
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 07:50:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aaron.zakhrov@gmail.com>) id 1iZaFS-0002Zk-M7
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:47:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aaron.zakhrov@gmail.com>) id 1iZaFR-0006PF-KN
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:47:18 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:44340)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aaron.zakhrov@gmail.com>)
 id 1iZaFR-0006OS-F0
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:47:17 -0500
Received: by mail-pl1-x634.google.com with SMTP id az9so8100730plb.11
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 04:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zbpFoQ9pmAzeK1m7zYyUnpnyJGtnrHOzILjdn9dJmI4=;
 b=rwdmmMN+ANUvZ65ckavuio96vs9P/3uuVrgLSMOLEPsWI2zCrgmRZUyuYQhYzgV4P7
 N6843vxSXmwnkNSHFKDYPtjIbJOmVC7R6Z2Xzk36eCkbWDAGAeKbuHePAWi79Caj6EKC
 vAHtg7Ah/iPYlvkuxS2QszWP1H6h0B9P+3i1iDon/vsVX4Ntpxbg01g3sJhMqPf2WPK4
 bSJ1s3NxaeEjq+J81Pr8uTVIE8cHwIDDKhg8L5llyO6kUkMeXiyFStxYt345BaUapIwC
 8krMPDtwyVsCjYLwk1gXxYldZKzxnY+EyJQLNAnyA7md6tRf4Li4WuXyXH9HoBT5qlIu
 EHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zbpFoQ9pmAzeK1m7zYyUnpnyJGtnrHOzILjdn9dJmI4=;
 b=LG76Ckge878+IGwwqk2uYdAfsRh2Y86d6HqEIbGDaPPze4p2N8QimqPudbDFqw106U
 oMpb7AXvZyFPrFEY22wrk9OfWi9CUgKsbHqjFUaEca0x8Ll7rhb71YoTIic8yUXKzxzA
 pqHYBPkE5FUhmBDbxTItfkuTg58eUknJJYBxyP70wOCOQtXv3+cTc0r6VD0dUrCvp83r
 ipNC9KRSj6x4M9f0baRwofse6Y4zoSuqnQTVSpKI86n7TZOTYVD5nY7Nn2E769L/E8kz
 /Zth8GEaf51+RtOyVN2c+44OHxzVsVWIzWLV2EjqDraLJnMBt83DpoBiJ6crJlUKl1PD
 8N2g==
X-Gm-Message-State: APjAAAVE8B1M6aVD0jxMP70tsWvi9iUYfiLTzqv3ezPVC8dM0s4V+doR
 50hOYoN+DsnNDdjoYktSGnUH3kSDCD43F9vT
X-Google-Smtp-Source: APXvYqyQLmUGZYI3gWsytDRXw2GjcarvAqqh/3AXpUkKOu5eoR9iz8thpUZDs+cXVKT258XnylvuJg==
X-Received: by 2002:a17:902:6bc4:: with SMTP id
 m4mr34485299plt.233.1574772435840; 
 Tue, 26 Nov 2019 04:47:15 -0800 (PST)
Received: from localhost.localdomain ([124.123.107.186])
 by smtp.gmail.com with ESMTPSA id d139sm13685922pfd.162.2019.11.26.04.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2019 04:47:14 -0800 (PST)
From: aaron.zakhrov@gmail.com
To: qemu-devel@nongnu.org
Subject: [RFC 07/10] R300 fixes
Date: Tue, 26 Nov 2019 18:14:33 +0530
Message-Id: <20191126124433.860-4-aaron.zakhrov@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191126124433.860-1-aaron.zakhrov@gmail.com>
References: <20191126124433.860-1-aaron.zakhrov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::634
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
Cc: kraxel@redhat.com, Aaron Dominick <aaron.zakhrov@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aaron Dominick <aaron.zakhrov@gmail.com>

---
 hw/display/r300.c | 9 +++++++++
 hw/display/r300.h | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/hw/display/r300.c b/hw/display/r300.c
index 653474c3aa..074dbf5b2d 100644
--- a/hw/display/r300.c
+++ b/hw/display/r300.c
@@ -878,6 +878,15 @@ static void r300_mm_write(void *opaque, hwaddr addr,
     case RADEON_DEFAULT_SC_BOTTOM_RIGHT:
         s->regs.default_sc_bottom_right = data & 0x3fff3fff;
         break;
+    case R300_GB_ENABLE:
+        s->regs.r300_gb_enable = data;
+        break;
+    case R300_GB_TILE_CONFIG:
+            s->regs.r300_gb_tile_config = data;
+            break;
+    case R300_GB_FIFO_SIZE:
+            s->regs.r300_gb_fifo_size = data;
+            break;
     default:
         break;
     }
diff --git a/hw/display/r300.h b/hw/display/r300.h
index a9e1db32be..19e3d97f8a 100644
--- a/hw/display/r300.h
+++ b/hw/display/r300.h
@@ -83,6 +83,12 @@ typedef struct RADVGARegs{
   uint32_t default_sc_bottom_right;
   uint32_t mc_status;
 
+  //R300 GB Registers
+  uint32_t r300_gb_enable;
+  uint32_t r300_gb_tile_config;
+  uint32_t r300_gb_fifo_size;
+
+
 //Color Buffer RB3D
   uint32_t r300_rb3d_aaresolve_ctl;
   uint32_t r300_rb3d_aaresolve_offset;
-- 
2.24.0



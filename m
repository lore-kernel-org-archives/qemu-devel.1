Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545DCC388F9
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 08:42:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACD2A223B0
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 08:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD2A223B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWy51-0002x0-OO
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 04:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kWxxu-0003LZ-9o
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 04:34:55 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:46990
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kWxxo-00062n-Op
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 04:34:54 -0400
Received: from host86-148-103-79.range86-148.btcentralplus.com
 ([86.148.103.79] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kWxxs-00082O-3R; Mon, 26 Oct 2020 08:34:56 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	kraxel@redhat.com,
	samuel.thibault@ens-lyon.org
Date: Mon, 26 Oct 2020 08:33:59 +0000
Message-Id: <20201026083401.13231-8-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201026083401.13231-1-mark.cave-ayland@ilande.co.uk>
References: <20201026083401.13231-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.148.103.79
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 7/9] dev-serial: add support for setting data_bits in
 QEMUSerialSetParams
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Also implement the behaviour reported in Linux's ftdi_sio.c whereby if an invalid
data_bits value is provided then the hardware defaults to using 8.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/usb/dev-serial.c | 17 +++++++++++++++++
 hw/usb/trace-events |  1 +
 2 files changed, 18 insertions(+)

diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 919e25e1d9..4c374d0790 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -308,6 +308,23 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
         break;
     }
     case VendorDeviceOutRequest | FTDI_SET_DATA:
+        switch (value & 0xff) {
+        case 7:
+            s->params.data_bits = 7;
+            break;
+        case 8:
+            s->params.data_bits = 8;
+            break;
+        default:
+            /*
+             * According to a comment in Linux's ftdi_sio.c original FTDI
+             * chips fall back to 8 data bits for unsupported data_bits
+             */
+            trace_usb_serial_unsupported_data_bits(bus->busnr, dev->addr,
+                                                   value & 0xff);
+            s->params.data_bits = 8;
+        }
+
         switch (value & FTDI_PARITY) {
         case 0:
             s->params.parity = 'N';
diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index 9e984b2e0c..0d0a3e5f2a 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -327,6 +327,7 @@ usb_serial_handle_control(int bus, int addr, int request, int value) "dev %d:%d
 usb_serial_unsupported_parity(int bus, int addr, int value) "dev %d:%d unsupported parity %d"
 usb_serial_unsupported_stopbits(int bus, int addr, int value) "dev %d:%d unsupported stop bits %d"
 usb_serial_unsupported_control(int bus, int addr, int request, int value) "dev %d:%d got unsupported/bogus control 0x%x, value 0x%x"
+usb_serial_unsupported_data_bits(int bus, int addr, int value) "dev %d:%d unsupported data bits %d, falling back to 8"
 usb_serial_bad_token(int bus, int addr) "dev %d:%d bad token"
 usb_serial_set_baud(int bus, int addr, int baud) "dev %d:%d baud rate %d"
 usb_serial_set_data(int bus, int addr, int parity, int data, int stop) "dev %d:%d parity %c, data bits %d, stop bits %d"
-- 
2.20.1



Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADC4C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 12:14:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8477F21734
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 12:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jIfJIBel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8477F21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaHga-00007l-Cb
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 07:14:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kaHfS-0007Xl-E1
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 07:13:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42830)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kaHfP-0007ol-0R
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 07:13:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604492010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rqPwVuzd+xNcq2NOXZ5u95vdesxmjeaiKL4t//5lY64=;
 b=jIfJIBelYSjRNtmT3500x2Gf8OQxnQG8h3vebXONe9KjoE+MGzPqXbFQsPnsGBL8bUIYjw
 NEHlfnckvtfoLA7MTs1K3nl4Q9Wz55KFQrWQKOZrkQk+402GIYB55Q4Oag6Zlr57UVFs6j
 pmgsjJUuI51fdO/1OEv6OiskfdeEFp0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-i02fnIF6N_yrJn91XhQVkQ-1; Wed, 04 Nov 2020 07:13:27 -0500
X-MC-Unique: i02fnIF6N_yrJn91XhQVkQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFB1187951C;
 Wed,  4 Nov 2020 12:13:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3EFC05DA30;
 Wed,  4 Nov 2020 12:13:22 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6CD0E9D17; Wed,  4 Nov 2020 13:13:21 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/8] dev-serial: add trace-events for baud rate and data
 parameters
Date: Wed,  4 Nov 2020 13:13:17 +0100
Message-Id: <20201104121321.7772-5-kraxel@redhat.com>
In-Reply-To: <20201104121321.7772-1-kraxel@redhat.com>
References: <20201104121321.7772-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20201027150456.24606-5-mark.cave-ayland@ilande.co.uk
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-serial.c | 3 +++
 hw/usb/trace-events | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index abc316c7bf1f..badf8785db46 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -307,6 +307,7 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
         }
 
         s->params.speed = (48000000 / 2) / (8 * divisor + subdivisor8);
+        trace_usb_serial_set_baud(bus->busnr, dev->addr, s->params.speed);
         qemu_chr_fe_ioctl(&s->cs, CHR_IOCTL_SERIAL_SET_PARAMS, &s->params);
         break;
     }
@@ -340,6 +341,8 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
             goto fail;
         }
 
+        trace_usb_serial_set_data(bus->busnr, dev->addr, s->params.parity,
+                                  s->params.data_bits, s->params.stop_bits);
         qemu_chr_fe_ioctl(&s->cs, CHR_IOCTL_SERIAL_SET_PARAMS, &s->params);
         /* TODO: TX ON/OFF */
         break;
diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index 89f1c351e339..98ee1c54627d 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -328,3 +328,5 @@ usb_serial_unsupported_parity(int bus, int addr, int value) "dev %d:%u unsupport
 usb_serial_unsupported_stopbits(int bus, int addr, int value) "dev %d:%u unsupported stop bits %d"
 usb_serial_unsupported_control(int bus, int addr, int request, int value) "dev %d:%u got unsupported/bogus control 0x%x, value 0x%x"
 usb_serial_bad_token(int bus, int addr) "dev %d:%u bad token"
+usb_serial_set_baud(int bus, int addr, int baud) "dev %d:%u baud rate %d"
+usb_serial_set_data(int bus, int addr, int parity, int data, int stop) "dev %d:%u parity %c, data bits %d, stop bits %d"
-- 
2.27.0



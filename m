Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2068C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:11:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FEC420674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJmVePaY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FEC420674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuDE-0005uI-PU
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42648)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jandryuk@gmail.com>) id 1jDtp4-0002jr-PR
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:46:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jandryuk@gmail.com>) id 1jDtp3-0001EL-No
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:46:42 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:45066)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jandryuk@gmail.com>) id 1jDtp2-000148-GI
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:46:41 -0400
Received: by mail-qk1-x741.google.com with SMTP id c145so27686146qke.12
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NYPa99RBsG8rBPsOgUkdsta0LQOmg9QvpdRKwBSChSo=;
 b=aJmVePaYLx0Akua/GEgMz5TMWILWbGFdp+mUZ4yY/lvBbVHvLCOpmxstv0xcwKVh5v
 ExM2+XQNYUaHvEkT1ZqDwZo9Zom3k2n1WBbioYTcyGQ3FVyzfQF/VjmFE+UxgdwD1kFE
 4pRUdJsu6E2oZeX3MGFx55wnq9wQDvVN6PV7qdcqE0FFLcFQe/W6bpetNqyPTQDmrX75
 Lph0BKCgvWdczGdO8RYwhbg6Q2Xp/4YjDIQsDymTGtzeNic0WCeDX7FOC0Uce9fbMeRV
 qPTeCnjCu4pRmuzYSvA5okPtfCy1dORZAuHP2nD1gYnV4BISa+3ljOVOHCvQifznb4Dg
 b8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NYPa99RBsG8rBPsOgUkdsta0LQOmg9QvpdRKwBSChSo=;
 b=quFyUlUPFUmz4wY18dBwbk/35u3nMiwwtrBBESHp9G9VgFgonao/5qDoKv6NeZxK/n
 Mje2CF9DZlkR4A4qLZyudZOTOhioE2YKVkhf9Gc+u7Zedt3IQYIOb6jw/DB3T+p2BrzF
 UHgIp3S5Wul17dvPBZZi6PW9TMToISkZA5LhK2Z0XfXyWZAwvB9b4l/TsJSQeJL0MSmv
 yvLvMehFwKr4fqDQXx2rxlDRJ5V3H7phZwMqRmVPUpi1batjb0bH0jNm5jdoR4kqgsNI
 gUquRRGo6cyqlbw/354yCQwucb9mc3trakBKay4aEcw5w1jQ66+clz5HYJrl7QOHDk6e
 OWxw==
X-Gm-Message-State: ANhLgQ2shwUdcnKP8/hh89UvGVU/ChhaaZ9Pu8Z82Vo0V4c3BNmk2VJO
 aQbhaGTvHsIZyBZC1safhDA=
X-Google-Smtp-Source: ADFU+vv2O7HnGZcU2Bjkh0J5Fg5IfkZw555n6o6hrVh/82lVv3s5xY/Un5JSLyjWV+xPRF3Py27kiw==
X-Received: by 2002:a37:6285:: with SMTP id w127mr886653qkb.138.1584380799866; 
 Mon, 16 Mar 2020 10:46:39 -0700 (PDT)
Received: from pm2-ws13.praxislan02.com ([2001:470:8:67e:7408:9006:8741:9ceb])
 by smtp.gmail.com with ESMTPSA id
 g7sm218422qki.64.2020.03.16.10.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 10:46:39 -0700 (PDT)
From: Jason Andryuk <jandryuk@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH v2 0/4] usb-serial: xHCI and timeout fixes
Date: Mon, 16 Mar 2020 13:46:06 -0400
Message-Id: <20200316174610.115820-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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
Cc: qemu-devel@nongnu.org, Jason Andryuk <jandryuk@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series includes two fixes for usb-serial.

The first is a data corruption issue with xHCI controllers.  The FTDI
data packets need to have a 2 byte header start every 64 bytes of packet
data.  For EHCI this is not a problem since USBPacket size is 64, so
only 1 such chunk fits in a packet.  xHCI controllers supply 512 byte
USBPackets, and usb-serial would only write a single header.  This
confuses drivers since they interpret some data bytes as header bytes.
Chunk the data with headers at every 64 byte offset.

To allow full use of the 512 USBPackets, increase the buffer size to 512
- 2 * 8 = 496 bytes.

A second fix is to set the FTDI_THRE (Transmitter Holding Register) and
FTDI_TEMT (Transmitter Empty) status bits in a GetModemStat response.
This makes the linux driver happy when closing the device and avoids a
30 second timeout.

v2: Add braces to single line if statements to comply with coding style.
    Added Samuel's R-b to 3 & 4.  1 & 2 only changed by the addition of
    braces, but I don't know the protocol for this situation.

Jason Andryuk (4):
  usb-serial: Move USB_TOKEN_IN into a helper function
  usb-serial: chunk data to wMaxPacketSize
  usb-serial: Increase receive buffer to 496
  usb-serial: Fix timeout closing the device

 hw/usb/dev-serial.c | 95 ++++++++++++++++++++++++++++-----------------
 1 file changed, 59 insertions(+), 36 deletions(-)

-- 
2.24.1



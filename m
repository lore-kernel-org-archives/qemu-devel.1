Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601DAC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:58:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BC7A206E7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8KfkQM5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC7A206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCNQF-0003cI-BD
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 08:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jandryuk@gmail.com>) id 1jCNNh-0008IA-0a
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:56:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jandryuk@gmail.com>) id 1jCNNf-0006tX-II
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:56:08 -0400
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:36295)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jandryuk@gmail.com>) id 1jCNNf-0006sg-Ea
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:56:07 -0400
Received: by mail-qv1-xf44.google.com with SMTP id r15so2517445qve.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 05:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pRHvKC9SEli8jcbh0ubfqMq6CpQShtCZnK/HGpAj9hk=;
 b=k8KfkQM5EyCCKzB20MEsXhPLyoDj55dGPHj6MBfjZVfmUFFNSzrTg+OuyCU9iLWXhP
 fYe1wY/G4y9QoBc3J8a+QuuaSONKb28NtoKPdRI7ByO1eXG91wY7yfhgu5U3NFvWQIox
 CZ4bARo5iwCJ+3go71ap3tQdH9ThANQ6T1cXXx0LGI9+mSItl8FSizOQb5+cttJSVffo
 mIcLhZg/dfHVzt/W8RgeQdIoc+U4GY4QX2lDNVfb+V1uDWxZ4Po3IA2uPwfqGkYJ4yVP
 x2MdHiFTA2oUS4vV1IUS5naeEerNrzIGeBCqZ/56p4l2AeubS9C3BNEYGBXMI8u38Y74
 WgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pRHvKC9SEli8jcbh0ubfqMq6CpQShtCZnK/HGpAj9hk=;
 b=BCyYg1XAcbFZV+Misyj7olPWgDDRhGT3030Tq2hszG8RY8zqRFkj8wnAHdwqWrA6UJ
 NbIFeLguLLkLHRlggiYV7Z3cEL8ILZxx1Sq7hw7rg+LRRmtCR6udL5M/N5ehZjIrqx5B
 zJDIhAO2H/t7AY5qfcjI/OW3BHMu9DrVfFIzzC7NoSm/jieupryNdlwZgEBeeOFyo8WH
 b4lLq51UmI+4+PPngdieKMdwjYslWmGQ8ki1VowfY7H5OimvM2eP5y9+IXr6xHBPN+oF
 74HgOw5dwswitQ7TE17069BiEwZnA1Ta3YMJPLaowrEB8aX4vLvWBN9BO7itewi9QlEX
 7umg==
X-Gm-Message-State: ANhLgQ1z8Rg/I011z9g1vLIlKAUz5osbzmWlok6XzntR9hQF00N5Sj36
 3oj+fdX+xr7mEq2C6NSDb7w=
X-Google-Smtp-Source: ADFU+vtP5sLtOGEfHlVOd2myrPuVE1P4xGGPh+gB0yRSe2MfIx2EitzKCeyCcyl1kT2UbTYHuymBZg==
X-Received: by 2002:ad4:49c6:: with SMTP id j6mr7357083qvy.68.1584017765324;
 Thu, 12 Mar 2020 05:56:05 -0700 (PDT)
Received: from pm2-ws13.praxislan02.com ([2001:470:8:67e:ba27:ebff:fee8:ce27])
 by smtp.gmail.com with ESMTPSA id
 u3sm8001236qkc.4.2020.03.12.05.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 05:56:04 -0700 (PDT)
From: Jason Andryuk <jandryuk@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH 0/4] usb-serial: xHCI and timeout fixes
Date: Thu, 12 Mar 2020 08:55:19 -0400
Message-Id: <20200312125524.7812-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f44
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

Jason Andryuk (4):
  usb-serial: Move USB_TOKEN_IN into a helper function
  usb-serial: chunk data to wMaxPacketSize
  usb-serial: Increase receive buffer to 496
  usb-serial: Fix timeout closing the device

 hw/usb/dev-serial.c | 92 +++++++++++++++++++++++++++------------------
 1 file changed, 56 insertions(+), 36 deletions(-)

-- 
2.24.1



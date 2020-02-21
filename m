Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27070C35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:43:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3716208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPDRbaJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3716208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58a9-0004LK-4o
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:43:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j58Jk-00032G-7U
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:26:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j58Jj-0007RN-5f
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:26:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22231
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j58Jj-0007Oj-1D
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582291560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5T5CduJWWeyulUp96IrLHjkVcZCM4TVxlB75vuVfrRw=;
 b=MPDRbaJt0UXHpo2U3tqM+kZVpHf7rZIrwjzgl7jpIAKEySbliBTzKwuIu4WkTSX+DGw0XW
 cEOJ7d+9DulLCltrMkqmtf8LQnlDNS2dqBIIlr75uL+lgpHF+aQ0h8jRRJ0SAmdHHgriVg
 vuQ/+2J9FGMtImFvIpnqMU2yvHM6+iY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-bNMQGqbIM16C8xULoLOYtA-1; Fri, 21 Feb 2020 08:25:55 -0500
X-MC-Unique: bNMQGqbIM16C8xULoLOYtA-1
Received: by mail-wr1-f71.google.com with SMTP id 50so1027437wrc.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:25:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=atTSmIAqNTRT8dPM6uxyh8sGk3r2t5Xb9izRkbykMAQ=;
 b=ob1IoG5yWFb0xmtEwvcOv8esZlxes/OGtjX2bwapDO/+4eKGjKogmsRdVxx3HP/aye
 sQ0fpJrv2ZnTJz3isecfFL5oNZGCoJWBFmSH7wBamf1gvkVrrjNfEJAe2SC60CGK2q0P
 pHesl0gmK/WWt6lGo/lpA0IZiRvprIgKxFWFb4563FmQZlAUSf5lWCm3x8vHCJuWEzLF
 BfBZVhI9EugB6oZLLavRJ/+wTPDa6c6xGd0tDy5qZzBqSflLKCR8/76BsSWfC3FUz4Sr
 yRuUOGne0jyP9kTutlVm5tf9v087PujMy9LZO6b/vBTjwn4SQteUfcdLIfRf44g4B/Th
 XQeQ==
X-Gm-Message-State: APjAAAVsq4bTlhMZcAu44MfL+HA3fNzoQKkx9AWBBSXm3bZSYKddIine
 Qk2cpysY2geTlX5sEE+wAJk6Q9zVM+tq1TYZl1m5/FVXLpM/qma/NPa/Z13xhqyQgwtkDRNddaq
 GIsMOd4tyP+TVuPA=
X-Received: by 2002:a05:600c:34b:: with SMTP id
 u11mr3868536wmd.69.1582291553007; 
 Fri, 21 Feb 2020 05:25:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqz2FFXBSLJIq7VA5W46RvUZEwhHhf5nIX2OZ5pPuGptRGT67YlWcbH/8bYbGkEecwdyk1cmfQ==
X-Received: by 2002:a05:600c:34b:: with SMTP id
 u11mr3868461wmd.69.1582291552302; 
 Fri, 21 Feb 2020 05:25:52 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id t13sm3947679wrw.19.2020.02.21.05.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:25:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] hw: More dma_memory_read/write() API cleanup
Date: Fri, 21 Feb 2020 14:25:47 +0100
Message-Id: <20200221132550.22156-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Following up "global exec/memory/dma APIs cleanup"
https://www.mail-archive.com/qemu-devel@nongnu.org/msg681475.html

Few more cleanups in PCNET & SCSI ESP devices.

Philippe Mathieu-Daud=C3=A9 (3):
  hw/dma/sparc32_dma: Make espdma_memory_[read/write] static
  hw/scsi/esp: Let ESPDMAMemoryReadWriteFunc take void pointer and
    size_t
  hw/net/pcnet: Let phys_mem_read/write take void pointer and boolean

 hw/net/pcnet.h                 |  4 ++--
 include/hw/scsi/esp.h          |  2 +-
 include/hw/sparc/sparc32_dma.h |  6 ++----
 hw/dma/sparc32_dma.c           |  8 ++++----
 hw/net/pcnet-pci.c             |  5 +++--
 hw/net/pcnet.c                 | 16 ++++++++--------
 hw/scsi/esp-pci.c              |  6 +++---
 7 files changed, 23 insertions(+), 24 deletions(-)

--=20
2.21.1



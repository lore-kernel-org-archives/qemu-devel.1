Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E17C4646C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:11:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1019E20663
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZdgE9M+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1019E20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54928 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfXBW-0007kc-QR
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 18:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54693)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfX1R-0007jP-DE
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:01:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfX1L-000340-MZ
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:01:04 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33235)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfX1K-00031R-LU
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:01:03 -0400
Received: by mail-wm1-x342.google.com with SMTP id h19so890721wme.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 15:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aBqxrS2+6+Ym/rs4g7maJmz+R7nY9F00WICb45xxr6c=;
 b=gZdgE9M+DoSv6ZkiBFY/h2BQqJjX3O6wwj/K/4+PD1YgV9fQg0TPtIBHyy9vOES5d5
 MIA7noZWBfnLZsLoiLRIiF8JvBcIh5pw6AOjrhPyFZT6heUUl39W1+BZoeqjRYBYYZ6m
 bwCG6c0YDDK4U0Ne5dbt3FL6UCN0xok1PbsKl1Bx7Lh/GeutAmNUVNSE0HWoolWEOUtQ
 S9Swpxdn1YsCc5SnvMAP1nlzKf0S9BswMtaT3dq7fear/AGiU3yQL+MDqlpxZbqDGT3H
 JopRQuhIJXVBXN9kCXbdOtV9CSzZW/Ue2nzcjUVUmW+I1FEL/0bBvM3obq2r84DoEshp
 SPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=aBqxrS2+6+Ym/rs4g7maJmz+R7nY9F00WICb45xxr6c=;
 b=iA2ozcSBzSJDrsgsUotDla7PrP/fUDgJwK5579D8gPv6jqDxgIMGw8XIGOLqxHfKpR
 r5xHv5n5LuAuWUl11PdNiTn3jGjsW2zY0VULV82dLOt9kBl5MGWHp83pTmKFk82deuIo
 xOkLcgJ2bgArYsR8cVuIfbMakRVDQQa8FIMtHefoP62gSGC7UoVSBxrwEY0dKP95h3eL
 g6q6spwIe4v6FY/3hFnc6IYbUjVh2Cdg2VF1DLqf8VWLi92D5m5yfSqu6xFtrVkM6jpl
 bc6XHECaJJrCLDZ5OaSvTC+f3S0jJXBGivxXDTrqftDnOHT5bSHjry0sCT5CWvtrQcs0
 kDIA==
X-Gm-Message-State: APjAAAV8/wBXFrLQ+3CkbbvYyD1In0RlM7OAqPZFFdrHh6WqY3nMhmjk
 heScJbDYtKlz1PcqCfBBHX5cq4Lg
X-Google-Smtp-Source: APXvYqyDwTsmwnY1ELVjqSytaPdzaZ7RQCFi0jiFSwQJ18TbakYtNig3lT8TwW852wUqj0t0YiXQwA==
X-Received: by 2002:a1c:5f56:: with SMTP id t83mr16233899wmb.37.1561413661353; 
 Mon, 24 Jun 2019 15:01:01 -0700 (PDT)
Received: from x1.local (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id z126sm1118612wmb.32.2019.06.24.15.01.00
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 15:01:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Tue, 25 Jun 2019 00:00:49 +0200
Message-Id: <20190624220056.25861-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190624220056.25861-1-f4bug@amsat.org>
References: <20190624220056.25861-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [RFC PATCH 2/9] MAINTAINERS: Add the 'empty_slot'
 device with the 'unimp' one
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The EmptySlot and UnimplementedDevice are very similar, the only
difference is how they log guest accesses.
Maintain them altogether.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Peter, are you OK with that? Do you prefer 2 distinct sections?

 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cad58b9487..abef4a1cfc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1643,11 +1643,13 @@ F: docs/specs/vmgenid.txt
 F: tests/vmgenid-test.c
 F: stubs/vmgenid.c
 
-Unimplemented device
+Unimplemented device, empty slot device
 M: Peter Maydell <peter.maydell@linaro.org>
 R: Philippe Mathieu-Daudé <f4bug@amsat.org>
 S: Maintained
+F: include/hw/misc/empty_slot.h
 F: include/hw/misc/unimp.h
+F: hw/misc/empty_slot.c
 F: hw/misc/unimp.c
 
 Standard VGA
-- 
2.19.1



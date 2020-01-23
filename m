Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470C8C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:53:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EBBB21D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPJy3guX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EBBB21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuent-000537-UY
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:53:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51163)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrA-0004gh-5R
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucr9-00030k-4R
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:12 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:33949)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucr7-0002yp-Ox
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:11 -0500
Received: by mail-wm1-x336.google.com with SMTP id s144so1922732wme.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=iersXa6LYLpYQZtE6C4xTYe9qeAHp3QZ3EqBuEU1RLI=;
 b=oPJy3guXU0WXAv2qCnJgOpi23y0ly2qrhOAcIPnAcwA84d6Dhik/3XMuRgKNcfZKQL
 ZjapA2D5EotzxDBilyRCeFa/tE2WT5ilXj0AjfjHEiEUEw2T47Un4BXjIGAOZLbbUoJD
 Qd8xMviylmmaekXd1Ub3et9KicDNiA936/5tdEl7b+12fhhtlZmF1gOx3yOiY3ZVQQf7
 lC3IK2aasqmgRn0cFgeN4GeZMsobbqntaH8lde5tnYzURWKj2NPKJxFeuBIQ0YjCcFcW
 wQ7dxa0jmWWSr6TujJn8lJrAfdr2JA1e86kRzVJUhcHEMUqkJGlqmqC81NqRP7afomum
 bzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=iersXa6LYLpYQZtE6C4xTYe9qeAHp3QZ3EqBuEU1RLI=;
 b=BcqDxIevJ03HmYFfBzGNXjE9AcGgr8kEUfLP9nqtzlXfn9cO5xlQERaazsir4QjxSk
 /UHU7iQFjv+V0uwCNUmTg8fUk9CtLstQU3UWFqq7Ld5q2/pBfL1LfnS3fF8iRVqogEEZ
 93tz/JMaW7OJ3hu6/G4G3upZeZJ2Ub6sS4myWB8aueiU+jIrKFHvuSPZCmWA8VF/+j6y
 IIvq9mnzXedViq/2GpnEIUBDxAFQlm33Txje9itDX84BjCqQEFYQNFQrpCbtD2fJn9uy
 nb7d9dhuofL+CP1Hp5/9Wgt7SAeOarvPaEfjghms5vot1hpvhUSKfDaPvQwKY7im12My
 5c9A==
X-Gm-Message-State: APjAAAWiNt+g1JknzlkPbcV1+qHk5EUvrc8ObJ1cYMLumvhad4lir37M
 +hGXd6/9csWzkpwUMIe9j7NO71Ea
X-Google-Smtp-Source: APXvYqxsG8z3lwWetDOD0OrOIj4v5yV/2y8g3hh1v8V0kJGpqETJ4tZaQ+av6ErsPpcINeAvXCqx2A==
X-Received: by 2002:a05:600c:22d3:: with SMTP id
 19mr4318632wmg.20.1579787348419; 
 Thu, 23 Jan 2020 05:49:08 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:07 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/59] pvpanic: introduce crashloaded for pvpanic
Date: Thu, 23 Jan 2020 14:48:06 +0100
Message-Id: <1579787342-27146-4-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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
Cc: zhenwei pi <pizhenwei@bytedance.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: zhenwei pi <pizhenwei@bytedance.com>

Add bit 1 for pvpanic. This bit means that guest hits a panic, but
guest wants to handle error by itself. Typical case: Linux guest runs
kdump in panic. It will help us to separate the abnormal reboot from
normal operation.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Message-Id: <20200114023102.612548-2-pizhenwei@bytedance.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/specs/pvpanic.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/docs/specs/pvpanic.txt b/docs/specs/pvpanic.txt
index c7bbacc..bdea68a 100644
--- a/docs/specs/pvpanic.txt
+++ b/docs/specs/pvpanic.txt
@@ -16,8 +16,12 @@ pvpanic exposes a single I/O port, by default 0x505. On read, the bits
 recognized by the device are set. Software should ignore bits it doesn't
 recognize. On write, the bits not recognized by the device are ignored.
 Software should set only bits both itself and the device recognize.
-Currently, only bit 0 is recognized, setting it indicates a guest panic
-has happened.
+
+Bit Definition
+--------------
+bit 0: setting it indicates a guest panic has happened.
+bit 1: named crashloaded. setting it indicates a guest panic and run
+       kexec to handle error by guest itself.
 
 ACPI Interface
 --------------
-- 
1.8.3.1




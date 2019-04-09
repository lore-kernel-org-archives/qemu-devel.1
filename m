Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C236C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 15:58:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C38A82084F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 15:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cse.mrt.ac.lk header.i=@cse.mrt.ac.lk header.b="iVVHp0lV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C38A82084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cse.mrt.ac.lk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45149 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDt9A-0001ym-1n
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 11:58:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hDt7O-0000no-B1
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:57:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hDt7K-0005Jx-2R
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:57:02 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:32903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aruna.15@cse.mrt.ac.lk>)
	id 1hDt7H-0005IW-PW
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:56:57 -0400
Received: by mail-pg1-x543.google.com with SMTP id k19so9554679pgh.0
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 08:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cse.mrt.ac.lk; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=PMMjSJN9ndM2+PQE8OXKGs8/tZEP12hzhNFyUF5JhmY=;
	b=iVVHp0lVpnXhNGGTIYQ3wmtG7ldYnPjx6H+crj5x8EDJp74Dfl7/hG0gxXvAr8rnTG
	Nyr2API65xDH3UH7exIuecOhdQztz+bmbGRO3A44G/V5AxljccKbGezM70wcms130Z8P
	NzAuoyYEedWlIwV+SohEVisRlY48UZT0glzaBTVvUp5yl7peb+FYoFfBwSnJSeWLBc7q
	3oCThJZ8nWM/E04mvPbheOxOsxuWrFSkq6jP8nPt+5QOWX2AFmNHNVBUZYa1YLUPOxue
	dYdouWhEMEZB8RSVHFGonY7qn4p6ZvWwJTrVTtUM0s5OJswPKBYXdiILVdYRtdfxfua8
	A2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=PMMjSJN9ndM2+PQE8OXKGs8/tZEP12hzhNFyUF5JhmY=;
	b=WmVDHQoq7Fez93uPs/DpPTCTNvENJ1NaEnVkydHeBQ/Wjj0lUZk+yKPuJKp2cJr27i
	yK6NuqPlO70BAWrc1pv8jUWjGAPBPT8KMQ12UgSPAEpYDROIbrxVxL0afOvKXZgXjsSy
	qvCkPzvrZ8MjipGBbcTM9zbjeF4L75IpeYgiF5X7v/rMHHrMisu3XeHfR32MxqdAQtZa
	y5E0rhMRKpgFX9fAWQX3QKwIEUtOpSejr5ThRU8V5Hum2UOyyev/X7kvxyhasVCoAQ9q
	nNSDL7IP1hwISb9DSlb82W4ApJIxMLsYDpX2qF21HLdztlT01oDY0mi+icRAsJxepbbc
	LfDQ==
X-Gm-Message-State: APjAAAX+So9FH9a1UdapW5Eel0mCaECACGryoX/XIPGTzvLJ/+uS9xju
	++HinrCWYDydHhm3VaWV3E4kfp7/5No=
X-Google-Smtp-Source: APXvYqxQ7mxxIo5J5q+yVflGv4F4tyha8pC9eH+jhaQXAhHYtQKEjV6cJJ2hkNyFIKFQPOxuJuJK9A==
X-Received: by 2002:a65:6496:: with SMTP id e22mr35303775pgv.249.1554825412090;
	Tue, 09 Apr 2019 08:56:52 -0700 (PDT)
Received: from localhost.localdomain ([112.134.48.137])
	by smtp.gmail.com with ESMTPSA id
	h4sm42203017pgn.20.2019.04.09.08.56.49
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 08:56:51 -0700 (PDT)
From: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
To: qemu-devel@nongnu.org
Date: Tue,  9 Apr 2019 21:26:35 +0530
Message-Id: <20190409155635.10276-1-aruna.15@cse.mrt.ac.lk>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel]  [PATCH 0/4] Header cleanups
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190409155635.RHNPLOhVhC9TeCr9o1JIVwdHdK0iR9VFa3YN2cD5pIo@z>

Removed unwanted includes from cpu-common.h
This task was under https://wiki.qemu.org/Contribute/BiteSizedTasks

Signed-off-by: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>

---
 include/exec/cpu-common.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index cef8b88a2a..a3594f3f50 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -7,8 +7,6 @@
 #include "exec/hwaddr.h"
 #endif
 
-#include "qemu/bswap.h"
-#include "qemu/queue.h"
 #include "qemu/fprintf-fn.h"
 
 /**
-- 
2.17.1



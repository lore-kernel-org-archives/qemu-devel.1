Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EFACA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:25:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 440B8205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FadYr7De"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 440B8205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNezn-0000Z3-Dc
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 11:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdj0-0007vT-GO
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdiz-0007m2-Ah
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:26 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:45369)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iNdiz-0007lU-4M
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:25 -0400
Received: by mail-wr1-x436.google.com with SMTP id q13so21265717wrs.12
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7GTd0Y4rUsiUUYjOXhHXbd2x4/qEqgV6Jh7YlKYq2OY=;
 b=FadYr7DeaU2z/kPbeGixm/CF3srccqBCeeTzhUD21MqS4lBqM8CNuJORHtxbjZK4S/
 qcVACiMHClZ7dKmF0ibDP9DmGk7ZOTCLZDt+nEEy9peVBdNovMHkB7Oe3WHFpOKbMwqC
 F3HEjFDjAdqPiw8LDVQ0uKbP3XFRDvcEEktQGepExQr9pss0t6F1i78ftjEkQkCCkf/5
 NtziyQzSMlRT4zDNayvtQw6FJixw4LQIPgBW0eIxNyAvkNo8FpCaTIXZb5GZKMSkn0Yx
 byw/RYH4zH9aOfCIuYuoqM8y+5G5E2g2O5zxaoP7SW4oNCctcon9xPSGK7sGJcv2MfhR
 JX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=7GTd0Y4rUsiUUYjOXhHXbd2x4/qEqgV6Jh7YlKYq2OY=;
 b=F3/B+PB3xhELVWeRf5GV4j8QqxoyetBVnYTjXV6Y9cqaZfoUXgs7y02+uoa8UhlX69
 vnemIzWPCzeGnVlMJc9c5bWczDMJ/wWDZOSRkaF/NAThasJYKaBvefSJSfE5StD8UnAe
 xYlUOW4jDiKmmhbZLllsNzJOuUDN1G3EW4gHIjMWfvdzFjHQU/Z1tIvjXcR4Q3ah5nrl
 +DnQbqetQg9KOr75ut57dCM5YbpAnFGbCYwU5mXhNCe+LgY1Yi8TZrS6YozrFgyg/JEA
 gDhTbzSgNcDQ853HuogJrmx3fMjRad5v9lEaZjjcPDCQ3+omC4ZmGaeeSrYRglofKqo7
 UuyQ==
X-Gm-Message-State: APjAAAWOtBjPW/o1tXBUBcpasdqPIRisXG3d9Lh/GBh/i7lp/dedjTYP
 723jlpYHoQlTzR57qWeq9CDrzGp3
X-Google-Smtp-Source: APXvYqwa/DSSmc9ZUag4HqvzvlUhpgy7cZ3c7HSq4u+f/uNPA4s/KDStNkv3NO8eAgJGBd1t3MLLIg==
X-Received: by 2002:adf:9c81:: with SMTP id d1mr3872040wre.238.1571925863761; 
 Thu, 24 Oct 2019 07:04:23 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b7sm10610155wrn.53.2019.10.24.07.04.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:04:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/39] hw/timer/mc146818rtc: Only include qapi-commands-misc on
 I386
Date: Thu, 24 Oct 2019 16:03:40 +0200
Message-Id: <1571925835-31930-25-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Commit a6c7040fb09 restricted the rtc-reset-reinjection command
to the I386 target.
Restrict the "qapi/qapi-commands-misc-target.h" header to it too.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191017162614.21327-1-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/mc146818rtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 0e7cf97..c979db0 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -37,12 +37,12 @@
 #include "hw/timer/mc146818rtc.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc-target.h"
 #include "qapi/qapi-events-misc-target.h"
 #include "qapi/visitor.h"
 #include "exec/address-spaces.h"
 
 #ifdef TARGET_I386
+#include "qapi/qapi-commands-misc-target.h"
 #include "hw/i386/apic.h"
 #endif
 
-- 
1.8.3.1




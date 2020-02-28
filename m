Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DFFC3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:50:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00925246AA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XDeZf28k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00925246AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7e9n-0004Im-7I
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 06:50:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41249)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7e79-00082b-GI
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:47:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7e76-0001Ho-8I
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:47:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53694
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7e75-0001HP-PT
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:47:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582890447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HcSl9tYPSfjtJ+NOfqsYRSXGvzeBOGmRpnqHEMwcJn8=;
 b=XDeZf28kYIGoxy4pG0EropZLszb0LOm3CmM1Rz2hxxQAbT9SzzVHyPp3pOhoUBntSrSP+Y
 PxwlXfPV4yAbsHvmIUCdTQ+qwycti3Vf7HFVg4Lc6Hnw5pOSFo74zxLityy8/eU39P/RJn
 IrnXlPWFR8MekQViCLgvkJNRggKKplE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-IvtZlMjQNIi-T1eXS9p_4Q-1; Fri, 28 Feb 2020 06:47:25 -0500
X-MC-Unique: IvtZlMjQNIi-T1eXS9p_4Q-1
Received: by mail-wm1-f71.google.com with SMTP id g26so602810wmk.6
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 03:47:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=z3tIZiyEES4D3l4DiwJs/XjoxuErI+/O6hJWeBZfg4c=;
 b=rQE2BpoK2jjX571FQM/dd5KepTG/zzomrZlS6wleK61/kEYSdtFUXLG5Rvm2c890/j
 WCAWd0glkOgrzpQJDX3Y7xQvfkvhRmFhSaLdnpY+Ndk78nxgrImj+BLQYP7vfGFg36gI
 2uqPAGAPYdU8qJNUEGQ9wmFTXAqZAd9C5/HXUZ6qJAAVt5CzbcIxOFoOBWIpq3Fp3wLa
 Vjt9bmBmIL/7y/3i7Wyf39esd5bc75PRLn9zQN5ZvkH4/Ec2/Px+yGhlWIReHa8bGfBb
 zydnWsq/xl6gnrPRNwwiddzX8+L5vXdSO8PwAcZSPACsV/qtQpRiD52sX8zLX5tk+2KZ
 JGTA==
X-Gm-Message-State: APjAAAVGiTprfyKV+NNoQsIV5bKy+FxgXA7TmSvvJOdDza9gVSwgKgaE
 X/sz/Umfc01PjFw5ZC/CxQ9HCd08y3YC8vqDzeNv9DKt3J5ScwvajxjjChMvK6zfUH1+vn9/PaV
 vi6zD6wZXpeoZf9c=
X-Received: by 2002:a1c:8041:: with SMTP id b62mr3826747wmd.76.1582890444565; 
 Fri, 28 Feb 2020 03:47:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqxU73H7mG32Ur+dSO5v+mK7xHg68/d9LWskB3pliSHUYr4inqpSvplnJ/QjyOkGPSYi9yvE+g==
X-Received: by 2002:a1c:8041:: with SMTP id b62mr3826732wmd.76.1582890444345; 
 Fri, 28 Feb 2020 03:47:24 -0800 (PST)
Received: from x1w.moovbox.local ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id f1sm12392933wro.85.2020.02.28.03.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 03:47:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/18] hw/timer: Remove unused "ui/console.h" header
Date: Fri, 28 Feb 2020 12:46:35 +0100
Message-Id: <20200228114649.12818-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200228114649.12818-1-philmd@redhat.com>
References: <20200228114649.12818-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "open list:nSeries" <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The timer models don't need anything from "ui/console.h".
Remove it.

Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/rtc/twl92230.c | 1 -
 hw/timer/hpet.c   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/rtc/twl92230.c b/hw/rtc/twl92230.c
index 63bd13d2ca..d0011be89e 100644
--- a/hw/rtc/twl92230.c
+++ b/hw/rtc/twl92230.c
@@ -27,7 +27,6 @@
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "sysemu/sysemu.h"
-#include "ui/console.h"
 #include "qemu/bcd.h"
 #include "qemu/module.h"
=20
diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 8dbcbdca16..4f30dd50a4 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -27,7 +27,6 @@
 #include "qemu/osdep.h"
 #include "hw/i386/pc.h"
 #include "hw/irq.h"
-#include "ui/console.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
--=20
2.21.1



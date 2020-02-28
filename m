Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5ACFC3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:50:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 867E6246AA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z651eW1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867E6246AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7e9q-0004PU-KQ
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 06:50:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7e6l-0007Nh-95
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:47:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7e6k-0001AK-8x
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:47:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47876
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7e6k-0001AF-5K
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:47:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582890425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lu32hqItUP7dM4PGcIuD4sRgE5GBtRTQN7Q926tcd10=;
 b=Z651eW1bEUGaWJT27PG2EPcz+/n8zuxhip1fbS8lTgmzM9E0ZKfJRaV9+HCOXEkip4iQGe
 xvDAsiQ38rReCwFGHntRFk3jLS/HWRNu1dxc1tWW0UhHe8LnbsLDu9sjWWLkdxHF8fj1tH
 /Cxunw+GBcfbJME5IGAEw8y3R/j561I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-Meo-8VRzN-OUuU-2jfabFQ-1; Fri, 28 Feb 2020 06:47:04 -0500
X-MC-Unique: Meo-8VRzN-OUuU-2jfabFQ-1
Received: by mail-wm1-f69.google.com with SMTP id y18so1544428wmi.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 03:47:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BP6/+KyIobA7aYPnUFr/bb+oOTNiJS/7LfeIG0A45xo=;
 b=e9sxYIl5NGmKccTp0KK89IKeo8Okl6N+6Q/h4VK//7T60XJ3Toam6DU0Of9jHUEhMT
 jggclNIK7qirYpdAmDlx0PuHYa0OtMmpzHM/gFEdDdDdLzTtJ7+dekNipxzvSKrqdLAf
 pdsx+f5vnBIs2ry+Sa+Ze07S0xYS41VPI2sworIYLctQIEFWo/MoUZS57XXH4BNRl/l/
 G1c4lCU0EeCpGAOxli7C4/Od2DjDOD7gBboVXr3WzwyLdirLwEknmLoWa6jeJCXEWw20
 SgutKUztaa/Djn5fs8q/CPUVt7fqAlJk6FPR2xLNANNSKCO9tlXQZB2djVjTHo5qWnV5
 F5DQ==
X-Gm-Message-State: APjAAAU1LwznWuAxBAeZNcsmQPmvEUDrT27FAYKtEKsZiYGqP8+T5Gwz
 Byze22E8j/bNw2pYp5h4a8118j42TphxaZytHLGo1F0OrsJBaO6Hq3SzcycEgSsmthPthE+YFaJ
 S/rk3vvzOxoJFRhU=
X-Received: by 2002:adf:a18b:: with SMTP id u11mr4669737wru.148.1582890421504; 
 Fri, 28 Feb 2020 03:47:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqz0BAxZC0vuVfdrKTugBW7uZS7nErJ64gXrD9UqgMAY8B2pOEjTh7K/y8dhhzFCNjK3dECNSw==
X-Received: by 2002:adf:a18b:: with SMTP id u11mr4669648wru.148.1582890419862; 
 Fri, 28 Feb 2020 03:46:59 -0800 (PST)
Received: from x1w.moovbox.local ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id q138sm1127219wme.41.2020.02.28.03.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 03:46:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/18] hw/i386/ioapic_internal: Remove unused
 "hw/i386/ioapic.h" header
Date: Fri, 28 Feb 2020 12:46:34 +0100
Message-Id: <20200228114649.12818-4-philmd@redhat.com>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The "ioapic_internal.h" does not use anything from
"hw/i386/ioapic.h", remove it.

Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/i386/ioapic_internal.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/hw/i386/ioapic_internal.h b/include/hw/i386/ioapic_int=
ernal.h
index d46c87c510..fe06938bda 100644
--- a/include/hw/i386/ioapic_internal.h
+++ b/include/hw/i386/ioapic_internal.h
@@ -23,7 +23,6 @@
 #define QEMU_IOAPIC_INTERNAL_H
=20
 #include "exec/memory.h"
-#include "hw/i386/ioapic.h"
 #include "hw/sysbus.h"
 #include "qemu/notify.h"
=20
--=20
2.21.1



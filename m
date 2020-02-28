Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F3DC3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:48:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE4F246AA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+N1dLOq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE4F246AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45745 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7e7w-0000dZ-Cr
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 06:48:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7e6g-0007LA-Vg
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:47:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7e6f-00018y-V4
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:47:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49785
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7e6f-00018e-Ru
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:47:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582890421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c3546yi0MNEa4PeS8dV7Vwzlyh9MvQJ56uhzxTJLw0w=;
 b=d+N1dLOq+LcvnjqJbSRSZhq/i9Ls4lTfMdSwLjo8Ee1IDA0TflQOggQunNyAsuo7QbtLK8
 0sxXAr8eWygTG2P/8s6jWvmyrrwMx9JFImHkz5lrUqhcYEBCs8G9qPIldKlledxz3f7Kmy
 hFf7swhKFVC3DV44jVOMqKHlW/UU3cU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-qEoFox1-OWaSAZpJadt_Qw-1; Fri, 28 Feb 2020 06:46:59 -0500
X-MC-Unique: qEoFox1-OWaSAZpJadt_Qw-1
Received: by mail-wr1-f71.google.com with SMTP id o6so1220512wrp.8
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 03:46:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=f7g55rjk1KrrisnX/ncLGxvcfXQdY0DJfVs+Hz1podY=;
 b=C6WoIqJ/Lv3UU/8NDZzdHHGnShQEcdmnoofsWhkxCTCBugA5trspf8TeExM8BCLOOv
 tjMP3M4m+AL9T2C661SGr6KEX69uoDfVt3UNMKERx422B0oXbInsXQXZgCfGxtQFjzvm
 74qitZLTEUYE40UMb/pzNrFpuvRueUxdWIYoVUJ1ynT9ZAlganLLLYwdoaPkY59RR1mp
 O3MkfGLbOH8jql+LinTSbgdI9Cjq8lI3g1scSEwRB6eMDoLFqvjK4hfbWBpANe3+yIql
 XjPNphY753bmlyOT5/MBU1elJojtg2MUj/vzAM2zVYH7jqblv+MjhGGGNOTkCAusQbj7
 qb1A==
X-Gm-Message-State: APjAAAWL9x2F1PhhhcLfFkYJPSPRp2BR3BoI7dbiEW/5gFE2DJlYDkW5
 kcDULWucipmnfwM+lpLiedsvdk3G3KLlR6ASyyf9S+Wt5PGyn7CMt1z06CrAIBle2XqKQCLMJF3
 z7a737WiaePLbEYM=
X-Received: by 2002:adf:f7c4:: with SMTP id a4mr4494905wrq.361.1582890418143; 
 Fri, 28 Feb 2020 03:46:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqxnzX87j3iygThg/Ua8j06sDbyEO3Vmhe1XCY219T9ODOfqM0dNbos+7UVje+Hl6zfQMiBUGg==
X-Received: by 2002:adf:f7c4:: with SMTP id a4mr4494890wrq.361.1582890417971; 
 Fri, 28 Feb 2020 03:46:57 -0800 (PST)
Received: from x1w.moovbox.local ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id q138sm1127219wme.41.2020.02.28.03.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 03:46:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/18] hw/southbridge/ich9: Removed unused headers
Date: Fri, 28 Feb 2020 12:46:33 +0100
Message-Id: <20200228114649.12818-3-philmd@redhat.com>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ICH9 chipset is not X86/PC specific.

These files don't use anything declared by the "hw/i386/pc.h"
or "hw/i386/ioapic.h" headers. Remove them.

Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/i386/ich9.h | 1 -
 hw/acpi/ich9.c         | 1 -
 hw/isa/lpc_ich9.c      | 1 -
 3 files changed, 3 deletions(-)

diff --git a/include/hw/i386/ich9.h b/include/hw/i386/ich9.h
index 72e803f6e2..a98d10b252 100644
--- a/include/hw/i386/ich9.h
+++ b/include/hw/i386/ich9.h
@@ -5,7 +5,6 @@
 #include "hw/sysbus.h"
 #include "hw/i386/pc.h"
 #include "hw/isa/apm.h"
-#include "hw/i386/ioapic.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pcie_host.h"
 #include "hw/pci/pci_bridge.h"
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 2034dd749e..fdd0a6c79e 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -27,7 +27,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
-#include "hw/i386/pc.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
 #include "qemu/timer.h"
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index f85b484eac..cb79616ced 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -37,7 +37,6 @@
 #include "migration/vmstate.h"
 #include "hw/irq.h"
 #include "hw/isa/apm.h"
-#include "hw/i386/ioapic.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/i386/ich9.h"
--=20
2.21.1



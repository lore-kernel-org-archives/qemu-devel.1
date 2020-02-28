Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8FDC3F2D3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:50:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B21A24690
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MpHaLUBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B21A24690
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7eAK-0005UW-7G
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 06:50:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7e7A-00085j-S0
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:47:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7e79-0001JZ-TM
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:47:32 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36440
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7e79-0001Iz-Q3
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:47:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582890449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=73OgrN2M+rMTohi90iBlDHcrDQ0XOXk9OuciFu+Dx5c=;
 b=MpHaLUBmOg24ni1lZi3xC1LymO2LYimkzhU53Q257Ipjxek2djZ73JUXPx9gZrrLymNdQ6
 KTx4LonJ7gvMgJQt6v4e7rFDwftWN9OqSCxXwq/kw03cWC9WVMm/Jsi8+U/RVb2FZRdS3A
 ulCP8FXNZo59iX9cWJiISnbBwjQLUmk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-dbULidXpOV6StX-QzlDXKg-1; Fri, 28 Feb 2020 06:47:28 -0500
X-MC-Unique: dbULidXpOV6StX-QzlDXKg-1
Received: by mail-wm1-f69.google.com with SMTP id p4so223109wmp.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 03:47:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2nnjZZT8SRwguHek+59VriRLt7OR5qsxOtTlGAQZhfs=;
 b=EZz19cemrYmP6nX+4iSKJnWtCe8adfNJs1FWiiwuk3Kq5vpWFhESsX7A9kPjv6VAP5
 PtnqVv7EzNTp7FlR2jVbzi6krbdrhrPq1GvSEvpRRPvN/plmZwRM5f9DOBqRDL8qSwD6
 kbpmflewDBQA4/zx9Q952YnB2yRXynEz418pzUmCvXBWGinFb+1ILhdo4myFiLZ3CMZX
 z/vtpgy6rH64rSd4mInWGJgXp0+Cfx1GbNXacKIb2izVTJVezJqdBtVrS2GuMhA7pugw
 Pe1vpZuGymx52qztO7JfPcXnEvXIW2BiYmtTg/uA9Q8AEbMy/E/GbDpjApvcqaRZz3D8
 cIUg==
X-Gm-Message-State: APjAAAVrCX4GE1Hi7Aydz05EAmR03Y17rNunmmZpN/PYiTpa1lXy20Pa
 iwx1WyjwHB5DRVve9Vi8ERz8PDI+35gxHBUsPRRK7psSBrQMvVzFM4AJ3wmVUBr2Falz4X9DEFV
 fvBx1OIEZbcgeH1Y=
X-Received: by 2002:a1c:cc06:: with SMTP id h6mr4661032wmb.118.1582890446801; 
 Fri, 28 Feb 2020 03:47:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqwzy+LStQa1gSChylqIu8s/TQY+qa5cvUG4+ApfOss4KtTM50KgxciBNLjGP10gzmJoTxvMhg==
X-Received: by 2002:a1c:cc06:: with SMTP id h6mr4661014wmb.118.1582890446582; 
 Fri, 28 Feb 2020 03:47:26 -0800 (PST)
Received: from x1w.moovbox.local ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id f1sm12392933wro.85.2020.02.28.03.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 03:47:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/18] hw/usb/dev-storage: Remove unused "ui/console.h"
 header
Date: Fri, 28 Feb 2020 12:46:36 +0100
Message-Id: <20200228114649.12818-6-philmd@redhat.com>
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
X-Received-From: 207.211.31.81
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
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The USB models related to storage don't need anything from
"ui/console.h". Remove it.

Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/usb/dev-storage.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 90da008df1..4883c1d89e 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -17,7 +17,6 @@
 #include "desc.h"
 #include "hw/qdev-properties.h"
 #include "hw/scsi/scsi.h"
-#include "ui/console.h"
 #include "migration/vmstate.h"
 #include "monitor/monitor.h"
 #include "sysemu/sysemu.h"
--=20
2.21.1



Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039D0C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:48:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0CA6246AA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="enZGkmMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0CA6246AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7e7w-0000fD-Sr
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 06:48:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7e6g-0007L8-5s
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:47:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7e6e-00018V-0C
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:47:01 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42861
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7e6d-00018L-Tl
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:46:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582890419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JwOs2po6nVBrNz+DhsO8Xnl0PhYikRZa4JYienbwBPU=;
 b=enZGkmMwcthCkeWiHJJV1P3i16eMoKwwNr7UCU4aNwT9T+Xoo6J+fOvpOEdxNLhDL8mDGo
 IwJVAZ/EkcMaY5+V6adpDIY07gPEYhvXtS/PV/y63ocjj9954WqQTjfFKjp+kUhFaZEOD0
 s+7qCJYKVtO8apkB8+hlUPAsr8pKN1M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-cLjOiksVMpS1oKPT7F1fuw-1; Fri, 28 Feb 2020 06:46:57 -0500
X-MC-Unique: cLjOiksVMpS1oKPT7F1fuw-1
Received: by mail-wm1-f71.google.com with SMTP id q20so25316wmg.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 03:46:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CpNdsjNPiC6/DnLPjwvW92rGWlXZRi+/lAbWPRuMDaY=;
 b=i7DcUtnX8LabTOBfrj6io2geYZhagHS4WroRiN9y/yeMu3j9VBveYlhuypExiu8cMo
 4Z1fyjRqM0bt6hjzB91h2uZnApAOm1rUdeBUD61+FPv9nrNPDjbdsfrJYbpoOsCIm3YS
 0v8ChltaHlnXZwylgHyHu3hUMeoHQKJkSuKaIL7UPTQID5Ue8UsPltGrL7FGzaMgTfPj
 gafBvuk5FiVb+7JLCj6AyGkCip9EjEkeQwiw/a9QJHWsou450qe8WXRJFQPeAp1PGH7g
 daVy/A0TkyUs4T0XhHdEBXEFuf/l+n6EkJl8X0vAFg2X6n7EBevBELgMXFdBYZ7ykKCN
 y2HA==
X-Gm-Message-State: APjAAAXhIemmYtQvuTtpafnEIrdcHagsuKgNe/5ATTtKCkD6azNzPN6l
 rI5p/kNn1fk5yq9bGejNySNJd+kpnCmlkbLuKB7bUQ+w3+jEk5wLd08YqRDCyXIB8szhOVLFSev
 1+9ufAgpoellKSVc=
X-Received: by 2002:a5d:4b03:: with SMTP id v3mr4785715wrq.81.1582890415985;
 Fri, 28 Feb 2020 03:46:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqxM2/smC26C3TpXbjvfNECRInDeKtZIZJPjM3yZ9lkl22pRKcGsi5IATwr0AxhD1KPwzkMb6w==
X-Received: by 2002:a5d:4b03:: with SMTP id v3mr4785695wrq.81.1582890415762;
 Fri, 28 Feb 2020 03:46:55 -0800 (PST)
Received: from x1w.moovbox.local ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id q138sm1127219wme.41.2020.02.28.03.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 03:46:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/18] vl: Add missing "hw/boards.h" include
Date: Fri, 28 Feb 2020 12:46:32 +0100
Message-Id: <20200228114649.12818-2-philmd@redhat.com>
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
X-Received-From: 205.139.110.61
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

vl.c calls machine_usb() declared in "hw/boards.h". Include it.

This fixes (when modifying unrelated headers):

  vl.c:1283:10: error: implicit declaration of function 'machine_usb' is in=
valid in C99 [-Werror,-Wimplicit-function-declaration]
      if (!machine_usb(current_machine)) {
           ^
  vl.c:1283:10: error: this function declaration is not a prototype [-Werro=
r,-Wstrict-prototypes]
  vl.c:1283:22: error: use of undeclared identifier 'current_machine'
      if (!machine_usb(current_machine)) {
                       ^

Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 softmmu/vl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 16ff5a16a3..20b7201451 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/units.h"
+#include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu-version.h"
--=20
2.21.1



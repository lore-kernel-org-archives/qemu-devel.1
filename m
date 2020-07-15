Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A703EC433E6
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:19:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7208420657
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1UEG0fa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7208420657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvhKC-0002Px-M8
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 09:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvhJH-00017w-Ob
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:18:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57594
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvhJF-00073W-Oa
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594819133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Zbi5X8sEm3AKNYmaEKJGFWMfdxl/pU19sE608TpMmDM=;
 b=S1UEG0faW2iq4m8A5WLMuZWcQNhGOjZrgQxcc0MGDCJBYI75+63LIA/Us7igyIxtg0uhWB
 4N+FNio08ZsRWPPBx67KpV4qIpOX6svzchhusaL6QY8+W4AzxNAbvY0z6s7EL6ldTALsdH
 wqaP81sQnOwkQWHNzgLeBogcI6PZsu4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-VG-i-y98NCODy7hZINUuaA-1; Wed, 15 Jul 2020 09:18:49 -0400
X-MC-Unique: VG-i-y98NCODy7hZINUuaA-1
Received: by mail-wr1-f70.google.com with SMTP id o12so1348189wrj.23
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 06:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Zbi5X8sEm3AKNYmaEKJGFWMfdxl/pU19sE608TpMmDM=;
 b=pKTiaSvMjr+8Rl2P1wVnZ3O1q57SOUnmDymSFp154Oq38aG6OUpKEakXmI5wJIwFw4
 Ofo7alCcM63fYfI803Wgy6AHm6Pl0b3BsCWq8gd71M23WQuBl4arKlZm9zGUcB1p7RWv
 n5DIrgZIBNcycaTcaw6l1Czz/cDRPxtwvIVUS/JVDTqmAG77a8h/2/S200dk7do/XZsh
 xU0HazP1vGDqKLmrjFwY12lFEk5gg10eH5cgYpd9nU1mZHK0hNfa/drC6sLdDyfyHv07
 xycyspDpGZWrCcBhhrlgXWfIw5qZWJ79Esi4K93ZDcU2Whf5ZBD5WeTMfmbuSDUSXqru
 Pm/w==
X-Gm-Message-State: AOAM533d0iDNpE+TDLXqK2QS2Lxmdkxkzaei5q6FhDbTfuuzwHkNsjDR
 fFRbR3LYKLzVC5JgHzzc/VKB/g7YJ9nFe0wBiScxrLiq06EmsrEExGC62ygZNuO963cyQfCIgLW
 gVXtf4/WxOVVF3RU=
X-Received: by 2002:adf:b608:: with SMTP id f8mr12143492wre.363.1594819127880; 
 Wed, 15 Jul 2020 06:18:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwd1hktajcwt6IlTSNw8oVN0i2hE/dfN0jCa+YQuDTnBvSXgCkZ25y6LNd7mK4cXfmCZFaYfg==
X-Received: by 2002:adf:b608:: with SMTP id f8mr12143461wre.363.1594819127568; 
 Wed, 15 Jul 2020 06:18:47 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id a15sm3796033wrh.54.2020.07.15.06.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 06:18:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2] hw/s390x: Move S390_ADAPTER_SUPPRESSIBLE from 'css.h'
 to 's390_flic.h'
Date: Wed, 15 Jul 2020 15:18:45 +0200
Message-Id: <20200715131845.30469-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 05:07:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Not all s390x devices require to have access to the CPU internals.

To reduce the include dependencies on "s390x/css.h", move the
S390_ADAPTER_SUPPRESSIBLE definition to "s390x/s390_flic.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/s390x/css.h       | 7 -------
 include/hw/s390x/s390_flic.h | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 08c869ab0a..7858666307 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -12,7 +12,6 @@
 #ifndef CSS_H
 #define CSS_H
 
-#include "cpu.h"
 #include "hw/s390x/adapter.h"
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/ioinst.h"
@@ -233,12 +232,6 @@ uint32_t css_get_adapter_id(CssIoAdapterType type, uint8_t isc);
 void css_register_io_adapters(CssIoAdapterType type, bool swap, bool maskable,
                               uint8_t flags, Error **errp);
 
-#ifndef CONFIG_KVM
-#define S390_ADAPTER_SUPPRESSIBLE 0x01
-#else
-#define S390_ADAPTER_SUPPRESSIBLE KVM_S390_ADAPTER_SUPPRESSIBLE
-#endif
-
 #ifndef CONFIG_USER_ONLY
 SubchDev *css_find_subch(uint8_t m, uint8_t cssid, uint8_t ssid,
                          uint16_t schid);
diff --git a/include/hw/s390x/s390_flic.h b/include/hw/s390x/s390_flic.h
index 4687ecfe83..6bf9d73728 100644
--- a/include/hw/s390x/s390_flic.h
+++ b/include/hw/s390x/s390_flic.h
@@ -17,6 +17,13 @@
 #include "hw/s390x/adapter.h"
 #include "hw/virtio/virtio.h"
 #include "qemu/queue.h"
+#include "cpu.h"
+
+#ifndef CONFIG_KVM
+#define S390_ADAPTER_SUPPRESSIBLE 0x01
+#else
+#define S390_ADAPTER_SUPPRESSIBLE KVM_S390_ADAPTER_SUPPRESSIBLE
+#endif
 
 /*
  * Reserve enough gsis to accommodate all virtio devices.
-- 
2.21.3



Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F5EC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:00:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35E4E21D91
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eoUy5FZ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E4E21D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLO2m-0002mO-52
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 06:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNUm-0003Is-Jo
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:24:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31205)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNUh-0006Do-42
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hQHdGaPRPiSSz7YlmIfS8lnsMcDdBc0lyN6LcIl/4c0=;
 b=eoUy5FZ0yA42s1enjKFGN5EeOaHt6nx6ISNkqt6Y35Oi7hgWN732WJocLIszQ2ZzfFoWLN
 /8ryB3p0+bnrswQET2skNjPvGs7Xxc6g/PCqcJy9uOzMJIHTZC+HS8+n1FlRNd93STD68b
 FJXwrPGUS7i1TYjBKH2QIgtQwcZBTj4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-xImUNCQbP4SfK-l9Qjy2bg-1; Thu, 24 Sep 2020 05:24:46 -0400
X-MC-Unique: xImUNCQbP4SfK-l9Qjy2bg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 191D185B66C
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 09:24:46 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BF1AD5C1C7;
 Thu, 24 Sep 2020 09:24:45 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 76/92] sysemu/xen: Add missing 'exec/cpu-common.h' header for
 ram_addr_t type
Date: Thu, 24 Sep 2020 05:22:58 -0400
Message-Id: <20200924092314.1722645-77-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-1-pbonzini@redhat.com>
References: <20200924092314.1722645-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

As this header use the ram_addr_t type, it has to include
"exec/cpu-common.h" to avoid odd errors such:

  include/sysemu/xen.h:35:44: error: unknown type name 'ram_addr_t'; did you mean 'in_addr_t'?
   35 | static inline void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
      |                                            ^~~~~~~~~~
      |                                            in_addr_t

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200908155530.249806-4-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/xen.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/sysemu/xen.h b/include/sysemu/xen.h
index 2c2c429ea8..0ca25697e4 100644
--- a/include/sysemu/xen.h
+++ b/include/sysemu/xen.h
@@ -8,6 +8,8 @@
 #ifndef SYSEMU_XEN_H
 #define SYSEMU_XEN_H
 
+#include "exec/cpu-common.h"
+
 #ifdef NEED_CPU_H
 # ifdef CONFIG_XEN
 #  define CONFIG_XEN_IS_POSSIBLE
-- 
2.26.2




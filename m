Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03058C54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 16:22:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B140F206F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 16:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXMbUQeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B140F206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQvfS-0001x8-RI
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 12:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54004)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jQveG-0000mZ-O7
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:21:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jQveB-00045y-Tw
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:21:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28741
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jQveB-00045G-IM
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587486078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I0YrSfJZG3OCin0XwLpQsE2WSkg0EXuV6HT6X0zjKVY=;
 b=IXMbUQeAyP0w2hQa/+ubzem/zA6rxKSMwAFUp9qBFzj3/69c//7yBAnujJsAxPeRNgxMWm
 tAiPhJkSCDIGBf9U09R4DROXAA1dIEKnFy5r4IQKIdnAwjXHXnQyFb6DLsKFby9mR/SOBK
 78ixMGIrWaaYwuhvry9juDV0F5uVHRg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-bTONjKJXMB-TwcXF8KhEnQ-1; Tue, 21 Apr 2020 12:21:16 -0400
X-MC-Unique: bTONjKJXMB-TwcXF8KhEnQ-1
Received: by mail-qt1-f197.google.com with SMTP id f56so15324186qte.18
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 09:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZpjWesWQtez4RVwbFQXrjywWOT0CDQMzNzTMHASVusg=;
 b=O01WSumiTLzz4EHYyFzd+jU9zEALDwNITCMz2rzZXwPA9v7LhB+Ow3uTM3yuGhDDnA
 7PPnlT0JqcjytwSocnlkFztftYwuBMZMU9DrqgMJN+cSNh722Ya+Q/Z0YKV+ebWtTyEh
 m+MC+90SgKvs2ptpxNWrX/VXWWW1GlF6ANE6XFcc1o6qp0Kk5FAke0GUuTo4GsaZFZPw
 9DxSusHic3kuJhMLW560rqSgiRFSVhxUie8z+YVaQF1AyKpbnCkTC12ing+PPRve34do
 Af5MknXR0FgtoGpxmDDinJWeBh2hPGVTlBRuyJBnevcBa19nqe0i03tpa778s/bcV/yS
 HJqQ==
X-Gm-Message-State: AGi0PubE/OE5EvKp9tCyF+CycSTxhgPIsSc7iI7O63Ecw+p//JhJFyAx
 yB92KX15NOS9SHwryW6PrF17UWa28f1PgsWlBoWNcPcZPmRoDb3iJhFqAliWfmNafu42WJF3QqZ
 wbJQkSfQ30BB4gjw=
X-Received: by 2002:a0c:f883:: with SMTP id u3mr20841115qvn.86.1587486075659; 
 Tue, 21 Apr 2020 09:21:15 -0700 (PDT)
X-Google-Smtp-Source: APiQypI4ZYxDlkw7lZXId1vwb0Snhu5C16MYvVeIRWGMGcHSua539raQFqse1kuOWbXHqS8a+pp4MQ==
X-Received: by 2002:a0c:f883:: with SMTP id u3mr20841022qvn.86.1587486074472; 
 Tue, 21 Apr 2020 09:21:14 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id k43sm2111531qtk.67.2020.04.21.09.21.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 09:21:13 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/8] memory: Introduce memory_region_transaction_{push|pop}()
Date: Tue, 21 Apr 2020 12:21:01 -0400
Message-Id: <20200421162108.594796-2-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200421162108.594796-1-peterx@redhat.com>
References: <20200421162108.594796-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 01:28:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

memory_region_transaction_{begin|commit}() could be too big when finalizing=
 a
memory region.  E.g., we should never attempt to update address space topol=
ogy
during the finalize() of a memory region.  Provide helpers for further use.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 memory.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/memory.c b/memory.c
index 601b749906..e5d634d648 100644
--- a/memory.c
+++ b/memory.c
@@ -1054,10 +1054,20 @@ static void address_space_update_topology(AddressSp=
ace *as)
     address_space_set_flatview(as);
 }
=20
+static void memory_region_transaction_push(void)
+{
+    memory_region_transaction_depth++;
+}
+
+static void memory_region_transaction_pop(void)
+{
+    memory_region_transaction_depth--;
+}
+
 void memory_region_transaction_begin(void)
 {
     qemu_flush_coalesced_mmio_buffer();
-    ++memory_region_transaction_depth;
+    memory_region_transaction_push();
 }
=20
 void memory_region_transaction_commit(void)
@@ -1067,7 +1077,7 @@ void memory_region_transaction_commit(void)
     assert(memory_region_transaction_depth);
     assert(qemu_mutex_iothread_locked());
=20
-    --memory_region_transaction_depth;
+    memory_region_transaction_pop();
     if (!memory_region_transaction_depth) {
         if (memory_region_update_pending) {
             flatviews_reset();
--=20
2.24.1



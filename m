Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D96C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:41:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A4F32073E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Paottn9J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4F32073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjU1H-0007qi-Jv
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAR-0001yB-Dc
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29240
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAO-0001QP-1e
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h8HdZFaM2mWIMMStldX3gYxAELTzDvL+kCBAAkvkGiU=;
 b=Paottn9J7o0cfOMeutD/jJwEE8gpENKlpbtQknjM6r8CtMgOH0KmadIfog4k5ObXeW6xCH
 7qFAQafdiU+oyuZ8BwkrqSP3UqcbmJ7WzLwUVVag68vVpr5MPSigyEOe0M6viqb0fb7v5D
 HdgQi6ApZy2ExrTmOe6ilB4XBvFvhA0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309---Fyvq-BPvCmIEh85Dr9TA-1; Thu, 11 Jun 2020 15:47:09 -0400
X-MC-Unique: --Fyvq-BPvCmIEh85Dr9TA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 485F81940923;
 Thu, 11 Jun 2020 19:47:07 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 56B8560CC0;
 Thu, 11 Jun 2020 19:47:06 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 100/115] target/i386: sev: Remove unused QSevGuestInfoClass
Date: Thu, 11 Jun 2020 15:44:34 -0400
Message-Id: <20200611194449.31468-101-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 08:37:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Gibson <david@gibson.dropbear.id.au>

This structure is nothing but an empty wrapper around the parent class,
which by QOM conventions means we don't need it at all.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200604064219.436242-2-david@gibson.dropbear.id.au>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c      | 1 -
 target/i386/sev_i386.h | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 51cdbe5496..2312510cf2 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -287,7 +287,6 @@ static const TypeInfo qsev_guest_info = {
     .name = TYPE_QSEV_GUEST_INFO,
     .instance_size = sizeof(QSevGuestInfo),
     .instance_finalize = qsev_guest_finalize,
-    .class_size = sizeof(QSevGuestInfoClass),
     .class_init = qsev_guest_class_init,
     .instance_init = qsev_guest_init,
     .interfaces = (InterfaceInfo[]) {
diff --git a/target/i386/sev_i386.h b/target/i386/sev_i386.h
index 8ada9d385d..4f193642ac 100644
--- a/target/i386/sev_i386.h
+++ b/target/i386/sev_i386.h
@@ -41,7 +41,6 @@ extern char *sev_get_launch_measurement(void);
 extern SevCapability *sev_get_capabilities(void);
 
 typedef struct QSevGuestInfo QSevGuestInfo;
-typedef struct QSevGuestInfoClass QSevGuestInfoClass;
 
 /**
  * QSevGuestInfo:
@@ -64,10 +63,6 @@ struct QSevGuestInfo {
     uint32_t reduced_phys_bits;
 };
 
-struct QSevGuestInfoClass {
-    ObjectClass parent_class;
-};
-
 struct SEVState {
     QSevGuestInfo *sev_info;
     uint8_t api_major;
-- 
2.26.2




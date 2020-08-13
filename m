Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DCCC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 22:40:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACCAA204EC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 22:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFrhJxhs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACCAA204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6LtJ-0001CD-VM
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 18:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k6LgW-0005UB-CT
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 18:26:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26637
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k6LgU-0002u0-Qz
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 18:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597357614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0AFt/jdIoJsJKvAKm30CyMtnXeXVjCgOWUctd7+Y3eo=;
 b=CFrhJxhs+6/LOgwgjz99KcSk5ZIYEmo5DekeuJebOLl7EXItADRajJLVzNMRL2sYCpEZEp
 J28q+taOCPQm9oDcK436NGnsyTjauujQ+/ZuVHd8nZv1W6nmTghrY7Ycccryva0d93dIKC
 iSmkqZ5Y1KXoUGSzWryjBGbQt+NOZFA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-QtRmwO4-OCC4Fz5eUSi-Pg-1; Thu, 13 Aug 2020 18:26:52 -0400
X-MC-Unique: QtRmwO4-OCC4Fz5eUSi-Pg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7567B801AC2
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 22:26:51 +0000 (UTC)
Received: from localhost (ovpn-117-153.rdu2.redhat.com [10.10.117.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 401A41992D;
 Thu, 13 Aug 2020 22:26:51 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 21/41] s390_flic: Move KVMS390FLICState typedef to header
Date: Thu, 13 Aug 2020 18:26:05 -0400
Message-Id: <20200813222625.243136-22-ehabkost@redhat.com>
In-Reply-To: <20200813222625.243136-1-ehabkost@redhat.com>
References: <20200813222625.243136-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 17:30:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move typedef closer to the type check macros, to make it easier
to convert the code to OBJECT_DEFINE_TYPE() in the future.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/s390x/s390_flic.h | 1 +
 hw/intc/s390_flic_kvm.c      | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/hw/s390x/s390_flic.h b/include/hw/s390x/s390_flic.h
index 4687ecfe83..df11de9b20 100644
--- a/include/hw/s390x/s390_flic.h
+++ b/include/hw/s390x/s390_flic.h
@@ -75,6 +75,7 @@ typedef struct S390FLICStateClass {
 } S390FLICStateClass;
 
 #define TYPE_KVM_S390_FLIC "s390-flic-kvm"
+typedef struct KVMS390FLICState KVMS390FLICState;
 #define KVM_S390_FLIC(obj) \
     OBJECT_CHECK(KVMS390FLICState, (obj), TYPE_KVM_S390_FLIC)
 
diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index a306b26faa..dbd4e682ce 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -29,12 +29,12 @@
 #define FLIC_FAILED (-1UL)
 #define FLIC_SAVEVM_VERSION 1
 
-typedef struct KVMS390FLICState {
+struct KVMS390FLICState{
     S390FLICState parent_obj;
 
     uint32_t fd;
     bool clear_io_supported;
-} KVMS390FLICState;
+};
 
 static KVMS390FLICState *s390_get_kvm_flic(S390FLICState *fs)
 {
-- 
2.26.2



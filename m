Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6022DC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 22:32:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A67220838
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 22:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QfFud/bv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A67220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Llo-0005XD-BW
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 18:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k6LgR-0005JZ-9B
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 18:26:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51684
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k6LgP-0002st-FH
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 18:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597357608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vwvusg9MS4kF6ELrZRZ593pFbp/RVvUV9tQQFpfX1b8=;
 b=QfFud/bvs3HA2AA2128xj5ll2mY+qcRik3FYPf9N3bYNplYvnxx2eYuKC7AlL05bV7tG8E
 xTXgniXHH0IaJCZs5Sx2aUFJ0WJDJ0MBKqC+E9/TqCG0pMxLn7u0KABHnYHe4LCYl597Av
 wB3knzOWifNL+q7z40f8uwk/4E6Pr6U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-yd1Cl_SANv-YU4W3muoR0Q-1; Thu, 13 Aug 2020 18:26:47 -0400
X-MC-Unique: yd1Cl_SANv-YU4W3muoR0Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 477D3800683
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 22:26:46 +0000 (UTC)
Received: from localhost (ovpn-117-153.rdu2.redhat.com [10.10.117.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E2B71002382;
 Thu, 13 Aug 2020 22:26:45 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/41] throttle-groups: Move ThrottleGroup typedef to header
Date: Thu, 13 Aug 2020 18:26:00 -0400
Message-Id: <20200813222625.243136-17-ehabkost@redhat.com>
In-Reply-To: <20200813222625.243136-1-ehabkost@redhat.com>
References: <20200813222625.243136-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 18:26:34
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
 include/block/throttle-groups.h | 1 +
 block/throttle-groups.c         | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/block/throttle-groups.h b/include/block/throttle-groups.h
index 712a8e64b4..5e77db700f 100644
--- a/include/block/throttle-groups.h
+++ b/include/block/throttle-groups.h
@@ -59,6 +59,7 @@ typedef struct ThrottleGroupMember {
 } ThrottleGroupMember;
 
 #define TYPE_THROTTLE_GROUP "throttle-group"
+typedef struct ThrottleGroup ThrottleGroup;
 #define THROTTLE_GROUP(obj) OBJECT_CHECK(ThrottleGroup, (obj), TYPE_THROTTLE_GROUP)
 
 const char *throttle_group_get_name(ThrottleGroupMember *tgm);
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 98fea7fd47..4e28365d8d 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -63,7 +63,7 @@ static void timer_cb(ThrottleGroupMember *tgm, bool is_write);
  * access some other ThrottleGroupMember's timers only after verifying that
  * that ThrottleGroupMember has throttled requests in the queue.
  */
-typedef struct ThrottleGroup {
+struct ThrottleGroup {
     Object parent_obj;
 
     /* refuse individual property change if initialization is complete */
@@ -79,7 +79,7 @@ typedef struct ThrottleGroup {
 
     /* This field is protected by the global QEMU mutex */
     QTAILQ_ENTRY(ThrottleGroup) list;
-} ThrottleGroup;
+};
 
 /* This is protected by the global QEMU mutex */
 static QTAILQ_HEAD(, ThrottleGroup) throttle_groups =
-- 
2.26.2



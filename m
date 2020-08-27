Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFC7C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:28:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 016BE2087E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fOktOShi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016BE2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBNZd-0002o2-46
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 15:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kBNTU-00072y-4U
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:22:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55761)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kBNTR-0000PV-NO
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598556132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yQ43M/CP56AWWK5Ae5pn7BmVve5jkZY63ZKHw7xQv+g=;
 b=fOktOShiVW8j3woByA5q9ItbeaeA5fGb6wDKYHI0aUqjImpY+UXSUuYlWoeDt6mtezRCVe
 1dcbY+fTIr50beUH8rAAe+zsAR9jpVpZisuuL9hpZDJAxjKvNlW5mgHkMLlFf2zYcUFLiB
 /b6fiKqWyNSfEagdKAs49ySswcM/oU0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-3aTkn6wcO1ywu-2jyqgVPQ-1; Thu, 27 Aug 2020 15:22:10 -0400
X-MC-Unique: 3aTkn6wcO1ywu-2jyqgVPQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 803A31015ECD;
 Thu, 27 Aug 2020 19:22:09 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 457FD784A8;
 Thu, 27 Aug 2020 19:22:09 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 17/53] i8254: Move PITCommonState/PITCommonClass typedefs to
 i8254.h
Date: Thu, 27 Aug 2020 15:20:46 -0400
Message-Id: <20200827192122.658035-18-ehabkost@redhat.com>
In-Reply-To: <20200827192122.658035-1-ehabkost@redhat.com>
References: <20200827192122.658035-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:54:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Roman Bolshakov <r.bolshakov@yadro.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move typedef closer to the type check macros, to make it easier
to convert the code to OBJECT_DEFINE_TYPE() in the future.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Tested-By: Roman Bolshakov <r.bolshakov@yadro.com>
Message-Id: <20200825192110.3528606-19-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/timer/i8254.h          | 2 ++
 include/hw/timer/i8254_internal.h | 8 ++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/hw/timer/i8254.h b/include/hw/timer/i8254.h
index e75b4a5a08..206b8f8464 100644
--- a/include/hw/timer/i8254.h
+++ b/include/hw/timer/i8254.h
@@ -39,6 +39,8 @@ typedef struct PITChannelInfo {
 } PITChannelInfo;
 
 #define TYPE_PIT_COMMON "pit-common"
+typedef struct PITCommonState PITCommonState;
+typedef struct PITCommonClass PITCommonClass;
 #define PIT_COMMON(obj) \
      OBJECT_CHECK(PITCommonState, (obj), TYPE_PIT_COMMON)
 #define PIT_COMMON_CLASS(klass) \
diff --git a/include/hw/timer/i8254_internal.h b/include/hw/timer/i8254_internal.h
index 3db462aecd..a9a600d941 100644
--- a/include/hw/timer/i8254_internal.h
+++ b/include/hw/timer/i8254_internal.h
@@ -50,14 +50,14 @@ typedef struct PITChannelState {
     uint32_t irq_disabled;
 } PITChannelState;
 
-typedef struct PITCommonState {
+struct PITCommonState {
     ISADevice dev;
     MemoryRegion ioports;
     uint32_t iobase;
     PITChannelState channels[3];
-} PITCommonState;
+};
 
-typedef struct PITCommonClass {
+struct PITCommonClass {
     ISADeviceClass parent_class;
 
     void (*set_channel_gate)(PITCommonState *s, PITChannelState *sc, int val);
@@ -65,7 +65,7 @@ typedef struct PITCommonClass {
                              PITChannelInfo *info);
     void (*pre_save)(PITCommonState *s);
     void (*post_load)(PITCommonState *s);
-} PITCommonClass;
+};
 
 int pit_get_out(PITChannelState *s, int64_t current_time);
 int64_t pit_get_next_transition_time(PITChannelState *s, int64_t current_time);
-- 
2.26.2



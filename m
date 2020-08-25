Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F23C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:50:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2205A2074D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMcYI4el"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2205A2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAey4-0001o8-7F
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeY7-0004XC-2c
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:24:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57595)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeY3-0006Qw-Lg
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598383438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N5iC3NayyESUg8c1+x1J95OctO9j2TLPOhxaSknsN88=;
 b=MMcYI4elFOjNRcQ+e5D/Oqgd6YxnxrewbtzvsOosI/9zyTdxqJf97q0BXAZMZR1pCQmLGj
 WHa6glUHcr9p/n3TnunshAgwahj27CEbh2GqYO4AgcCjTV0LauluXWl8NXw6RUR+2GCr8f
 JVLYo1og646k6XX678m07JyEXidwZ8M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-rMI6QtF-MiOt-wt5N6RRaA-1; Tue, 25 Aug 2020 15:23:56 -0400
X-MC-Unique: rMI6QtF-MiOt-wt5N6RRaA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9561C10066FF;
 Tue, 25 Aug 2020 19:23:55 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 64E9F5D9D3;
 Tue, 25 Aug 2020 19:23:52 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 63/74] [automated] Use TYPE_INFO macro (pass 2)
Date: Tue, 25 Aug 2020 15:20:59 -0400
Message-Id: <20200825192110.3528606-64-ehabkost@redhat.com>
In-Reply-To: <20200825192110.3528606-1-ehabkost@redhat.com>
References: <20200825192110.3528606-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 06:38:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>, Corey Minyard <minyard@acm.org>,
 Michael Walle <michael@walle.cc>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Generated using:
  $ ./scripts/codeconverter/converter.py -i --passes=2 \
    --pattern=TypeRegisterCall,TypeInitMacro $(git grep -l TypeInfo -- '*.[ch]')

One notable difference is that files declaring multiple types
will now have multiple separate __construtor__ functions
declared, instead of one for all types.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes series v2 -> v3: this is a new patch added in series v3

Script was re-run after the rebase, and after being changed to
accept spaces in "type_init (...)" and "type_register_static
(...)" lines.

This is being submitted as a separate patch to make review
easier, but it can be squashed into the previous patch once it
gets reviewed.

---
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Corey Minyard <minyard@acm.org>
Cc: Michael Walle <michael@walle.cc>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
---
 hw/audio/ac97.c           | 2 +-
 hw/audio/adlib.c          | 2 +-
 hw/audio/cs4231a.c        | 2 +-
 hw/audio/es1370.c         | 2 +-
 hw/audio/gus.c            | 2 +-
 hw/audio/sb16.c           | 2 +-
 hw/ipmi/ipmi_bmc_extern.c | 6 +-----
 hw/sd/milkymist-memcard.c | 8 ++------
 hw/sd/pl181.c             | 8 ++------
 9 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 38522cf0ba..96683b188c 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -1426,10 +1426,10 @@ static const TypeInfo ac97_info = {
         { },
     },
 };
+TYPE_INFO(ac97_info)
 
 static void ac97_register_types (void)
 {
-    type_register_static (&ac97_info);
     deprecated_register_soundhw("ac97", "Intel 82801AA AC97 Audio",
                                 0, TYPE_AC97);
 }
diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index 65dff5b6fc..671f99a2e1 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -318,10 +318,10 @@ static const TypeInfo adlib_info = {
     .instance_size = sizeof (AdlibState),
     .class_init    = adlib_class_initfn,
 };
+TYPE_INFO(adlib_info)
 
 static void adlib_register_types (void)
 {
-    type_register_static (&adlib_info);
     deprecated_register_soundhw("adlib", ADLIB_DESC, 1, TYPE_ADLIB);
 }
 
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index 59705a8d47..176a96ffb3 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -710,10 +710,10 @@ static const TypeInfo cs4231a_info = {
     .instance_init = cs4231a_initfn,
     .class_init    = cs4231a_class_initfn,
 };
+TYPE_INFO(cs4231a_info)
 
 static void cs4231a_register_types (void)
 {
-    type_register_static (&cs4231a_info);
     deprecated_register_soundhw("cs4231a", "CS4231A", 1, TYPE_CS4231A);
 }
 
diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 4255463a49..8c924946bd 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -918,10 +918,10 @@ static const TypeInfo es1370_info = {
         { },
     },
 };
+TYPE_INFO(es1370_info)
 
 static void es1370_register_types (void)
 {
-    type_register_static (&es1370_info);
     deprecated_register_soundhw("es1370", "ENSONIQ AudioPCI ES1370",
                                 0, TYPE_ES1370);
 }
diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index 7e4a8cadad..3f2733d168 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -312,10 +312,10 @@ static const TypeInfo gus_info = {
     .instance_size = sizeof (GUSState),
     .class_init    = gus_class_initfn,
 };
+TYPE_INFO(gus_info)
 
 static void gus_register_types (void)
 {
-    type_register_static (&gus_info);
     deprecated_register_soundhw("gus", "Gravis Ultrasound GF1", 1, TYPE_GUS);
 }
 
diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index 2d9e50f99b..79984de7b9 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -1443,10 +1443,10 @@ static const TypeInfo sb16_info = {
     .instance_init = sb16_initfn,
     .class_init    = sb16_class_initfn,
 };
+TYPE_INFO(sb16_info)
 
 static void sb16_register_types (void)
 {
-    type_register_static (&sb16_info);
     deprecated_register_soundhw("sb16", "Creative Sound Blaster 16",
                                 1, TYPE_SB16);
 }
diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index f9a13e0a44..0d3dff02c4 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -539,10 +539,6 @@ static const TypeInfo ipmi_bmc_extern_type = {
     .instance_finalize = ipmi_bmc_extern_finalize,
     .class_init    = ipmi_bmc_extern_class_init,
  };
+TYPE_INFO(ipmi_bmc_extern_type)
 
-static void ipmi_bmc_extern_register_types(void)
-{
-    type_register_static(&ipmi_bmc_extern_type);
-}
 
-type_init(ipmi_bmc_extern_register_types)
diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index be89a93876..76f6ae9d23 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -311,6 +311,7 @@ static const TypeInfo milkymist_memcard_info = {
     .instance_init = milkymist_memcard_init,
     .class_init    = milkymist_memcard_class_init,
 };
+TYPE_INFO(milkymist_memcard_info)
 
 static void milkymist_sdbus_class_init(ObjectClass *klass, void *data)
 {
@@ -326,11 +327,6 @@ static const TypeInfo milkymist_sdbus_info = {
     .instance_size = sizeof(SDBus),
     .class_init = milkymist_sdbus_class_init,
 };
+TYPE_INFO(milkymist_sdbus_info)
 
-static void milkymist_memcard_register_types(void)
-{
-    type_register_static(&milkymist_memcard_info);
-    type_register_static(&milkymist_sdbus_info);
-}
 
-type_init(milkymist_memcard_register_types)
diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index 579d68ad83..5153959b1d 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -526,6 +526,7 @@ static const TypeInfo pl181_info = {
     .instance_init = pl181_init,
     .class_init    = pl181_class_init,
 };
+TYPE_INFO(pl181_info)
 
 static void pl181_bus_class_init(ObjectClass *klass, void *data)
 {
@@ -541,11 +542,6 @@ static const TypeInfo pl181_bus_info = {
     .instance_size = sizeof(SDBus),
     .class_init = pl181_bus_class_init,
 };
+TYPE_INFO(pl181_bus_info)
 
-static void pl181_register_types(void)
-{
-    type_register_static(&pl181_info);
-    type_register_static(&pl181_bus_info);
-}
 
-type_init(pl181_register_types)
-- 
2.26.2



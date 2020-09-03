Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80B2C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:03:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D78520684
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LhJOKoGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D78520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwNs-0007Cq-LH
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDwEd-00017u-NN
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 16:53:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44138)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDwEZ-0006bm-E4
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 16:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599166405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T4dBx0MZfsfJpNpI7a/vbxtuu/0AO++J414wc1ABxzM=;
 b=LhJOKoGhzwdEN8wrD4fKOY741Q2043G4DJBewTYWCyl4huC5eb+06A84UWweWAMEsh7Bys
 MUmFkiZW1eaTLpO32xM6qyhxRWlecs765QR+BB9qCityuceiWGiYkrzQ+SLHfnj5W02jfS
 bfKS6mRuh6Uri+tR0T1xnWHdRJz8U3s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-yXYrPUGQOPyI1pZpJrPTMQ-1; Thu, 03 Sep 2020 16:53:23 -0400
X-MC-Unique: yXYrPUGQOPyI1pZpJrPTMQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4A381019640;
 Thu,  3 Sep 2020 20:53:22 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6DC625D9CC;
 Thu,  3 Sep 2020 20:53:22 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 22/27] rs6000_mc: Rename RS6000MC_DEVICE to RS6000MC
Date: Thu,  3 Sep 2020 16:52:42 -0400
Message-Id: <20200903205247.1667472-23-ehabkost@redhat.com>
In-Reply-To: <20200903205247.1667472-1-ehabkost@redhat.com>
References: <20200903205247.1667472-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the type checking macro name consistent with the TYPE_*
constant.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200902224311.1321159-48-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/ppc/rs6000_mc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/rs6000_mc.c b/hw/ppc/rs6000_mc.c
index 56e96010b8..8611ffa96d 100644
--- a/hw/ppc/rs6000_mc.c
+++ b/hw/ppc/rs6000_mc.c
@@ -30,7 +30,7 @@
 
 #define TYPE_RS6000MC "rs6000-mc"
 typedef struct RS6000MCState RS6000MCState;
-DECLARE_INSTANCE_CHECKER(RS6000MCState, RS6000MC_DEVICE,
+DECLARE_INSTANCE_CHECKER(RS6000MCState, RS6000MC,
                          TYPE_RS6000MC)
 
 struct RS6000MCState {
@@ -143,7 +143,7 @@ static const MemoryRegionPortio rs6000mc_port_list[] = {
 
 static void rs6000mc_realize(DeviceState *dev, Error **errp)
 {
-    RS6000MCState *s = RS6000MC_DEVICE(dev);
+    RS6000MCState *s = RS6000MC(dev);
     int socket = 0;
     unsigned int ram_size = s->ram_size / MiB;
     Error *local_err = NULL;
-- 
2.26.2



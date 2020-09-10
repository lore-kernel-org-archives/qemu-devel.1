Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A09DC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:49:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAE7F20855
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RL1I8CTv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE7F20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGRdf-0004eF-0T
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGRCv-00065P-Vc
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:22:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57033
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGRCn-00039F-4H
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599762116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ZBCdbwo8Mc19VIclh2bvCUYx2+GOIoW4pEAh8lwB8o=;
 b=RL1I8CTvtpsW5aXgNikYTZsVkx+XWCAHClADeBuA+l1BaejY31bzVgVOoZYLRmCKrlzf9e
 YI/nzHmssm1xWTGb9uTzZ4J0ujn+SGqTIvKiydOBJfg2D5PhptUDL1V0MUUd7G3U5YxbJB
 1bTylQF1PrYCLw+iooBDgK78Uro5VPU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-fZSJAqmTPSaTKa87xYsU7w-1; Thu, 10 Sep 2020 14:21:54 -0400
X-MC-Unique: fZSJAqmTPSaTKa87xYsU7w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82F058030A9;
 Thu, 10 Sep 2020 18:21:53 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4C98175128;
 Thu, 10 Sep 2020 18:21:53 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 30/33] lpc_ich9: Use typedef name for instance_size
Date: Thu, 10 Sep 2020 14:21:09 -0400
Message-Id: <20200910182112.4030917-31-ehabkost@redhat.com>
In-Reply-To: <20200910182112.4030917-1-ehabkost@redhat.com>
References: <20200910182112.4030917-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 09:07:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This makes the code consistent with the rest of QOM code in QEMU,
and will make automated conversion to type declaration macros
simpler.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20200824215936.2961951-4-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/isa/lpc_ich9.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index cd6e169d47..3303d2eab6 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -792,7 +792,7 @@ static void ich9_lpc_class_init(ObjectClass *klass, void *data)
 static const TypeInfo ich9_lpc_info = {
     .name       = TYPE_ICH9_LPC_DEVICE,
     .parent     = TYPE_PCI_DEVICE,
-    .instance_size = sizeof(struct ICH9LPCState),
+    .instance_size = sizeof(ICH9LPCState),
     .instance_init = ich9_lpc_initfn,
     .class_init  = ich9_lpc_class_init,
     .interfaces = (InterfaceInfo[]) {
-- 
2.26.2



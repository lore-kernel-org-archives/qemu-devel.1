Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25923C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 08:38:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E666120708
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 08:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPPm8vQm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E666120708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtS4S-0000zR-8G
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 04:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtS3j-0000Ye-CP
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 04:37:35 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57889
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtS3h-0000fv-OZ
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 04:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594283853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=qzZTBaOjnCZ63EdjzcPcO1pwG1z6poR38z7K8JZ/PC4=;
 b=YPPm8vQmQTTaLxrUCkNELeZV0dLV2a32th1JDMJlukRdiiuOFzGxTM+xmpUZGWg01qCdtc
 mq9kj3Q6A6Rt3t61q3Ph2PoJP+tM0zZoCvhQtraYjRTQQ9q/z4PMcw9Zbj2gIgpRLi+KdD
 6bG4NP8sFNy/ligFdJ0uQ8nf2sHwE9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-Z2ogDUAlMPiJW_1O1kN52A-1; Thu, 09 Jul 2020 04:37:31 -0400
X-MC-Unique: Z2ogDUAlMPiJW_1O1kN52A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 708161091;
 Thu,  9 Jul 2020 08:37:30 +0000 (UTC)
Received: from thuth.com (ovpn-112-106.ams2.redhat.com [10.36.112.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C57260E1C;
 Thu,  9 Jul 2020 08:37:23 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Alexander Bulekov <alxndr@bu.edu>,
	qemu-devel@nongnu.org
Subject: [PATCH] tests/qtest/fuzz: Add missing spaces in description
Date: Thu,  9 Jul 2020 10:37:19 +0200
Message-Id: <20200709083719.22221-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 04:33:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There should be a space between "forking" and "for".

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/fuzz/virtio_scsi_fuzz.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/fuzz/virtio_scsi_fuzz.c b/tests/qtest/fuzz/virtio_scsi_fuzz.c
index 51dce491ab..3a9ea13736 100644
--- a/tests/qtest/fuzz/virtio_scsi_fuzz.c
+++ b/tests/qtest/fuzz/virtio_scsi_fuzz.c
@@ -191,7 +191,7 @@ static void register_virtio_scsi_fuzz_targets(void)
 {
     fuzz_add_qos_target(&(FuzzTarget){
                 .name = "virtio-scsi-fuzz",
-                .description = "Fuzz the virtio-scsi virtual queues, forking"
+                .description = "Fuzz the virtio-scsi virtual queues, forking "
                                 "for each fuzz run",
                 .pre_vm_init = &counter_shm_init,
                 .pre_fuzz = &virtio_scsi_pre_fuzz,
@@ -202,7 +202,7 @@ static void register_virtio_scsi_fuzz_targets(void)
 
     fuzz_add_qos_target(&(FuzzTarget){
                 .name = "virtio-scsi-flags-fuzz",
-                .description = "Fuzz the virtio-scsi virtual queues, forking"
+                .description = "Fuzz the virtio-scsi virtual queues, forking "
                 "for each fuzz run (also fuzzes the virtio flags)",
                 .pre_vm_init = &counter_shm_init,
                 .pre_fuzz = &virtio_scsi_pre_fuzz,
-- 
2.18.1



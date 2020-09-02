Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C4FC2BBD0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:03:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2463E20773
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBkgoC4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2463E20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDbmo-0007eg-6n
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 19:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbVS-0005FP-82
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:45:30 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50149
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbVQ-0000Dg-BH
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=may9SiP3x3SiApTDSN5j7jfBgduk5as5YrYWWy6Bt4U=;
 b=jBkgoC4rmo7Fi46N+eHlr5/BoVbSaVFUgweKzRs9ytG93EXptuK5/Qy8zEkdZ3kZaE9gJv
 MJQqp/GgiS1LLftpRuDFHA0FID3r076qsiU7p+s5YsaiAzNaYHrBIXmZYFRr8dBqwgSRq7
 L/+iEu8Q1DEI1LDAick6UloymTapgMk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-zBIk5K9pPiydGBPxf9Oc8w-1; Wed, 02 Sep 2020 18:45:23 -0400
X-MC-Unique: zBIk5K9pPiydGBPxf9Oc8w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 933E1107464A;
 Wed,  2 Sep 2020 22:45:22 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 592141002D40;
 Wed,  2 Sep 2020 22:45:22 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 50/63] tpm_crb: Rename CRB to TPM_CRB
Date: Wed,  2 Sep 2020 18:42:58 -0400
Message-Id: <20200902224311.1321159-51-ehabkost@redhat.com>
In-Reply-To: <20200902224311.1321159-1-ehabkost@redhat.com>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 17:54:07
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
Cc: berrange@redhat.com, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the type checking macro name consistent with the TYPE_*
constant.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org
---
 hw/tpm/tpm_crb.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index aa9c00aad3..f4e3f0abbc 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -47,7 +47,7 @@ struct CRBState {
 };
 typedef struct CRBState CRBState;
 
-DECLARE_INSTANCE_CHECKER(CRBState, CRB,
+DECLARE_INSTANCE_CHECKER(CRBState, TPM_CRB,
                          TYPE_TPM_CRB)
 
 #define CRB_INTF_TYPE_CRB_ACTIVE 0b1
@@ -86,7 +86,7 @@ enum crb_cancel {
 static uint64_t tpm_crb_mmio_read(void *opaque, hwaddr addr,
                                   unsigned size)
 {
-    CRBState *s = CRB(opaque);
+    CRBState *s = TPM_CRB(opaque);
     void *regs = (void *)&s->regs + (addr & ~3);
     unsigned offset = addr & 3;
     uint32_t val = *(uint32_t *)regs >> (8 * offset);
@@ -113,7 +113,7 @@ static uint8_t tpm_crb_get_active_locty(CRBState *s)
 static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
                                uint64_t val, unsigned size)
 {
-    CRBState *s = CRB(opaque);
+    CRBState *s = TPM_CRB(opaque);
     uint8_t locty =  addr >> 12;
 
     trace_tpm_crb_mmio_write(addr, size, val);
@@ -190,7 +190,7 @@ static const MemoryRegionOps tpm_crb_memory_ops = {
 
 static void tpm_crb_request_completed(TPMIf *ti, int ret)
 {
-    CRBState *s = CRB(ti);
+    CRBState *s = TPM_CRB(ti);
 
     s->regs[R_CRB_CTRL_START] &= ~CRB_START_INVOKE;
     if (ret != 0) {
@@ -201,7 +201,7 @@ static void tpm_crb_request_completed(TPMIf *ti, int ret)
 
 static enum TPMVersion tpm_crb_get_version(TPMIf *ti)
 {
-    CRBState *s = CRB(ti);
+    CRBState *s = TPM_CRB(ti);
 
     return tpm_backend_get_tpm_version(s->tpmbe);
 }
@@ -232,7 +232,7 @@ static Property tpm_crb_properties[] = {
 
 static void tpm_crb_reset(void *dev)
 {
-    CRBState *s = CRB(dev);
+    CRBState *s = TPM_CRB(dev);
 
     if (s->ppi_enabled) {
         tpm_ppi_reset(&s->ppi);
@@ -281,7 +281,7 @@ static void tpm_crb_reset(void *dev)
 
 static void tpm_crb_realize(DeviceState *dev, Error **errp)
 {
-    CRBState *s = CRB(dev);
+    CRBState *s = TPM_CRB(dev);
 
     if (!tpm_find()) {
         error_setg(errp, "at most one TPM device is permitted");
-- 
2.26.2



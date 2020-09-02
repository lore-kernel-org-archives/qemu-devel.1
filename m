Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C707FC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:08:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DDBA20767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KkE0Y1r/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DDBA20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDbrJ-0007w9-Ni
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 19:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbVR-0005Dy-Ly
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:45:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43597
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbVP-0000DT-PF
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+HqocEVt3IjTtTEYyuQs0S10647C8sqQ/V5hlLQKIcI=;
 b=KkE0Y1r/+Zycyns9qnsEfNRQVlwz6hy/HXvEBQI+JFjX0Ujj1IxsPtPm0Y3E6CSmntRgVd
 KudZZ1az5qc0llMq/8nTtH4pJCdVbNxHKYzVqf87aOYOwgBivZ4N75Wxt/5owdhAoZRbfY
 N3Fr5HhXfUF1YPzTeZRykUyuzEkNp3E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-XJtxKrB2OcKm-n0QdgEKOQ-1; Wed, 02 Sep 2020 18:45:24 -0400
X-MC-Unique: XJtxKrB2OcKm-n0QdgEKOQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 792681005E65;
 Wed,  2 Sep 2020 22:45:23 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4898C100EBBE;
 Wed,  2 Sep 2020 22:45:23 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 51/63] tpm_spapr: Rename VIO_SPAPR_VTPM to TPM_SPAPR
Date: Wed,  2 Sep 2020 18:42:59 -0400
Message-Id: <20200902224311.1321159-52-ehabkost@redhat.com>
In-Reply-To: <20200902224311.1321159-1-ehabkost@redhat.com>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 16:25:58
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
 hw/tpm/tpm_spapr.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
index e3775adc57..aa86d5f943 100644
--- a/hw/tpm/tpm_spapr.c
+++ b/hw/tpm/tpm_spapr.c
@@ -31,7 +31,7 @@
 #define DEBUG_SPAPR 0
 
 typedef struct SpaprTpmState SpaprTpmState;
-DECLARE_INSTANCE_CHECKER(SpaprTpmState, VIO_SPAPR_VTPM,
+DECLARE_INSTANCE_CHECKER(SpaprTpmState, TPM_SPAPR,
                          TYPE_TPM_SPAPR)
 
 typedef struct TpmCrq {
@@ -132,7 +132,7 @@ static inline int spapr_tpm_send_crq(struct SpaprVioDevice *dev, TpmCrq *crq)
 
 static int tpm_spapr_do_crq(struct SpaprVioDevice *dev, uint8_t *crq_data)
 {
-    SpaprTpmState *s = VIO_SPAPR_VTPM(dev);
+    SpaprTpmState *s = TPM_SPAPR(dev);
     TpmCrq local_crq;
     TpmCrq *crq = &s->crq; /* requests only */
     int rc;
@@ -235,7 +235,7 @@ static int tpm_spapr_do_crq(struct SpaprVioDevice *dev, uint8_t *crq_data)
 
 static void tpm_spapr_request_completed(TPMIf *ti, int ret)
 {
-    SpaprTpmState *s = VIO_SPAPR_VTPM(ti);
+    SpaprTpmState *s = TPM_SPAPR(ti);
     TpmCrq *crq = &s->crq;
     uint32_t len;
     int rc;
@@ -283,7 +283,7 @@ static int tpm_spapr_do_startup_tpm(SpaprTpmState *s, size_t buffersize)
 
 static const char *tpm_spapr_get_dt_compatible(SpaprVioDevice *dev)
 {
-    SpaprTpmState *s = VIO_SPAPR_VTPM(dev);
+    SpaprTpmState *s = TPM_SPAPR(dev);
 
     switch (s->be_tpm_version) {
     case TPM_VERSION_1_2:
@@ -297,7 +297,7 @@ static const char *tpm_spapr_get_dt_compatible(SpaprVioDevice *dev)
 
 static void tpm_spapr_reset(SpaprVioDevice *dev)
 {
-    SpaprTpmState *s = VIO_SPAPR_VTPM(dev);
+    SpaprTpmState *s = TPM_SPAPR(dev);
 
     s->state = SPAPR_VTPM_STATE_NONE;
     s->numbytes = 0;
@@ -316,7 +316,7 @@ static void tpm_spapr_reset(SpaprVioDevice *dev)
 
 static enum TPMVersion tpm_spapr_get_version(TPMIf *ti)
 {
-    SpaprTpmState *s = VIO_SPAPR_VTPM(ti);
+    SpaprTpmState *s = TPM_SPAPR(ti);
 
     if (tpm_backend_had_startup_error(s->be_driver)) {
         return TPM_VERSION_UNSPEC;
@@ -377,7 +377,7 @@ static Property tpm_spapr_properties[] = {
 
 static void tpm_spapr_realizefn(SpaprVioDevice *dev, Error **errp)
 {
-    SpaprTpmState *s = VIO_SPAPR_VTPM(dev);
+    SpaprTpmState *s = TPM_SPAPR(dev);
 
     if (!tpm_find()) {
         error_setg(errp, "at most one TPM device is permitted");
-- 
2.26.2



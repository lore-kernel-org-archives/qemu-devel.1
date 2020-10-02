Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4FCC4727D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:22:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30208207EA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azD8WIR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30208207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOK4n-0004Tp-2W
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 08:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kOJvC-0004Ih-Cu
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:12:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33779)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kOJv4-0003Sm-T3
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601640733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OU6Y6Jz7cq8uW3N9sI3TJVwBty4jN6+TFXKrR3iHLoY=;
 b=azD8WIR9d8m7o5GHJHeRVdayIERR7pTnCQEnFc9OvQwRwYuqahktULYhJHcM8X+ofuIRDh
 FaXy73SV+0DhQXXKLfRSTV4TRObVLV/V0dHLI+NoZzxTBj8x7BJz7lFNkUNpAJG6KoGGds
 eF8R07EWvnXKyE58WnMkNMEAWtOlOE0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-x_tgy0B1NAODP_RYx9HX7g-1; Fri, 02 Oct 2020 08:12:09 -0400
X-MC-Unique: x_tgy0B1NAODP_RYx9HX7g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2471185FD8B;
 Fri,  2 Oct 2020 12:12:07 +0000 (UTC)
Received: from localhost (ovpn-112-216.ams2.redhat.com [10.36.112.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A93C95D9D3;
 Fri,  2 Oct 2020 12:12:01 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 11/19] s390x/cpumodel: S390_FEAT_MISC_INSTRUCTION_EXT ->
 S390_FEAT_MISC_INSTRUCTION_EXT2
Date: Fri,  2 Oct 2020 14:11:10 +0200
Message-Id: <20201002121118.180315-12-cohuck@redhat.com>
In-Reply-To: <20201002121118.180315-1-cohuck@redhat.com>
References: <20201002121118.180315-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Let's avoid confusion with the "Miscellaneous-Instruction-Extensions
Facility 1"

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <20200928122717.30586-2-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu_features_def.h.inc | 2 +-
 target/s390x/gen-features.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
index f82b4b5ec16a..7db3449e0434 100644
--- a/target/s390x/cpu_features_def.h.inc
+++ b/target/s390x/cpu_features_def.h.inc
@@ -72,7 +72,7 @@ DEF_FEAT(INTERLOCKED_ACCESS_2, "iacc2", STFL, 52, "Interlocked-access facility 2
 DEF_FEAT(STFLE_53, "stfle53", STFL, 53, "Various facilities introduced with z13")
 DEF_FEAT(ENTROPY_ENC_COMP, "eec", STFL, 54, "Entropy encoding compression facility")
 DEF_FEAT(MSA_EXT_5, "msa5-base", STFL, 57, "Message-security-assist-extension-5 facility (excluding subfunctions)")
-DEF_FEAT(MISC_INSTRUCTION_EXT, "minste2", STFL, 58, "Miscellaneous-instruction-extensions facility 2")
+DEF_FEAT(MISC_INSTRUCTION_EXT2, "minste2", STFL, 58, "Miscellaneous-instruction-extensions facility 2")
 DEF_FEAT(SEMAPHORE_ASSIST, "sema", STFL, 59, "Semaphore-assist facility")
 DEF_FEAT(TIME_SLICE_INSTRUMENTATION, "tsi", STFL, 60, "Time-slice Instrumentation facility")
 DEF_FEAT(MISC_INSTRUCTION_EXT3, "minste3", STFL, 61, "Miscellaneous-Instruction-Extensions Facility 3")
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index a1f0a6f3c6fc..e3fd0c0a2ef3 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -412,7 +412,7 @@ static uint16_t base_GEN13_GA1[] = {
 
 static uint16_t base_GEN14_GA1[] = {
     S390_FEAT_ENTROPY_ENC_COMP,
-    S390_FEAT_MISC_INSTRUCTION_EXT,
+    S390_FEAT_MISC_INSTRUCTION_EXT2,
     S390_FEAT_SEMAPHORE_ASSIST,
     S390_FEAT_TIME_SLICE_INSTRUMENTATION,
     S390_FEAT_ORDER_PRESERVING_COMPRESSION,
-- 
2.25.4



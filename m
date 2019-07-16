Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB442C7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:06:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 936A720880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:06:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936A720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnO6W-0005JF-KD
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 10:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35200)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hnO5v-0002pB-W9
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:06:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hnO5r-0000Nt-4r
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:06:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46154)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hnO5n-0000Lo-Eq; Tue, 16 Jul 2019 10:06:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A2687300CB0B;
 Tue, 16 Jul 2019 14:06:06 +0000 (UTC)
Received: from localhost (ovpn-117-180.ams2.redhat.com [10.36.117.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 18C265C221;
 Tue, 16 Jul 2019 14:06:02 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jul 2019 16:05:46 +0200
Message-Id: <20190716140546.6661-4-cohuck@redhat.com>
In-Reply-To: <20190716140546.6661-1-cohuck@redhat.com>
References: <20190716140546.6661-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 16 Jul 2019 14:06:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL for-4.1 3/3] s390x/cpumodel: change internal
 name of vxpdeh to match description
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

From: Christian Borntraeger <borntraeger@de.ibm.com>

The internal macro name VECTOR_BCD_ENH does not match the actual
description. Fix this.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <20190715142304.215018-4-borntraeger@de.ibm.com>
[CH: vxp->vxpdeh, as discussed]
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu_features_def.inc.h | 2 +-
 target/s390x/gen-features.c         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/cpu_features_def.inc.h b/target/s390x/cpu_featu=
res_def.inc.h
index 05b7674affe6..31dff0d84e97 100644
--- a/target/s390x/cpu_features_def.inc.h
+++ b/target/s390x/cpu_features_def.inc.h
@@ -104,7 +104,7 @@ DEF_FEAT(CMM_NT, "cmmnt", STFL, 147, "CMM: ESSA-enhan=
cement (no translate) facil
 DEF_FEAT(VECTOR_ENH2, "vxeh2", STFL, 148, "Vector Enhancements facility =
2")
 DEF_FEAT(ESORT_BASE, "esort-base", STFL, 150, "Enhanced-sort facility (e=
xcluding subfunctions)")
 DEF_FEAT(DEFLATE_BASE, "deflate-base", STFL, 151, "Deflate-conversion fa=
cility (excluding subfunctions)")
-DEF_FEAT(VECTOR_BCD_ENH, "vxpdeh", STFL, 152, "Vector-Packed-Decimal-Enh=
ancement Facility")
+DEF_FEAT(VECTOR_PACKED_DECIMAL_ENH, "vxpdeh", STFL, 152, "Vector-Packed-=
Decimal-Enhancement Facility")
 DEF_FEAT(MSA_EXT_9, "msa9-base", STFL, 155, "Message-security-assist-ext=
ension-9 facility (excluding subfunctions)")
 DEF_FEAT(ETOKEN, "etoken", STFL, 156, "Etoken facility")
=20
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 6debfc1d217e..49a650ac52d0 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -558,7 +558,7 @@ static uint16_t full_GEN15_GA1[] =3D {
     S390_FEAT_VECTOR_ENH2,
     S390_FEAT_GROUP_ENH_SORT,
     S390_FEAT_GROUP_DEFLATE_CONVERSION,
-    S390_FEAT_VECTOR_BCD_ENH,
+    S390_FEAT_VECTOR_PACKED_DECIMAL_ENH,
     S390_FEAT_GROUP_MSA_EXT_9,
     S390_FEAT_GROUP_MSA_EXT_9_PCKMO,
     S390_FEAT_ETOKEN,
@@ -643,7 +643,7 @@ static uint16_t default_GEN14_GA1[] =3D {
 static uint16_t default_GEN15_GA1[] =3D {
     S390_FEAT_VECTOR_ENH2,
     S390_FEAT_GROUP_DEFLATE_CONVERSION,
-    S390_FEAT_VECTOR_BCD_ENH,
+    S390_FEAT_VECTOR_PACKED_DECIMAL_ENH,
     S390_FEAT_GROUP_MSA_EXT_9,
     S390_FEAT_GROUP_MSA_EXT_9_PCKMO,
     S390_FEAT_ETOKEN,
--=20
2.20.1



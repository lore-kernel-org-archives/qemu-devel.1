Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCE9C7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:06:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C80D120880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C80D120880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnO6A-0003Qx-IO
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 10:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35137)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hnO5n-0002D8-Ev
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:06:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hnO5h-0000Iz-NR
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:06:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51356)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hnO5h-0000Ic-GS; Tue, 16 Jul 2019 10:06:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CD74AC06511D;
 Tue, 16 Jul 2019 14:06:00 +0000 (UTC)
Received: from localhost (ovpn-117-180.ams2.redhat.com [10.36.117.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E3AA60A9F;
 Tue, 16 Jul 2019 14:05:58 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jul 2019 16:05:45 +0200
Message-Id: <20190716140546.6661-3-cohuck@redhat.com>
In-Reply-To: <20190716140546.6661-1-cohuck@redhat.com>
References: <20190716140546.6661-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Tue, 16 Jul 2019 14:06:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL for-4.1 2/3] s390x/cpumodel: also change name of
 vxbeh
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

David suggested to keep everything in sync as 4.1 is not yet released.
This patch fixes the name "vxbeh" into "vxpdeh".

To simplify the backports this patch will not change VECTOR_BCD_ENH as
this is just an internal name. That will be done by an extra patch that
does not need to be backported.

Suggested-by: David Hildenbrand <david@redhat.com>
Fixes: d05be57ddc2e ("s390: cpumodel: fix description for the new vector =
facility")
Fixes: 54d65de0b525 ("s390x/cpumodel: vector enhancements")
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <20190715142304.215018-3-borntraeger@de.ibm.com>
[CH: vxp->vxpdeh, as discussed]
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu_features_def.inc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/cpu_features_def.inc.h b/target/s390x/cpu_featu=
res_def.inc.h
index 3118a9f89228..05b7674affe6 100644
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
-DEF_FEAT(VECTOR_BCD_ENH, "vxbeh", STFL, 152, "Vector-Packed-Decimal-Enha=
ncement Facility")
+DEF_FEAT(VECTOR_BCD_ENH, "vxpdeh", STFL, 152, "Vector-Packed-Decimal-Enh=
ancement Facility")
 DEF_FEAT(MSA_EXT_9, "msa9-base", STFL, 155, "Message-security-assist-ext=
ension-9 facility (excluding subfunctions)")
 DEF_FEAT(ETOKEN, "etoken", STFL, 156, "Etoken facility")
=20
--=20
2.20.1



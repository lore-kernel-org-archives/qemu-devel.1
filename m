Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC28C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:40:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E95A2206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:40:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E95A2206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39363 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSmGc-0005cQ-3Y
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 13:40:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hSlqk-0000Mp-Ay
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:13:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hSlqh-0006qi-Hj
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:13:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hSlqh-0006q0-6k; Mon, 20 May 2019 13:13:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2648A308FC4D;
	Mon, 20 May 2019 17:13:10 +0000 (UTC)
Received: from localhost (ovpn-204-110.brq.redhat.com [10.40.204.110])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 29EA060BEC;
	Mon, 20 May 2019 17:13:02 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2019 19:03:00 +0200
Message-Id: <20190520170302.13643-53-cohuck@redhat.com>
In-Reply-To: <20190520170302.13643-1-cohuck@redhat.com>
References: <20190520170302.13643-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Mon, 20 May 2019 17:13:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 52/54] s390x/cpumodel: add Deflate-conversion
 facility
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
	Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
	David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

add the deflate conversion facility.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <20190429090250.7648-8-borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu_features.c     |  9 +++++++++
 target/s390x/cpu_features.h     |  1 +
 target/s390x/cpu_features_def.h |  7 +++++++
 target/s390x/gen-features.c     | 12 ++++++++++++
 target/s390x/kvm.c              |  6 ++++++
 5 files changed, 35 insertions(+)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 1d19b3072e1a..f64f581c8614 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -110,6 +110,7 @@ static const S390FeatDef s390_features[] =3D {
     FEAT_INIT("cmmnt", S390_FEAT_TYPE_STFL, 147, "CMM: ESSA-enhancement =
(no translate) facility"),
     FEAT_INIT("vxeh2", S390_FEAT_TYPE_STFL, 148, "Vector Enhancements fa=
cility 2"),
     FEAT_INIT("esort-base", S390_FEAT_TYPE_STFL, 150, "Enhanced-sort fac=
ility (excluding subfunctions)"),
+    FEAT_INIT("deflate-base", S390_FEAT_TYPE_STFL, 151, "Deflate-convers=
ion facility (excluding subfunctions)"),
     FEAT_INIT("vxbeh", S390_FEAT_TYPE_STFL, 152, "Vector BCD enhancement=
s facility 1"),
     FEAT_INIT("msa9-base", S390_FEAT_TYPE_STFL, 155, "Message-security-a=
ssist-extension-9 facility (excluding subfunctions)"),
     FEAT_INIT("etoken", S390_FEAT_TYPE_STFL, 156, "Etoken facility"),
@@ -347,6 +348,11 @@ static const S390FeatDef s390_features[] =3D {
     FEAT_INIT("sortl-32", S390_FEAT_TYPE_SORTL, 130, "SORTL 32 input lis=
ts"),
     FEAT_INIT("sortl-128", S390_FEAT_TYPE_SORTL, 132, "SORTL 128 input l=
ists"),
     FEAT_INIT("sortl-f0", S390_FEAT_TYPE_SORTL, 192, "SORTL format 0 par=
ameter-block"),
+
+    FEAT_INIT("dfltcc-gdht", S390_FEAT_TYPE_DFLTCC, 1, "DFLTCC GDHT"),
+    FEAT_INIT("dfltcc-cmpr", S390_FEAT_TYPE_DFLTCC, 2, "DFLTCC CMPR"),
+    FEAT_INIT("dfltcc-xpnd", S390_FEAT_TYPE_DFLTCC, 4, "DFLTCC XPND"),
+    FEAT_INIT("dfltcc-f0", S390_FEAT_TYPE_DFLTCC, 192, "DFLTCC format 0 =
parameter-block"),
 };
=20
 const S390FeatDef *s390_feat_def(S390Feat feat)
@@ -411,6 +417,7 @@ void s390_fill_feat_block(const S390FeatBitmap featur=
es, S390FeatType type,
     case S390_FEAT_TYPE_KMA:
     case S390_FEAT_TYPE_KDSA:
     case S390_FEAT_TYPE_SORTL:
+    case S390_FEAT_TYPE_DFLTCC:
         set_be_bit(0, data); /* query is always available */
         break;
     default:
@@ -439,6 +446,7 @@ void s390_add_from_feat_block(S390FeatBitmap features=
, S390FeatType type,
        break;
     case S390_FEAT_TYPE_PLO:
     case S390_FEAT_TYPE_SORTL:
+    case S390_FEAT_TYPE_DFLTCC:
        nr_bits =3D 256;
        break;
     default:
@@ -511,6 +519,7 @@ static S390FeatGroupDef s390_feature_groups[] =3D {
     FEAT_GROUP_INIT("msa9_pckmo", MSA_EXT_9_PCKMO, "Message-security-ass=
ist-extension 9 PCKMO subfunctions"),
     FEAT_GROUP_INIT("mepochptff", MULTIPLE_EPOCH_PTFF, "PTFF enhancement=
s introduced with Multiple-epoch facility"),
     FEAT_GROUP_INIT("esort", ENH_SORT, "Enhanced-sort facility"),
+    FEAT_GROUP_INIT("deflate", DEFLATE_CONVERSION, "Deflate-conversion f=
acility"),
 };
=20
 const S390FeatGroupDef *s390_feat_group_def(S390FeatGroup group)
diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index 3b8c5b25dd4e..da695a8346e9 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -41,6 +41,7 @@ typedef enum {
     S390_FEAT_TYPE_KMA,
     S390_FEAT_TYPE_KDSA,
     S390_FEAT_TYPE_SORTL,
+    S390_FEAT_TYPE_DFLTCC,
 } S390FeatType;
=20
 /* Definition of a CPU feature */
diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_=
def.h
index bb8585847f25..292b17b35d32 100644
--- a/target/s390x/cpu_features_def.h
+++ b/target/s390x/cpu_features_def.h
@@ -98,6 +98,7 @@ typedef enum {
     S390_FEAT_CMM_NT,
     S390_FEAT_VECTOR_ENH2,
     S390_FEAT_ESORT_BASE,
+    S390_FEAT_DEFLATE_BASE,
     S390_FEAT_VECTOR_BCD_ENH,
     S390_FEAT_MSA_EXT_9,
     S390_FEAT_ETOKEN,
@@ -354,6 +355,12 @@ typedef enum {
     S390_FEAT_SORTL_128,
     S390_FEAT_SORTL_F0,
=20
+    /* DEFLATE */
+    S390_FEAT_DEFLATE_GHDT,
+    S390_FEAT_DEFLATE_CMPR,
+    S390_FEAT_DEFLATE_XPND,
+    S390_FEAT_DEFLATE_F0,
+
     S390_FEAT_MAX,
 } S390Feat;
=20
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 0a62cc563140..8fc2e8e72fc9 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -254,6 +254,13 @@
     S390_FEAT_SORTL_F0
=20
=20
+#define S390_FEAT_GROUP_DEFLATE_CONVERSION \
+    S390_FEAT_DEFLATE_BASE, \
+    S390_FEAT_DEFLATE_GHDT, \
+    S390_FEAT_DEFLATE_CMPR, \
+    S390_FEAT_DEFLATE_XPND, \
+    S390_FEAT_DEFLATE_F0
+
 /* cpu feature groups */
 static uint16_t group_PLO[] =3D {
     S390_FEAT_GROUP_PLO,
@@ -307,6 +314,10 @@ static uint16_t group_ENH_SORT[] =3D {
     S390_FEAT_GROUP_ENH_SORT,
 };
=20
+static uint16_t group_DEFLATE_CONVERSION[] =3D {
+    S390_FEAT_GROUP_DEFLATE_CONVERSION,
+};
+
 /* Base features (in order of release)
  * Only non-hypervisor managed features belong here.
  * Base feature sets are static meaning they do not change in future QEM=
U
@@ -766,6 +777,7 @@ static FeatGroupDefSpec FeatGroupDef[] =3D {
     FEAT_GROUP_INITIALIZER(MSA_EXT_9_PCKMO),
     FEAT_GROUP_INITIALIZER(MULTIPLE_EPOCH_PTFF),
     FEAT_GROUP_INITIALIZER(ENH_SORT),
+    FEAT_GROUP_INITIALIZER(DEFLATE_CONVERSION),
 };
=20
 #define QEMU_FEAT_INITIALIZER(_name)                   \
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index f91f436a313b..e5e2b691f253 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2079,6 +2079,9 @@ static int query_cpu_subfunc(S390FeatBitmap feature=
s)
     if (test_bit(S390_FEAT_ESORT_BASE, features)) {
         s390_add_from_feat_block(features, S390_FEAT_TYPE_SORTL, prop.so=
rtl);
     }
+    if (test_bit(S390_FEAT_DEFLATE_BASE, features)) {
+        s390_add_from_feat_block(features, S390_FEAT_TYPE_DFLTCC, prop.d=
fltcc);
+    }
     return 0;
 }
=20
@@ -2129,6 +2132,9 @@ static int configure_cpu_subfunc(const S390FeatBitm=
ap features)
     if (test_bit(S390_FEAT_ESORT_BASE, features)) {
         s390_fill_feat_block(features, S390_FEAT_TYPE_SORTL, prop.sortl)=
;
     }
+    if (test_bit(S390_FEAT_DEFLATE_BASE, features)) {
+        s390_fill_feat_block(features, S390_FEAT_TYPE_DFLTCC, prop.dfltc=
c);
+    }
     return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
 }
=20
--=20
2.20.1



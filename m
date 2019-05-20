Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F419C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:58:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E3AA206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E3AA206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39747 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSmY8-0003dd-QN
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 13:58:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hSlqT-0008UX-Kb
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hSlqR-0006j0-Vs
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:13:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hSlqR-0006hp-Nw; Mon, 20 May 2019 13:13:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 693DC7EBC1;
	Mon, 20 May 2019 17:12:57 +0000 (UTC)
Received: from localhost (ovpn-204-110.brq.redhat.com [10.40.204.110])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DB2195C644;
	Mon, 20 May 2019 17:12:36 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2019 19:02:59 +0200
Message-Id: <20190520170302.13643-52-cohuck@redhat.com>
In-Reply-To: <20190520170302.13643-1-cohuck@redhat.com>
References: <20190520170302.13643-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Mon, 20 May 2019 17:13:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 51/54] s390x/cpumodel: enhanced sort facility
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

add the enhanced sort facility.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190429090250.7648-7-borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu_features.c     | 10 ++++++++++
 target/s390x/cpu_features.h     |  1 +
 target/s390x/cpu_features_def.h |  8 ++++++++
 target/s390x/gen-features.c     | 14 ++++++++++++++
 target/s390x/kvm.c              |  6 ++++++
 5 files changed, 39 insertions(+)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 35873253be8d..1d19b3072e1a 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -109,6 +109,7 @@ static const S390FeatDef s390_features[] =3D {
     FEAT_INIT("msa8-base", S390_FEAT_TYPE_STFL, 146, "Message-security-a=
ssist-extension-8 facility (excluding subfunctions)"),
     FEAT_INIT("cmmnt", S390_FEAT_TYPE_STFL, 147, "CMM: ESSA-enhancement =
(no translate) facility"),
     FEAT_INIT("vxeh2", S390_FEAT_TYPE_STFL, 148, "Vector Enhancements fa=
cility 2"),
+    FEAT_INIT("esort-base", S390_FEAT_TYPE_STFL, 150, "Enhanced-sort fac=
ility (excluding subfunctions)"),
     FEAT_INIT("vxbeh", S390_FEAT_TYPE_STFL, 152, "Vector BCD enhancement=
s facility 1"),
     FEAT_INIT("msa9-base", S390_FEAT_TYPE_STFL, 155, "Message-security-a=
ssist-extension-9 facility (excluding subfunctions)"),
     FEAT_INIT("etoken", S390_FEAT_TYPE_STFL, 156, "Etoken facility"),
@@ -340,6 +341,12 @@ static const S390FeatDef s390_features[] =3D {
     FEAT_INIT("kdsa-eddsa-sign-ed448", S390_FEAT_TYPE_KDSA, 44, "KDSA Ed=
DSA-Sign-Ed448"),
     FEAT_INIT("kdsa-eeddsa-sign-ed25519", S390_FEAT_TYPE_KDSA, 48, "KDSA=
 Encrypted-EdDSA-Sign-Ed25519"),
     FEAT_INIT("kdsa-eeddsa-sign-ed448", S390_FEAT_TYPE_KDSA, 52, "KDSA E=
ncrypted-EdDSA-Sign-Ed448"),
+
+    FEAT_INIT("sortl-sflr", S390_FEAT_TYPE_SORTL, 1, "SORTL SFLR"),
+    FEAT_INIT("sortl-svlr", S390_FEAT_TYPE_SORTL, 2, "SORTL SVLR"),
+    FEAT_INIT("sortl-32", S390_FEAT_TYPE_SORTL, 130, "SORTL 32 input lis=
ts"),
+    FEAT_INIT("sortl-128", S390_FEAT_TYPE_SORTL, 132, "SORTL 128 input l=
ists"),
+    FEAT_INIT("sortl-f0", S390_FEAT_TYPE_SORTL, 192, "SORTL format 0 par=
ameter-block"),
 };
=20
 const S390FeatDef *s390_feat_def(S390Feat feat)
@@ -403,6 +410,7 @@ void s390_fill_feat_block(const S390FeatBitmap featur=
es, S390FeatType type,
     case S390_FEAT_TYPE_PPNO:
     case S390_FEAT_TYPE_KMA:
     case S390_FEAT_TYPE_KDSA:
+    case S390_FEAT_TYPE_SORTL:
         set_be_bit(0, data); /* query is always available */
         break;
     default:
@@ -430,6 +438,7 @@ void s390_add_from_feat_block(S390FeatBitmap features=
, S390FeatType type,
        nr_bits =3D 16384;
        break;
     case S390_FEAT_TYPE_PLO:
+    case S390_FEAT_TYPE_SORTL:
        nr_bits =3D 256;
        break;
     default:
@@ -501,6 +510,7 @@ static S390FeatGroupDef s390_feature_groups[] =3D {
     FEAT_GROUP_INIT("msa9", MSA_EXT_9, "Message-security-assist-extensio=
n 9 facility"),
     FEAT_GROUP_INIT("msa9_pckmo", MSA_EXT_9_PCKMO, "Message-security-ass=
ist-extension 9 PCKMO subfunctions"),
     FEAT_GROUP_INIT("mepochptff", MULTIPLE_EPOCH_PTFF, "PTFF enhancement=
s introduced with Multiple-epoch facility"),
+    FEAT_GROUP_INIT("esort", ENH_SORT, "Enhanced-sort facility"),
 };
=20
 const S390FeatGroupDef *s390_feat_group_def(S390FeatGroup group)
diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index 5ffd3db083d4..3b8c5b25dd4e 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -40,6 +40,7 @@ typedef enum {
     S390_FEAT_TYPE_PPNO,
     S390_FEAT_TYPE_KMA,
     S390_FEAT_TYPE_KDSA,
+    S390_FEAT_TYPE_SORTL,
 } S390FeatType;
=20
 /* Definition of a CPU feature */
diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_=
def.h
index ce2223c9d774..bb8585847f25 100644
--- a/target/s390x/cpu_features_def.h
+++ b/target/s390x/cpu_features_def.h
@@ -97,6 +97,7 @@ typedef enum {
     S390_FEAT_MSA_EXT_8,
     S390_FEAT_CMM_NT,
     S390_FEAT_VECTOR_ENH2,
+    S390_FEAT_ESORT_BASE,
     S390_FEAT_VECTOR_BCD_ENH,
     S390_FEAT_MSA_EXT_9,
     S390_FEAT_ETOKEN,
@@ -346,6 +347,13 @@ typedef enum {
     S390_FEAT_EEDDSA_SIGN_ED25519,
     S390_FEAT_EEDDSA_SIGN_ED448,
=20
+    /* SORTL */
+    S390_FEAT_SORTL_SFLR,
+    S390_FEAT_SORTL_SVLR,
+    S390_FEAT_SORTL_32,
+    S390_FEAT_SORTL_128,
+    S390_FEAT_SORTL_F0,
+
     S390_FEAT_MAX,
 } S390Feat;
=20
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index a2f9e2b43f74..0a62cc563140 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -245,6 +245,15 @@
     S390_FEAT_PCKMO_ECC_ED25519, \
     S390_FEAT_PCKMO_ECC_ED448
=20
+#define S390_FEAT_GROUP_ENH_SORT \
+    S390_FEAT_ESORT_BASE, \
+    S390_FEAT_SORTL_SFLR, \
+    S390_FEAT_SORTL_SVLR, \
+    S390_FEAT_SORTL_32, \
+    S390_FEAT_SORTL_128, \
+    S390_FEAT_SORTL_F0
+
+
 /* cpu feature groups */
 static uint16_t group_PLO[] =3D {
     S390_FEAT_GROUP_PLO,
@@ -294,6 +303,10 @@ static uint16_t group_MSA_EXT_9_PCKMO[] =3D {
     S390_FEAT_GROUP_MSA_EXT_9_PCKMO,
 };
=20
+static uint16_t group_ENH_SORT[] =3D {
+    S390_FEAT_GROUP_ENH_SORT,
+};
+
 /* Base features (in order of release)
  * Only non-hypervisor managed features belong here.
  * Base feature sets are static meaning they do not change in future QEM=
U
@@ -752,6 +765,7 @@ static FeatGroupDefSpec FeatGroupDef[] =3D {
     FEAT_GROUP_INITIALIZER(MSA_EXT_9),
     FEAT_GROUP_INITIALIZER(MSA_EXT_9_PCKMO),
     FEAT_GROUP_INITIALIZER(MULTIPLE_EPOCH_PTFF),
+    FEAT_GROUP_INITIALIZER(ENH_SORT),
 };
=20
 #define QEMU_FEAT_INITIALIZER(_name)                   \
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index de0b984b680e..f91f436a313b 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2076,6 +2076,9 @@ static int query_cpu_subfunc(S390FeatBitmap feature=
s)
     if (test_bit(S390_FEAT_MSA_EXT_9, features)) {
         s390_add_from_feat_block(features, S390_FEAT_TYPE_KDSA, prop.kds=
a);
     }
+    if (test_bit(S390_FEAT_ESORT_BASE, features)) {
+        s390_add_from_feat_block(features, S390_FEAT_TYPE_SORTL, prop.so=
rtl);
+    }
     return 0;
 }
=20
@@ -2123,6 +2126,9 @@ static int configure_cpu_subfunc(const S390FeatBitm=
ap features)
     if (test_bit(S390_FEAT_MSA_EXT_9, features)) {
         s390_fill_feat_block(features, S390_FEAT_TYPE_KDSA, prop.kdsa);
     }
+    if (test_bit(S390_FEAT_ESORT_BASE, features)) {
+        s390_fill_feat_block(features, S390_FEAT_TYPE_SORTL, prop.sortl)=
;
+    }
     return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
 }
=20
--=20
2.20.1



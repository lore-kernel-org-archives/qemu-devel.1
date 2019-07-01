Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF04FC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:22:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B7FF208E4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B7FF208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhuOB-0001vM-O0
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 07:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43418)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hhuK1-0006Wa-Ue
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:18:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hhuJw-0000hh-LS
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:18:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59153)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hhuJu-0000Lw-4h; Mon, 01 Jul 2019 07:18:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 56D7530832D8;
 Mon,  1 Jul 2019 11:17:43 +0000 (UTC)
Received: from localhost (ovpn-117-220.ams2.redhat.com [10.36.117.220])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E33F3176B2;
 Mon,  1 Jul 2019 11:17:42 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  1 Jul 2019 13:17:19 +0200
Message-Id: <20190701111722.32068-4-cohuck@redhat.com>
In-Reply-To: <20190701111722.32068-1-cohuck@redhat.com>
References: <20190701111722.32068-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 01 Jul 2019 11:17:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 3/6] s390x/cpumodel: Prepend KDSA features with
 "KDSA"
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
Cc: Janosch Frank <frankja@linux.ibm.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Let's handle it just like for other crypto features.

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu_features_def.inc.h | 30 ++++++++++++++---------------
 target/s390x/gen-features.c         | 30 ++++++++++++++---------------
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/target/s390x/cpu_features_def.inc.h b/target/s390x/cpu_featu=
res_def.inc.h
index 5dffff65fa5d..c20c780f2ea7 100644
--- a/target/s390x/cpu_features_def.inc.h
+++ b/target/s390x/cpu_features_def.inc.h
@@ -339,21 +339,21 @@ DEF_FEAT(KMA_GCM_EAES_192, "kma-gcm-eaes-192", KMA,=
 27, "KMA GCM-Encrypted-AES-1
 DEF_FEAT(KMA_GCM_EAES_256, "kma-gcm-eaes-256", KMA, 28, "KMA GCM-Encrypt=
ed-AES-256")
=20
 /* Features exposed via the KDSA instruction. */
-DEF_FEAT(ECDSA_VERIFY_P256, "kdsa-ecdsa-verify-p256", KDSA, 1, "KDSA ECD=
SA-Verify-P256")
-DEF_FEAT(ECDSA_VERIFY_P384, "kdsa-ecdsa-verify-p384", KDSA, 2, "KDSA ECD=
SA-Verify-P384")
-DEF_FEAT(ECDSA_VERIFY_P512, "kdsa-ecdsa-verify-p521", KDSA, 3, "KDSA ECD=
SA-Verify-P521")
-DEF_FEAT(ECDSA_SIGN_P256, "kdsa-ecdsa-sign-p256", KDSA, 9, "KDSA ECDSA-S=
ign-P256")
-DEF_FEAT(ECDSA_SIGN_P384, "kdsa-ecdsa-sign-p384", KDSA, 10, "KDSA ECDSA-=
Sign-P384")
-DEF_FEAT(ECDSA_SIGN_P512, "kdsa-ecdsa-sign-p521", KDSA, 11, "KDSA ECDSA-=
Sign-P521")
-DEF_FEAT(EECDSA_SIGN_P256, "kdsa-eecdsa-sign-p256", KDSA, 17, "KDSA Encr=
ypted-ECDSA-Sign-P256")
-DEF_FEAT(EECDSA_SIGN_P384, "kdsa-eecdsa-sign-p384", KDSA, 18, "KDSA Encr=
ypted-ECDSA-Sign-P384")
-DEF_FEAT(EECDSA_SIGN_P512, "kdsa-eecdsa-sign-p521", KDSA, 19, "KDSA Encr=
ypted-ECDSA-Sign-P521")
-DEF_FEAT(EDDSA_VERIFY_ED25519, "kdsa-eddsa-verify-ed25519", KDSA, 32, "K=
DSA EdDSA-Verify-Ed25519")
-DEF_FEAT(EDDSA_VERIFY_ED448, "kdsa-eddsa-verify-ed448", KDSA, 36, "KDSA =
EdDSA-Verify-Ed448")
-DEF_FEAT(EDDSA_SIGN_ED25519, "kdsa-eddsa-sign-ed25519", KDSA, 40, "KDSA =
EdDSA-Sign-Ed25519")
-DEF_FEAT(EDDSA_SIGN_ED448, "kdsa-eddsa-sign-ed448", KDSA, 44, "KDSA EdDS=
A-Sign-Ed448")
-DEF_FEAT(EEDDSA_SIGN_ED25519, "kdsa-eeddsa-sign-ed25519", KDSA, 48, "KDS=
A Encrypted-EdDSA-Sign-Ed25519")
-DEF_FEAT(EEDDSA_SIGN_ED448, "kdsa-eeddsa-sign-ed448", KDSA, 52, "KDSA En=
crypted-EdDSA-Sign-Ed448")
+DEF_FEAT(KDSA_ECDSA_VERIFY_P256, "kdsa-ecdsa-verify-p256", KDSA, 1, "KDS=
A ECDSA-Verify-P256")
+DEF_FEAT(KDSA_ECDSA_VERIFY_P384, "kdsa-ecdsa-verify-p384", KDSA, 2, "KDS=
A ECDSA-Verify-P384")
+DEF_FEAT(KDSA_ECDSA_VERIFY_P512, "kdsa-ecdsa-verify-p521", KDSA, 3, "KDS=
A ECDSA-Verify-P521")
+DEF_FEAT(KDSA_ECDSA_SIGN_P256, "kdsa-ecdsa-sign-p256", KDSA, 9, "KDSA EC=
DSA-Sign-P256")
+DEF_FEAT(KDSA_ECDSA_SIGN_P384, "kdsa-ecdsa-sign-p384", KDSA, 10, "KDSA E=
CDSA-Sign-P384")
+DEF_FEAT(KDSA_ECDSA_SIGN_P512, "kdsa-ecdsa-sign-p521", KDSA, 11, "KDSA E=
CDSA-Sign-P521")
+DEF_FEAT(KDSA_EECDSA_SIGN_P256, "kdsa-eecdsa-sign-p256", KDSA, 17, "KDSA=
 Encrypted-ECDSA-Sign-P256")
+DEF_FEAT(KDSA_EECDSA_SIGN_P384, "kdsa-eecdsa-sign-p384", KDSA, 18, "KDSA=
 Encrypted-ECDSA-Sign-P384")
+DEF_FEAT(KDSA_EECDSA_SIGN_P512, "kdsa-eecdsa-sign-p521", KDSA, 19, "KDSA=
 Encrypted-ECDSA-Sign-P521")
+DEF_FEAT(KDSA_EDDSA_VERIFY_ED25519, "kdsa-eddsa-verify-ed25519", KDSA, 3=
2, "KDSA EdDSA-Verify-Ed25519")
+DEF_FEAT(KDSA_EDDSA_VERIFY_ED448, "kdsa-eddsa-verify-ed448", KDSA, 36, "=
KDSA EdDSA-Verify-Ed448")
+DEF_FEAT(KDSA_EDDSA_SIGN_ED25519, "kdsa-eddsa-sign-ed25519", KDSA, 40, "=
KDSA EdDSA-Sign-Ed25519")
+DEF_FEAT(KDSA_EDDSA_SIGN_ED448, "kdsa-eddsa-sign-ed448", KDSA, 44, "KDSA=
 EdDSA-Sign-Ed448")
+DEF_FEAT(KDSA_EEDDSA_SIGN_ED25519, "kdsa-eeddsa-sign-ed25519", KDSA, 48,=
 "KDSA Encrypted-EdDSA-Sign-Ed25519")
+DEF_FEAT(KDSA_EEDDSA_SIGN_ED448, "kdsa-eeddsa-sign-ed448", KDSA, 52, "KD=
SA Encrypted-EdDSA-Sign-Ed448")
=20
 /* Features exposed via the SORTL instruction. */
 DEF_FEAT(SORTL_SFLR, "sortl-sflr", SORTL, 1, "SORTL SFLR")
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index dc320a06c271..af06be3e3b98 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -216,21 +216,21 @@
=20
 #define S390_FEAT_GROUP_MSA_EXT_9 \
     S390_FEAT_MSA_EXT_9, \
-    S390_FEAT_ECDSA_VERIFY_P256, \
-    S390_FEAT_ECDSA_VERIFY_P384, \
-    S390_FEAT_ECDSA_VERIFY_P512, \
-    S390_FEAT_ECDSA_SIGN_P256, \
-    S390_FEAT_ECDSA_SIGN_P384, \
-    S390_FEAT_ECDSA_SIGN_P512, \
-    S390_FEAT_EECDSA_SIGN_P256, \
-    S390_FEAT_EECDSA_SIGN_P384, \
-    S390_FEAT_EECDSA_SIGN_P512, \
-    S390_FEAT_EDDSA_VERIFY_ED25519, \
-    S390_FEAT_EDDSA_VERIFY_ED448, \
-    S390_FEAT_EDDSA_SIGN_ED25519, \
-    S390_FEAT_EDDSA_SIGN_ED448, \
-    S390_FEAT_EEDDSA_SIGN_ED25519, \
-    S390_FEAT_EEDDSA_SIGN_ED448, \
+    S390_FEAT_KDSA_ECDSA_VERIFY_P256, \
+    S390_FEAT_KDSA_ECDSA_VERIFY_P384, \
+    S390_FEAT_KDSA_ECDSA_VERIFY_P512, \
+    S390_FEAT_KDSA_ECDSA_SIGN_P256, \
+    S390_FEAT_KDSA_ECDSA_SIGN_P384, \
+    S390_FEAT_KDSA_ECDSA_SIGN_P512, \
+    S390_FEAT_KDSA_EECDSA_SIGN_P256, \
+    S390_FEAT_KDSA_EECDSA_SIGN_P384, \
+    S390_FEAT_KDSA_EECDSA_SIGN_P512, \
+    S390_FEAT_KDSA_EDDSA_VERIFY_ED25519, \
+    S390_FEAT_KDSA_EDDSA_VERIFY_ED448, \
+    S390_FEAT_KDSA_EDDSA_SIGN_ED25519, \
+    S390_FEAT_KDSA_EDDSA_SIGN_ED448, \
+    S390_FEAT_KDSA_EEDDSA_SIGN_ED25519, \
+    S390_FEAT_KDSA_EEDDSA_SIGN_ED448, \
     S390_FEAT_PCC_SCALAR_MULT_P256, \
     S390_FEAT_PCC_SCALAR_MULT_P384, \
     S390_FEAT_PCC_SCALAR_MULT_P512, \
--=20
2.20.1



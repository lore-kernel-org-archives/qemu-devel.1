Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012FFC4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:44:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA3CC218AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3CC218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAd4P-0004w8-JO
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 12:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50823)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iAbvf-0002BS-Vk
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:31:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iAbve-0000iA-Ol
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:31:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8889)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iAbvc-0000fH-OB; Wed, 18 Sep 2019 11:31:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 446A620F2;
 Wed, 18 Sep 2019 15:31:34 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-119.ams2.redhat.com [10.36.117.119])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3893062A8B;
 Wed, 18 Sep 2019 15:31:31 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 18 Sep 2019 17:29:13 +0200
Message-Id: <20190918152922.18949-21-david@redhat.com>
In-Reply-To: <20190918152922.18949-1-david@redhat.com>
References: <20190918152922.18949-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Wed, 18 Sep 2019 15:31:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL SUBSYSTEM s390x 20/29] s390x/tcg: MVCLU:
 Fault-safe handling
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
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The last remaining bit is padding with two bytes.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mem_helper.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index abb9d4d70c..853b9557cf 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -919,15 +919,17 @@ static inline uint32_t do_mvcl(CPUS390XState *env,
         access_memset(env, &desta, pad, ra);
         *dest =3D wrap_address(env, *dest + len);
     } else {
+        desta =3D access_prepare(env, *dest, len, MMU_DATA_STORE, mmu_id=
x, ra);
+
         /* The remaining length selects the padding byte. */
         for (i =3D 0; i < len; (*destlen)--, i++) {
             if (*destlen & 1) {
-                cpu_stb_data_ra(env, *dest, pad, ra);
+                access_set_byte(env, &desta, i, pad, ra);
             } else {
-                cpu_stb_data_ra(env, *dest, pad >> 8, ra);
+                access_set_byte(env, &desta, i, pad >> 8, ra);
             }
-            *dest =3D wrap_address(env, *dest + 1);
         }
+        *dest =3D wrap_address(env, *dest + len);
     }
=20
     return *destlen ? 3 : cc;
--=20
2.21.0



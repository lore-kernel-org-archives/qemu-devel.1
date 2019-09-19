Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E36C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:21:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B60F21924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B60F21924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAwMr-0004T8-Di
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 09:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iAvsf-0006je-PZ
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:49:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iAvkk-0008CD-C1
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:41:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45406)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1iAvkk-0008Ax-3c; Thu, 19 Sep 2019 08:41:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 61CEE307D923;
 Thu, 19 Sep 2019 12:41:41 +0000 (UTC)
Received: from localhost (dhcp-192-230.str.redhat.com [10.33.192.230])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A4C045D6B2;
 Thu, 19 Sep 2019 12:41:36 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Sep 2019 14:40:46 +0200
Message-Id: <20190919124115.11510-6-cohuck@redhat.com>
In-Reply-To: <20190919124115.11510-1-cohuck@redhat.com>
References: <20190919124115.11510-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 19 Sep 2019 12:41:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 05/34] s390x/tcg: MVC: Increment the length once
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
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Let's increment the length once.

While at it, cleanup the comment. The memset() example is given as a
programming note in the PoP, so drop the description.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mem_helper.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 58ab2e48e341..013e8d6045e7 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -320,16 +320,20 @@ static uint32_t do_helper_mvc(CPUS390XState *env, u=
int32_t l, uint64_t dest,
     HELPER_LOG("%s l %d dest %" PRIx64 " src %" PRIx64 "\n",
                __func__, l, dest, src);
=20
-    /* mvc and memmove do not behave the same when areas overlap! */
-    /* mvc with source pointing to the byte after the destination is the
-       same as memset with the first source byte */
+    /* MVC always copies one more byte than specified - maximum is 256 *=
/
+    l++;
+
+    /*
+     * "When the operands overlap, the result is obtained as if the oper=
ands
+     * were processed one byte at a time". Only non-destructive overlaps
+     * behave like memmove().
+     */
     if (dest =3D=3D src + 1) {
-        fast_memset(env, dest, cpu_ldub_data_ra(env, src, ra), l + 1, ra=
);
-    } else if (dest < src || src + l < dest) {
-        fast_memmove(env, dest, src, l + 1, ra);
+        fast_memset(env, dest, cpu_ldub_data_ra(env, src, ra), l, ra);
+    } else if (dest < src || src + l <=3D dest) {
+        fast_memmove(env, dest, src, l, ra);
     } else {
-        /* slow version with byte accesses which always work */
-        for (i =3D 0; i <=3D l; i++) {
+        for (i =3D 0; i < l; i++) {
             uint8_t x =3D cpu_ldub_data_ra(env, src + i, ra);
             cpu_stb_data_ra(env, dest + i, x, ra);
         }
--=20
2.20.1



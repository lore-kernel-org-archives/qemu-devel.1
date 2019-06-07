Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF6FC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:54:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 340802083D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:54:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 340802083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48368 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZG3c-0002ts-Js
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 10:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53053)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hZFhI-0003dc-GJ
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:18:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hZFhF-0003Wf-SH
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:18:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38430)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hZFhD-0003QW-6s; Fri, 07 Jun 2019 10:18:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AC01085376;
 Fri,  7 Jun 2019 14:18:17 +0000 (UTC)
Received: from localhost (dhcp-192-191.str.redhat.com [10.33.192.191])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1689178566;
 Fri,  7 Jun 2019 14:18:14 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  7 Jun 2019 16:17:05 +0200
Message-Id: <20190607141727.29018-13-cohuck@redhat.com>
In-Reply-To: <20190607141727.29018-1-cohuck@redhat.com>
References: <20190607141727.29018-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 07 Jun 2019 14:18:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 12/34] s390x/tcg: Export float_comp_to_cc()
 and float(32|64|128)_dcmask()
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

Vector floating-point instructions will require these functions, so
allow to use them from other files.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/fpu_helper.c | 4 ++--
 target/s390x/internal.h   | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
index 1be68bafea30..d2c17ed9421f 100644
--- a/target/s390x/fpu_helper.c
+++ b/target/s390x/fpu_helper.c
@@ -112,7 +112,7 @@ static void handle_exceptions(CPUS390XState *env, boo=
l XxC, uintptr_t retaddr)
     }
 }
=20
-static inline int float_comp_to_cc(CPUS390XState *env, int float_compare=
)
+int float_comp_to_cc(CPUS390XState *env, int float_compare)
 {
     S390CPU *cpu =3D s390_env_get_cpu(env);
=20
@@ -746,7 +746,7 @@ static inline uint16_t dcmask(int bit, bool neg)
 }
=20
 #define DEF_FLOAT_DCMASK(_TYPE) \
-static uint16_t _TYPE##_dcmask(CPUS390XState *env, _TYPE f1)       \
+uint16_t _TYPE##_dcmask(CPUS390XState *env, _TYPE f1)              \
 {                                                                  \
     const bool neg =3D _TYPE##_is_neg(f1);                           \
                                                                    \
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index 9893fc094bd6..c243fa725b36 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -285,6 +285,10 @@ uint32_t set_cc_nz_f128(float128 v);
 uint8_t s390_softfloat_exc_to_ieee(unsigned int exc);
 int s390_swap_bfp_rounding_mode(CPUS390XState *env, int m3);
 void s390_restore_bfp_rounding_mode(CPUS390XState *env, int old_mode);
+int float_comp_to_cc(CPUS390XState *env, int float_compare);
+uint16_t float32_dcmask(CPUS390XState *env, float32 f1);
+uint16_t float64_dcmask(CPUS390XState *env, float64 f1);
+uint16_t float128_dcmask(CPUS390XState *env, float128 f1);
=20
=20
 /* gdbstub.c */
--=20
2.20.1



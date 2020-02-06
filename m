Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421AFC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 22:50:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0422F21927
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 22:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+wnx4PZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0422F21927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izpyB-0002dB-8U
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 17:49:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59942)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izpxM-0001aw-Q7
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 17:49:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izpxL-0006oF-Sl
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 17:49:08 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53925
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izpxL-0006nh-PA
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 17:49:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581029347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qYf/Ojw8DoD3PTNFTI9fXiekKBI4qRmD7q/QCymONSA=;
 b=W+wnx4PZhrKor5BH/R9K55fF5JWCKzFpMqz4+S+hog5TMq4wYidNwtA9MwVmCqw48mNL8f
 9QXmcFclxqt3QuMbhIIdYzj2My6+WRlKR3BhPrayTV0ADwb9hAzNz3PiciMsyFM1Mh0Zd6
 VujGB2NlibnhvbRchUjRiOSOORZHheY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-2d9xMeajOo6yCIon5SB78g-1; Thu, 06 Feb 2020 17:49:05 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90CB6800EB2;
 Thu,  6 Feb 2020 22:49:04 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-120.brq.redhat.com [10.40.204.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 651FF87B1C;
 Thu,  6 Feb 2020 22:49:00 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Andrew Jones <drjones@redhat.com>
Subject: [PATCH] docs/arm-cpu-features: Make kvm-no-adjvtime comment clearer
Date: Thu,  6 Feb 2020 23:48:58 +0100
Message-Id: <20200206224858.23184-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 2d9xMeajOo6yCIon5SB78g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The bold text sounds like 'knock knock'. Only bolding the
second 'not' makes it easier to read.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 docs/arm-cpu-features.rst | 2 +-
 target/arm/kvm.c          | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/docs/arm-cpu-features.rst b/docs/arm-cpu-features.rst
index dbf3b7cf42..fc1623aeca 100644
--- a/docs/arm-cpu-features.rst
+++ b/docs/arm-cpu-features.rst
@@ -185,7 +185,7 @@ the list of KVM VCPU features and their descriptions.
=20
   kvm-no-adjvtime          By default kvm-no-adjvtime is disabled.  This
                            means that by default the virtual time
-                           adjustment is enabled (vtime is *not not*
+                           adjustment is enabled (vtime is not *not*
                            adjusted).
=20
                            When virtual time adjustment is enabled each
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 85860e6f95..bcca8c8029 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -194,10 +194,7 @@ static void kvm_no_adjvtime_set(Object *obj, bool valu=
e, Error **errp)
 /* KVM VCPU properties should be prefixed with "kvm-". */
 void kvm_arm_add_vcpu_properties(Object *obj)
 {
-    if (!kvm_enabled()) {
-        return;
-    }
-
+    assert(kvm_enabled());
     ARM_CPU(obj)->kvm_adjvtime =3D true;
     object_property_add_bool(obj, "kvm-no-adjvtime", kvm_no_adjvtime_get,
                              kvm_no_adjvtime_set, &error_abort);
--=20
2.21.1



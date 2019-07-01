Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B36C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:33:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A702089C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A702089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhuYN-0005Tp-UG
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 07:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43520)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hhuKA-0006Yr-B1
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:18:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hhuK8-0000wF-MK
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:18:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40260)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hhuK3-0000UW-Pj; Mon, 01 Jul 2019 07:18:13 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7D6AC3082E3F;
 Mon,  1 Jul 2019 11:17:53 +0000 (UTC)
Received: from localhost (ovpn-117-220.ams2.redhat.com [10.36.117.220])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D0E119C6F;
 Mon,  1 Jul 2019 11:17:52 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  1 Jul 2019 13:17:22 +0200
Message-Id: <20190701111722.32068-7-cohuck@redhat.com>
In-Reply-To: <20190701111722.32068-1-cohuck@redhat.com>
References: <20190701111722.32068-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Mon, 01 Jul 2019 11:17:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 6/6] s390x: add cpu feature/model files to KVM
 section
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
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The cpu features/models are not only relevant for TCG, but
also for KVM. Make sure that the KVM maintainers are cc:ed
on patches as well.

Message-Id: <20190626130820.12290-1-cohuck@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cad58b948791..d9b6c129076a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -383,6 +383,8 @@ F: target/s390x/kvm-stub.c
 F: target/s390x/ioinst.[ch]
 F: target/s390x/machine.c
 F: target/s390x/sigp.c
+F: target/s390x/cpu_features*.[ch]
+F: target/s390x/cpu_models.[ch]
 F: hw/intc/s390_flic.c
 F: hw/intc/s390_flic_kvm.c
 F: include/hw/s390x/s390_flic.h
--=20
2.20.1



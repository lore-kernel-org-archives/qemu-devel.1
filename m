Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231D1C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 18:51:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE35B208C2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 18:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE35B208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i332L-0003Ge-Q2
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 14:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33368)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1i32sO-0002JR-57
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 14:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1i32sM-0003bt-67
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 14:41:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45580)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1i32sK-0003aZ-4G
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 14:40:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5D9FF20260;
 Wed, 28 Aug 2019 18:40:55 +0000 (UTC)
Received: from localhost (ovpn-116-60.gru2.redhat.com [10.97.116.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 95AE95C1D6;
 Wed, 28 Aug 2019 18:40:52 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <rth@twiddle.net>,
 Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Aug 2019 15:40:21 -0300
Message-Id: <20190828184026.5840-8-ehabkost@redhat.com>
In-Reply-To: <20190828184026.5840-1-ehabkost@redhat.com>
References: <20190828184026.5840-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Wed, 28 Aug 2019 18:40:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v6 07/12] pc: Fix error message on die-id
 validation
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
Cc: "Vanderson M . do Rosario" <vandersonmr2@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The error message for die-id range validation is incorrect.  Example:

  $ qemu-system-x86_64 -smp 1,sockets=3D6,maxcpus=3D6 \
    -device qemu64-x86_64-cpu,socket-id=3D1,die-id=3D1,core-id=3D0,thread=
-id=3D0
  qemu-system-x86_64: -device qemu64-x86_64-cpu,socket-id=3D1,die-id=3D1,=
core-id=3D0,thread-id=3D0: \
    Invalid CPU die-id: 1 must be in range 0:5

The actual range for die-id in this example is 0:0.

Fix the error message to use smp_dies and print the correct range.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20190815183803.13346-2-ehabkost@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/pc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 985e9261b0..584cd3ed0a 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2430,7 +2430,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug=
_dev,
             return;
         } else if (cpu->die_id > pcms->smp_dies - 1) {
             error_setg(errp, "Invalid CPU die-id: %u must be in range 0:=
%u",
-                       cpu->die_id, max_socket);
+                       cpu->die_id, pcms->smp_dies - 1);
             return;
         }
         if (cpu->core_id < 0) {
--=20
2.21.0



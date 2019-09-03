Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BFCC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:38:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 368CF2087E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368CF2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5GVL-00039Q-Ob
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 17:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1i5FwW-0004J0-Hj
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:02:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1i5FwV-0001KQ-Aa
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:02:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52420)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1i5FwU-0001JM-VL
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:02:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2E5411056FB1;
 Tue,  3 Sep 2019 21:02:22 +0000 (UTC)
Received: from localhost (ovpn-116-55.gru2.redhat.com [10.97.116.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7229E5DAAD;
 Tue,  3 Sep 2019 21:02:19 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <rth@twiddle.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 18:01:55 -0300
Message-Id: <20190903210201.14627-8-ehabkost@redhat.com>
In-Reply-To: <20190903210201.14627-1-ehabkost@redhat.com>
References: <20190903210201.14627-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Tue, 03 Sep 2019 21:02:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 07/13] pc: Improve error message when die-id
 is omitted
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

The error message when die-id is omitted doesn't make sense:

  $ qemu-system-x86_64 -smp 1,sockets=3D6,maxcpus=3D6 \
    -device qemu64-x86_64-cpu,socket-id=3D1,core-id=3D0,thread-id=3D0
  qemu-system-x86_64: -device qemu64-x86_64-cpu,socket-id=3D1,core-id=3D0=
,thread-id=3D0: \
    Invalid CPU die-id: 4294967295 must be in range 0:0

Fix it, so it will now read:

  qemu-system-x86_64: -device qemu64-x86_64-cpu,socket-id=3D1,core-id=3D0=
,thread-id=3D0: \
    CPU die-id is not set

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20190815183803.13346-3-ehabkost@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/pc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 584cd3ed0a..3494423d63 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2428,6 +2428,10 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplu=
g_dev,
             error_setg(errp, "Invalid CPU socket-id: %u must be in range=
 0:%u",
                        cpu->socket_id, max_socket);
             return;
+        }
+        if (cpu->die_id < 0) {
+            error_setg(errp, "CPU die-id is not set");
+            return;
         } else if (cpu->die_id > pcms->smp_dies - 1) {
             error_setg(errp, "Invalid CPU die-id: %u must be in range 0:=
%u",
                        cpu->die_id, pcms->smp_dies - 1);
--=20
2.21.0



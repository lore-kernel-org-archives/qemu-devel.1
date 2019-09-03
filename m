Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA23C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:40:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C5672087E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C5672087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5GXM-0005Xe-6C
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 17:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1i5FwZ-0004Ly-RS
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:02:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1i5FwY-0001PT-R6
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:02:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58796)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1i5FwY-0001Oo-Lz
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:02:26 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DCEA410F23F4;
 Tue,  3 Sep 2019 21:02:25 +0000 (UTC)
Received: from localhost (ovpn-116-55.gru2.redhat.com [10.97.116.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F08060BE2;
 Tue,  3 Sep 2019 21:02:25 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <rth@twiddle.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 18:01:57 -0300
Message-Id: <20190903210201.14627-10-ehabkost@redhat.com>
In-Reply-To: <20190903210201.14627-1-ehabkost@redhat.com>
References: <20190903210201.14627-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Tue, 03 Sep 2019 21:02:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 09/13] qapi: report the default CPU type for
 each machine
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

When user doesn't request any explicit CPU model with libvirt or QEMU,
a machine type specific CPU model is picked. Currently there is no way
to determine what this QEMU built-in default is, so libvirt cannot
report this back to the user in the XML config.

This extends the "query-machines" QMP command so that it reports the
default CPU model typename for each machine.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20190822100412.23746-1-berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qapi/machine.json          | 5 ++++-
 hw/core/machine-qmp-cmds.c | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index de5c742d72..ca26779f1a 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -348,13 +348,16 @@
 #              in future versions of QEMU according to the QEMU deprecat=
ion
 #              policy (since 4.1.0)
 #
+# @default-cpu-type: default CPU model typename if none is requested via
+#                    the -cpu argument. (since 4.2)
+#
 # Since: 1.2.0
 ##
 { 'struct': 'MachineInfo',
   'data': { 'name': 'str', '*alias': 'str',
             '*is-default': 'bool', 'cpu-max': 'int',
             'hotpluggable-cpus': 'bool',  'numa-mem-supported': 'bool',
-            'deprecated': 'bool' } }
+            'deprecated': 'bool', '*default-cpu-type': 'str' } }
=20
 ##
 # @query-machines:
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 15cf7c62e3..eed5aeb2f7 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -230,6 +230,10 @@ MachineInfoList *qmp_query_machines(Error **errp)
         info->hotpluggable_cpus =3D mc->has_hotpluggable_cpus;
         info->numa_mem_supported =3D mc->numa_mem_supported;
         info->deprecated =3D !!mc->deprecation_reason;
+        if (mc->default_cpu_type) {
+            info->default_cpu_type =3D g_strdup(mc->default_cpu_type);
+            info->has_default_cpu_type =3D true;
+        }
=20
         entry =3D g_malloc0(sizeof(*entry));
         entry->value =3D info;
--=20
2.21.0



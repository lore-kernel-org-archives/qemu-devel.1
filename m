Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EFAC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:41:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AD1120659
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:41:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD1120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHqgS-0005q4-DL
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 10:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51144)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iHqa8-0006gB-TO
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:35:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iHqa7-0004eC-Nj
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:35:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39716)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iHqa7-0004dZ-HW
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:35:19 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C3A7580F6D
 for <qemu-devel@nongnu.org>; Tue,  8 Oct 2019 14:35:18 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-43.brq.redhat.com [10.40.204.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C337710013A1;
 Tue,  8 Oct 2019 14:35:11 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 8/8] hw/misc/vmcoreinfo: Add comment about reset handler
Date: Tue,  8 Oct 2019 16:34:55 +0200
Message-Id: <20191008143455.8524-1-philmd@redhat.com>
In-Reply-To: <20191008142539.7793-1-philmd@redhat.com>
References: <20191008142539.7793-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 08 Oct 2019 14:35:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The VM coreinfo device does not sit on a bus, so it won't be
reset automatically. This is why it calls qemu_register_reset().

Add a comment about it, so we don't convert its reset handler
to a DeviceReset method.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/misc/vmcoreinfo.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
index 326a3ce8f4..a9d718fc23 100644
--- a/hw/misc/vmcoreinfo.c
+++ b/hw/misc/vmcoreinfo.c
@@ -61,6 +61,10 @@ static void vmcoreinfo_realize(DeviceState *dev, Error=
 **errp)
                              NULL, fw_cfg_vmci_write, s,
                              &s->vmcoreinfo, sizeof(s->vmcoreinfo), fals=
e);
=20
+    /*
+     * This device requires to register a global reset because it is
+     * not plugged to a bus (which, as its QOM parent, would reset it).
+     */
     qemu_register_reset(vmcoreinfo_reset, dev);
     vmcoreinfo_state =3D s;
 }
--=20
2.21.0



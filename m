Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880ACC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 11:12:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5987F20863
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 11:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5987F20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51224 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDSCh-0003EX-M6
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 07:12:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDS9b-0000wk-L5
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:09:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDS9a-0001mw-2r
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:09:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hDS9Z-0001lx-R6
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:09:30 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7DC22249;
	Mon,  8 Apr 2019 11:09:28 +0000 (UTC)
Received: from thuth.com (ovpn-116-50.ams2.redhat.com [10.36.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2CB58177B6;
	Mon,  8 Apr 2019 11:09:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Mon,  8 Apr 2019 13:09:19 +0200
Message-Id: <20190408110920.30119-3-thuth@redhat.com>
In-Reply-To: <20190408110920.30119-1-thuth@redhat.com>
References: <20190408110920.30119-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Mon, 08 Apr 2019 11:09:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/3] tests/libqos: fix usage of bool in
 pci-spapr.c
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Jafar Abdi <cafer.abdi@gmail.com>, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408110919.gObEytj3FaTiP-dLuIieJ5lqTvclYkUmP0VgA9PyEI0@z>

From: Jafar Abdi <cafer.abdi@gmail.com>

Clean up wrong usage of FALSE and TRUE in places that use "bool" from std=
bool.h.

FALSE and TRUE (with capital letters) are the constants defined by glib f=
or
being used with the "gboolean" type of glib. But some parts of the code a=
lso use
TRUE and FALSE for variables that are declared as "bool" (the type from <=
stdbool.h>).

Signed-off-by: Jafar Abdi <cafer.abdi@gmail.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <1553351197-14581-4-git-send-email-cafer.abdi@gmail.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/libqos/pci-spapr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/libqos/pci-spapr.c b/tests/libqos/pci-spapr.c
index 6925925997..58ba27ae6d 100644
--- a/tests/libqos/pci-spapr.c
+++ b/tests/libqos/pci-spapr.c
@@ -156,7 +156,7 @@ void qpci_init_spapr(QPCIBusSPAPR *qpci, QTestState *=
qts,
     assert(qts);
=20
     /* tests cannot use spapr, needs to be fixed first */
-    qpci->bus.has_buggy_msi =3D TRUE;
+    qpci->bus.has_buggy_msi =3D true;
=20
     qpci->alloc =3D alloc;
=20
--=20
2.21.0



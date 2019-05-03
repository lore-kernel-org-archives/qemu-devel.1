Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53EAC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 00:52:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB742075E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 00:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB742075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60591 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMMQi-0003fa-I0
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 20:52:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMHC-0003tX-1T
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMHA-0006vI-7f
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hMMHA-0006v6-2b
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 647DD81F13;
	Fri,  3 May 2019 00:42:07 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E67E3183C0;
	Fri,  3 May 2019 00:42:06 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	Cleber Rosa <crosa@redhat.com>
Date: Thu,  2 May 2019 21:41:21 -0300
Message-Id: <20190503004130.8285-11-ehabkost@redhat.com>
In-Reply-To: <20190503004130.8285-1-ehabkost@redhat.com>
References: <20190503004130.8285-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Fri, 03 May 2019 00:42:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 10/19] tests/boot_linux_console: increase timeout
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503004121.q7ilcUF4TUICvDuIOOR8VxknxVjOUILWwvaTVJrQXFA@z>

From: Cleber Rosa <crosa@redhat.com>

When running on very low powered environments, some tests may time out
causing false negatives.  As a conservative change, and for
considering that human time (investigating false negatives) is worth
more than some extra machine cycles (and time), let's increase the
overall timeout.

CC: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20190312171824.5134-11-crosa@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
index a94f5cd2c8..bfcae3771b 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -19,7 +19,7 @@ class BootLinuxConsole(Test):
     kernel command line is properly passed from QEMU to the kernel
     """
=20
-    timeout =3D 60
+    timeout =3D 90
=20
     KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
=20
--=20
2.18.0.rc1.1.g3f1ff2140



Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE5BC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 12:58:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 308D320879
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 12:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308D320879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35642 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTnJA-0005di-Dj
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 08:58:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hTnGz-0003xa-CX
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hTn5M-0002gv-Eg
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:44:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hTn5M-0002ex-A0; Thu, 23 May 2019 08:44:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8FD2D300414E;
	Thu, 23 May 2019 12:44:39 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5234A67C9B;
	Thu, 23 May 2019 12:44:36 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 14:43:15 +0200
Message-Id: <20190523124320.28726-11-philmd@redhat.com>
In-Reply-To: <20190523124320.28726-1-philmd@redhat.com>
References: <20190523124320.28726-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Thu, 23 May 2019 12:44:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 10/15] tests/fw_cfg: Free QFWCFG object after
 qtest has run
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
	Li Qiang <liq3ea@163.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We allocate the QFWCFG object previous to run the qtests,
free it once we are finished.

Signed-off-by: Li Qiang <liq3ea@163.com>
Message-Id: <20190424140643.62457-2-liq3ea@163.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
[PMD: Split patch, fill commit description]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
---
 tests/fw_cfg-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
index 1c5103fe1c..a370ad5667 100644
--- a/tests/fw_cfg-test.c
+++ b/tests/fw_cfg-test.c
@@ -128,6 +128,7 @@ int main(int argc, char **argv)
=20
     ret =3D g_test_run();
=20
+    pc_fw_cfg_uninit(fw_cfg);
     qtest_quit(s);
=20
     return ret;
--=20
2.20.1



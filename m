Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A7BC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 12:38:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB14320731
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 12:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="URb68Cyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB14320731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioReZ-0005TI-0j
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 07:38:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1ioRdv-00050J-DS
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 07:38:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1ioRds-0000D8-OX
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 07:37:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38985
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ioRds-0000CV-Jy
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 07:37:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578314275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zL00mHF/8Uu5d7EV2Y3D3nzt3So8ezNEsPnrlK61Oq0=;
 b=URb68Cyb6U3FUeNImqLYw5hQJgPqcNKVrAqxcy/PiIvKuBSC0FBxXLvha4e1jJnfMNEFAH
 ZuPDVq69UQMbIVoWFzWhg5XZSncLrbmyJMBFaHyhLUnMcRUChQW4koO2YBO/pugqXXj6pv
 IuY/S9moTUVAh37nXzaRei4hay9vQ9w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-a-mnHyL3OnygA2qlGJ96TQ-1; Mon, 06 Jan 2020 07:37:54 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 970D9DBE6;
 Mon,  6 Jan 2020 12:37:52 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-98.ams2.redhat.com
 [10.36.116.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 45A0F858A6;
 Mon,  6 Jan 2020 12:37:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 47E8D48E0; Mon,  6 Jan 2020 13:37:46 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] freebsd: use python37
Date: Mon,  6 Jan 2020 13:37:46 +0100
Message-Id: <20200106123746.18201-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: a-mnHyL3OnygA2qlGJ96TQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

FreeBSD seems to use python37 by default now, which breaks the build
script.  Add python to the package list, to explicitly pick the version,
and also adapt the configure command line.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 tests/vm/freebsd | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 1825cc58218b..33a736298a9a 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -32,6 +32,7 @@ class FreeBSDVM(basevm.BaseVM):
         "git",
         "pkgconf",
         "bzip2",
+        "python37",
=20
         # gnu tools
         "bash",
@@ -63,7 +64,7 @@ class FreeBSDVM(basevm.BaseVM):
         mkdir src build; cd src;
         tar -xf /dev/vtbd1;
         cd ../build
-        ../src/configure --python=3Dpython3.6 {configure_opts};
+        ../src/configure --python=3Dpython3.7 {configure_opts};
         gmake --output-sync -j{jobs} {target} {verbose};
     """
=20
--=20
2.18.1



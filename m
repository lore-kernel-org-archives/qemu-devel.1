Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1704AC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 11:02:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE63621920
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 11:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE63621920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFFvl-0003VN-1A
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 07:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iFFuG-0002wP-50
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 07:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iFFuE-0005FS-PG
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 07:01:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44784)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1iFFuE-0005Er-Jk; Tue, 01 Oct 2019 07:01:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 51848309321D;
 Tue,  1 Oct 2019 11:01:21 +0000 (UTC)
Received: from thuth.com (ovpn-116-70.ams2.redhat.com [10.36.116.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E88A75D6D0;
 Tue,  1 Oct 2019 11:01:14 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: [PATCH] qemu-doc: Remove paragraph about requiring a HD image with
 -kernel
Date: Tue,  1 Oct 2019 13:01:11 +0200
Message-Id: <20191001110111.4870-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 01 Oct 2019 11:01:21 +0000 (UTC)
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
Cc: qemu-trivial@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The need for specifying "-hda" together with "-kernel" has been removed in
commit 57a46d057995 ("Convert linux bootrom to external rom and fw_cfg"),
almost 10 years ago, so let's remove this description from our documentation
now, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qemu-doc.texi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 2ba6c90c08..3c5022050f 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -906,10 +906,6 @@ Use @option{-kernel} to provide the Linux kernel image and
 @option{-append} to give the kernel command line arguments. The
 @option{-initrd} option can be used to provide an INITRD image.
 
-When using the direct Linux boot, a disk image for the first hard disk
-@file{hda} is required because its boot sector is used to launch the
-Linux kernel.
-
 If you do not need graphical output, you can disable it and redirect
 the virtual serial port and the QEMU monitor to the console with the
 @option{-nographic} option. The typical command line is:
-- 
2.18.1



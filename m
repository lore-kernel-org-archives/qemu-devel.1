Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAF7C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 05:43:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EF34217F4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 05:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF34217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=weilnetz.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35611 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDjY3-0007H1-JC
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 01:43:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1hDjXF-0006xL-K7
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 01:43:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1hDjXE-0002Ix-O0
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 01:43:05 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:42706
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>)
	id 1hDjXE-0002Id-Fg; Tue, 09 Apr 2019 01:43:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by v2201612906741603.powersrv.de (Postfix) with ESMTP id 524A6DB6058;
	Tue,  9 Apr 2019 07:33:47 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at v2201612906741603.powersrv.de
Received: from v2201612906741603.powersrv.de ([127.0.0.1])
	by localhost (v2201612906741603.powersrv.de [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id zRAv7lYHggYD; Tue,  9 Apr 2019 07:33:46 +0200 (CEST)
Received: from qemu.weilnetz.de (qemu.weilnetz.de [188.68.58.204])
	by v2201612906741603.powersrv.de (Postfix) with ESMTP id 05A26DB6050;
	Tue,  9 Apr 2019 07:33:45 +0200 (CEST)
Received: by qemu.weilnetz.de (Postfix, from userid 1000)
	id 45A6646000F; Tue,  9 Apr 2019 07:33:45 +0200 (CEST)
From: Stefan Weil <sw@weilnetz.de>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
	Igor Mammedov <imammedo@redhat.com>
Date: Tue,  9 Apr 2019 07:33:20 +0200
Message-Id: <20190409053320.14612-1-sw@weilnetz.de>
X-Mailer: git-send-email 2.11.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 37.120.169.71
Subject: [Qemu-devel] [PATCH] Update configure
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
Cc: Stefan Weil <sw@weilnetz.de>, Gerd Hoffmann <kraxel@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190409053320.AD88K8HrnGKxtAkNVg6ywHQFMquahe63ZRoLRXMMH84@z>

The last *.aml file was removed in commit 13b1881aacc7e5018773bd545bbaf8d5476699ee.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---
 configure | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configure b/configure
index 1c563a7027..9c5d9a8c96 100755
--- a/configure
+++ b/configure
@@ -7886,7 +7886,6 @@ LINKS="$LINKS python"
 for bios_file in \
     $source_path/pc-bios/*.bin \
     $source_path/pc-bios/*.lid \
-    $source_path/pc-bios/*.aml \
     $source_path/pc-bios/*.rom \
     $source_path/pc-bios/*.dtb \
     $source_path/pc-bios/*.img \
-- 
2.11.0



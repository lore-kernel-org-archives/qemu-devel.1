Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B14FC352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:58:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D567320815
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D567320815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFTu2-0002yi-9i
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 21:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iFS05-0000mk-6H
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:56:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iFS03-00025s-TR
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:56:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53524)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iFS01-00020p-1z; Tue, 01 Oct 2019 19:56:09 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 325253058E0A;
 Tue,  1 Oct 2019 23:56:08 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-165.bos.redhat.com [10.18.17.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 642C460C80;
 Tue,  1 Oct 2019 23:56:06 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 1/8] block: Refactor macros - fix tabbing
Date: Tue,  1 Oct 2019 19:55:45 -0400
Message-Id: <20191001235552.17790-2-jsnow@redhat.com>
In-Reply-To: <20191001235552.17790-1-jsnow@redhat.com>
References: <20191001235552.17790-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 01 Oct 2019 23:56:08 +0000 (UTC)
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Arbel Moshe <arbel.moshe@oracle.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Sam Eiderman <shmuel.eiderman@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Karl Heubaum <karl.heubaum@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sam Eiderman <shmuel.eiderman@oracle.com>

Fixing tabbing in block related macros.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
Message-id: 20190925110639.100699-2-sameid@google.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 include/hw/block/block.h | 16 ++++++++--------
 hw/ide/qdev.c            |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index 607539057a..fd55a30bca 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -50,21 +50,21 @@ static inline unsigned int get_physical_block_exp(Blo=
ckConf *conf)
                           _conf.logical_block_size),                    =
\
     DEFINE_PROP_BLOCKSIZE("physical_block_size", _state,                =
\
                           _conf.physical_block_size),                   =
\
-    DEFINE_PROP_UINT16("min_io_size", _state, _conf.min_io_size, 0),  \
+    DEFINE_PROP_UINT16("min_io_size", _state, _conf.min_io_size, 0),    =
\
     DEFINE_PROP_UINT32("opt_io_size", _state, _conf.opt_io_size, 0),    =
\
-    DEFINE_PROP_UINT32("discard_granularity", _state, \
-                       _conf.discard_granularity, -1), \
-    DEFINE_PROP_ON_OFF_AUTO("write-cache", _state, _conf.wce, \
-                            ON_OFF_AUTO_AUTO), \
+    DEFINE_PROP_UINT32("discard_granularity", _state,                   =
\
+                       _conf.discard_granularity, -1),                  =
\
+    DEFINE_PROP_ON_OFF_AUTO("write-cache", _state, _conf.wce,           =
\
+                            ON_OFF_AUTO_AUTO),                          =
\
     DEFINE_PROP_BOOL("share-rw", _state, _conf.share_rw, false)
=20
 #define DEFINE_BLOCK_PROPERTIES(_state, _conf)                          =
\
     DEFINE_PROP_DRIVE("drive", _state, _conf.blk),                      =
\
     DEFINE_BLOCK_PROPERTIES_BASE(_state, _conf)
=20
-#define DEFINE_BLOCK_CHS_PROPERTIES(_state, _conf)      \
-    DEFINE_PROP_UINT32("cyls", _state, _conf.cyls, 0),  \
-    DEFINE_PROP_UINT32("heads", _state, _conf.heads, 0), \
+#define DEFINE_BLOCK_CHS_PROPERTIES(_state, _conf)                      =
\
+    DEFINE_PROP_UINT32("cyls", _state, _conf.cyls, 0),                  =
\
+    DEFINE_PROP_UINT32("heads", _state, _conf.heads, 0),                =
\
     DEFINE_PROP_UINT32("secs", _state, _conf.secs, 0)
=20
 #define DEFINE_BLOCK_ERROR_PROPERTIES(_state, _conf)                    =
\
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 6fba6b62b8..6dd219944f 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -290,7 +290,7 @@ static void ide_drive_realize(IDEDevice *dev, Error *=
*errp)
     DEFINE_BLOCK_PROPERTIES(IDEDrive, dev.conf),        \
     DEFINE_BLOCK_ERROR_PROPERTIES(IDEDrive, dev.conf),  \
     DEFINE_PROP_STRING("ver",  IDEDrive, dev.version),  \
-    DEFINE_PROP_UINT64("wwn",  IDEDrive, dev.wwn, 0),    \
+    DEFINE_PROP_UINT64("wwn",  IDEDrive, dev.wwn, 0),   \
     DEFINE_PROP_STRING("serial",  IDEDrive, dev.serial),\
     DEFINE_PROP_STRING("model", IDEDrive, dev.model)
=20
--=20
2.21.0



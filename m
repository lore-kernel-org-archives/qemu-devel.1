Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D33C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 08:29:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E63A82053B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 08:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="DDwDhD0Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E63A82053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Wr4-0001Dx-W7
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 04:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36618)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <30OhkXQYKCicVDPHLGJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--sameid.bounces.google.com>)
 id 1i2WmY-0004cH-O4
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:24:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <30OhkXQYKCicVDPHLGJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--sameid.bounces.google.com>)
 id 1i2WmX-0007li-JP
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:24:50 -0400
Received: from mail-yw1-xc49.google.com ([2607:f8b0:4864:20::c49]:53639)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <30OhkXQYKCicVDPHLGJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--sameid.bounces.google.com>)
 id 1i2WmX-0007lU-EO
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:24:49 -0400
Received: by mail-yw1-xc49.google.com with SMTP id c199so14467415ywb.20
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 01:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=mnC+MT0EWE3I8fOBTcQ2N9AqdBzn+92Zu9jnhpTsMuE=;
 b=DDwDhD0YXeUSFsn3sVNu1s5mqtuPZDRWp00A0WqIe54ydnAgjidn6NHQ6wfVXF4lR7
 qy5XFJjXfSoVEBYNtqX11NUJ42TAdCEWU6QmnSR91uoAuIQxlw1m+P99pHxXYWz1CiPX
 ofaqwn3E7ZDLhjR9lbUhoolTXTwPww+bd4QAMkcsc8GOuGIMci1j7aQdYH4wGRW+V7QC
 Zqzp6NVtFHI1oRNnLibPEPegukvPMyNxWZAUis7bF/daQRqRzo49YjhLQgBUhQ7I2hPU
 ieIRGQl9XKDG/Gy+hUisHZqGdpP/vrH2sJpwz8xE8YpveE+WJrll/gxm2APmRxQ2d6Lk
 ieQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=mnC+MT0EWE3I8fOBTcQ2N9AqdBzn+92Zu9jnhpTsMuE=;
 b=JJpqVylKUwaTZTFJGx0U1AS2+uv2PrQ4V1Q32jAVtwd0BKcUJCt4xaXsczDrMEwmuw
 fU4rMRTWHUHi4mYIvls/xNHhhO4Udi/hVJKdyhc9Kgit77lbh5GcSpetKmLrgsY27hQ7
 NuNVbpaNXKk0gOkGvjoZWLfcehAiYTcYydsLnYvLSUsUNk1A5ukJS5KSMlTfGzRDkSCi
 JWJx8I+UYhjQQLomBI4zr9JakKb9ukQB4VN2yd98BsRbVAg7YDvnEETYosjPGii3REFQ
 +4oytM7fNS1Qr3oZ96ZY/cQ2GHcKSPrVSlukVUqwnKs6cI2Um5Gc0ROrXLV0v53/j5tN
 pw8w==
X-Gm-Message-State: APjAAAU2+QJBipjiiY/+1tjpKIz7u1JBIwsigNJsa4DdfHnykkLmh3ys
 /0BqfbyEjyXdAHLxgX3BCyDE92XYOJzYI13FV/siS14rkOM+pUQehvP9aTn6ZF3VG0Yaoh6rJlM
 k7+qbIQIuOrXLIS5qnZa6ZPNQLE1IOvMpk5qD7gSqhKaoujWI67MuMYn2a+Cz
X-Google-Smtp-Source: APXvYqzi8ekgmecfMPl2IqzfpRITXbSbqWc/XSUvBl6sfHg569OeKCapBtkMaAhRQX3Xj5AwjED0Uodh0vA=
X-Received: by 2002:a25:768c:: with SMTP id r134mr15316699ybc.32.1566894288527; 
 Tue, 27 Aug 2019 01:24:48 -0700 (PDT)
Date: Tue, 27 Aug 2019 11:24:20 +0300
In-Reply-To: <20190827082427.64280-1-sameid@google.com>
Message-Id: <20190827082427.64280-2-sameid@google.com>
Mime-Version: 1.0
References: <20190827082427.64280-1-sameid@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c49
Subject: [Qemu-devel] [PATCH v6 1/8] block: Refactor macros - fix tabbing
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
From: Sam Eiderman via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Sam Eiderman <sameid@google.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org,
 Arbel Moshe <arbel.moshe@oracle.com>, seabios@seabios.org, kevin@koconnor.net,
 liran.alon@oracle.com, kraxel@redhat.com,
 Sam Eiderman <shmuel.eiderman@oracle.com>, sameid@google.com,
 karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sam Eiderman <shmuel.eiderman@oracle.com>

Fixing tabbing in block related macros.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
---
 hw/ide/qdev.c            |  2 +-
 include/hw/block/block.h | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 6fba6b62b8..6dd219944f 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -290,7 +290,7 @@ static void ide_drive_realize(IDEDevice *dev, Error **errp)
     DEFINE_BLOCK_PROPERTIES(IDEDrive, dev.conf),        \
     DEFINE_BLOCK_ERROR_PROPERTIES(IDEDrive, dev.conf),  \
     DEFINE_PROP_STRING("ver",  IDEDrive, dev.version),  \
-    DEFINE_PROP_UINT64("wwn",  IDEDrive, dev.wwn, 0),    \
+    DEFINE_PROP_UINT64("wwn",  IDEDrive, dev.wwn, 0),   \
     DEFINE_PROP_STRING("serial",  IDEDrive, dev.serial),\
     DEFINE_PROP_STRING("model", IDEDrive, dev.model)
 
diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index 607539057a..fd55a30bca 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -50,21 +50,21 @@ static inline unsigned int get_physical_block_exp(BlockConf *conf)
                           _conf.logical_block_size),                    \
     DEFINE_PROP_BLOCKSIZE("physical_block_size", _state,                \
                           _conf.physical_block_size),                   \
-    DEFINE_PROP_UINT16("min_io_size", _state, _conf.min_io_size, 0),  \
+    DEFINE_PROP_UINT16("min_io_size", _state, _conf.min_io_size, 0),    \
     DEFINE_PROP_UINT32("opt_io_size", _state, _conf.opt_io_size, 0),    \
-    DEFINE_PROP_UINT32("discard_granularity", _state, \
-                       _conf.discard_granularity, -1), \
-    DEFINE_PROP_ON_OFF_AUTO("write-cache", _state, _conf.wce, \
-                            ON_OFF_AUTO_AUTO), \
+    DEFINE_PROP_UINT32("discard_granularity", _state,                   \
+                       _conf.discard_granularity, -1),                  \
+    DEFINE_PROP_ON_OFF_AUTO("write-cache", _state, _conf.wce,           \
+                            ON_OFF_AUTO_AUTO),                          \
     DEFINE_PROP_BOOL("share-rw", _state, _conf.share_rw, false)
 
 #define DEFINE_BLOCK_PROPERTIES(_state, _conf)                          \
     DEFINE_PROP_DRIVE("drive", _state, _conf.blk),                      \
     DEFINE_BLOCK_PROPERTIES_BASE(_state, _conf)
 
-#define DEFINE_BLOCK_CHS_PROPERTIES(_state, _conf)      \
-    DEFINE_PROP_UINT32("cyls", _state, _conf.cyls, 0),  \
-    DEFINE_PROP_UINT32("heads", _state, _conf.heads, 0), \
+#define DEFINE_BLOCK_CHS_PROPERTIES(_state, _conf)                      \
+    DEFINE_PROP_UINT32("cyls", _state, _conf.cyls, 0),                  \
+    DEFINE_PROP_UINT32("heads", _state, _conf.heads, 0),                \
     DEFINE_PROP_UINT32("secs", _state, _conf.secs, 0)
 
 #define DEFINE_BLOCK_ERROR_PROPERTIES(_state, _conf)                    \
-- 
2.23.0.187.g17f5b7556c-goog



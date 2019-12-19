Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A19C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:03:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AF1924650
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlXyv9M1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF1924650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvT7-0000t6-CE
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:03:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47099)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nirsof@gmail.com>) id 1ihvHa-0002ka-Jd
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:51:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nirsof@gmail.com>) id 1ihvHZ-0008Oo-3E
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:51:58 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43795)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nirsof@gmail.com>)
 id 1ihvHY-0008FD-NX; Thu, 19 Dec 2019 07:51:56 -0500
Received: by mail-wr1-x441.google.com with SMTP id d16so5837482wre.10;
 Thu, 19 Dec 2019 04:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mJYRaB+zXX5eueh7N2Sh8nJY2+XkOOgPVXg9m3dGKP8=;
 b=AlXyv9M1OgC/F8VAPj6chtsFmQFfuxmW8t0+9EKvEZc40ZoG3SvCraYJKF51AwRip4
 /qC6uxrnskkBCLpDKpxKnOkrGqvq3JK6xPF7F3JI6wskVp/3XbjFDqbYqNppWJXB7icT
 K9BC92mgu06MCpt4EWSC3jrFEt24Wbuh1knTghaNI7jQtQlOfjDeCkUX9ICbn3RJxrgR
 INSjoIPOmX8UtP0TRoxjNTYvGkkp28qV2thQ9IrE+jrpfPoVfUtLS5Ei/iE6ONo4kVyM
 cJ8tTGPmMt176zFYPbUwDt7lcPUaPPwWPMvnhdAwhiUiGzoFyuGRBnV+zNT3jDaIX3Ad
 EuAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mJYRaB+zXX5eueh7N2Sh8nJY2+XkOOgPVXg9m3dGKP8=;
 b=KfRv4obpbnUzbDIUhTa8e9SHcfurt6+nawqQTa/rgUbKojQ6bLPhudfb4j1jPiAuCR
 r6ZpjrpHv+UUNlVV9lCAL9SdkE3/8hmtbuVR1jxtW6t8fSAENN13xxznoQxyOS7UmOmY
 YzbVQHHY2YUoIQr6pEq5Gmc6euxA/dR0Qo17Mdpd5HZp+q8ZhkwIikgrvbDVYrjD680N
 JWh2Yf76bJc/RclymEgHtptSooXShMxScDAJrHU7r+JEhsUsT1flL0E9sdnhZpHbYzbU
 /GJHIt0unDK86j97yMIGXh3BEW4Y4Fi9qf5zUEuOHkfNXU8XUwjcJqUhP+qikos6w3ev
 3Cdg==
X-Gm-Message-State: APjAAAWErmQCOqSRlHxQtaE8mgYWM7rQ0ImJwglMGGpOCwcOMdgqO0Px
 xRgBu6qua/+aAsiw44b2Agt4utaz
X-Google-Smtp-Source: APXvYqzinrpi6iA2CvgidZwVtKV6Ssg3m+QtLJRUNFLseRiawl+JAB0e3oHFjZFZUn24lz62uSW1cQ==
X-Received: by 2002:a05:6000:118e:: with SMTP id
 g14mr9244602wrx.39.1576759914512; 
 Thu, 19 Dec 2019 04:51:54 -0800 (PST)
Received: from sparse-local.redhat.com (93-173-2-23.bb.netvision.net.il.
 [93.173.2.23])
 by smtp.gmail.com with ESMTPSA id s65sm6207905wmf.48.2019.12.19.04.51.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 04:51:53 -0800 (PST)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] block: nbd: Fix dirty bitmap context name
Date: Thu, 19 Dec 2019 14:51:51 +0200
Message-Id: <20191219125151.21482-1-nsoffer@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When adding an export with a dirty bitmap, expose the bitmap at:

    qemu:dirty-bitmap:export-name

This matches qapi documentation, and user expectations.

Without this, qemu leaks libvirt implementations details to clients by
exposing the bitmap using the actual bitmap name:

    qemu:dirty-bitmap:bitmap-name

And all clients need to duplicate code like:

    meta_context = "qemu:dirty-bitmap:backup-" + export_name

NBD allows exposing multiple bitmaps under "qemu:dirty-bitmap:"
namespace, and clients can query the available bitmaps, but it is not
clear what a client should do if a server provides multiple bitmaps.
---
 nbd/server.c               |  2 +-
 tests/qemu-iotests/223     | 16 ++++++++--------
 tests/qemu-iotests/223.out |  8 ++++----
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 24ebc1a805..f20f2994c0 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1574,7 +1574,7 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
         exp->export_bitmap = bm;
         assert(strlen(bitmap) <= BDRV_BITMAP_MAX_NAME_SIZE);
         exp->export_bitmap_context = g_strdup_printf("qemu:dirty-bitmap:%s",
-                                                     bitmap);
+                                                     name);
         assert(strlen(exp->export_bitmap_context) < NBD_MAX_STRING_SIZE);
     }
 
diff --git a/tests/qemu-iotests/223 b/tests/qemu-iotests/223
index ea69cd4b8b..3068a7c280 100755
--- a/tests/qemu-iotests/223
+++ b/tests/qemu-iotests/223
@@ -167,7 +167,7 @@ $QEMU_IO -r -c 'r -P 0x22 512 512' -c 'r -P 0 512k 512k' -c 'r -P 0x11 1m 1m' \
 $QEMU_IMG map --output=json --image-opts \
   "$IMG" | _filter_qemu_img_map
 $QEMU_IMG map --output=json --image-opts \
-  "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:b" | _filter_qemu_img_map
+  "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:n" | _filter_qemu_img_map
 
 echo
 echo "=== Contrast to small granularity dirty-bitmap ==="
@@ -175,7 +175,7 @@ echo
 
 IMG="driver=nbd,export=n2,server.type=unix,server.path=$SOCK_DIR/nbd"
 $QEMU_IMG map --output=json --image-opts \
-  "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:b2" | _filter_qemu_img_map
+  "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:n2" | _filter_qemu_img_map
 
 echo
 echo "=== End qemu NBD server ==="
@@ -199,15 +199,15 @@ echo
 echo "=== Use qemu-nbd as server ==="
 echo
 
-nbd_server_start_unix_socket -r -f $IMGFMT -B b "$TEST_IMG"
-IMG="driver=nbd,server.type=unix,server.path=$nbd_unix_socket"
+nbd_server_start_unix_socket -r -f $IMGFMT -x n -B b "$TEST_IMG"
+IMG="driver=nbd,export=n,server.type=unix,server.path=$nbd_unix_socket"
 $QEMU_IMG map --output=json --image-opts \
-  "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:b" | _filter_qemu_img_map
+  "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:n" | _filter_qemu_img_map
 
-nbd_server_start_unix_socket -f $IMGFMT -B b2 "$TEST_IMG"
-IMG="driver=nbd,server.type=unix,server.path=$nbd_unix_socket"
+nbd_server_start_unix_socket -f $IMGFMT -x n -B b2 "$TEST_IMG"
+IMG="driver=nbd,export=n,server.type=unix,server.path=$nbd_unix_socket"
 $QEMU_IMG map --output=json --image-opts \
-  "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:b2" | _filter_qemu_img_map
+  "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:n" | _filter_qemu_img_map
 
 # success, all done
 echo '*** done'
diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
index f175598802..9f879add60 100644
--- a/tests/qemu-iotests/223.out
+++ b/tests/qemu-iotests/223.out
@@ -61,7 +61,7 @@ exports available: 2
   max block: 33554432
   available meta contexts: 2
    base:allocation
-   qemu:dirty-bitmap:b
+   qemu:dirty-bitmap:n
  export: 'n2'
   size:  4194304
   flags: 0xced ( flush fua trim zeroes df cache fast-zero )
@@ -70,7 +70,7 @@ exports available: 2
   max block: 33554432
   available meta contexts: 2
    base:allocation
-   qemu:dirty-bitmap:b2
+   qemu:dirty-bitmap:n2
 
 === Contrast normal status to large granularity dirty-bitmap ===
 
@@ -141,7 +141,7 @@ exports available: 2
   max block: 33554432
   available meta contexts: 2
    base:allocation
-   qemu:dirty-bitmap:b
+   qemu:dirty-bitmap:n
  export: 'n2'
   size:  4194304
   flags: 0xced ( flush fua trim zeroes df cache fast-zero )
@@ -150,7 +150,7 @@ exports available: 2
   max block: 33554432
   available meta contexts: 2
    base:allocation
-   qemu:dirty-bitmap:b2
+   qemu:dirty-bitmap:n2
 
 === Contrast normal status to large granularity dirty-bitmap ===
 
-- 
2.21.0



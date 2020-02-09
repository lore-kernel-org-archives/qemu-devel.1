Return-Path: <SRS0=SBSl=35=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FD7C2BA83
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2020 17:53:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 017F720715
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2020 17:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xsmxv//d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 017F720715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0qlS-0005Ea-36
	for qemu-devel@archiver.kernel.org; Sun, 09 Feb 2020 12:53:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42690)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hikarupsp@gmail.com>) id 1j0qkk-0004em-TT
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 12:52:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hikarupsp@gmail.com>) id 1j0qki-0007O0-UA
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 12:52:18 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41661)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hikarupsp@gmail.com>)
 id 1j0qki-0007Nj-P9; Sun, 09 Feb 2020 12:52:16 -0500
Received: by mail-pf1-x443.google.com with SMTP id j9so2484263pfa.8;
 Sun, 09 Feb 2020 09:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6VHbqhHU0b14Bzz1NLDvKje1OcBGOakwYWy+1O0Z0L4=;
 b=Xsmxv//dhwHFj/gS+n/qnjuOxMtAowYDLOW9sajKCrpwvb5tkjIICX3mDTLF0lqNgW
 5owusfB/eAVph0ZqTo9WEoca4D1lr1M7glg2AmtLkhD9keYhm5iFlTQtwlQmJ6kwe3ia
 /XjYrLFRRh5oMUDsYdD6eqHUD6deebqXDC9ImW5EuCkX6N1akkPkhe32kfMho9yUPex/
 bQIA7xkBw5HXYUSZvTOK6yMlKlKfpi9g+uiIHGw+WDfUbDmToB4o5gsrO27DVFM1sydm
 ZBuiIoyx1kej+oYLJ9xa3IvL67HwJWRFnQjcoVubUmxKfaFM5WzfLbGXSRLFLqVuyLSL
 5Zvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6VHbqhHU0b14Bzz1NLDvKje1OcBGOakwYWy+1O0Z0L4=;
 b=pgMGoDNG1eIhe6SNtuGUoKYyuuX8ezRTNbwxvNXexfqzlsAYNDA7QuL6F9p3J1Vtd9
 tQPtc0N203+NdlKTXHNr0NojzGlyZZ9kvG96czv5E0bmotrK+4A19diLTpqIPzESpgZD
 O7TpSx7YPWAqDAJWjppu0zl6GErcVJgJiBrvEsrxzlaL5VDkvGwFlagmwc6+ZzNfsjIP
 j2Ljfa4iDcGmSwMBCTjRTGLAtAeNzjqUwWR5etp0/M0gGvNxkZLGB89dNMjh4k72vFn0
 aIWKFAi0Jqr6jkJS85jrtmxeOOothtY9X3t2cXmHy4vICoNOb5rsoBpiQ6LQRHzYwuwN
 7YCA==
X-Gm-Message-State: APjAAAVnoQTpr90iYk0KUi0Y6lm9rgGfdaYO6M78hmsKoJSXg7wPN+dK
 Q9oKEhuRS4uIAjD9Czfffc4nC0qR8Uo=
X-Google-Smtp-Source: APXvYqxeBY1OlzlZR5KdEGA0ep2Z7Okj1Dhf6KtuGk5Y8syCwX0RETEqFHNTCdt9FbB6LIIwj+IKBA==
X-Received: by 2002:a63:28a:: with SMTP id 132mr10028721pgc.165.1581270734553; 
 Sun, 09 Feb 2020 09:52:14 -0800 (PST)
Received: from t05.z01.hikalium.com.com (113x36x63x49.ap113.ftth.ucom.ne.jp.
 [113.36.63.49])
 by smtp.gmail.com with ESMTPSA id j4sm9453928pfh.152.2020.02.09.09.52.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Feb 2020 09:52:13 -0800 (PST)
From: Hikaru Nishida <hikarupsp@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] block/vvfat: Do not unref qcow on closing backing bdrv
Date: Mon, 10 Feb 2020 02:51:56 +0900
Message-Id: <20200209175156.85748-1-hikarupsp@gmail.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: Kevin Wolf <kwolf@redhat.com>, Hikaru Nishida <hikarupsp@gmail.com>,
 "open list:vvfat" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Before this commit, BDRVVVFATState.qcow is unrefed in write_target_close
on closing backing bdrv of vvfat. However, qcow bdrv is opend as a child
of vvfat in enable_write_target() so it will be also unrefed on closing
vvfat itself. This causes use-after-free of qcow on freeing vvfat which
has backing bdrv and qcow bdrv as children in this order because
bdrv_close(vvfat) tries to free qcow bdrv after freeing backing bdrv
as QLIST_FOREACH_SAFE() loop keeps next pointer, but BdrvChild of qcow
is already freed in bdrv_close(backing bdrv).

Signed-off-by: Hikaru Nishida <hikarupsp@gmail.com>
---
 block/vvfat.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 019b8f1341..ab800c4887 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3124,17 +3124,10 @@ write_target_commit(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     return ret;
 }
 
-static void write_target_close(BlockDriverState *bs) {
-    BDRVVVFATState* s = *((BDRVVVFATState**) bs->opaque);
-    bdrv_unref_child(s->bs, s->qcow);
-    g_free(s->qcow_filename);
-}
-
 static BlockDriver vvfat_write_target = {
     .format_name        = "vvfat_write_target",
     .instance_size      = sizeof(void*),
     .bdrv_co_pwritev    = write_target_commit,
-    .bdrv_close         = write_target_close,
 };
 
 static void vvfat_qcow_options(int *child_flags, QDict *child_options,
-- 
2.21.0 (Apple Git-122.2)



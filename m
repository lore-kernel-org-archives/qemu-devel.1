Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFC2CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 08:26:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B859920578
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 08:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="olyA8lfx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B859920578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNByN-0001tu-Ti
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 04:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNBwe-00015J-CD
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:24:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNBwa-0003fR-Hh
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:24:39 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53166)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iNBwY-0003dt-Nf
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:24:36 -0400
Received: by mail-wm1-x344.google.com with SMTP id r19so20186947wmh.2
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 01:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VMV+6575Q+m9914+vgxwQ9KJMHnLqPfbP/SeVonxq20=;
 b=olyA8lfx/OAZVunPC0Tx31m6B2ruzyD9iDZZ8YTVKvEm/IDXg6J7O+gh1PQtcrL3Dc
 1sTzZzvADcQG4gC3XROr8JOVM9Wnl798vokcEWN6RurkQtPlvhxgy784drAyyp3WflFU
 w6wWsCqnsu/cUFCFLkoc5QC3jccRirha6fFgsXWd9acOLw3SCeFpF5+lOxijxkjVJ0xs
 tGieEUHf7uXJzCuXnj9UNEbw4P/8OSaYUemoeNq3GQxYLK2+jqhghWyASfrg2sTghsO8
 xS9Upp1CgmpTljZfBOb+iOxMTYrdIdbcLhGmTmWw202yrvWCMZd1O9xMxPKcn8OOASDR
 rhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=VMV+6575Q+m9914+vgxwQ9KJMHnLqPfbP/SeVonxq20=;
 b=TJWcWkK957LLyVLgL9Q4FI4gsg7mIFOew4hZ4xjcU8qOafBO+5dX5om0ZLyCwfoHqk
 5UA1eWAcq37IG1Cqdu/sDd57alj9lmwvyS0xb2LGG1raAK8Ppcdp34Oyn7LMO4v3jQzi
 n5PYwZ4oCcnvqE5UocAsXOUPnTQF1D66qF8n0y0BbSakZ3RcGieVYwy8rwfQ66t2bXSu
 j//wkLuU+6AC3tFy5q7LdxFC22DZJhWv43CLz8qEOSHylsSDSEC05j10Xx4UEdM+ikPJ
 yCLpu25N6WSTUZnVzBXo5mqhWVp3fjj2FmNnzJcavUf29kNm3Ny0bVl89eBpgsNxFGyM
 y6Xw==
X-Gm-Message-State: APjAAAV6CqiirDMaRXRiHDA2vrVwaRhi2Z0Ya7z6LYhDM9UbegqthA+i
 uNaHe7+EbhdFI8IDrpnO6e7Ai5uG
X-Google-Smtp-Source: APXvYqxMUwagOILUxyIG387ynvsfhUFSPIkl+Ms8fU6NoqJwyzm8iD0Zp2MZ60txeV+G0MxY3/NT1g==
X-Received: by 2002:a1c:64d6:: with SMTP id y205mr6204975wmb.136.1571819072884; 
 Wed, 23 Oct 2019 01:24:32 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:45c:4f58:5841:71b2])
 by smtp.gmail.com with ESMTPSA id s21sm25512913wrb.31.2019.10.23.01.24.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 01:24:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] audio: fix missing break
Date: Wed, 23 Oct 2019 10:24:31 +0200
Message-Id: <20191023082431.30780-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reported by Coverity (CID 1406449).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/paaudio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index df541a72d3..55a91f8980 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -385,6 +385,7 @@ static pa_stream *qpa_simple_new (
         map.map[5] = PA_CHANNEL_POSITION_REAR_RIGHT;
         map.map[6] = PA_CHANNEL_POSITION_SIDE_LEFT;
         map.map[7] = PA_CHANNEL_POSITION_SIDE_RIGHT;
+        break;
 
     default:
         dolog("Internal error: unsupported channel count %d\n", ss->channels);
-- 
2.21.0



Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534CFC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:47:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E784206D7
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMli5Ycf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E784206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVWlO-0005Fl-76
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 04:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVWk3-0003ui-P2; Mon, 04 May 2020 04:46:23 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35336)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVWk3-0005A4-3f; Mon, 04 May 2020 04:46:23 -0400
Received: by mail-wr1-x444.google.com with SMTP id x18so19916912wrq.2;
 Mon, 04 May 2020 01:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=f+EbD9Q86u44mnUNC8LdzOT84sTEw0zjnLN96ls2FY8=;
 b=LMli5Ycftq50qDovpVx2BVYHKwF46lqCoDqY5tfX7XuHCkNIwVjbUHykKpSNh3z0OH
 pFH897SPxW/L+a5YAO1+Nx5b3xrqXYLWojiOl+/sEGpmvss+Q4z12cJ0f3Rf6G702Nz2
 NjVYuhe2PQiqdxNs8pEkDDER4vf/oQYxFsFYAQm0BZxqSvbnVnFGywAGykJChmH+Z90Z
 mt4dwkopUi+eZG+8P2mPtvcDteS8HnsY+wdHnCBCwlsFpTf+JEkkMx8FpwtTuReKtbet
 dKfTpQRpDuIHlkb8kx3u2LrUO9SWVZXO0UZrmAxR9hiNWsryKcTmsGrh4SnfVkBble3e
 iV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=f+EbD9Q86u44mnUNC8LdzOT84sTEw0zjnLN96ls2FY8=;
 b=ORCqY42TPQ5TBsHvsd5WMG4sgUZBj94ioQC81xmt7pYNzTGr0GhKVnydWAt8SGgg0L
 26HZJ6XHDQnoRdj70Tzi6LO8IFYZFdDlSE+QTzJAkSHkfFZ4DcV1jHFeXH4caiXXnm7j
 RVg7R+48sdUHORrwe1K9fVc5GSXhMlcEU4V1tUejkm4UAokPI7EC1MgEKRn1qfc/JoY4
 RelD77H+QWbRWMSFCifXn+i49kuOzUnRSt9DT7oK3JjVJG4J8A9mweNVj5B18uoP5W8C
 HJ6SskMUphIR+YM9ZsdQqNJGhcHNPWR1yL9iDmJKOQo/lq5VEll/vSxMULV2U2aHuDTB
 Tlrg==
X-Gm-Message-State: AGi0PuZoUe9o5UCZBntefIqFtt9wZLAzc8bMss4NLBsR8+lg6LuSU6gU
 FKXxIbR6DR7KBUA6EBCvIrGKnfNr
X-Google-Smtp-Source: APiQypL8IYJwhIZ1YGlLBCl4ZFybfnP1SZCSz8tDIjCk975wpi7l83A+O/6xGCkHA0yE/OKhNQ/uhw==
X-Received: by 2002:a5d:5651:: with SMTP id j17mr17455133wrw.406.1588581981066; 
 Mon, 04 May 2020 01:46:21 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id w6sm10740621wrt.39.2020.05.04.01.46.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 01:46:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] qom/object: Make reparenting error more verbose
Date: Mon,  4 May 2020 10:46:15 +0200
Message-Id: <20200504084615.27642-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200504084615.27642-1-f4bug@amsat.org>
References: <20200504084615.27642-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Display child and parent names when reparenting occurs.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 qom/object.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/qom/object.c b/qom/object.c
index be700e831f..417fd90aa5 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1683,7 +1683,12 @@ void object_property_add_child(Object *obj, const char *name,
     ObjectProperty *op;
 
     if (child->parent != NULL) {
-        error_setg(errp, "child object is already parented");
+        error_setg(errp, "child object '%s' is already parented (parent: '%s') "
+                         "can not be children '%s' of '%s'",
+                   object_get_typename(child),
+                   object_get_typename(child->parent),
+                   name,
+                   object_get_typename(obj));
         return;
     }
 
-- 
2.21.3



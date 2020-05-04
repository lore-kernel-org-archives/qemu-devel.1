Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799FEC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 11:59:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48942206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 11:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnCK6mhU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48942206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVZka-0003lR-CD
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 07:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVZie-0001qs-2O; Mon, 04 May 2020 07:57:08 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36656)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVZid-0001G9-Cd; Mon, 04 May 2020 07:57:07 -0400
Received: by mail-wr1-x441.google.com with SMTP id d15so20574349wrx.3;
 Mon, 04 May 2020 04:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=f+EbD9Q86u44mnUNC8LdzOT84sTEw0zjnLN96ls2FY8=;
 b=OnCK6mhU9G9SVkGhpY5pbKk+MRkuYS47AV66uu4tzs2/gtCqXvvvnHH7JudFKDPPHF
 htrPx2KMZjAZy9uKmL4GL4bKGwJKnM/X/jejPyctXNd5xEGeYj5Iadeq+Pjwr/vGD+PD
 S2RytjYaE6aJ96hOOgEMMAQNnxwEHvueFhLJYsB/Kh8f0TUk5kGdNHyWpRFVYfn6uKrQ
 nuMHYaTnKmJwSkcwvb380WneVcgxRglW43+lhBGQbOFInNJvUj1Qqy+hnK+iUrHaS5Q1
 R+GKpQH7ZUTgrmjgZM5YxObCj9F4s0j8P4bareMfZwi+myQ0wDPx41gvK/0QRuiI5myA
 pWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=f+EbD9Q86u44mnUNC8LdzOT84sTEw0zjnLN96ls2FY8=;
 b=sTC+ywQtm3abwI2QxEShTRWsXe3FIuYkx5qeuqagj+I7hB3kY1ggXx8u6hUEvPuLp8
 lVXv3tDXMvW0TCASCH3GcwfU5sgfFJorynyk43oIgiBUCn+HEcvl1DsNmntZuTeP0bww
 bvJJRPPSSNMjX0NXqsU1DoLIMdbP/v+IyGkxerdPvSLl39vPISSoH7N09KP1vP3EcYr0
 1Tc9QwGC4q55mTVLm9lbePb1xng6oyyVL1dtczPGhw1uHO/GtAB/Do5LQOQRk73ZpRep
 sqChbHeXCsyEMoApH4yiwWs8IRTQww25ZjsN6Feaj4BSsNCrq0IUChaBbfPTe0vkfdEX
 Fzmw==
X-Gm-Message-State: AGi0PuZZooCteVsZq6Up1Xs3+lgEIv+9Nie6YjHx/x8ymXs91mFEkkPx
 nbOWmd48zXpyT22F4lGlT/Nk3Qva
X-Google-Smtp-Source: APiQypJsyuG2c/A4OQ3/iYixKP3P+ijzEYV8F+Bo2y915r7C5w8QQ8mnDS1SQ80UjthvbFgDUwf8PQ==
X-Received: by 2002:adf:c7c3:: with SMTP id y3mr17461703wrg.196.1588593423019; 
 Mon, 04 May 2020 04:57:03 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id n12sm5660984wrj.95.2020.05.04.04.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 04:57:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] qom/object: Make reparenting error more verbose
Date: Mon,  4 May 2020 13:56:56 +0200
Message-Id: <20200504115656.6045-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200504115656.6045-1-f4bug@amsat.org>
References: <20200504115656.6045-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
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



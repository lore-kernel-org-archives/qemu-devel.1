Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D444BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 23:56:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D9E120702
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 23:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieRnS9/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9E120702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8uPj-0002Ok-Tc
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 19:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1k8uOI-0000Z1-VA; Thu, 20 Aug 2020 19:54:42 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:40129)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1k8uOG-00072R-Nu; Thu, 20 Aug 2020 19:54:42 -0400
Received: by mail-wr1-x42e.google.com with SMTP id l2so339544wrc.7;
 Thu, 20 Aug 2020 16:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gC2hJbrUiIGgGDI/h0RY2Ob+Q69oEsfEZIUg5eipKcE=;
 b=ieRnS9/t2idmp05ieVq6uL4x17BlWng5YactD6o1Co8uAuQrWnvJjydmf/Ew/chPvi
 0SFn6QsG669tR6QnZGsrDz4w5B7oB/Mr2EVOqvlxRYTVX7KneE4Q9wNMQ6Z9Owz3ITIL
 B7MCsREhK03zGBEVUKHpWrAEVNrOIhrPY3n2TEyEYnry9gD5V2vNz2hEvC2iI7NIbMPT
 AyXsJ2HEo6Wr00bKv6cwKRrcdCMvcsISIsfzqmN6TO9YhPK5XfcJxVWB4ewALI2ia/Kg
 iDIWP5W7s87Ouk2ecvj5O75AmnTz/6rF8RLxBxW7/ANvSio1o4u6UNWKSmw6erJzT5lJ
 2wzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gC2hJbrUiIGgGDI/h0RY2Ob+Q69oEsfEZIUg5eipKcE=;
 b=ZMbkE3rPI9bveuiakUZeiin0397gqBhuKxurH7A76Zr474pRMXquxo4g534g1evHat
 dmXp73xdKqkFxYf2XyojhSwKD+Bslg6XwWPbeYbeoJISEd4IW4fuEinGlvgp1iQ8ct/I
 V8Iro956qai3GpOeU4bq+0ohE1pgOhu1MEN6hdOwjYJhRGMIaczbpCjAj3MvMSbPjXus
 KaqBpba36fUPWRIKC8xLPVKjRyCkZv4l57T0eD8MyvfWy/Bag+OlbVUWrVb4JumgXStu
 1fneENIsJHx4MRTWPo4CZQhbelNQNbyEF80aoFzj8wg8agdEKyQuFEYui3Wc3nIlirbr
 Ucjg==
X-Gm-Message-State: AOAM533X0Zd+etvqO2/PI4IaVh6l6kqjdPgZSoDRNb9UlkAvIzG4kIjR
 996KuERDx/5hR04Wjjag2xVu3AGQQkFsu6yN
X-Google-Smtp-Source: ABdhPJxVs5mlEN5+ggQADMze65/RDrhSS/ThKeNei1G5Kmn3o0jrWbOCHZbFXZKW4DNh8+u8i54zQw==
X-Received: by 2002:a5d:480b:: with SMTP id l11mr148027wrq.85.1597967678675;
 Thu, 20 Aug 2020 16:54:38 -0700 (PDT)
Received: from localhost.localdomain (109-186-18-89.bb.netvision.net.il.
 [109.186.18.89])
 by smtp.gmail.com with ESMTPSA id o128sm556506wmo.39.2020.08.20.16.54.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 16:54:38 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/5] qemu-iotests: Simplify FilePath __init__
Date: Fri, 21 Aug 2020 02:54:27 +0300
Message-Id: <20200820235427.374645-6-nsoffer@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200820235427.374645-1-nsoffer@redhat.com>
References: <20200820235427.374645-1-nsoffer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=nirsof@gmail.com; helo=mail-wr1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use list comprehension instead of append loop.

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
---
 tests/qemu-iotests/iotests.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 1b5cdd493e..7ebd0bcc92 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -467,9 +467,8 @@ class FilePath:
 
     """
     def __init__(self, *names, base_dir=test_dir):
-        self.paths = []
-        for name in names:
-            self.paths.append(os.path.join(base_dir, file_pattern(name)))
+        self.paths = [os.path.join(base_dir, file_pattern(name))
+                      for name in names]
 
     def __enter__(self):
         if len(self.paths) == 1:
-- 
2.26.2



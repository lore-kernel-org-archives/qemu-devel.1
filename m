Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CBCC43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 09:34:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB22620719
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 09:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="ripkTEJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB22620719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKIDI-0006vP-Kq
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 05:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kKICX-0006VF-VR
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 05:33:37 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033]:54287)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kKICV-0001rZ-RJ
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 05:33:37 -0400
Received: by mail-pj1-x1033.google.com with SMTP id mm21so7141448pjb.4
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 02:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zP8Fzfbikkz0CVK4gtgCKhStmuRGHmZ9KRCHJCFGsRI=;
 b=ripkTEJC2+I8rIRSabA/S3bVDnO0CgbNdqLwCFycqDNo/Nnhhf3VzOdTaNK+Ts7rvJ
 DFXjdGlP6jRt/APG43ubvakb0F5uvFqqYjXUCBSyI2oofQpJnJbCyDiyNuSg/OQXF6Ln
 Zcb6iPl8a0wWe9gL8HWRyUuNyOhJvWu0z1ZVtIYPIRBlUE85GbC2weVqa7/g9K1NNnZW
 OlsTKWJw9Xqrzgg5RyunlkDuW7PTgz/OgcxOZqcjdybudXrXmiVN5f0lU/sm/fI1oTWa
 VuriC8Obrq2ZUWxsV1vY570J0zq7V5ItLmB/ohG9giCoZSeq4fzxWmj4cpNtejCGssHk
 T2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zP8Fzfbikkz0CVK4gtgCKhStmuRGHmZ9KRCHJCFGsRI=;
 b=Xz3pzLQUg0+1n6WJ34BPfbP0sgmAfIMrMEeCnMS7zGxzOh/UfaPga/85bRDfrII+jR
 a/whZtQPtLhTmegayTOmNzWeQHpsKzMfkm6jY43w3Rvlr204H1LpuivxWX9zsg/hHjhZ
 5bMbKP7Js41uNlBz2+mH8ZaxVE/Eq58vLS5MUEG/2jzP50YI00rJFRDHJ+lynqhPy99p
 RCZ34NcoAru+I6V0qPM1+t3IVBlhQxkE4GnOpmC1XLMuZGn395XCaUwEN46bJZJ0/LgP
 bvvAdQrUnJ9eaXT4AFFDLhu2HeszmwoZ1CbotpjDuEswtbWMTfIQ91uiQWFl0lHbboMX
 nVng==
X-Gm-Message-State: AOAM533wiX6b9whEBPQfyc2Mx1ry6AuJxz+BYiskc1fqV+0l6EX2fBfX
 2PtR2dyLmELt6oJlBGcOaM6IboWc6qVTizQC
X-Google-Smtp-Source: ABdhPJyFw/J16GlkTDzXtgTKRUMI6lVqKtalxQ1Ud0lots4Xi1qxewDWXE5VMfZoQmOBgRUhwH9LYQ==
X-Received: by 2002:a17:90a:8d05:: with SMTP id
 c5mr23397144pjo.222.1600680814001; 
 Mon, 21 Sep 2020 02:33:34 -0700 (PDT)
Received: from localhost.localdomain ([115.96.132.156])
 by smtp.googlemail.com with ESMTPSA id a2sm11235355pfr.104.2020.09.21.02.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 02:33:33 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v3] qom: code hardening - have bound checking while looping
 with integer value
Date: Mon, 21 Sep 2020 15:03:25 +0530
Message-Id: <20200921093325.25617-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1033;
 envelope-from=ani@anisinha.ca; helo=mail-pj1-x1033.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Ani Sinha <ani@anisinha.ca>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Object property insertion code iterates over an integer to get an unused
index that can be used as an unique name for an object property. This loop
increments the integer value indefinitely. Although very unlikely, this can
still cause an integer overflow.
In this change, we fix the above code by checking against INT16_MAX and making
sure that the interger index does not overflow beyond that value. If no
available index is found, the code would cause an assertion failure. This
assertion failure is necessary because the callers of the function do not check
the return value for NULL.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qom/object.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

changelog:
v1: initial version
v2: change INT_MAX to INT16_MAX in code
v3: make the same change in commit log. Sorry for missing it.

diff --git a/qom/object.c b/qom/object.c
index 387efb25eb..9962874598 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1166,11 +1166,11 @@ object_property_try_add(Object *obj, const char *name, const char *type,
 
     if (name_len >= 3 && !memcmp(name + name_len - 3, "[*]", 4)) {
         int i;
-        ObjectProperty *ret;
+        ObjectProperty *ret = NULL;
         char *name_no_array = g_strdup(name);
 
         name_no_array[name_len - 3] = '\0';
-        for (i = 0; ; ++i) {
+        for (i = 0; i < INT16_MAX; ++i) {
             char *full_name = g_strdup_printf("%s[%d]", name_no_array, i);
 
             ret = object_property_try_add(obj, full_name, type, get, set,
@@ -1181,6 +1181,7 @@ object_property_try_add(Object *obj, const char *name, const char *type,
             }
         }
         g_free(name_no_array);
+        assert(ret);
         return ret;
     }
 
-- 
2.17.1



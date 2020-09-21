Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD28C43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 09:08:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D9AA20773
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 09:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="ooRlojMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D9AA20773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKHnv-0003Ff-91
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 05:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kKHn5-0002n5-Ko
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 05:07:19 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46195)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kKHn3-00072H-M4
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 05:07:19 -0400
Received: by mail-pf1-x443.google.com with SMTP id b124so8693005pfg.13
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 02:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=kR9iCYe84KslL3W3ktEJjo+Xu7hMFud5I6WivYPB80k=;
 b=ooRlojMwaXpmsm7BlYnVeM9BWBApaw9LWrDmvTwt1M/smGxgG3xqym2ge6p/pkR/+f
 AUQlYvnx4iPKoLXVouf81Cuo2MUzUSe26oQ1SpKkpMP7C6TLm7wb/tWFLMAsNrKQBFQI
 6uaG6rCtHNcWNyEd04AxiRu61k5KK8AezRiEL3SogUgGH7mAhERmRioa/cAY8DHwJ1os
 fq0P8BhjgqkerOBwKzYdYhja1YTG4in9xUA78R86N912zminnRqWN1r9Xds+znwEi4AE
 VoOg3DlhFuBtufCSGlUmDLJ4YfE9SbQhc4NCD2gf5eOK4l7ypfduCto6Uxa69w5RN8hP
 71Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=kR9iCYe84KslL3W3ktEJjo+Xu7hMFud5I6WivYPB80k=;
 b=k4Lg4nJbObfXIdMT5s56Cfc6NEHmsm16SCAA1DSQmI6nsG4p8xLdLee32LmcNhVE2m
 /0VF9kgLPsW8gaamJHv5s6ym0ElRmtwmt1z9cd7UxOS8bfkNPE7OXfjvf59ERK7CR151
 1bqOhjlt99wJsUSyP9h8HRYkrGMglTX90t85UuzHDmZ/nlRXNZQhIjUjJ7bw5Q6DsDSj
 1LQQH/bkHiKI9CF3n81SPzSLwyTCAoQeXCiXKXK0/50jmEly5u8ULXyn7YpIXA1pAMn3
 RhYlTJnX01UN2D1ZxGUHQYlWM15uALUIEYdBzz9XzioNtfD+nZTGcTkt0r773QboWfDh
 e/fg==
X-Gm-Message-State: AOAM530q71Vfycov88gvWIYqWJ4aPXOR3Rp7jYJgwB0X4s7E6+dHoe3D
 JhKhUIa5pTaE+LJC3nW3tSWAgiBhonjNBX2E
X-Google-Smtp-Source: ABdhPJy1pgCMXNCZiJ1Rqu0j9O/4FuAYrsxd/TIptISch0UwgW08UpDJPj9radX4ylC9pgcgD4S+ug==
X-Received: by 2002:a63:d449:: with SMTP id i9mr34479341pgj.83.1600679235346; 
 Mon, 21 Sep 2020 02:07:15 -0700 (PDT)
Received: from localhost.localdomain ([115.96.132.156])
 by smtp.googlemail.com with ESMTPSA id q7sm10743256pgg.10.2020.09.21.02.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 02:07:14 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] qom: code hardening - have bound checking while looping
 with integer value
Date: Mon, 21 Sep 2020 14:37:04 +0530
Message-Id: <20200921090704.25353-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
Received-SPF: none client-ip=2607:f8b0:4864:20::443;
 envelope-from=ani@anisinha.ca; helo=mail-pf1-x443.google.com
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
In this change, we fix the above code by checking against INT_MAX and making
sure that the interger index does not overflow beyond that value. If no
available index is found, the code would cause an assertion failure. This
assertion failure is necessary because the callers of the function do not check
the return value for NULL.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 qom/object.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

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



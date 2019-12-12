Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D031AC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:14:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C88521655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uAIVzBZL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C88521655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOIr-0002r3-5N
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:14:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyH-0003Nx-Eb
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyG-0006Zu-3B
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:33 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:39580)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyF-0006X7-Qw
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:32 -0500
Received: by mail-wr1-x42b.google.com with SMTP id y11so2612920wrt.6
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Bxsd7cj1t1IS27BdAUrkJJ/4ZajGVGqHzwhI7jGnNf0=;
 b=uAIVzBZLzlF70bo9em0ieC8sc5toqa+mD/sXh/cKdxoieVhINn1uovhUC30H8NHG9+
 vepKIhlhI2hHGfa8Bok1edNlKChTVGZ7iw6lySuSIK7DhMU5Gji0SZei3qTYKgPxrMql
 oQb140psvjHwohlGGfiPLrt877JKQklUsJFZoK1w/MKKDVI6eatd9YWTDdyBdz2WTHPn
 mYJwu16zTKoAZDDjjFHWW94FRcvwYLDsAwoEUyV7/2Sj4wT1l9dHPi62Qe9Jqtksidgp
 HcXrRT+pt+N4sPKFueCDSgoxoJQ048BucRGFp6iOXo2/RUXmVPjpzlmCQt0XqWmi4kz8
 1OFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Bxsd7cj1t1IS27BdAUrkJJ/4ZajGVGqHzwhI7jGnNf0=;
 b=ccicDJk8le6bBXY1r4xr0nZGS1kw+jV+FwYWXzbEgTjdMm2vjAe9b7vJGJm0CfMS1w
 G6HVr7HB1QFbeDqdEduyexTRjkFBSgZBwDTD+YVtNXBiVGfQym4qSM+csGshg4h0QpLX
 qxyxxmv7Agsyo0FoMWZX7nQa1L92R8pYRf0Sy1s/bRRzlPk+JmLN3xcI+ouscSf9ndaf
 ViZJ3L9Gq/6KHEzBcrLvkP6UBOtbwy9Ut2Jado71e8UTpkI8nf67Dca+IZDxRLeJvhF8
 B82eirwllMbRL3QPkXlY9xG4vyRjnmUL7zsVDYTZnjsY64ce+cRKo0jnnHXqlq3L2UKg
 d/rA==
X-Gm-Message-State: APjAAAWTDRlXCcgPDesUSNkdCIYKIfTm2Rw1qWGYccgcEntYEgT00+TU
 z0F8axLQlGj//jBtGKp/JY7KULpp
X-Google-Smtp-Source: APXvYqzvPJCqG/Gxinm+XDjZpeEBehFj+5csNVj/Td1sjPtT22lzkJSNc0rqnbJ8BVO5J6M4MTxxxA==
X-Received: by 2002:adf:f885:: with SMTP id u5mr6283471wrp.359.1576155210602; 
 Thu, 12 Dec 2019 04:53:30 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:30 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 033/132] build-sys hack: link with whole .fa archives
Date: Thu, 12 Dec 2019 13:51:17 +0100
Message-Id: <1576155176-2464-34-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

In order to link the *-obj-y files into tests, we will make static
libraries of them in Meson, and then link them as whole archives
into the tests.  To separate regular static libraries from link-whole
libraries, give them a different file extension.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rules.mak | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/rules.mak b/rules.mak
index 5289184..a10a972 100644
--- a/rules.mak
+++ b/rules.mak
@@ -39,6 +39,13 @@ find-symbols = $(if $1, $(sort $(shell $(NM) -P -g $1 | $2)))
 defined-symbols = $(call find-symbols,$1,awk '$$2!="U"{print $$1}')
 undefined-symbols = $(call find-symbols,$1,awk '$$2=="U"{print $$1}')
 
+WL := -Wl,
+ifdef CONFIG_DARWIN
+whole-archive = $(WL)-force_load,$1
+else
+whole-archive = $(WL)--whole-archive $1 $(WL)--no-whole-archive
+endif
+
 # All the .mo objects in -m variables are also added into corresponding -y
 # variable in unnest-vars, but filtered out here, when LINK is called.
 #
@@ -54,11 +61,12 @@ undefined-symbols = $(call find-symbols,$1,awk '$$2=="U"{print $$1}')
 # This is necessary because the exectuable itself may not use the function, in
 # which case the function would not be linked in. Then the DSO loading will
 # fail because of the missing symbol.
-process-archive-undefs = $(filter-out %.a %.mo,$1) \
+process-archive-undefs = $(filter-out %.a %.fa %.mo,$1) \
                 $(addprefix $(WL_U), \
-                     $(filter $(call defined-symbols,$(filter %.a, $1)), \
+                     $(filter $(call defined-symbols,$(filter %.a %.fa, $1)), \
                               $(call undefined-symbols,$(filter %.mo,$1)))) \
-                $(filter %.a,$1)
+		$(foreach l,$(filter %.fa,$1),$(call whole-archive,$l)) \
+		$(filter %.a,$1)
 
 extract-libs = $(strip $(foreach o,$(filter-out %.mo,$1),$($o-libs)))
 expand-objs = $(strip $(sort $(filter %.o,$1)) \
@@ -122,7 +130,7 @@ LD_REL := $(CC) -nostdlib $(LD_REL_FLAGS)
 modules:
 
 %$(EXESUF): %.o
-	$(call LINK,$(filter %.o %.a %.mo, $^))
+	$(call LINK,$(filter %.o %.a %.mo %.fa, $^))
 
 %.a:
 	$(call quiet-command,rm -f $@ && $(AR) rcs $@ $^,"AR","$(TARGET_DIR)$@")
@@ -378,7 +386,7 @@ define unnest-vars
                 $(error $o added in $v but $o-objs is not set)))
         $(shell mkdir -p ./ $(sort $(dir $($v))))
         # Include all the .d files
-        $(eval -include $(patsubst %.o,%.d,$(patsubst %.mo,%.d,$($v))))
+        $(eval -include $(patsubst %.o,%.d,$(patsubst %.mo,%.d,$(filter %.o,$($v)))))
         $(eval $v := $(filter-out %/,$($v))))
 endef
 
-- 
1.8.3.1




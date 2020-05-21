Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F180C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 13:58:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28D7F206F6
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 13:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sctq1WWA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D7F206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jblib-0001p8-IS
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 09:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jblhx-0001PU-7v
 for qemu-devel@nongnu.org; Thu, 21 May 2020 09:58:01 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:36450)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jblhw-0001XY-3k
 for qemu-devel@nongnu.org; Thu, 21 May 2020 09:58:00 -0400
Received: by mail-ed1-x543.google.com with SMTP id b91so6727102edf.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 06:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jOXM0m/kqe/Bzewn8gZ7sUGDJi/1sEEUwPb5JWkw44g=;
 b=sctq1WWAmg/x/CQGB4m4dJ2UeNZcRJ7kbiULo0gTIEh2qM/znOjFGx/sBhR2zj/T7I
 vvlFQKLoNi3C9HwfUXlSrK93WvskP6W5Q+xffdrfo3yV4fbqFhc/2RUgPYhnZnMYTo/P
 t+AyHJfk4fPIqyZrStIuLzRqtJINapfDT5EM+WBWmoy5YYUeQdwD/G9mgtkKOXJu0E0r
 HfBFmaBoFYFAbu5oOv20bIoc4/OE/OjSnXZ55pBWIKzfOYM2R8nnbn+27wsIsylD9U8e
 vhuA/QiOaIKjbG1hf2XmuEzXkBEm/kF92U2BE3k6E/9FcFpgBBFIHaOn+9IFJnOx1+K3
 ztSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jOXM0m/kqe/Bzewn8gZ7sUGDJi/1sEEUwPb5JWkw44g=;
 b=bBppkgide7ca0d83GOXQxz5SG+OsBD225fmEJ81U2sMfshdcyKj4uPWcGsX9UzWykC
 0VCXwoiUGVnwR7R6sU1gztv/L4ykqsA4hGXZKhZmYufzWVtecOuzEdF8bZhEsSO7p1BD
 4zauk328JuyVYwFhsE9DNllLTi1hrr3B252mmM2T201EUjdmeUOoyu3amZtfB2wUHbBp
 QtGfzVUz3fbwIAe05+qkYoTANf+PO30HMWCokTt7TTn+FfBiDmUlvvJDXk6ktQdPhE2i
 jz1uxe5QNYVT5QYuaHDTfcdhTpxOYVoaYD39wjpFbnH7vZmtBkpo7uMLDb7jlFieoAgF
 o3jQ==
X-Gm-Message-State: AOAM531iDadfAQEeJEsl0lGOh0auHOWam9jxusY5Ymz7azazQ4jfIdHh
 5iqQJbmAWL3O+XCkdDVWQUIh/g==
X-Google-Smtp-Source: ABdhPJxjUabx6SDTFq+s4jU3XDoQyTwOvIWuf0nqdsqNy6YHC3qF8iJ1kLynBDCgwfcpeuy3crDy+Q==
X-Received: by 2002:a05:6402:128f:: with SMTP id
 w15mr7949700edv.203.1590069476780; 
 Thu, 21 May 2020 06:57:56 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w14sm5061690ejk.13.2020.05.21.06.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 06:57:55 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 75F561FF7E;
 Thu, 21 May 2020 14:57:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] linux-user: limit check to HOST_LONG_BITS == 32
Date: Thu, 21 May 2020 14:57:48 +0100
Message-Id: <20200521135748.9859-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Newer clangs rightly spot that you can never exceed the full address
space of 64 bit hosts with:

  linux-user/elfload.c:2076:41: error: result of comparison 'unsigned
  long' > 18446744073709551615 is always false
  [-Werror,-Wtautological-type-limit-compare]
  4685         if ((guest_hiaddr - guest_base) > ~(uintptr_t)0) {
  4686             ~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~
  4687 1 error generated.

So lets limit the check to 32 bit hosts only.

Fixes: ee94743034bf
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - move inside else bracket
---
 linux-user/elfload.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 01a9323a637..de82eaf5420 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2073,12 +2073,14 @@ static void pgb_have_guest_base(const char *image_name, abi_ulong guest_loaddr,
             exit(EXIT_FAILURE);
         }
     } else {
+#if HOST_LONG_BITS == 32
         if ((guest_hiaddr - guest_base) > ~(uintptr_t)0) {
             error_report("%s: requires more virtual address space "
                          "than the host can provide (0x%" PRIx64 ")",
                          image_name, (uint64_t)guest_hiaddr - guest_base);
             exit(EXIT_FAILURE);
         }
+#endif
     }
 
     /*
-- 
2.20.1



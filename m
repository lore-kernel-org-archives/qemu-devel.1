Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BEDC3F68F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:56:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 581C32087E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NgsC7cOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581C32087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu6Bx-0005h4-Ty
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 21:56:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iu65d-0005Q4-4G
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:49:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iu65c-0002i8-2M
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:49:56 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:43676)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iu65b-0002hu-TK
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:49:56 -0500
Received: by mail-pg1-x532.google.com with SMTP id k197so2619496pga.10
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 18:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pu4pttn5OmCwY0HJaYMHcfh+W4ea/gLi0/NHNHqzkuE=;
 b=NgsC7cOWeLZVaPsRjLhoCfJrNM+JKWSph6ovGHKMiRHrBc5k7rwehgs/c0D50IzSeR
 6ZJKnbNMecxmfphE0ASimZV4/EU6pSRD6Z2YiG0hZBcfP8RFMypdAjwDQmlC56SL+Hk3
 G3C+4JX4D12PDGpjCZT/PLSTToxqyidlV8/UtYGY4Iryy7IFBsZHTsPq7ZA4yqitAfOI
 zAbE4J2s7bm0aUeQOZwtl1eRmgvtZpHUkRfaTaVGm23EGSNhM1ltWAMLdeMdXX0h7sNe
 vxcnFpzRCzHjWGevqqErdgLrxdVa0AZNPmE7UlMaLvRWTFbLiEZcvLTABBvOycqVBP7F
 jO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pu4pttn5OmCwY0HJaYMHcfh+W4ea/gLi0/NHNHqzkuE=;
 b=dZmJXu/3SX9wrazr7h3xRP1sJCpIY0jPgHUObp+SSjgdlbR4X4AlXh80nsMSpTkpmL
 UZLea/VJfwUX3PDDverG1tsIY38TUkT5TKmcEWkjwCOZVG3jB9d1G8Bnig2CDRW1jIsr
 Y8dBOBb9/3bUzR0t27ZGpThdXcsZkasrjsXzxe1Eig1CHHcycgJgiLR/Hu7eoYZ7wpk4
 XS5c4Ccu3AHaXovC+hTwLKkl4fygAMEhiNq6lRfBBQOiPPs9b1Z4qUN91FPoykdnyH49
 5IPF4iuT5wvUut9GZMK49S6YcUF1Ri79M6S6Z7GbYTnIGAuJZ7hggkYQa9XytiJOtkHx
 jquA==
X-Gm-Message-State: APjAAAVoQWzy6uttMUU8SdP2VEca5cdNINMitCRfD47rJRX24P1UdQO+
 UOCLNXsdxfTngTLHTHk4kj5YkDbRkjg=
X-Google-Smtp-Source: APXvYqwD2FPN6Idg2uOYYUU0C2Tq9jfqHhCHwzBqSYOC2keEYzJSEeSXJMii9U5tUKogAOek+4BLrA==
X-Received: by 2002:a63:2ad8:: with SMTP id q207mr8772938pgq.45.1579661394669; 
 Tue, 21 Jan 2020 18:49:54 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id c22sm44149883pfo.50.2020.01.21.18.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 18:49:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/16] vl: Remove unused variable in configure_accelerators
Date: Tue, 21 Jan 2020 16:49:33 -1000
Message-Id: <20200122024946.28484-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200122024946.28484-1-richard.henderson@linaro.org>
References: <20200122024946.28484-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::532
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The accel_initialised variable no longer has any setters.

Fixes: 6f6e1698a68c
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 vl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/vl.c b/vl.c
index 71d3e7eefb..da5bf2de27 100644
--- a/vl.c
+++ b/vl.c
@@ -2756,7 +2756,6 @@ static void configure_accelerators(const char *progname)
 {
     const char *accel;
     char **accel_list, **tmp;
-    bool accel_initialised = false;
     bool init_failed = false;
 
     qemu_opts_foreach(qemu_find_opts("icount"),
@@ -2783,7 +2782,7 @@ static void configure_accelerators(const char *progname)
 
         accel_list = g_strsplit(accel, ":", 0);
 
-        for (tmp = accel_list; !accel_initialised && tmp && *tmp; tmp++) {
+        for (tmp = accel_list; tmp && *tmp; tmp++) {
             /*
              * Filter invalid accelerators here, to prevent obscenities
              * such as "-machine accel=tcg,,thread=single".
-- 
2.20.1



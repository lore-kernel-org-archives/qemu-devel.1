Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C94C33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 21:07:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D362F20661
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 21:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MjyPDGDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D362F20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isCM7-0003nd-TO
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 16:07:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1isCKe-0002QT-77
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 16:05:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1isCKd-0007Oq-4b
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 16:05:36 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:39149)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1isCKc-0007NR-UA
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 16:05:35 -0500
Received: by mail-pg1-x544.google.com with SMTP id b137so10514442pga.6
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 13:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3RxuNErO3G6jh94WlBjbMCnN6twwO5VkwerBc+JWKzQ=;
 b=MjyPDGDyS8qi8yxrdxJYmKATXHLD+PYqOIlGEO/5u98PQ8+fx+sb9/E7U983jgsNP3
 MmUVvqx8phopN6xIU/itr9Jil4C+nkLz8No1PVTPBaMO0UrI8MAtPLEEqrUG2g2p96ws
 c/XKJvz1zzPmSa+28+bLPQ6PR5XByiS7Q5tVDwehYfdxD57Cxa3iJV4SpbwbbNXDP47a
 sz15qyjNzNul4c3t8W7frG4yoG3UXE+iLQZD5cEY/yPjNPVpj4dXmRfue932UsTBZ+0F
 UeYWFrpZ5LSG1KB9+tKdMI295lpHwerVItfndI8w3fpeUDyQrnEYFDkWBIYzwo6k8NEH
 DWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3RxuNErO3G6jh94WlBjbMCnN6twwO5VkwerBc+JWKzQ=;
 b=g7dkWhnisxhW1xPKdTmCXH0dK3cPUToFLmk9GKc6P0UcFOtr55JOG7Gltq1coT6MXK
 D+Mo0AldhBkxr7J5Xx/i3QSpR5gFQWdWXP/PrrxULk6GYq5A8CIMznD+1gAm+r80NLdp
 qr0xdfEEzyiyNXj6RJodgeHEq5kBmO+NHvVnlfD0AhI7HAd/jEhOuzHN71hyX2pely4S
 /aEc8p4e54FS3maKytYbAE8gCvoUHxDJVSXrcFTt5gXNJ/ViURiTCGQENvw9MspNNado
 MpECPCZdpxE83K7zoGXumWwe6FaNCC47ppedQWlT64m0PL6Zwa8AwFL2OXPipf05djnb
 fSXg==
X-Gm-Message-State: APjAAAUjimxn19RJtk2xCVUkyUd2Wf1rOE0QHwcBtHFuwFCRGPrxjmbi
 z5DShAqnw3tDWI6wQtWTybNYh90RTvE=
X-Google-Smtp-Source: APXvYqyXKrO8h/2ufqMNr+kxAdYD2tBix+VL1dG4KoUHoUHfhP0Mm5Ndi89Gu1bIfcESq3Nk6J8m+Q==
X-Received: by 2002:a63:b642:: with SMTP id v2mr40768301pgt.126.1579208733618; 
 Thu, 16 Jan 2020 13:05:33 -0800 (PST)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id k21sm25494907pgt.22.2020.01.16.13.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 13:05:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/4] vl: Remove unused variable in configure_accelerators
Date: Thu, 16 Jan 2020 11:05:25 -1000
Message-Id: <20200116210528.31953-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116210528.31953-1-richard.henderson@linaro.org>
References: <20200116210528.31953-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, aleksandar.m.mail@gmail.com,
 philmd@redhat.com
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
index 751401214c..6a5abf2f54 100644
--- a/vl.c
+++ b/vl.c
@@ -2754,7 +2754,6 @@ static void configure_accelerators(const char *progname)
 {
     const char *accel;
     char **accel_list, **tmp;
-    bool accel_initialised = false;
     bool init_failed = false;
 
     qemu_opts_foreach(qemu_find_opts("icount"),
@@ -2781,7 +2780,7 @@ static void configure_accelerators(const char *progname)
 
         accel_list = g_strsplit(accel, ":", 0);
 
-        for (tmp = accel_list; !accel_initialised && tmp && *tmp; tmp++) {
+        for (tmp = accel_list; tmp && *tmp; tmp++) {
             /*
              * Filter invalid accelerators here, to prevent obscenities
              * such as "-machine accel=tcg,,thread=single".
-- 
2.20.1



Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B02C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 16:55:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E135322CED
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 16:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KG6G42am"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E135322CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i31ET-0001SV-Fy
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 12:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i31CE-0007in-2A
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:53:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i31CC-0000yN-0i
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:53:21 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38574)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i31C7-0000qo-1E
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:53:18 -0400
Received: by mail-wm1-x344.google.com with SMTP id o184so794115wme.3
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 09:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XYDil4p7u1BVyZvi3vGSRuZatnO0Tk5MNRsRKlBY+Xo=;
 b=KG6G42amMcs/3rRJ3gU2YP8WFdCEfyvNT9hc3pW5f7YxUqssWebEjiQv1Jen6KXAkD
 k7JUtKzbbF6JFZ9zyG4GkWYoeqIRgX86+TJ3MXcQusmskWnC4mPfIIthmeL7Et6/QsfF
 w3z22DvOxsw1yW4Gew3c/EcjzAYlcdpulwLAdynzEi2DsFLY7aMETuxOPwJ9CQBAW8eA
 WTH6cnFyjCjrshRPfc2P8P0wyO+S1pgD2ZHfqUpuB9pL4w2vulPlil2Y0kagHVkMROsE
 Y70Ut2mMEo/l2+6T8yxOmxx9LUchnfPWsiIjjVWzSJ4kv8up5RwCpVwoCQm6+BV0Ki5+
 7wJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XYDil4p7u1BVyZvi3vGSRuZatnO0Tk5MNRsRKlBY+Xo=;
 b=Uo2WWRrpr2znGa1cmtowGJqeNm6nwQtFoDYfeuj2orQwfP+g3zjzqxHvDC92x3giFn
 SSAsikw7wQ4lnw4ewdbv36SC6y2FOZGPIQ/7wN58dJ3JCrtmE/KaSrXK0VwLGln5+5hw
 +1pJc1icYwz9XwKghPyb/K3C9Ignp9owoMSfUEaRJcDw/GGWMaouDE7S/vyJs/Kdr52X
 rvXLE4ZCcXA9p/AguOf6MMZBaL6c5WHoDleVwK4WI6LGTKaZxThjsJbzSbTozfVqm5Nz
 mvFqbYUY3JdMfyhJjG47oz5oyxaxRjo7kgM92wzz6g3LWzKBYKSc+c2yiFGxEUX1elsn
 N8Kw==
X-Gm-Message-State: APjAAAUhNO6RTuhMspSqQCsXmHzO0hpO3p3dooBjv2vrt1+PSBI2yS/m
 /VMKZtwtYmXG5Sc+IFHYVcdLe9dRpi0=
X-Google-Smtp-Source: APXvYqw8anfacmi//HxUPIasSq4QPtCmADIH8zvHKx1RIoIg89USUKN2SUKqPRBISQgVxn1PUb9Vyw==
X-Received: by 2002:a1c:f007:: with SMTP id a7mr4465376wmb.172.1567011191456; 
 Wed, 28 Aug 2019 09:53:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a192sm302176wma.1.2019.08.28.09.53.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 09:53:10 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CABC61FF92;
 Wed, 28 Aug 2019 17:53:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 17:53:03 +0100
Message-Id: <20190828165307.18321-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828165307.18321-1-alex.bennee@linaro.org>
References: <20190828165307.18321-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v1 5/9] includes: remove stale [smp|max]_cpus
 externs
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Like Xu <like.xu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit a5e0b3311 removed these in favour of querying machine
properties. Remove the extern declarations as well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Like Xu <like.xu@linux.intel.com>
Message-Id: <20190711130546.18578-1-alex.bennee@linaro.org>
---
 include/sysemu/sysemu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index d2c38f611a3..44f18eb7394 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -42,8 +42,6 @@ extern const char *keyboard_layout;
 extern int win2k_install_hack;
 extern int alt_grab;
 extern int ctrl_grab;
-extern int smp_cpus;
-extern unsigned int max_cpus;
 extern int cursor_hide;
 extern int graphic_rotate;
 extern int no_quit;
-- 
2.20.1



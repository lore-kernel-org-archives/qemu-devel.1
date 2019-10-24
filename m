Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6BBCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:33:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73CB12084C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OZxXxbF8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73CB12084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNaQk-0001lg-F7
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 06:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNaGU-0001yl-AT
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNaGT-00042S-6t
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:46 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:36601)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNaGT-00041O-0Q
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:45 -0400
Received: by mail-wm1-x334.google.com with SMTP id c22so2033442wmd.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 03:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=S0J0OHtlkhtsiwOiMGa2JCRS3jdwpSxsM23Z6If6Jsg=;
 b=OZxXxbF8jAQlvMqksx4OORc4dFoAAmz8uVxyjJtU4yT8KNiMZYNmO88oFKGmBn2/EC
 o4PIzPgzdjjRugW0EPqVte1QsXijNlNHIgP9cbmN8lAbEM43utKWeGppjXuvJwy1IUTg
 A6jQ+jRCR48zJGNcre2fdOGHxF057aGLvE5ByN7cx5Dp6cRvlJKf0dqR9wb0+DKUkSr6
 QaNi8UVZBI5OraTagLpC0ecgk8rz44Ae5BMdHGBAN972hqYBqzUb+1z+2FHqMzcUap+B
 dTC33Z9kvlnkItavh65yfkar+wmR1y5CjDbWRUOuwPh1Brr2QfcNqdYFA8evsI0+VDkO
 DREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S0J0OHtlkhtsiwOiMGa2JCRS3jdwpSxsM23Z6If6Jsg=;
 b=pv98G7MuJFDmhzua3A6ekd1l0RDyiBku/kEWyv3Dfe8A5bvK9FeWJ94oSIZ3oitm8h
 zh7jaV5/OkjMdfyI7dVqv2s0hnOYGW0/IFv16kYKa7B8pfwUY/uoTzLs0J0Qx3dpvJSc
 myBkktBHREISlaWkJfNuGfLQrSqIbCTYQbSXlPl3cJqGAXhkJBaKpp+/dKeO7I697Eug
 mLT7OmssyiqDT6CkH9t+A8FNg028flc+f7WWDTpsTxLDwuL/5Q1BDVLlMv+1Z1FBLakp
 gqxP6wg/rDEXUim5N+tG/hfWQ6Zi+V5tLvfcb4RKwZ2bf20LxGwNGy8+SosjJC2K9PxI
 OC4w==
X-Gm-Message-State: APjAAAUaLc51bkmHP4fP89jCy9uDzn5jB3IHgVdb4oHPcoNhaf4OyT+c
 ANJZTVY2L5CZRd/afSdseSKMJw==
X-Google-Smtp-Source: APXvYqyQLRiolmekj0segdDJIcwW/5NNWWzhax1HK57iFlgDkWcPkZi1S1ojMUs7iaAsV1Q+IlFg2w==
X-Received: by 2002:a7b:ce88:: with SMTP id q8mr3909684wmj.160.1571912563430; 
 Thu, 24 Oct 2019 03:22:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f143sm2023341wme.40.2019.10.24.03.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 03:22:41 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7D94C1FF8F;
 Thu, 24 Oct 2019 11:22:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/17] travis.yml: Add libvdeplug-dev to compile-test
 net/vde.c
Date: Thu, 24 Oct 2019 11:22:25 +0100
Message-Id: <20191024102240.2778-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024102240.2778-1-alex.bennee@linaro.org>
References: <20191024102240.2778-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

This library is needed to compile the VDE network backend.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191009170701.14756-2-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.travis.yml b/.travis.yml
index 7d90b87540f..7be2a9949f5 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -46,6 +46,7 @@ addons:
       - libssh-dev
       - liburcu-dev
       - libusb-1.0-0-dev
+      - libvdeplug-dev
       - libvte-2.91-dev
       - sparse
       - uuid-dev
-- 
2.20.1



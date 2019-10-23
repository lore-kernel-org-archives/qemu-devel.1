Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28791CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:02:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4FC3205C9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FuHRWKfk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4FC3205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNJ5i-0003Cf-Tn
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 12:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNIp4-0004ky-9O
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:45:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNIp2-0005Z9-Uw
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:45:17 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:44118)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNIp1-0005TG-1P
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:45:15 -0400
Received: by mail-qt1-x843.google.com with SMTP id z22so12436658qtq.11
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 08:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qse2dU+9DDWN9Jnukz33b9KCxbTfJVcInGskyFTMfNk=;
 b=FuHRWKfkKKiXQSuHFviEiHAH6gXryMMRKVBOqBve87UIFlFlT0XuwqdeAcoSykCNo+
 /SQRVg6LCxROdcCyyB8MqO0/tBKTs+31Qo87VVKM2w7Rs5Z++Ib8TG4ePTP6s1LAH6Gv
 0H1Ju0rjEAnzHpM5K0lmisiLOjSUr1fEREJ81WOSLWBQKFJ5v2q5IRdrqaXmpGC54poX
 EtwvZUZsqu5Ij+HoZwMoUQbMRupaTSwHppN3TqfoRyTXIMiCWYOyaxjZ08baiNa7qFcL
 1j31W2UzjjidYB9OU/l1HSfegl/zPVAH7clIMLy8jkWygGjkI2FqudlMbL+kW4e0SY1/
 Gtrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qse2dU+9DDWN9Jnukz33b9KCxbTfJVcInGskyFTMfNk=;
 b=hkfN21KPaaXKnpmo7HaC9iDHkn+C+ucMw/ZVaY9SmZMNlIeQvv0/OPcGN86rGXelBT
 OBQWmdYrambdLGJQU/eGRITcxyFzmc4DxVj7I9MeC89Tx+xYgVgmEXHlpF8hAqDIGoxu
 XUryiaf7K9MSaRvTHuOvuxFQyRPTGYd95Fv5OyKKL8m9V/uymRxFmKo+lho0w2hVYea4
 6EALdpMfoEjRUWb+ejPFZutmRd/jO9oUoyfqpMjYeMhh7AZRTGkjOC9vpfsoWnk4cAI2
 6HNc/T/Th3AZE4z6lEYnt+2hUQPmCxw39Z0OUsQ93xGHl3Gom0q65ztp6kILRFtELwcm
 RdCA==
X-Gm-Message-State: APjAAAWx8cDrGhBd6qL9ojXI0j8jFbiM1gjoI9tcS2TQA7cPoH503GRy
 Nx/+aXIW9W3h+icAR5KMeCO/nmt8YIw=
X-Google-Smtp-Source: APXvYqw/ZwCxViqMKoKEV2tcDv81yvz1OKL9h6uhBdnTrs/97/frVC5+Wff5yZs6Pils3qpq85WFnQ==
X-Received: by 2002:ac8:7082:: with SMTP id y2mr10067641qto.386.1571845513447; 
 Wed, 23 Oct 2019 08:45:13 -0700 (PDT)
Received: from localhost.localdomain (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id o1sm2456272qtb.82.2019.10.23.08.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 08:45:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/7] exec: Restrict TARGET_PAGE_BITS_VARY assert to
 CONFIG_DEBUG_TCG
Date: Wed, 23 Oct 2019 11:45:03 -0400
Message-Id: <20191023154505.30521-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023154505.30521-1-richard.henderson@linaro.org>
References: <20191023154505.30521-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This reduces the size of a release build by about 10k.
Noticably, within the tlb miss helpers.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 76515dc8d9..d3e4660d50 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -219,7 +219,11 @@ extern const TargetPageBits target_page;
 #else
 extern TargetPageBits target_page;
 # endif
-#define TARGET_PAGE_BITS (assert(target_page.decided), target_page.bits)
+# ifdef CONFIG_DEBUG_TCG
+#  define TARGET_PAGE_BITS (assert(target_page.decided), target_page.bits)
+# else
+#  define TARGET_PAGE_BITS target_page.bits
+# endif
 #else
 #define TARGET_PAGE_BITS_MIN TARGET_PAGE_BITS
 #endif
-- 
2.17.1



Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF65C33C9E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E73BE2070A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TAqoz4P2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E73BE2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2hc-0007yP-1O
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 23:12:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Jj-0005mQ-AA
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:47:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Ji-0004Rx-6B
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:47:35 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:37213)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2Ji-0004RB-0r
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:47:34 -0500
Received: by mail-pg1-x52d.google.com with SMTP id q127so874516pga.4
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RzXBbhxl96ISJyXRfF2leNwAZhzfRVDaPz7xNTcibJE=;
 b=TAqoz4P2xKcAp0SrGhlNYnU9NaPsMDw/CvWocI21QsElPumrYluW8Sy9e3369osFSR
 oYi4NbxnrYHARPpT/cm7nOyJwucpBeGBL53VzUrWmu22N4vRgcp7h627sADyzqpq3lFS
 fxpddnkjWgfd3t2b9SGhOkHE0udFhvx+vtx2vdPPt6sgFpH28+NaGiFb2mkT/K3wLe2y
 2s0SCOncROGulijX2Z258H7ps8AEHZ0Ku2wJf/wKUg4R56ojKJCdNgwFf9NiGTFDiL51
 N3Q3yEL8i1TA95Ux+KnvSsDrwchUGha/M9K+yGYFdeF1SVVCYPLmpdZlhJFOM6UIiRNH
 c7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RzXBbhxl96ISJyXRfF2leNwAZhzfRVDaPz7xNTcibJE=;
 b=bz2mQmSHsQ7cxTIS4ElUkqoAzfNIL73uwHGaWL2QNL0VgfA9LlnKXFoQUH1Zla+fjW
 mDdnBEUTEbpFDr+kMS0Nwe/g8w/CNux8591ZGOg4JrKXOo9a091an4mqEFSu6lnCmqQP
 +kcn0dpR+G+DXeWvB+AMkquIFPpfkadHrwT4j44XwMyCVN4XCMC+aVIsc+ppFnXklDBi
 gl0mQGY8P5vZ+RbOnELEWwkdzt3NHHC9clKI7EexjQUVTeVXm1OeP8iGtatDRXEAOKO1
 /ONHelTbokHDXuveiqa2O6r4wb9HLBYY6tAu4+NByNtK6FVUdLWnGUt7Hg9c1rNvehu/
 +ZGw==
X-Gm-Message-State: APjAAAUMCr8I22XKUBf9j8svd8ea15n9VHfZohqCYMpYl7MI0jbE9yV6
 Lga6n7e9FS6i+T/HUShDG3H5Fvzd62+tzw==
X-Google-Smtp-Source: APXvYqyJIjSL+0r/DNG2izx6PHeVU9XntEhoZXADTcp7EHNO/Uq23qcb9hEq586osUMk/YcVT12XsQ==
X-Received: by 2002:a63:d108:: with SMTP id k8mr3055415pgg.434.1578455252611; 
 Tue, 07 Jan 2020 19:47:32 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:47:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/41] tcg: Move TCG headers to include/tcg/
Date: Wed,  8 Jan 2020 14:45:21 +1100
Message-Id: <20200108034523.17349-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108034523.17349-1-richard.henderson@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52d
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
Cc: peter.maydell@linaro.org, Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200101112303.20724-4-philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 {tcg => include/tcg}/tcg-gvec-desc.h | 0
 {tcg => include/tcg}/tcg-mo.h        | 0
 {tcg => include/tcg}/tcg-op-gvec.h   | 0
 {tcg => include/tcg}/tcg-op.h        | 0
 {tcg => include/tcg}/tcg-opc.h       | 0
 {tcg => include/tcg}/tcg.h           | 0
 MAINTAINERS                          | 1 +
 7 files changed, 1 insertion(+)
 rename {tcg => include/tcg}/tcg-gvec-desc.h (100%)
 rename {tcg => include/tcg}/tcg-mo.h (100%)
 rename {tcg => include/tcg}/tcg-op-gvec.h (100%)
 rename {tcg => include/tcg}/tcg-op.h (100%)
 rename {tcg => include/tcg}/tcg-opc.h (100%)
 rename {tcg => include/tcg}/tcg.h (100%)

diff --git a/tcg/tcg-gvec-desc.h b/include/tcg/tcg-gvec-desc.h
similarity index 100%
rename from tcg/tcg-gvec-desc.h
rename to include/tcg/tcg-gvec-desc.h
diff --git a/tcg/tcg-mo.h b/include/tcg/tcg-mo.h
similarity index 100%
rename from tcg/tcg-mo.h
rename to include/tcg/tcg-mo.h
diff --git a/tcg/tcg-op-gvec.h b/include/tcg/tcg-op-gvec.h
similarity index 100%
rename from tcg/tcg-op-gvec.h
rename to include/tcg/tcg-op-gvec.h
diff --git a/tcg/tcg-op.h b/include/tcg/tcg-op.h
similarity index 100%
rename from tcg/tcg-op.h
rename to include/tcg/tcg-op.h
diff --git a/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
similarity index 100%
rename from tcg/tcg-opc.h
rename to include/tcg/tcg-opc.h
diff --git a/tcg/tcg.h b/include/tcg/tcg.h
similarity index 100%
rename from tcg/tcg.h
rename to include/tcg/tcg.h
diff --git a/MAINTAINERS b/MAINTAINERS
index cd2dc137a3..1c6919c455 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2386,6 +2386,7 @@ Common TCG code
 M: Richard Henderson <rth@twiddle.net>
 S: Maintained
 F: tcg/
+F: include/tcg/
 
 TCG Plugins
 M: Alex Bennée <alex.bennee@linaro.org>
-- 
2.20.1



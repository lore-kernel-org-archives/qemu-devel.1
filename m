Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0DFCA9EBC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:41:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 795432064A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xt2/AoHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795432064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO0mm-0004Y1-04
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 10:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44327)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iO0Th-00053x-VO
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iO0Tg-0001dH-Sf
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:09 -0400
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735]:33141)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iO0Tg-0001d2-Od
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:08 -0400
Received: by mail-qk1-x735.google.com with SMTP id 71so1928542qkl.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 07:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZwXbM1gR9MpWZvFXDuXSv541qXotelrmjZ6gTXEMEYw=;
 b=Xt2/AoHig+fMveab3f6ZpL1cn9Wiki3qnn6nW/icRxs2e5rdQBX2auMG2NVyN7McOO
 L1Z8wDuJ7LCssfm7PTIgJuRsmDJ6ch2566LrdrbtpEBc7BLR7/smmFM1b0O9DTlPxIhK
 yPTJJqxyhsEulzJKm6A6K4lS5vl5F9iYAPL3j3xEkn9EuhDsc6EPlRIJsxGuB5677Grz
 MkCRKquf7hQ0rVy9FrUJIGmVXOeqwUx1faf2qJfheGUeS4JFo1wKGFn2CnTCTRtHd7Sr
 NG8QuzOSu/skZG3pKALCXUgsvi66sLscUpR1viD2A+BxGy1Zj3UWUQjge1+F0rTGO2oy
 8qlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZwXbM1gR9MpWZvFXDuXSv541qXotelrmjZ6gTXEMEYw=;
 b=Kz1ItPHaboB87dRmclWT5sUiSvC35mGbZRUC2FMp+Y2i1G0jglzSk3/BHZ3n3oiAny
 sk38V8PJpq/8BSVXSuzljJlcPURPNCEcLMyevg6CiLpm8p/vGjBQB0XnseqJ5n1YRNJf
 nbWSPYXpYiq1C+g5a0jCIdMf/+YKFoKC43uWv/ILHBkG6AERG9bSnDPk7NA7mWroie1y
 0SRe/oHclk8e+Rsd7MI8INuN8/Ceafz/r+KDe+0DJModb7rHPy5waxFr+JLEofLvFfL4
 keg5/HaF6jboi7ZJUGyTuvhaq7SI0g79rCGZP2/7p42Z+WUvddOSQscGJjHIlWUpPr8k
 4k0w==
X-Gm-Message-State: APjAAAUnqQLKVMl28AFI8Qf71sJ4iqJMCtIQJnwob2snVMFF7wFTwOcZ
 p94qrnFq+s/o18VZ+Bh6jU38aAf6er0=
X-Google-Smtp-Source: APXvYqwZMgry29KNDYn4F9vzU3Lg5lyqbYr5lWca0Osz6R9X/B265Cd411YYvWMjocKjcT3+8oJ0xw==
X-Received: by 2002:a37:388:: with SMTP id 130mr3169905qkd.378.1572013327780; 
 Fri, 25 Oct 2019 07:22:07 -0700 (PDT)
Received: from localhost.localdomain (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id q17sm1137050qtq.58.2019.10.25.07.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 07:22:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/12] configure: Detect compiler support for
 __attribute__((alias))
Date: Fri, 25 Oct 2019 10:21:52 -0400
Message-Id: <20191025142159.12459-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025142159.12459-1-richard.henderson@linaro.org>
References: <20191025142159.12459-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::735
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Such support is present almost everywhere, except for Xcode 9.
It is added in Xcode 10, but travis uses xcode9 by default,
so we should support it for a while yet.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/configure b/configure
index 145fcabbb3..3a9862fe5e 100755
--- a/configure
+++ b/configure
@@ -5518,6 +5518,21 @@ if compile_prog "" "" ; then
   vector16=yes
 fi
 
+########################################
+# See if __attribute__((alias)) is supported.
+# This false for Xcode 9, but has been remedied for Xcode 10.
+# Unfortunately, travis uses Xcode 9 by default.
+
+attralias=no
+cat > $TMPC << EOF
+int x = 1;
+extern const int y __attribute__((alias("x")));
+int main(void) { return 0; }
+EOF
+if compile_prog "" "" ; then
+    attralias=yes
+fi
+
 ########################################
 # check if getauxval is available.
 
@@ -7083,6 +7098,10 @@ if test "$vector16" = "yes" ; then
   echo "CONFIG_VECTOR16=y" >> $config_host_mak
 fi
 
+if test "$attralias" = "yes" ; then
+  echo "CONFIG_ATTRIBUTE_ALIAS=y" >> $config_host_mak
+fi
+
 if test "$getauxval" = "yes" ; then
   echo "CONFIG_GETAUXVAL=y" >> $config_host_mak
 fi
-- 
2.17.1



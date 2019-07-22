Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B73C76190
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 13:16:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9452221921
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 13:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q7KSpSyc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9452221921
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpYAb-0003vX-S0
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 09:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47673)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hpY9F-0007Us-LB
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:14:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hpY9E-00038h-Fs
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:14:37 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:46984)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hpY9E-00037u-A0
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:14:36 -0400
Received: by mail-wr1-x42a.google.com with SMTP id z1so39347024wru.13
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 06:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=017UTObH7jJptsckGJh0SSq+6RtfkpOFjT0jK0dZ1dQ=;
 b=Q7KSpSycvGW1FzeKrPMcA2A/oQvg2gbdlUzkA3G2uCqAgt+j/316NUze2KJpvwqNNC
 q60WTpcaxvw4Kmlz7rsBSketIwVarjAsMSfi6rWC17GhMSDIXVrp8cNoVOE2D29T8LRA
 0TC3VyDOS1mSjVAM2s8Cx+0BNamqrJmAU92PXeCednaL2qREsU+p9VnHVwIRquv4d+d7
 mpDiOZevmsuWJYKBazktdWYV184IFF4RtzAYunuBHuMOejcYoFLLlajKzJ8eHpzNGHNH
 qqVLq6SISTG49+CjBrS5JbpDe8UR0VQpzxrA0jn+/Lfbap2aZy9rQSi2KknFIa1VCi3T
 YKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=017UTObH7jJptsckGJh0SSq+6RtfkpOFjT0jK0dZ1dQ=;
 b=mbNzblwT+9rlQq3YBA8rl5VJnLs0rygXkRVBWqWiErY3E10Ty1Y/HPzUEQtO3gAc0U
 dGxtlUK/ypq4Xtw22yZjsHxAEh5v0K/7iugFJ65dhbAYaZaSsiFbQslLOAunpG3pbNfH
 lkambSmoVqNicf8qXr2fDWKBX9yMRs5g4hwVsnr9WT29J3KJWaG6E+GV6Kfjo1dwJ2pH
 OmcwE+wd6id3WVHj+ZdrL6GgWGuUay4jYtsJdUtmd6D+R1Dlv62svg7xS+qJDXTRNQz+
 yZWKI+YYVN/Ll1K+oRzuxr1bb4hd7oX/Y7qYrSW6UMClj9DLow1MMCcpeep8R360qtbK
 ZFbw==
X-Gm-Message-State: APjAAAUDjPtqQEoYEvxsiMPt7YFUfXNMMS5Aq5bas1O5rhkwJaTGP0bG
 /4HvJHPhTu6uhox7r4YfPp+3oUQbsTxW1g==
X-Google-Smtp-Source: APXvYqxy7UsRxuGRjsbE2rM+oFc3LiqFpwZIhg05sg2EfE2NAiEq9b1iWkMjB8fSyi9XmyfzaqLwqw==
X-Received: by 2002:a5d:5012:: with SMTP id e18mr46752005wrt.166.1563801275126; 
 Mon, 22 Jul 2019 06:14:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f12sm42207217wrg.5.2019.07.22.06.14.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 22 Jul 2019 06:14:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 22 Jul 2019 14:14:27 +0100
Message-Id: <20190722131427.2669-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722131427.2669-1-peter.maydell@linaro.org>
References: <20190722131427.2669-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
Subject: [Qemu-devel] [PULL 5/5] contrib/elf2dmp: Build download.o with
 CURL_CFLAGS
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

contrib/elf2dmp has a source file which uses curl/curl.h;
although we link the final executable with CURL_LIBS, we
forgot to build this source file with CURL_CFLAGS, so if
the curl header is in a place that's not already on the
system include path then it will fail to build.

Add a line specifying the cflags needed for download.o;
while we are here, bring the specification of the libs
into line with this, since using a per-object variable
setting is preferred over adding them to the final
executable link line.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-id: 20190719100955.17180-1-peter.maydell@linaro.org
---
 Makefile                      | 1 -
 contrib/elf2dmp/Makefile.objs | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 386e13a6ea0..ecb788b2ce3 100644
--- a/Makefile
+++ b/Makefile
@@ -626,7 +626,6 @@ ifneq ($(EXESUF),)
 qemu-ga: qemu-ga$(EXESUF) $(QGA_VSS_PROVIDER) $(QEMU_GA_MSI)
 endif
 
-elf2dmp$(EXESUF): LIBS += $(CURL_LIBS)
 elf2dmp$(EXESUF): $(elf2dmp-obj-y)
 	$(call LINK, $^)
 
diff --git a/contrib/elf2dmp/Makefile.objs b/contrib/elf2dmp/Makefile.objs
index e3140f58cf7..15057169160 100644
--- a/contrib/elf2dmp/Makefile.objs
+++ b/contrib/elf2dmp/Makefile.objs
@@ -1 +1,4 @@
 elf2dmp-obj-y = main.o addrspace.o download.o pdb.o qemu_elf.o
+
+download.o-cflags := $(CURL_CFLAGS)
+download.o-libs   := $(CURL_LIBS)
-- 
2.20.1



Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8A1CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:56:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3356920679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ni9w/Cxl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3356920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNanN-0007do-5h
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 06:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55287)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNaOz-0000hC-EH
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:31:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNaOy-0007og-8b
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:31:33 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38034)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNaOy-0007oJ-20
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:31:32 -0400
Received: by mail-wr1-x444.google.com with SMTP id v9so14185203wrq.5
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 03:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FAqFQJqp9wB9CdQPIdWZc2GaC2MYvXPxclSsx2WiX5w=;
 b=ni9w/Cxla3lsJ4R76bMS0LfSaR4jkqtLFP5FIxKDn9WcbXi3Gpf0Ve2GGAa81Y8u6y
 +t37YNfVvCWKOz1Ver8w8Qah8cb+AUxuuiuR8Y4wysqk88pPPMXjyC6KbenA/jchCPTx
 BBRBAIymOXXw39xUwGhtgntNbNJrYLEyD28NagqKF8+fCqnGbrji57KbtW4q2dmuAW/6
 scaaE5QgybTNPLmlFOTZfXzi2V58gLFS1w0ug0B6XCQWaMy2GnuAj3cVMDkuumoSzK5n
 XJ+w5SaPx1mjEZdpNM2oY7eKYU8SyCwnfhcdZujV4S27KdKlxekgF3Is280D2ZpDC1oW
 nvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FAqFQJqp9wB9CdQPIdWZc2GaC2MYvXPxclSsx2WiX5w=;
 b=D+mKSsd8pNR6Nr7F9DvLZkOvSfx9W6hCa0l/bAM2H5c8l6JX7GklHIFi08+tJK/BIL
 su3rpFIUCnINnQ2gSdnBQl9sMMBvEfiu4TRdzFgoBdsVbZidzeFXSYTXRJ4BTzLkh5ya
 muRdZr3OPOaXa2EBh5moRVguNzbY4Ib3LH8EUQtO1i3ZUBUUvY7LY+Lw8bQReSfynue3
 P+m9qInTDjfj7y7woqZ5hYYYLr2OLMDJtbeCWIAv0nu4QbFnuM20DHe7HxNON5uNofMV
 dSrc5bn6T4UZPQcTInGUvzY33v8/fNlNyZ+Vbti22em4xOrX3AMqwGr78CAWqCSqj1x6
 ddrg==
X-Gm-Message-State: APjAAAU5qODtIlFIPnGop3IWGAmfCSC1ADsGK2PwgxEoYvtf3lR2rR1i
 IyYJXEXz1Od8CkstbE14WZkEOA==
X-Google-Smtp-Source: APXvYqyLdaSlj9MJ/kCbhH4tXNg1wV4GHNk83NC3X4HH1uH7gVqEMUDc7dYiKqTKQ1yFvduOPemHsg==
X-Received: by 2002:a5d:4644:: with SMTP id j4mr3345152wrs.355.1571913090926; 
 Thu, 24 Oct 2019 03:31:30 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k8sm46265710wrg.15.2019.10.24.03.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 03:31:28 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6D19E1FF9C;
 Thu, 24 Oct 2019 11:22:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 12/17] tests/vm/netbsd: Disable IPv6
Date: Thu, 24 Oct 2019 11:22:35 +0100
Message-Id: <20191024102240.2778-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024102240.2778-1-alex.bennee@linaro.org>
References: <20191024102240.2778-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
 Eduardo Habkost <ehabkost@redhat.com>, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, cota@braap.org, stefanha@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eduardo Habkost <ehabkost@redhat.com>

Workaround for issues when the host has no IPv6 connectivity.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191018181705.17957-4-ehabkost@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/netbsd | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index 9558a672efa..d4dd1929f2d 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -63,6 +63,13 @@ class NetBSDVM(basevm.BaseVM):
     """
     poweroff = "/sbin/poweroff"
 
+    # Workaround for NetBSD + IPv6 + slirp issues.
+    # NetBSD seems to ignore the ICMPv6 Destination Unreachable
+    # messages generated by slirp.  When the host has no IPv6
+    # connectivity, this causes every connection to ftp.NetBSD.org
+    # take more than a minute to be established.
+    ipv6 = False
+
     def build_image(self, img):
         cimg = self._download_with_cache(self.link, sha512sum=self.csum)
         img_tmp = img + ".tmp"
-- 
2.20.1



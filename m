Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3803AC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 20:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0238920850
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 20:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qB3wHsq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0238920850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49611 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPCFE-0001jY-8M
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 16:35:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hPCER-0001MS-9C
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:35:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hPCEP-0007Kf-UR
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:35:03 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:40932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hPCEL-0006yA-HK
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:34:58 -0400
Received: by mail-pl1-x644.google.com with SMTP id b3so3336563plr.7
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 13:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=7vmrE3P4TVjsKYtNMDaI+6ptGlXtemIm7wnPvGwAlNA=;
	b=qB3wHsq5erdNmHHbOpbqLEJ+iTx0bpJVqbYNNslsP0ONg3d/xbGP5AXR3GMB0o9WyG
	+V3K8iQbZjfJf73VHsfZ69r18E1Tca/QtkVyZwZIP4HsH6luq6oCmYe/VT4AOAW5UC9M
	FLBoG2GYTXnQFOYD7NzwwGudJFXdoI/YVbSNWiwZRrew+KmmdLqIHMFSgugKe9LRcluJ
	JjXyhIWXUAeIw7AupJ23V8GChscYGRXWBgb0ZovYNMIE+Jaex/LEHAIIgfVp2kBxUbTo
	hKb5B/5tsEhjOxHqyXfroYiqKK4Yu8/NmbpFYQCVtxR9QIiRXRUD9tS1O98jjSC7gnaS
	B90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=7vmrE3P4TVjsKYtNMDaI+6ptGlXtemIm7wnPvGwAlNA=;
	b=bGLKu49cfnFOdZS4HuKeVNnKCLE33FEFkXy1mMaRiltM9qmi8PokOvTQcABMtOLGvm
	4ULSKmpYqHxnT+N1ZYy1JpnLNNLEylT6JLRmLyS7FgfKWACYtVTgc1OXfJRLB5fWZgHd
	126NjHAOzWyboqZSNS3fpZaVMKur3nrd0+ylJenUoVoXuJknhUKHXOJglTH8AgQq7l+E
	MXEnMlNSWv+gfLhf1/yktQ5x9XKkjDTtGTXnOEc4XR+h3+7TRz0OH7+ieOjibQdW/Xwt
	7P+KYDuQkysYxj9cN3rmE+qYEExIQyTP2dPH/opZdr5sS9gp4o1w7+ATHH7CuFo5qQUH
	MDhg==
X-Gm-Message-State: APjAAAXCVNXd2x1TkuMGr82XI2U0D1DgZTv6zduqk0UBJbR8h+sAeiCe
	Rg6kjsPrJc2t0LQsB0xrbAzVRpxzmkg=
X-Google-Smtp-Source: APXvYqwzzbmul2zgolOopYx1TSLmSLdFFBXttDC4UFuPAbo3kt+oFF1sPyo8q3dkeQmd1yVUxmteqg==
X-Received: by 2002:a17:902:8e88:: with SMTP id
	bg8mr15390485plb.173.1557520494550; 
	Fri, 10 May 2019 13:34:54 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	a129sm7739200pfa.152.2019.05.10.13.34.53
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 13:34:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 13:34:52 -0700
Message-Id: <20190510203452.11870-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH] configure: Disable slirp if --disable-system
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: marcandre.lureau@redhat.com, samuel.thibault@ens-lyon.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For linux-user, there is no need to add slirp to the set of
git modules checked out, nor build it.

This also avoids a makefile bug wrt insufficient dependencies
on subdir-slirp.  If slirp/ is not initially present, the
dependencies that check it out are associated with softmmu,
which then generates a build error on slirp/ not present.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configure b/configure
index 63f312bd1f..9de7e43a80 100755
--- a/configure
+++ b/configure
@@ -5878,6 +5878,10 @@ fi
 ##########################################
 # check for slirp
 
+if test "$softmmu" = "no"; then
+    slirp=no
+fi
+
 case "$slirp" in
   "" | yes)
     if $pkg_config slirp; then
-- 
2.17.1



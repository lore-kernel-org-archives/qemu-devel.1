Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC19C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:22:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F53820842
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ggzu6F2R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F53820842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8phy-0008Lx-Fj
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 13:22:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43615)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8pfD-0002Xr-Tp
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:19:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8pfC-0001EI-Fr
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:19:35 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:38158)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8pfC-00019i-9E
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:19:34 -0500
Received: by mail-wr1-x429.google.com with SMTP id t11so983931wrw.5
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 10:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dCr0Z8PfAqS4rx+S0HXKAf2zVkW9ZlqRt2oF49qU2FA=;
 b=ggzu6F2Rbxl79fGhkDUyBM16K3abHaWTrABJHewKUCzSaJpB2PrWdvtwayeO1tS2J+
 VNqqEXu+aODvWEB7gfrsBLU0NcA6QZqZ8uBos+K6UA55MkQVPGZ3M5BfwX304QN40L+4
 kcyapHCEi9Cxa78lv1k5ltur2Hk+q91+hfp3auxUGaC/9NdEsAGR40vOEN47L7kzRbS0
 o/Dit0bfq3HL7wgzzEVQmnuxzZRBQggBAf2mOFDbYW/56y5lbKyROgb4skB0PJ3i/4Q/
 cWYEBQ3qHdTe4uzJy+nFA2sfTfZNrRXe6dhO8fe2r40H+DWU1XQshlHlJBXY7S2j5h8z
 9vhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dCr0Z8PfAqS4rx+S0HXKAf2zVkW9ZlqRt2oF49qU2FA=;
 b=tGkEM8+o/tU69PYBHFWk73sd04ugW3H/NjIC5BN/KbfoHossvHGNMB51wnkh2QpbjC
 Gscxl5tO29W7qOAcz8b7A4iXk/OwJ0w/wALGmh+WPUjdyhVvNAdP3FRF4vkwtSTgvGiU
 NQBfPgclpUjjJ+iJOrECvMHm5dRhWdMADk8HcV9xVDiohlvaVYl7NUlljz07u5wN+82J
 ZSssvKU/L/6tf3BdVZFvkNNl2tJRwqQjgIwx4bAK6gbh/fad/QLF9OtrnufuPOwXvpNW
 /4KLqShxKkDuMi0oALCzQ2utRNhLfWxZXik2AvObarQhRpx+PsxTpmRkTXNRSIvBQVvh
 rk4w==
X-Gm-Message-State: ANhLgQ3LhcHSUq7cKSG6k7lcegzfZ1BLPhQID42a+GnA7r/YrnEXSqe3
 t1PgkzWIbkYiPA/6pwUBbicwiw==
X-Google-Smtp-Source: ADFU+vtUocKf9bHW/GfljfYbNxyom7lG+rzzSPsRs5PNpdBMWSWP6qTuj+BOkb+uWQDmcqF4KfoC+Q==
X-Received: by 2002:a05:6000:4b:: with SMTP id
 k11mr805024wrx.362.1583173153067; 
 Mon, 02 Mar 2020 10:19:13 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z12sm2842292wrs.43.2020.03.02.10.19.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 10:19:09 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BE5841FF90;
 Mon,  2 Mar 2020 18:19:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 03/10] tests/vm: increased max timeout for vm boot.
Date: Mon,  2 Mar 2020 18:19:00 +0000
Message-Id: <20200302181907.32110-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200302181907.32110-1-alex.bennee@linaro.org>
References: <20200302181907.32110-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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
Cc: Fam Zheng <fam@euphon.net>, Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

Add change to increase timeout waiting for VM to boot.
Needed for some emulation cases where it can take longer
than 5 minutes to boot.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200219163537.22098-4-robert.foley@linaro.org>
---
 tests/vm/basevm.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index c99725b8c0d..5ca445e29af 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -57,6 +57,10 @@ class BaseVM(object):
     poweroff = "poweroff"
     # enable IPv6 networking
     ipv6 = True
+    # Scale up some timeouts under TCG.
+    # 4 is arbitrary, but greater than 2,
+    # since we found we need to wait more than twice as long.
+    tcg_ssh_timeout_multiplier = 4
     def __init__(self, debug=False, vcpus=None):
         self._guest = None
         self._tmpdir = os.path.realpath(tempfile.mkdtemp(prefix="vm-test-",
@@ -309,6 +313,9 @@ class BaseVM(object):
         sys.stderr.write("### %s ...\n" % text)
 
     def wait_ssh(self, seconds=300):
+        # Allow more time for VM to boot under TCG.
+        if not kvm_available(self.arch):
+            seconds *= self.tcg_ssh_timeout_multiplier
         starttime = datetime.datetime.now()
         endtime = starttime + datetime.timedelta(seconds=seconds)
         guest_up = False
-- 
2.20.1



Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35B1C3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:10:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E25720842
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m2BbtaOO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E25720842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j99Bw-0003NV-QC
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 10:10:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j9981-0003Cs-Or
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:06:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j997w-0001ki-Vn
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:06:37 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55510)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j997w-0001kU-Pv
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:06:32 -0500
Received: by mail-wm1-x343.google.com with SMTP id 6so3615596wmi.5
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 07:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mdvWh9OrF/L9iRiaqnANinaDnfQj3vHE3kNBKnfVJSk=;
 b=m2BbtaOOZtbEjLhCMqvpzY7KwujwpNKZs1+WNNgZJ6W7Jf6l+MeOIHJJQLGS+E+LOp
 2Ne/pn7rj0aaNaviasNlWk+UiUgXnKD2ZsYHLnmnkLDQAKV/Hb+e+1bq//DWOH4VFGDd
 zI0xQr0pvjTA7KcXZ7X7/fJMjX/rCCE85nXj1csaSkJoT2FCoeY+/xODrfNPAfwJsZVO
 kiW+/d11d3FkWQTT4+n128IAittVT1XwmEHPRQMFph8ug2dYWht7e+cBf1IRJ+kVNwfQ
 TFLMZ9hDPv76oUJwzz/oQLRkljNCMrm+mDgOfxjIP7A3+l8rxjMGDaCuW7mEa/OerPs8
 BzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mdvWh9OrF/L9iRiaqnANinaDnfQj3vHE3kNBKnfVJSk=;
 b=QRyBgaQXJmnSIePf7UR9UY6quy+Ll83JSQbTp6SjfNmKghM/OCsv1H7CVOgKWnR85V
 rdsNXBMncPz0JmLyxn8k54JARR9BBPo5luS6qg3mv4JVpfZ+hI88wPVEqt3cuCGB1ene
 2BAzcaes4TUwYFAnM+GiZPmukkt+xr8v96Hq1R/5GwFhxr5nq0qx52hizDI9jGYweewO
 /iwNUERoMGrJPW95KrRbVRJmGVmt7ItY1Z3COEmIwRiICpRVsO+Nx/MEfonKx+ASJGQX
 mcBg3PCfunEhqFtxYktmrkE4YdJ/N8jo0Ke6fsgY3ogC7b4tdymHXmwfocp4JsS669Ud
 FjFg==
X-Gm-Message-State: ANhLgQ1qCcBbh6E+7oMuxabb61U/s7wlXDjxoIMaAKGm6rqzNntAjQTZ
 SLwV0SRtJBvBtudemkqTXxMib8FafKM=
X-Google-Smtp-Source: ADFU+vuJyjxYdCDdwbw+C+NrDQ+mXRSBggKNIEMlY0qO5WJW8lNnPXHS7ta/kBu8ynB0GDdi/BXmbw==
X-Received: by 2002:a1c:6884:: with SMTP id d126mr4539032wmc.38.1583247991682; 
 Tue, 03 Mar 2020 07:06:31 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p16sm33887682wrw.15.2020.03.03.07.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2020 07:06:29 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E82981FF98;
 Tue,  3 Mar 2020 15:06:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 8/9] tests/acceptance: bump avocado requirements to 76.0
Date: Tue,  3 Mar 2020 15:06:21 +0000
Message-Id: <20200303150622.20133-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303150622.20133-1-alex.bennee@linaro.org>
References: <20200303150622.20133-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we want to use @skipUnless decorations on the class we need a
newer version of avocado.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/requirements.txt b/tests/requirements.txt
index a2a587223a9..f4f1736a086 100644
--- a/tests/requirements.txt
+++ b/tests/requirements.txt
@@ -1,4 +1,4 @@
 # Add Python module requirements, one per line, to be installed
 # in the tests/venv Python virtual environment. For more info,
 # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
-avocado-framework==72.0
+avocado-framework==76.0
-- 
2.20.1



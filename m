Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A58C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 14:57:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F381920656
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 14:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="llKqRYuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F381920656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUXbo-0002eo-1j
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 09:57:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iUXV8-0003SZ-8s
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:50:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iUXV7-00035A-42
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:50:38 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:37267)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iUXV6-00034f-UH
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:50:37 -0500
Received: by mail-wm1-x32f.google.com with SMTP id b17so3265376wmj.2
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 06:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KwclHsri8LmcLI50PiGGlusR9EB2W9H/laTcrk7KH84=;
 b=llKqRYuFmltnlWlwuRcDU/M/P/QDcQIOmcthPeo73idJ4OeK1K3eF7phISpYNGU1YO
 IZNgruGetqUsL5DTZiFWkJsS84P9OdvC0jKbC43Uu3XkU5Lx6UsD1G7juaEePZwFzqeF
 UDFYFylbK4H6B/USvXdXeR7gKHYDVB6r3dHmXBWVwCsl5v2G0zSFUgSciNHxFXq1V866
 hhHLSxgEzieLCrjs5KoygkPP8M5nfPTcPTLszWDHYWxUbJasqAV2TPoVm0CTQPqfo96O
 Y4SqMtC9SLzTcvZsLoV0KamCAsCrVL5BpB0srF8yIu9HlIKgT34O10yqS7O9skfvphmP
 BErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KwclHsri8LmcLI50PiGGlusR9EB2W9H/laTcrk7KH84=;
 b=d7ZRkQPPBFR4NnAoXjRGOzcW7IbGuh+9sfEqNB+WZGil5AGn1GRoq8uXw30ZO+N9O1
 CECL+dux9IM+5S47QHbgHgi+jc7htuzAw/r224vnJ5wygJvi//YwR6QoDenfYVA/tNOq
 OCwH+uxBnt3YvPfMKQ98AsBFvklv9+qgd9PwXuWgZhfDc6iKENQJE7Fvnn9w8rvZt8yo
 Dx89h2/ua6xz5p4DV9p0AodEHVtW39p1SXjXk0Z39QC1CymSKGgKvCAFcVHYjpPlURgP
 1lTb+i5oqjl8VuuDpzyjVsPxSgKARxYTbpSLa0sv4tqKgnVdTJUA5FIK1w0Azw0J6UHe
 qyRA==
X-Gm-Message-State: APjAAAX1IS1DNc5V10/U+iU8ZQZoVBxhypMJxBxO+QNal6JrcVIRkHxV
 26OFzclxoh0GToJeZIhd0fEKc2IJQy0=
X-Google-Smtp-Source: APXvYqwakR/Eit6wZ00pieCW7gTLqCCSb8a1bvwJvFimQbnurUMR8j0KhsDgsw70pFLKdfZZ0dTjrw==
X-Received: by 2002:a1c:67d7:: with SMTP id b206mr4224157wmc.68.1573570235820; 
 Tue, 12 Nov 2019 06:50:35 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y6sm14052312wrn.21.2019.11.12.06.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 06:50:30 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 62FFC1FF91;
 Tue, 12 Nov 2019 14:50:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 4/8] tests/vm: update netbsd to version 8.1
Date: Tue, 12 Nov 2019 14:50:24 +0000
Message-Id: <20191112145028.26386-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191112145028.26386-1-alex.bennee@linaro.org>
References: <20191112145028.26386-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Kamil Rytarowski <kamil@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-Id: <20191031085306.28888-5-kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index 0083f7ff6a7..c48c60853e7 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -22,7 +22,7 @@ class NetBSDVM(basevm.BaseVM):
     name = "netbsd"
     arch = "x86_64"
 
-    link = "https://cdn.netbsd.org/pub/NetBSD/NetBSD-8.0/images/NetBSD-8.0-amd64.iso"
+    link = "https://cdn.netbsd.org/pub/NetBSD/NetBSD-8.1/images/NetBSD-8.1-amd64.iso"
     size = "20G"
     pkgs = [
         # tools
-- 
2.20.1



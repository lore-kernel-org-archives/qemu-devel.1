Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5132C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 10:53:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D2BC206CD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 10:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CF5NSvn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2BC206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOIgx-0002aV-Gl
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 06:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kOIg9-00028W-9E
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 06:52:48 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38792)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kOIg7-0002XT-CZ
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 06:52:44 -0400
Received: by mail-wm1-x341.google.com with SMTP id v12so1258113wmh.3
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 03:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2ZOYJQFgwtkRMUbE80VKve55fsHkUx0xDSOrENJ6dJU=;
 b=CF5NSvn88v4DupqwVj70RIEXi4/If7/u1Fm0kELJTQzHJAgbgIKLLS+2QR6R9EQm5g
 PoMVhGgUxTIGO3A3WvPA/gHTWOQrEiMoicYal04Qm7oWitGTU8Iiff9pMTWwhD7mkB1V
 jM4dpB1IoVyFdcpA2LzA0yFWHqpNi5g291aXi+QACup/e7q17PAWX89ItCgzfdyk1ywf
 pZ+PW3g9taKQOeQ1tJLsqitoVou3ATE4aXQOGKuEEsZF1b5Bw3WCBFW9CNJ/4PlBqza0
 WMOKvFijlGQpLHyaNtAcTvMdJ8AnRNoNyHAdDmGGar4a/GGFxu1L26btrtX2IkbX+cM7
 DohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2ZOYJQFgwtkRMUbE80VKve55fsHkUx0xDSOrENJ6dJU=;
 b=q8T175xnIKeysAI7gV55QKOGmTYC5+bCe3vDm5v3Rnj5vUWAN77Cj+t2B0foJVa91h
 Xmt/pFRc0gc/fvEL2WfItz+xdmSQ7LBWbbti7YHquDGQmgyO7vF6Px1Y1WUx7KXo5bQj
 u3Zoz2aC0T3x4Ql60o6vkKA+CHhNfT8ndzHDuFQxCe50ay0DtdnGhh1Mpq12vR7uWjVM
 H4mF3ppg0PU1QAydKZRnLLfKiYJJD97g/SW1kGPMENNJ9C2UR8MMV3MhMZBPlXnzzY/c
 eC+1Af3IzLLT+JWwZvr7CZE13IvJTY47kiE3fPKCLBZ+UX7Zq5tDqXdxHHg3Cnenj3eU
 yOXw==
X-Gm-Message-State: AOAM530c3No4xWqSO7Hi+kp7LfCFg6q94od+gQz+mfojq0WCSvapgDWD
 wEqCk6qnenESGtRxLAGG5L67aA1J8POqnilC
X-Google-Smtp-Source: ABdhPJxX5AwH5rMIsTZ0LgzTtS3Q0RRmJofw7mpTWe+XscrtRnSIA5Yp2kGQKeDGOFonLkfVkXSCDA==
X-Received: by 2002:a1c:e046:: with SMTP id x67mr2161200wmg.35.1601635961423; 
 Fri, 02 Oct 2020 03:52:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id l17sm1336430wme.11.2020.10.02.03.52.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 03:52:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] meson.build: Don't look for libudev for static builds
Date: Fri,  2 Oct 2020 11:52:39 +0100
Message-Id: <20201002105239.2444-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

commit f01496a314d916 moved the logic for detecting libudev from
configure to meson.build, but in the process it dropped the condition
that meant we only ask pkg-config about libudev for a non-static
build.

This breaks static builds of the system emulators on at least Ubuntu
18.04.4, because on that host there is no static libudev but
pkg-config still claims it exists.

Reinstate the logic that we had in the configure check.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
We could certainly do something cleverer here, but basic "convert
from configure to meson" should in general not also be changing the
detection logic IMHO.  We can make the logic smarter as a follow-on
patch if desired.
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 3161c1f037a..07da66e1d81 100644
--- a/meson.build
+++ b/meson.build
@@ -271,7 +271,7 @@ if 'CONFIG_CURL' in config_host
                             link_args: config_host['CURL_LIBS'].split())
 endif
 libudev = not_found
-if targetos == 'linux' and (have_system or have_tools)
+if targetos == 'linux' and (have_system or have_tools) and not enable_static
   libudev = dependency('libudev',
                        required: get_option('mpath').enabled(),
                        static: enable_static)
-- 
2.20.1



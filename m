Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E00C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:07:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 924BA2073D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hPnOGRPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924BA2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j998x-0004nm-Nk
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 10:07:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j997x-00037i-1f
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:06:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j997w-0001kQ-2s
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:06:32 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:53847)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j997v-0001kH-TD
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:06:32 -0500
Received: by mail-wm1-x32a.google.com with SMTP id g134so2273640wme.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 07:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Gxmks0/YVneY+yAMKMWYzrWKCmyXGN/IawhpnRsRhk8=;
 b=hPnOGRPjAyz+iDQO4a8Oz5SO8wsXpmo3zKA00vt3p4bBMyaK/6JE8meBgLUQ8ZmV2R
 9ThnoDBNDZM7LjoAQ3B72xOyuxm3naJMbnh6pXd0HdQFhExmK/RjRQ+MnwBZIR0caXKW
 lb0lQbgODIDULgpb+TVtRmlOWNkN+NwVQlMBcKQPfAM9hUDRJMKSI267HZsJnMxRR9Lx
 sIlVmAzA5TV+kV98fqrtYX5XYjUyMgr2Yu4LSxUyADiBDEheeRow98xljVizlXUu8r/c
 Y84H3JaLfu02Q1aNMNLfL2Q3Ohg+o4LybYInRYPQ1fjafSxJB/CdTMqAkN0ZLfJZzkoT
 tkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Gxmks0/YVneY+yAMKMWYzrWKCmyXGN/IawhpnRsRhk8=;
 b=rVo33EDY94zNX5f69cTu1MQKLeUQWgR0QHpkl4dCFyQKicL5B4pYlJaN8HqZ4NlIvT
 IJBQVoSNy4WveQMmnmf0WUARgt7AkzuW28btOfHPO2aezlhWjYYU4jZE6YgUmCkppaUj
 b7DFoes/l64LVrgECnGNlcSWdA9wTlBMz/UdIO1dIO9+KGHRjMdv+sOXfyQ2lbgG0r6R
 idScdjHlQ09vi/IfBFenW7F80ygbbKiEHOe/zj/3fE5JoUwt8KsLDRt73DB0bsxx7+dM
 vjBaUcNmH2yfYFTh2+im74F6F7oORizJTXqxTtfncPkorboWzmmr9G859VYsKkcMUBh3
 xJkQ==
X-Gm-Message-State: ANhLgQ2/4hr8MXxyAb98EcVIIgVcBxGFzwhWcu/AV/PJrc1avZsoUJbE
 eZtvTeedF9ZSZ0PWrdS8SO2vmA==
X-Google-Smtp-Source: ADFU+vv9iNsYd0ygf+v9iF1F4cvH3ahIUGWDROlxGcsuNVLmwXAkjS/+0ENc1L1pbUyII1NesSK5qQ==
X-Received: by 2002:a05:600c:2c13:: with SMTP id
 q19mr4849057wmg.144.1583247990822; 
 Tue, 03 Mar 2020 07:06:30 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l5sm4536717wml.3.2020.03.03.07.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2020 07:06:29 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8B1591FF93;
 Tue,  3 Mar 2020 15:06:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 6/9] travis: enable tools build on OS X
Date: Tue,  3 Mar 2020 15:06:19 +0000
Message-Id: <20200303150622.20133-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303150622.20133-1-alex.bennee@linaro.org>
References: <20200303150622.20133-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <lvivier@redhat.com>

As we can build tools on OS X we should check we don't break build
when we submit new codes.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200302154630.45620-3-lvivier@redhat.com>
---
 .travis.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.travis.yml b/.travis.yml
index 9867272177d..70a24bf2fc8 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -273,6 +273,7 @@ jobs:
 
     - name: "OSX Xcode 10.3"
       env:
+        - BASE_CONFIG="--disable-docs --enable-tools"
         - CONFIG="--target-list=i386-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,x86_64-softmmu"
       os: osx
       osx_image: xcode10.3
-- 
2.20.1



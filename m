Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A82C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:26:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FE19204EC
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q9HWzBbF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE19204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpYGf-0000Hz-SG
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 10:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpYEe-0006Ag-K1
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 10:24:44 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43533)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpYEb-0004i8-Ot
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 10:24:44 -0400
Received: by mail-wr1-x443.google.com with SMTP id j4so11581881wrp.10
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2020 07:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3Ex3r734PRmdu+0SSgiqE0R+VV7DrroB2AwHxTaeBTw=;
 b=Q9HWzBbF+yo35jKXgazvJ4L35YG59p9Q+ZQw8fKUtN2BRUgjdPAMh16UAg5G2ncbyo
 bV5GHEz+bw3yV4d3CVW/4Rlx8OmI9rhYYA966aKKrQkEusrZudMnF1VApMg2y78Rvh1l
 Zts5KqAfSZYFXm1190hFwUGJkGK/gTBSkyuDYF5pMvSoZzmW4ljzAgfw2UFoWNp2Vp0d
 Fu2OoWMRKOYE50Tgnx1JS0aU4r/A4CI+nyVX1/r8JQCdQo4ByxCI1zkrWxD5pG5QuagP
 LpVjgiCnzaP7FZFlO7fW+YeSEC6fXhTSFFvC21SFTdIHulaCBq5vU3j3zNnUqOudBT2M
 ZGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3Ex3r734PRmdu+0SSgiqE0R+VV7DrroB2AwHxTaeBTw=;
 b=naTAMeSmVxY3GkvrWGE02Hluxk0M4TwYoSGwiSf8oiYpAsAew6MjHGsymKFyRXDl7p
 6nSPMiT3f95xPXd8IiKoCyYN+7Gjbbm9vzsvK6FYv2Br1Lo8NUEx2xz86Qk9DQdw9a8D
 RZ86eUuiPUEeVC+OcN3hoC/LJ+lkrh+xI7sMKPI8y5QQqX0QjASrdt+Q7jOfUPaEjmc/
 Ktu8JEPNZ3YAMjDLVy5oDbRBasT2D7fmYhM3Zd/jEyUdwuCMbvWohMRIsn0KGUDbjrym
 o6rpClbD7YraljclgqloQOc6itsvMU41hJsKEalL9FH1GZp18yzNr+DmPQ9de6QpcFBW
 1V3w==
X-Gm-Message-State: AOAM531NdJJK9rOyAqt8bwAtYJNKq+BL1dLSU3yfkSEUPxvLlt9wphei
 GxAsCiXBbOIohwKwIvGei49CqA==
X-Google-Smtp-Source: ABdhPJwDmjGXLF8eC3dcxAaiNDnn6wjSCktljjmg1DkUMT03Iby5BxaAVa8N9RHnH/6cU2wUYKIq9g==
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr12725375wrv.162.1593354280394; 
 Sun, 28 Jun 2020 07:24:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id h13sm5321555wml.42.2020.06.28.07.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2020 07:24:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 07/17] hw/misc/max111x: Don't use vmstate_register()
Date: Sun, 28 Jun 2020 15:24:19 +0100
Message-Id: <20200628142429.17111-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200628142429.17111-1-peter.maydell@linaro.org>
References: <20200628142429.17111-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The max111x is a proper qdev device; we can use dc->vmsd rather than
directly calling vmstate_register().

It's possible that this is a migration compat break, but the only
boards that use this device are the spitz-family ('akita', 'borzoi',
'spitz', 'terrier').

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/max111x.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/misc/max111x.c b/hw/misc/max111x.c
index d0e5534e4f5..abddfa3c660 100644
--- a/hw/misc/max111x.c
+++ b/hw/misc/max111x.c
@@ -140,8 +140,6 @@ static int max111x_init(SSISlave *d, int inputs)
 
     s->inputs = inputs;
 
-    vmstate_register(VMSTATE_IF(dev), VMSTATE_INSTANCE_ID_ANY,
-                     &vmstate_max111x, s);
     return 0;
 }
 
@@ -206,6 +204,7 @@ static void max111x_class_init(ObjectClass *klass, void *data)
 
     k->transfer = max111x_transfer;
     dc->reset = max111x_reset;
+    dc->vmsd = &vmstate_max111x;
 }
 
 static const TypeInfo max111x_info = {
-- 
2.20.1



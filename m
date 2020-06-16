Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A6DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:52:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D0E5208B8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mR8N9e50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D0E5208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCwb-0005xx-MM
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQd-0003Xd-Hs; Tue, 16 Jun 2020 10:19:11 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38314)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQc-0006xe-02; Tue, 16 Jun 2020 10:19:07 -0400
Received: by mail-ot1-x342.google.com with SMTP id n70so16046712ota.5;
 Tue, 16 Jun 2020 07:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=H56oUyDfYltLK80fHHPutYvS4jI1ii23yt2DPH3g7jo=;
 b=mR8N9e50RCg23pLx3lKQlKlZBTAxe7ycOstMiYqo+u5iEaxm7sROaN6zZQx5Gv+Sdx
 dI1NmQ5e7eQDvYZXmue7nhzfEu0PdnXxww3/i+C+jcYC2AQz9HrrRNr+yxqSPUDWe2tx
 PwFzzk7vl6YsIp6sNN0h5AgxM4Rr4lipa7U3cazENk8YzIJfSv0Kc4gXxoTsYdI5lmEN
 sNEvCZkGe6l4U0XLJGXpgSbv5Gs7vxc+3urlyDHfgKbRGUnbZ97/68psdnQBcfCSPgdt
 dx1icNfzL+23gLTQQ4ApAU/Ob1AcaRHbydw3h9IwitxBP5/B3RMWrQ+o0/M0hgbYOHar
 LBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=H56oUyDfYltLK80fHHPutYvS4jI1ii23yt2DPH3g7jo=;
 b=qWX+agNeBWFoFc35OaLZwafBPh5W2MfmW/Q12E0P77QtYlzrl1pfGMtxUTkW0JEXYc
 CND7YIfqtJgBiAIMHfpy2svwZ0TP+RQ0RuZXw4NzDyjh4tVOvxmpd3BlPO/vSxpG3ZkF
 cdjOJ+8qebKwSclxg7DkDgYGEhisa8G8/rhkUbGcwRf3iR+gLVqmWm9BU7DQ969Gw1A5
 QjZFbUQHeXFtdLFKcS7EBmmOBpgtgz2Mek+dyJukzZpNg3yzv2J6cM5GyZTViOwOQhzh
 55yx4OFMguu9pYD/Y+1/CUTLtw6JFlCysfrOkMsfzWUIOsEtk1y8Zbri6zR2J5dfSoWt
 IR8w==
X-Gm-Message-State: AOAM530whbEfiyDYzdQ6aKr5sOnwLl3HGPFCOBgCmURcRMkfAePQ752M
 u3jqLQ1rO2e0lMfPiOBZ6sB23vZr
X-Google-Smtp-Source: ABdhPJyu5pc0DvMfVeaxEpuB/WEofk2K3ge4Q2IeJ41xYDar/iRg6/OgDt74uFg+NhRVfojxbuDZew==
X-Received: by 2002:a9d:3df7:: with SMTP id l110mr2495125otc.214.1592317143900; 
 Tue, 16 Jun 2020 07:19:03 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id e25sm4082086otj.73.2020.06.16.07.19.02
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:19:02 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 58/78] qga: Installer: Wait for installation to finish
Date: Tue, 16 Jun 2020 09:15:27 -0500
Message-Id: <20200616141547.24664-59-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Sameeh Jubran <sjubran@redhat.com>, Basil Salman <basil@daynix.com>,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Basil Salman <basil@daynix.com>

Installation might fail if we don't wait for the provider
unregisteration process to finish.

Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
Signed-off-by: Basil Salman <basil@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
(cherry picked from commit bb1ce44b15f159b67fafc5f4b285bbf20a1961e9)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/installer/qemu-ga.wxs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/installer/qemu-ga.wxs b/qga/installer/qemu-ga.wxs
index 64bf90bd85..f6781752e6 100644
--- a/qga/installer/qemu-ga.wxs
+++ b/qga/installer/qemu-ga.wxs
@@ -81,7 +81,7 @@
               Arguments="-d --retry-path"
               >
             </ServiceInstall>
-            <ServiceControl Id="StartService" Start="install" Stop="both" Remove="uninstall" Name="QEMU-GA" Wait="no" />
+            <ServiceControl Id="StartService" Start="install" Stop="both" Remove="uninstall" Name="QEMU-GA" Wait="yes" />
           </Component>
           <?ifdef var.InstallVss?>
           <Component Id="qga_vss_dll" Guid="{CB19C453-FABB-4BB1-ABAB-6B74F687BFBB}">
-- 
2.17.1



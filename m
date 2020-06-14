Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3DAC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 23:22:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78EB7206D7
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 23:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkIv9BYD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78EB7206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkbxV-0004wI-Ot
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 19:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gorbak25@gmail.com>)
 id 1jkbwg-0004V4-Bx
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 19:21:46 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:37463)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gorbak25@gmail.com>)
 id 1jkbwd-0001Yf-SA
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 19:21:46 -0400
Received: by mail-ej1-x644.google.com with SMTP id mb16so15466214ejb.4
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2020 16:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SH6vGa/2KJH/HQw68J9t455+U0X8pVu2CUDEZICF8XY=;
 b=EkIv9BYDu2bqD1CBznjqgx+paP0JuGPGE0DqOLWDwiv7lfBUIT49NApiq0ZRi/3k2a
 HVdA1VVaLKHShFXr379eP0t9AVISe91N5vK3lsX9WU5PS/lT6Vfw9TKXZjmF4QZITHzt
 G/2TL4LJXm07PWpaXJ50e69gWgbFHaSBdFyIixlWacp/mMngaChRqG9E/78G3TQFuMQr
 qXHHfCAf20lHz7uFFDy/Xm5D+0dVs0J1AAfmOi6lqCMXXmHUhSs/U9Xxzn1Krtw1Vm/7
 FIMZCbRr0oibg6NYn4EweryYKu6DtBVH+GkEwIzQPktg0aoE3md1Uki3WJ8rO02lghDP
 jQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SH6vGa/2KJH/HQw68J9t455+U0X8pVu2CUDEZICF8XY=;
 b=FC+jlDCK53ArU7n9SBPg6dVui54Z24DTzl7OmlDIpQp/1CeBiUdGzOqt0miWhCDTUG
 34W+FGZ8cLJzPrcpEiyoliA1QALTh8EnkbONAx+hC96cV5j5kwusW8+6pc5QuGckc73E
 MkXtkfODX7YL1YQ64AiwW3x9Ql+5NPdMv4ZwIPuYP2gmkRj+lsAvR1eOlTWuFvnkiBEg
 HIUFXkGEgQEVz03on1CqJzFpDnjN5rXU/rHOmrppR6GzUBxfJHxqjw7qZIAYfzKcbTjm
 iFDfX8SS+uGR8dR2TxrExOek5i/Rz6F4hfRdJDgoU4KZ+9gekJ4HG9ZP1u1Qv2EXPbyW
 uvuQ==
X-Gm-Message-State: AOAM532K1kRWGDKuZS7XJTBztZzEhhPzyAYemRXtcXDBDvHc8lwg8+iX
 GYx35uBQ9a3dygIP45owid1nn6ds2hQaFw==
X-Google-Smtp-Source: ABdhPJwOoAC6qLQWxDRL1D5jvqQBH2cD4fnGpHmX1LN/GMQycdeSu6OgkZRdLPIMHrPNtvN6+LLa8w==
X-Received: by 2002:a17:906:7712:: with SMTP id
 q18mr22584732ejm.140.1592176901522; 
 Sun, 14 Jun 2020 16:21:41 -0700 (PDT)
Received: from localhost.localdomain (public-gprs354212.centertel.pl.
 [37.47.14.229])
 by smtp.gmail.com with ESMTPSA id i21sm7332998edr.68.2020.06.14.16.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2020 16:21:41 -0700 (PDT)
From: Grzegorz Uriasz <gorbak25@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/xen_pt: Don't grant opregion permissions
Date: Sun, 14 Jun 2020 23:21:09 +0000
Message-Id: <2157e10d63619d43151fe8b8ca913b44c54aba6e.1592176600.git.gorbak25@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=gorbak25@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, jakub@bartmin.ski,
 marmarek@invisiblethingslab.com, Grzegorz Uriasz <gorbak25@gmail.com>,
 j.nowak26@student.uw.edu.pl, Anthony Perard <anthony.perard@citrix.com>,
 xen-devel@lists.xenproject.org, contact@puzio.waw.pl
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With the upstreaming of linux based stubdomains to xen, qemu can't
assume it runs inside dom0 - permission assignment must be moved to
libxl running in dom0. This xen patch:
https://lists.xenproject.org/archives/html/xen-devel/2020-06/msg00973.html
implements granting the required permissions to the stubdomain running
qemu. This patch removes granting opregion permissions in qemu - this
should be fine as when qemu is running inside dom0 the memory mapping will
be successfully created without first explicitly granting the permission.

Signed-off-by: Grzegorz Uriasz <gorbak25@gmail.com>
---
 hw/xen/xen_pt_graphics.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/hw/xen/xen_pt_graphics.c b/hw/xen/xen_pt_graphics.c
index 7d46e9c209..303674365b 100644
--- a/hw/xen/xen_pt_graphics.c
+++ b/hw/xen/xen_pt_graphics.c
@@ -283,19 +283,6 @@ void igd_write_opregion(XenPCIPassthroughState *s, uint32_t val)
     igd_guest_opregion = (unsigned long)(val & ~XEN_PCI_INTEL_OPREGION_MASK)
                             | (igd_host_opregion & XEN_PCI_INTEL_OPREGION_MASK);
 
-    ret = xc_domain_iomem_permission(xen_xc, xen_domid,
-            (unsigned long)(igd_host_opregion >> XC_PAGE_SHIFT),
-            XEN_PCI_INTEL_OPREGION_PAGES,
-            XEN_PCI_INTEL_OPREGION_ENABLE_ACCESSED);
-
-    if (ret) {
-        XEN_PT_ERR(&s->dev, "[%d]:Can't enable to access IGD host opregion:"
-                    " 0x%lx.\n", ret,
-                    (unsigned long)(igd_host_opregion >> XC_PAGE_SHIFT)),
-        igd_guest_opregion = 0;
-        return;
-    }
-
     ret = xc_domain_memory_mapping(xen_xc, xen_domid,
             (unsigned long)(igd_guest_opregion >> XC_PAGE_SHIFT),
             (unsigned long)(igd_host_opregion >> XC_PAGE_SHIFT),
-- 
2.27.0



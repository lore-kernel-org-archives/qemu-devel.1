Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303B4C43457
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 21:55:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 858432076E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 21:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOJbPTap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858432076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTBDf-0002Wt-6Z
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 17:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTBCJ-0000ow-BF
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 17:54:07 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b]:52443)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTBCH-0005HL-Pr
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 17:54:07 -0400
Received: by mail-pj1-x102b.google.com with SMTP id gm14so202187pjb.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 14:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IkJ+z3wbykhjoUQ4XRK2kASFvDBSvBM63031zcipiFE=;
 b=UOJbPTapcP3B1PXzcMvduCL31x38ycdzNR1iga9VQlu/q6Qic0QLwxaVzrj8XkSd/X
 kVZtgUeONPXE0qWx3XlSxHRJU3jNQhGoacwANEwAME0dOHvQYszsdv9qtCn0MYZ6YnjU
 XkSNf/amZd9VXPWxhgmz1BI4amhDuCMWroHeEJmahOOVb8YcZDERRQxyXxpmdabduTTA
 3IgIk+bNt26S7CEIK0UOpGvDzuF19xcmiqndK0zRB/IOgB4WiwRM9+Pyfn41rJJIa0xo
 rVVVjtvZB2jMOErwCxpeVCltd0qgN+HhbONY8LRfaLJsxnanMx5GX6uY5ctB3JCnPzzl
 Rz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IkJ+z3wbykhjoUQ4XRK2kASFvDBSvBM63031zcipiFE=;
 b=daXbcA1dqK0py8wrqZ4TRZAs5S1Bm87kzpCEkdfz1/UkZWmydXDDsSPDt84hF9l5eQ
 GADx1WgCaS5PWxi5HEABAhrazS6ihhxP2r3mDgZsFqM7moU326pGTBg+gOMYJmdAj3lT
 Pw/kYFnml2OLz5FZkRhr7i1U4O2ou5PrTscZRvq4rMpo0ASJqEnCkcWTDxw7C1JYdt0W
 eWynNlyl/pk4HpOc2Ri6olHZFuthb3GXxXVwFYcuEPyyr2LDhnZkGNor+CyxVuGRMDwH
 k94Cv1iZU98m/JlVROK0ArSG2F1xnKFgxc26NSbfe/Qz18tyMgPfMjMTBWnvgXEtbnfr
 hmHg==
X-Gm-Message-State: AOAM533t/A4uBqPBXuuONeU2fYycOyVinNEzSog9pB7EUh1Gx+GNH1dc
 3/nqIhd1sF/5CvokMUGkXUgmWHTnxuMnITtx
X-Google-Smtp-Source: ABdhPJxnV6qyk8FQ8nrXQbimStv04L00DmzroETLAXZ/+9Jig3iShJkSkLF0fF8uKM0eS1kDcIButA==
X-Received: by 2002:a17:90a:77c6:: with SMTP id
 e6mr695899pjs.116.1602798844051; 
 Thu, 15 Oct 2020 14:54:04 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id f66sm252856pfa.59.2020.10.15.14.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 14:54:03 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/4] configure: the docdir option should passed to meson as
 is.
Date: Fri, 16 Oct 2020 05:53:43 +0800
Message-Id: <20201015215345.173-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201015215345.173-1-luoyonggang@gmail.com>
References: <20201015215345.173-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x102b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 configure | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/configure b/configure
index f839c2a557..1ce31f97b4 100755
--- a/configure
+++ b/configure
@@ -971,7 +971,7 @@ for opt do
   ;;
   --with-suffix=*) qemu_suffix="$optarg"
   ;;
-  --docdir=*) qemu_docdir="$optarg"
+  --docdir=*) docdir="$optarg"
   ;;
   --sysconfdir=*) sysconfdir="$optarg"
   ;;
@@ -5770,7 +5770,6 @@ fi
 qemu_confdir="$sysconfdir/$qemu_suffix"
 qemu_moddir="$libdir/$qemu_suffix"
 qemu_datadir="$datadir/$qemu_suffix"
-qemu_docdir="$docdir/$qemu_suffix"
 qemu_localedir="$datadir/locale"
 qemu_icondir="$datadir/icons"
 qemu_desktopdir="$datadir/applications"
-- 
2.28.0.windows.1



Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28329C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:10:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E98F222365
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWocVGEM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98F222365
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX65U-0003dz-LN
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 11:10:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iX63o-0001ot-0j
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:09:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iX63n-00064Z-1L
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:08:59 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40927)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iX63m-000645-R9
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:08:58 -0500
Received: by mail-wm1-x343.google.com with SMTP id f3so4324703wmc.5
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 08:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7UO6xeR8ytjGjoYuV7yLmVYHg1zyTHVjoP2SmInf7fQ=;
 b=OWocVGEMgTWyU5pwdAYmFzwvEj5BGT3M0NeZ9loh3+VZqBLluS3yVH1hbARUjl07YV
 W56cLRsCy4BgYNwcDZHzyZFw3jlKV2TYU/eqbtHDqogCA2WS2pH5ymQ4xRe0q/eWDCTl
 bspZ9no+PL9KP9zadBV0ksoIx0+Dv9aDVd5XIYiKIr4D95Spfqi/g1Fc/sbLUhuzO/yF
 Y2XvY/RoV3kXbc71IoaKDxvDicKWHCUXA4zOdTCGJlIOK/aeJNBEwe3JKe2G0uQu+iD8
 GItEZhwdEQkobcKJcpfDFV1bHXC/tr01FQHa7RfHgN7OHoSG5mKeXFGnE5e7NM0duXdf
 W9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=7UO6xeR8ytjGjoYuV7yLmVYHg1zyTHVjoP2SmInf7fQ=;
 b=WNXun65R53ywCNZaJmacmcVMwU9/qJCeV7PjNWvqTtOVf5HC2Kda1L0zUnTUpuOSDJ
 4SQ2ab5pqXJg/J9xbcV6bIjPbX+pAsJfCIUn/kmyt5QT67Pjz+jmCop2JK+ZGoczDZ7p
 z1y7v87onl9npQZbvqCAegojgUdAKOhRdaraKelfQPGDLGan5KwCwPyu+avWZHHM/WZ3
 yPCOhl5x1kwqiVXKgJJGPjA++NoqZDWOJBwxH3v/ic4QYMzFOWiddBW3Ke4+rbo8REaM
 RpBjoF9nlcrCsLSubZkD8HAKdqid/6FLaNgdUQOOWrNKuoDcyCh//JJYLFOG4QHTVmiw
 M7fA==
X-Gm-Message-State: APjAAAXNRv7ZW+uW9qNF0I7KLwNFITYc2SAdTFqcuB/bC7LVUS2lv8qG
 EioOu6TCloh2Sb2DbshCcWonWI6f
X-Google-Smtp-Source: APXvYqwZjv08OlvUE8whr5mIbwcV9Hn4mhS/5gUU6tmipw4019zPRhM6ac0MviEkFrNEe8lLF1/txQ==
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr6809211wmc.130.1574179737579; 
 Tue, 19 Nov 2019 08:08:57 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n13sm3442203wmi.25.2019.11.19.08.08.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Nov 2019 08:08:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/12] vfio: vfio-pci requires EDID
Date: Tue, 19 Nov 2019 17:08:42 +0100
Message-Id: <1574179728-35535-7-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574179728-35535-1-git-send-email-pbonzini@redhat.com>
References: <1574179728-35535-1-git-send-email-pbonzini@redhat.com>
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
Cc: Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

hw/vfio/display.c needs the EDID subsystem, select it.

Cc: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/vfio/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/vfio/Kconfig b/hw/vfio/Kconfig
index 34da2a3..f0eaa75 100644
--- a/hw/vfio/Kconfig
+++ b/hw/vfio/Kconfig
@@ -6,6 +6,7 @@ config VFIO_PCI
     bool
     default y
     select VFIO
+    select EDID
     depends on LINUX && PCI
 
 config VFIO_CCW
-- 
1.8.3.1




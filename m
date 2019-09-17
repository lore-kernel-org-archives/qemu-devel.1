Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28B5C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:13:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A35F72171F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35F72171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAFAS-0003Zh-D6
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 11:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iAF7p-0002CB-QA
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:10:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iAF7o-0000KG-Lm
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:10:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7794)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iAF7o-0000Jt-8n
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:10:40 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 622E42A09A2
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 15:10:39 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id s28so4569675qkm.5
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 08:10:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zfz6oVRF7r97yySFleqn2Nd7rw4Mi4TzVl/Lgiolzjw=;
 b=t63EB/ejizh0D2/uIhOw71XmqX14LtCVv+T5Er5uLibhMhaiHV1yb+ibj93OxwFRyK
 TJJ2FoK5NMYkLMxjq5Rd0ErENFdUhiSLW9RB7NGcUAPcyAiJw4uhbQmYKKQ9QyokytJC
 8znJKS2EnISTnFV2Es5A2TxslZ53FQ/elH5xVm5ar250V7p9jUpsCEh/cNSTjgmPBoyr
 LiGEc767tXiRf+j5EWFBSHUTktKURmFsN8Cg/H0Nv3WsxC8H0vHEEwnjzn9Mf62Powln
 2T0wiGDen2q5L96UI/Atog7KVL1Sk/+CTy2uhKPrtqkbunruI16gII+i707APuRpR9Bm
 I3Mw==
X-Gm-Message-State: APjAAAWggiMbuTfXcmcH5kzuSoKjvu98O+9c4fDihpP5sbJ6mNLAWc8Z
 4ChLsns8qdm/suw6uW72EA5m1Nm2GVR95ripfSEAqPiA+c6rOvwc6HVBiy9VXsxY2fSAm14HM8h
 7iZIBk5B4Afc1ByE=
X-Received: by 2002:a37:660c:: with SMTP id a12mr4332472qkc.70.1568733038248; 
 Tue, 17 Sep 2019 08:10:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz58vT4fmKlvpdeMNEeFI3fqKAs5f+vwfPox6I+eaB45m24CDPsREI/T+Z/2q1CiNA/+WRDCw==
X-Received: by 2002:a37:660c:: with SMTP id a12mr4332456qkc.70.1568733038107; 
 Tue, 17 Sep 2019 08:10:38 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id z12sm1388526qkg.97.2019.09.17.08.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 08:10:37 -0700 (PDT)
Date: Tue, 17 Sep 2019 11:10:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190910140350.2931-1-lvivier@redhat.com>
References: <20190917151011.24588-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190917151011.24588-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 01/10] MAINTAINERS: update virtio-rng and
 virtio-serial maintainer
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
 Peter Maydell <peter.maydell@linaro.org>, Amit Shah <amit@kernel.org>,
 Thomas Huth <huth@tuxfamily.org>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190917151033.guN0KY4-pyC8FTeoIfj9A04mEMtREe253EV49Mf186s@z>

From: Laurent Vivier <lvivier@redhat.com>

As discussed with Amit, I volunteer to maintain virtio-rng and virtio-serial
previously maintained by Amit.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Acked-by: Amit Shah <amit@kernel.org>
Message-Id: <20190910140350.2931-1-lvivier@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 50eaf005f4..db916ade55 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1554,7 +1554,8 @@ F: include/hw/virtio/virtio-input.h
 F: contrib/vhost-user-input/*
 
 virtio-serial
-M: Amit Shah <amit@kernel.org>
+M: Laurent Vivier <lvivier@redhat.com>
+R: Amit Shah <amit@kernel.org>
 S: Supported
 F: hw/char/virtio-serial-bus.c
 F: hw/char/virtio-console.c
@@ -1563,7 +1564,8 @@ F: tests/virtio-console-test.c
 F: tests/virtio-serial-test.c
 
 virtio-rng
-M: Amit Shah <amit@kernel.org>
+M: Laurent Vivier <lvivier@redhat.com>
+R: Amit Shah <amit@kernel.org>
 S: Supported
 F: hw/virtio/virtio-rng.c
 F: include/hw/virtio/virtio-rng.h
-- 
MST



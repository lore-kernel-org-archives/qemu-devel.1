Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64272C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 12:45:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DB5120702
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 12:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M1akO5Kx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB5120702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqc7R-0005QT-BX
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 08:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jqc6E-0004Wt-30
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 08:44:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31494
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jqc6C-0002cE-60
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 08:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593607462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0wpOvQBPbMF3BayS6+bRG30NGcH4i+MsWglklad2aKE=;
 b=M1akO5Kx95dQI6flIM5gc4TykT6LOGYmXU99J3o8/vKa1EKi57eK8EJQzV933HH1YXIsDe
 mm9HWeMzp/8ABXQLAOfcgfgpijwts4kGk/YPMaoFgn6Gp730Xfr3MM0N327x5J8JrQv/OU
 DZQMXR4U8F8W7cCdC/5huj+8eG/fCrc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-E2aUP-_PO1ypuxwakOmasA-1; Wed, 01 Jul 2020 08:44:21 -0400
X-MC-Unique: E2aUP-_PO1ypuxwakOmasA-1
Received: by mail-qt1-f197.google.com with SMTP id 71so8732157qte.5
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 05:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0wpOvQBPbMF3BayS6+bRG30NGcH4i+MsWglklad2aKE=;
 b=gSnLJlaJhmEdr+ZjoGXc4i1y2WzuoKHtam8qWVqhQe04QcTZmZ1FjK2I7M4hM52a4F
 X1T0I61SE8unWSlxYoloYpwLWykTfUvFBeyBt/fOF0VwX1osAR1g3yUpwctgM04UWrSR
 jQteVhBwRUNxtA/tkjFEqQGtMCKhqKREvOQOy+lRFNcIxA6jivTMX1DiPS55WFeart+A
 h6qZpGlApfqvqPozU7/V79eJqkTo/r0oc10tDGD01MtmbtvKNEGj85L9etteypIw5jAw
 U7nxymLSoV3cwjzLg4Cv4Lb41/smjHmn4KYLL5ZOk7vzK3cZJzFzB+EIc/m6WQU6GKsH
 pzBA==
X-Gm-Message-State: AOAM533xTUxdaWvalF4tB6mL4KcBssM89ow8L27EPezwynGAoFfpafZs
 FHFlFy3gHhOdq3Lw4gSHtHV3d1/vAwAD/wNhH7ifNyCQrQjbRiuLKwO6EpzmpTd14G0r1vTP8gw
 bDGtTUNVrThyranI=
X-Received: by 2002:a05:620a:24cc:: with SMTP id
 m12mr18228863qkn.318.1593607460705; 
 Wed, 01 Jul 2020 05:44:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2xzg/gaxDvThMhYz281sa4gCUs+f9V8M/HVT6HwDslDhrURruvtBCukiajht3p/hzkGyMzw==
X-Received: by 2002:a05:620a:24cc:: with SMTP id
 m12mr18228846qkn.318.1593607460484; 
 Wed, 01 Jul 2020 05:44:20 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id x26sm5227637qtr.4.2020.07.01.05.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 05:44:19 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] MAINTAINERS: add VT-d entry
Date: Wed,  1 Jul 2020 08:44:18 -0400
Message-Id: <20200701124418.63060-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:29:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 peterx@redhat.com, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add this entry as suggested by Jason and Michael.

CC: Jason Wang <jasowang@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dec252f38b..569cfc1fcd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2615,6 +2615,15 @@ F: tests/uefi-test-tools/
 F: .gitlab-ci.d/edk2.yml
 F: .gitlab-ci.d/edk2/
 
+VT-d Emulation
+M: Michael S. Tsirkin <mst@redhat.com>
+M: Peter Xu <peterx@redhat.com>
+R: Jason Wang <jasowang@redhat.com>
+S: Supported
+F: hw/i386/intel_iommu.c
+F: hw/i386/intel_iommu_internal.h
+F: include/hw/i386/intel_iommu.h
+
 Usermode Emulation
 ------------------
 Overall usermode emulation
-- 
2.26.2



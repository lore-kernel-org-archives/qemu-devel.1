Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB802C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:17:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90F122171F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:17:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F122171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAFDw-0006ce-TG
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 11:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60085)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iAF7u-0002F0-JB
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iAF7t-0000LR-4U
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:10:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44102)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iAF7s-0000LE-S4
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:10:45 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0442285541
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 15:10:44 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id u8so4545032qtq.19
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 08:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=s8tVfTpVuqGSQJ8iutxuKUIWs9UbMiNRJICAIZykt7U=;
 b=WbPRIMG8PtXZmTW00sMG9t+WzDqNGU/oc1Gl4HZGAOdQQrpaSW2HgBGTI1D65itzm4
 Ld7dvdqZtc/SLzvnR3hdb7BFoQYPO6VTpY1GsgGSG2rFDvv7RhRaAJTflMfa37e2nc5p
 9gjvaDND7q6u83cNKw8cTZuR/tq4MBgFuHDaACLK1ovtxH6KOyd4ax0rQxqoI1GRlUgi
 1YQXSzJAPTEmjHT2NY4Sv+cDGJw2i0FA1cYL+SIgPzOrO7PbSvLF2SJfpv1Olz0/hL0B
 3yPUNUYQfshYCEsEGUyX8IJg/DH3840FX9hSKAW2b3+nprauFSzZbMNhJLCEq4+LwoxX
 JS4Q==
X-Gm-Message-State: APjAAAV7+RWnFg0heQxVVur0pmJ9SQVQR8uBXsBZ57pgIb7kX5YO6QGb
 foa0HoJmnzX8VwMZx1JDVTYt5L8Vq83RgvQQCLr+TymlceHYu6WQSpGpmkgawJdjnVaDEebSddr
 z4DFcFeMNbk+SCTo=
X-Received: by 2002:ac8:2c8f:: with SMTP id 15mr4197833qtw.3.1568733042733;
 Tue, 17 Sep 2019 08:10:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyAxnRPAb3stTK8vIArmaRml1j2x5gbF7rD7f837Pw2z/m1p9E69090SDvx/zWC3DuqP59ezA==
X-Received: by 2002:ac8:2c8f:: with SMTP id 15mr4197815qtw.3.1568733042534;
 Tue, 17 Sep 2019 08:10:42 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id k17sm1603267qtk.7.2019.09.17.08.10.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 08:10:41 -0700 (PDT)
Date: Tue, 17 Sep 2019 11:10:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190801004053.7021-1-richardw.yang@linux.intel.com>
References: <20190917151011.24588-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190917151011.24588-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 02/10] docs/nvdimm: add example on persistent
 backend setup
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Wei Yang <richardw.yang@linux.intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Pankaj Gupta <pagupta@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190917151038.BBVoj_liBtTt5_B1tOY4NN5APCTkY9yJBcfqVlmDEPo@z>

From: Wei Yang <richardw.yang@linux.intel.com>

Persistent backend setup requires some knowledge about nvdimm and ndctl
tool. Some users report they may struggle to gather these knowledge and
have difficulty to setup it properly.

Here we provide two examples for persistent backend and gives the link
to ndctl. By doing so, user could try it directly and do more
investigation on persistent backend setup with ndctl.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Pankaj Gupta <pagupta@redhat.com>

Message-Id: <20190801004053.7021-1-richardw.yang@linux.intel.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/nvdimm.txt | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
index b531cacd35..362e99109e 100644
--- a/docs/nvdimm.txt
+++ b/docs/nvdimm.txt
@@ -171,6 +171,35 @@ guest software that this vNVDIMM device contains a region that cannot
 accept persistent writes. In result, for example, the guest Linux
 NVDIMM driver, marks such vNVDIMM device as read-only.
 
+Backend File Setup Example
+--------------------------
+
+Here are two examples showing how to setup these persistent backends on
+linux using the tool ndctl [3].
+
+A. DAX device
+
+Use the following command to set up /dev/dax0.0 so that the entirety of
+namespace0.0 can be exposed as an emulated NVDIMM to the guest:
+
+    ndctl create-namespace -f -e namespace0.0 -m devdax
+
+The /dev/dax0.0 could be used directly in "mem-path" option.
+
+B. DAX file
+
+Individual files on a DAX host file system can be exposed as emulated
+NVDIMMS.  First an fsdax block device is created, partitioned, and then
+mounted with the "dax" mount option:
+
+    ndctl create-namespace -f -e namespace0.0 -m fsdax
+    (partition /dev/pmem0 with name pmem0p1)
+    mount -o dax /dev/pmem0p1 /mnt
+    (create or copy a disk image file with qemu-img(1), cp(1), or dd(1)
+     in /mnt)
+
+Then the new file in /mnt could be used in "mem-path" option.
+
 NVDIMM Persistence
 ------------------
 
@@ -212,3 +241,5 @@ References
     https://www.snia.org/sites/default/files/technical_work/final/NVMProgrammingModel_v1.2.pdf
 [2] Persistent Memory Development Kit (PMDK), formerly known as NVML project, home page:
     http://pmem.io/pmdk/
+[3] ndctl-create-namespace - provision or reconfigure a namespace
+    http://pmem.io/ndctl/ndctl-create-namespace.html
-- 
MST



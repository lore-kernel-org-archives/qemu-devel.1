Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB14C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 08:32:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 562C02173E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 08:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="HWwmL1Up"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 562C02173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Wtj-00046k-1r
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 04:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36657)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <31OhkXQYKCisZHTLPKNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--sameid.bounces.google.com>)
 id 1i2Wmd-0004j2-S4
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <31OhkXQYKCisZHTLPKNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--sameid.bounces.google.com>)
 id 1i2Wmc-0007nQ-Q1
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:24:55 -0400
Received: from mail-vk1-xa4a.google.com ([2607:f8b0:4864:20::a4a]:48033)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <31OhkXQYKCisZHTLPKNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--sameid.bounces.google.com>)
 id 1i2Wmc-0007ms-Mb
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:24:54 -0400
Received: by mail-vk1-xa4a.google.com with SMTP id n185so8756041vkf.14
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 01:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=FVd1PFIeVFll6+dyMcyTHlqBKcnOQa+GKOSlsKMvxhU=;
 b=HWwmL1UpfDGN341vc1Zjy1tfdObT0V33VvW2TsMd7ql/ZA/CmN6gvnXr991eusT6r/
 kq7bYSWuTFHaQdkdM6hUFAJVSqLCfTzIUDkg9IUbaj+JJH4MjkSP85HMQWzUPBXEOMRV
 nY0MaySOP4+DRRfbfYcvx6EpXDRnv8b/oNlI38w54q3RvdFb4ZsTxnmykr/HVWi2dK/D
 YfK7solvBt0XDwRY1Nkc/I9NvIgMEQB+jEkf6Ot/mpCjw9Jt4Rna2pQfgFhMMJsEM6Gx
 /VmyLnU8M/h2gxlVJAMpdoIAwl5pgA632HQG0BvAlj3apvxd7pLiwJE9VutJquSs08/r
 Hhog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=FVd1PFIeVFll6+dyMcyTHlqBKcnOQa+GKOSlsKMvxhU=;
 b=doKVsP7nwBNJXiQhT2iGIyA2FxevJDTnkoRsk1An82qxDzmN6gtI1APTWQpM18JIUE
 r2MARhdL2BSrI1ajd371+H3Gum7sFBjVJ8W0e18kVa2pxBJgOX4Zn5aF9ZKKIWzPXnyt
 n/QQTKXJN4+U7Oh5qOsRXN3YpcCQodWuqU/YsAdtJmIk16RcG8/O5IryZwH8fVTNbpLu
 wF2AJnqFv1W9Sysv56cLjq2axPLYn5ca1JfNUEB+HsB4Uw/ngi/qImqBYNNUjv4Mvm4R
 CI7K+x77PEZWNTCr6d8YqeaWfn75eRFO+xIEZzVkDn5C2ROB3REXqS44bP4Qi5Pik3QQ
 Rc7Q==
X-Gm-Message-State: APjAAAXsAtW0AtgUdZ/2AmzcGmDpYHRJqMsmZmIw28BrFED4N34WOVn+
 C2uAfkSveGvZw5+rfhlSlhQqOwcXOqpSFC22wezi/LvAh6VfttpACmkoDFMngdesR0hjYFEGItI
 DCgz1/W6S4+CDLpsRnkezkEWljA0XezZXYq00jiZqpqaKjZPBlvqmEvnh8cvG
X-Google-Smtp-Source: APXvYqzoCKMgHI1WnRC/weBOvJdgtiFj95SoXzEqQaiYEW50PPzAw7Y/xt/6i/fxJNE2xikB86QsbFehTAw=
X-Received: by 2002:a1f:b511:: with SMTP id e17mr9407857vkf.86.1566894292959; 
 Tue, 27 Aug 2019 01:24:52 -0700 (PDT)
Date: Tue, 27 Aug 2019 11:24:21 +0300
In-Reply-To: <20190827082427.64280-1-sameid@google.com>
Message-Id: <20190827082427.64280-3-sameid@google.com>
Mime-Version: 1.0
References: <20190827082427.64280-1-sameid@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::a4a
Subject: [Qemu-devel] [PATCH v6 2/8] block: Support providing LCHS from user
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
From: Sam Eiderman via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Sam Eiderman <sameid@google.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org,
 Arbel Moshe <arbel.moshe@oracle.com>, seabios@seabios.org, kevin@koconnor.net,
 liran.alon@oracle.com, kraxel@redhat.com,
 Sam Eiderman <shmuel.eiderman@oracle.com>, sameid@google.com,
 karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sam Eiderman <shmuel.eiderman@oracle.com>

Add logical geometry variables to BlockConf.

A user can now supply "lcyls", "lheads" & "lsecs" for any HD device
that supports CHS ("cyls", "heads", "secs").

These devices include:
    * ide-hd
    * scsi-hd
    * virtio-blk-pci

In future commits we will use the provided LCHS and pass it to the BIOS
through fw_cfg to be supplied using INT13 routines.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
---
 include/hw/block/block.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index fd55a30bca..d7246f3862 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -26,6 +26,7 @@ typedef struct BlockConf {
     uint32_t discard_granularity;
     /* geometry, not all devices use this */
     uint32_t cyls, heads, secs;
+    uint32_t lcyls, lheads, lsecs;
     OnOffAuto wce;
     bool share_rw;
     BlockdevOnError rerror;
@@ -65,7 +66,10 @@ static inline unsigned int get_physical_block_exp(BlockConf *conf)
 #define DEFINE_BLOCK_CHS_PROPERTIES(_state, _conf)                      \
     DEFINE_PROP_UINT32("cyls", _state, _conf.cyls, 0),                  \
     DEFINE_PROP_UINT32("heads", _state, _conf.heads, 0),                \
-    DEFINE_PROP_UINT32("secs", _state, _conf.secs, 0)
+    DEFINE_PROP_UINT32("secs", _state, _conf.secs, 0),                  \
+    DEFINE_PROP_UINT32("lcyls", _state, _conf.lcyls, 0),                \
+    DEFINE_PROP_UINT32("lheads", _state, _conf.lheads, 0),              \
+    DEFINE_PROP_UINT32("lsecs", _state, _conf.lsecs, 0)
 
 #define DEFINE_BLOCK_ERROR_PROPERTIES(_state, _conf)                    \
     DEFINE_PROP_BLOCKDEV_ON_ERROR("rerror", _state, _conf.rerror,       \
-- 
2.23.0.187.g17f5b7556c-goog



Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F3EC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:06:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C344206C1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVXvaw2+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C344206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXRUm-00026f-FT
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 12:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXRSO-0008UE-D1
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 12:04:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23666)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXRSI-0006YC-UV
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 12:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603814653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fxbpQEAHbX0or96GM6hC5X/mct/rAasK8lB74c4iv5g=;
 b=EVXvaw2+ntEsqVzAMMPaER6drU9XMDq2ogdedktlI5gRGbLXZWz7byywg0U0nMmnhLa14y
 Nfz+W27/6MTGhCxVrZBrGQjomuL0RIRh9uRF5+vtPxhM1TDO3CVyjblduSLqbV0pL0hX+5
 1tHjNJlPhWZYHq0JO/OIJhiRycNCzkU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-qMuCexd0OgSg-i1053dHsQ-1; Tue, 27 Oct 2020 12:04:11 -0400
X-MC-Unique: qMuCexd0OgSg-i1053dHsQ-1
Received: by mail-ej1-f71.google.com with SMTP id d12so1027820ejr.19
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 09:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fxbpQEAHbX0or96GM6hC5X/mct/rAasK8lB74c4iv5g=;
 b=nrGsZZCn9UvKySbe9xU4fEE379AF/Sa8FVJa/72DASIN5oHiwjlRk1YFyWeWioEbh2
 JPyAVQZTxvOKSHlnJro7QetpixINnd89RLm5/rlGsE3hg0kstl4KNwL88YtUTkuRlpzw
 QPb8CcgfZZn1Kd4rUJOXKk3t4CxJnwmwAd0Lvm9y2PuihyHP0ikBOQsuMmtNq7IBx9uy
 ZVY8kK+xW0fTIABgaP0eybcTUA9+tCQuDs4gYnRWAL4+NthVPrKYWv8jbsAqvVu7Byu6
 LD7e6Nj3eh/L2OZ4bBxmpFwK46mUUWMD8uRdT3Y0dZuWVto/+k8dYzzHDuYOIxAJfO6x
 6Wxg==
X-Gm-Message-State: AOAM530rMa2zN/PfMDj4mnWsT7q3NduF7oCyHjKKN0QFLe7RMrbX90Hq
 ur9N9YX9dGkyMW3GN3HhCAlZixFsdSNl6B//Zv1L99B6ey7/CxseLT9AqKXcFkYH6+sfG0R/PFT
 3RDyuFFgavLVF07A=
X-Received: by 2002:a17:906:715a:: with SMTP id
 z26mr3104419ejj.300.1603814650104; 
 Tue, 27 Oct 2020 09:04:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCpWNAoohzquAZWXz2B+4CFzZ4g/AL9GzaiTeQwT58v/d+X/sdCVtZJKxpc52fg0lZAxrEqA==
X-Received: by 2002:a17:906:715a:: with SMTP id
 z26mr3104396ejj.300.1603814649868; 
 Tue, 27 Oct 2020 09:04:09 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id u2sm1261486edr.70.2020.10.27.09.04.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 09:04:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2] block/nvme: Fix nvme_submit_command() on big-endian
 host
Date: Tue, 27 Oct 2020 17:04:07 +0100
Message-Id: <20201027160407.418423-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Eric Auger <eric.auger@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Completion Queue Command Identifier is a 16-bit value,
so nvme_submit_command() is unlikely to work on big-endian
hosts, as the relevant bits are truncated.

The "Completion Queue Entry: DW 2" describes it as:

  This identifier is assigned by host software when
  the command is submitted to the Submission

As the is just an opaque cookie, it is pointless to byte-swap it.

Fixes: bdd6a90a9e5 ("block: Add VFIO based NVMe driver")
Reported-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Based-on: <20201027135547.374946-1-philmd@redhat.com>
---
 block/nvme.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index ff645eefe6a..d9b2245db40 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -343,7 +343,7 @@ static inline int nvme_translate_error(const NvmeCqe *c)
         trace_nvme_error(le32_to_cpu(c->result),
                          le16_to_cpu(c->sq_head),
                          le16_to_cpu(c->sq_id),
-                         le16_to_cpu(c->cid),
+                         c->cid,
                          le16_to_cpu(status));
     }
     switch (status) {
@@ -400,7 +400,7 @@ static bool nvme_process_completion(NVMeQueuePair *q)
         if (!q->cq.head) {
             q->cq_phase = !q->cq_phase;
         }
-        cid = le16_to_cpu(c->cid);
+        cid = c->cid;
         if (cid == 0 || cid > NVME_QUEUE_SIZE) {
             warn_report("NVMe: Unexpected CID in completion queue: %"PRIu32", "
                         "queue size: %u", cid, NVME_QUEUE_SIZE);
@@ -468,7 +468,7 @@ static void nvme_submit_command(NVMeQueuePair *q, NVMeRequest *req,
     assert(!req->cb);
     req->cb = cb;
     req->opaque = opaque;
-    cmd->cid = cpu_to_le32(req->cid);
+    cmd->cid = req->cid;
 
     trace_nvme_submit_command(q->s, q->index, req->cid);
     nvme_trace_command(cmd);
-- 
2.26.2



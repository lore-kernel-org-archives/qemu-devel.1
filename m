Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C837FC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:07:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92EED20775
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDr+PWOy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92EED20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGkDa-0001BI-Pp
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 10:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <minwoo.im.dev@gmail.com>) id 1jGkCt-0000Zh-91
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <minwoo.im.dev@gmail.com>) id 1jGkCs-0004Id-AW
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:07:03 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38272)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1jGkCp-0004D5-MZ; Tue, 24 Mar 2020 10:06:59 -0400
Received: by mail-pf1-x443.google.com with SMTP id z25so4975323pfa.5;
 Tue, 24 Mar 2020 07:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=4iJZL/bJMF5zR0HAiSzST7AqXTPauUeoMEnxTWPjIts=;
 b=XDr+PWOyKNc70V3g8ubMjQfhsjSNL4x0ZeONBRADc2GRK83e8jplN436ycoUq0ly1n
 eceGnb03Fui5i4r5GERPEupMkOEUxK+1bMTZ4QRR4mRV1ojd4YtCSToUJlPztKGVS6tD
 fx88xtkD3cD3cqKRHycQ3FPzbqeluvAXhMICa6Ch6JAOPMylP2pVx3EiGC8MyCbGJylc
 fHoZFNndHE7RNvdf0V3FOJsiRkCEF6TLM+oBRNYeVP2NySKU/Ia8L8s3dF0HogmdkoYV
 87DXQXT/uY/WXxBi2eJnfMk3WiUtj8E+1hmdL0oN+k16/U1HXoMGuoQHGvEOY7A3k9K3
 YQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=4iJZL/bJMF5zR0HAiSzST7AqXTPauUeoMEnxTWPjIts=;
 b=eBM8d9W29ccmOM/cFNvipbxdGO3FrwRAEfCmXick0+OAhz4CSAE2uJ188DJDJm6PKS
 I4pGiGdfc5EFlzHcz3XvPloMlFvy05rxjBwQfvpWVSuuFYhb9WCKwIgfji870u0ARYl5
 NZcQ5+A1O0cCMMaMu4HS/M9YnGGGmvKvQPLWnBilnuBPliAdesNDwPw4SO917LSEdHuO
 uEVewvI+ZvDSwZMVOqU3cY3iFBuj0IeqfJz/YMtsSlfPpG5NYTviY2GZxApFGX2Al3hq
 7gcpVY2vNWSgcQIBBP9Uk8vpswsBF+3YQ/vfyQvTuByJhHa8bo0GpQHn/0Nea+rNRjg2
 KJhw==
X-Gm-Message-State: ANhLgQ1EiXIt2OUmkKfjWGclWljycff0OGinAQQZUhQhfkG8ilY9uikN
 BbSYZHOK5o3D7Fq5D/mjxdZD8LomTIg=
X-Google-Smtp-Source: ADFU+vuNgY515kWHpHABUGw6YDWtVhakWfMFRSYePsGAzPat2SYA7CPpYjfX6mvnKIZS1o+yA9cGJQ==
X-Received: by 2002:a63:4707:: with SMTP id u7mr27927670pga.221.1585058818241; 
 Tue, 24 Mar 2020 07:06:58 -0700 (PDT)
Received: from localhost.localdomain ([222.237.189.180])
 by smtp.gmail.com with ESMTPSA id y17sm9766490pfl.104.2020.03.24.07.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2020 07:06:57 -0700 (PDT)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: qemu-block@nongnu.org
Subject: [PATCH] nvme: Print 'cqid' for nvme_del_cq
Date: Tue, 24 Mar 2020 23:06:46 +0900
Message-Id: <20200324140646.8274-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Minwoo Im <minwoo.im.dev@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The given argument for this trace should be cqid, not sqid.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 hw/block/trace-events | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/trace-events b/hw/block/trace-events
index f78939fa9da1..bf6d11b58b85 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -37,7 +37,7 @@ nvme_rw(const char *verb, uint32_t blk_count, uint64_t byte_count, uint64_t lba)
 nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsize, uint16_t qflags) "create submission queue, addr=0x%"PRIx64", sqid=%"PRIu16", cqid=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16""
 nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size, uint16_t qflags, int ien) "create completion queue, addr=0x%"PRIx64", cqid=%"PRIu16", vector=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16", ien=%d"
 nvme_del_sq(uint16_t qid) "deleting submission queue sqid=%"PRIu16""
-nvme_del_cq(uint16_t cqid) "deleted completion queue, sqid=%"PRIu16""
+nvme_del_cq(uint16_t cqid) "deleted completion queue, cqid=%"PRIu16""
 nvme_identify_ctrl(void) "identify controller"
 nvme_identify_ns(uint16_t ns) "identify namespace, nsid=%"PRIu16""
 nvme_identify_nslist(uint16_t ns) "identify namespace list, nsid=%"PRIu16""
-- 
2.17.1



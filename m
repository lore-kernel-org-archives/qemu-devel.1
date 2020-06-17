Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC8FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:47:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C3E12070A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qBCAFHPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3E12070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfuE-0000om-Hz
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=430b82a1d=dmitry.fomichev@wdc.com>)
 id 1jlfhi-0003nq-R8; Wed, 17 Jun 2020 17:34:42 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:29837)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=430b82a1d=dmitry.fomichev@wdc.com>)
 id 1jlfhg-0005DU-56; Wed, 17 Jun 2020 17:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592429679; x=1623965679;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9XbVUSXZTerXVjhktMLUPFM/BRnSv5jdmytB77i3T/s=;
 b=qBCAFHPvN6YMzFDmH+m/n+BK7mQ+hhnHYDHWEaqLkyCh/KEOggiufpFF
 i35cg1yl7Hze0ejZBUhKPV/Mk2PFZFxA6q2O6NQjG7AQzMZAVStvgEyQe
 dSAVCe9sZCiahEpEDuO+gHCeGMsmk+ger6F9v4TgCzokWwvwrhZTYlUwt
 K5j9oV7OrsbEp/hL/A/1cIDZCikbxfqrQY72QtWcjwBB5WAnP24nlEOZw
 TRfAbJ8puhjl45LD9c2kDpm9jr3jg+PzTA0MTZVLpriXQnFrXIqCT3ADV
 YW+xg8dovIyknpZljVtosa1PTQPluqD4kd4w0a7y1cmVPaZ9ZnEFrfFT6 Q==;
IronPort-SDR: ycs0lHR3QlI5YmA+tVyoNDpO0v7WQ/UornFfw9+3vBOEdE6V+QpCCKlFha16+2Y+KGfsfKn+jz
 RekifCeQRvWX1MdasYO010L/eecVdBJaxp9s3NRBwUFXE7iKnn/4QnxmDXmt4QYM5jysnE60Vh
 cOjEYPoQ9J+Ubgp7RoApYJ1RbhvseA72yOEhVGXMO03nCslcmUbVr6ppbWXS45pTxTnqnK161c
 dZJFcCcZB8AaWHseEY3ZgejpcMwgpTjf8CauTlUK2ffYCVQEXMPf+7ZFJTc7BhVCuuErsrWUwt
 6KQ=
X-IronPort-AV: E=Sophos;i="5.73,523,1583164800"; d="scan'208";a="249439803"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2020 05:34:38 +0800
IronPort-SDR: t/vhM23xocdZ+AYSLbL60kmwG4vLtFFjm7BHp/oIVsRAqPG5yfMHc47CzsGvfT91iUkU6CRATw
 DEhuwX6HbevZG2hJP3/AE3AJVmgStGmYQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2020 14:23:19 -0700
IronPort-SDR: mAzXKkE5FWXGaC32XLb+fiE8vFn6bINncoGKellhfu55397vyhCgifMGJYsdN/liboIsGOwhfh
 2NuDqBf5Fy+Q==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 17 Jun 2020 14:34:37 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Kevin Wolf <kwolf@redhat.com>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>
Subject: [PATCH v2 06/18] hw/block/nvme: Define trace events related to NS
 Types
Date: Thu, 18 Jun 2020 06:34:03 +0900
Message-Id: <20200617213415.22417-7-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
References: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=430b82a1d=dmitry.fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 17:34:28
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>, qemu-devel@nongnu.org,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A few trace events are defined that are relevant to implementing
Namespace Types (NVMe TP 4056).

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 hw/block/trace-events | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/block/trace-events b/hw/block/trace-events
index 423d491e27..3f3323fe38 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -39,8 +39,13 @@ pci_nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size,
 pci_nvme_del_sq(uint16_t qid) "deleting submission queue sqid=%"PRIu16""
 pci_nvme_del_cq(uint16_t cqid) "deleted completion queue, cqid=%"PRIu16""
 pci_nvme_identify_ctrl(void) "identify controller"
+pci_nvme_identify_ctrl_csi(uint8_t csi) "identify controller, csi=0x%"PRIx8""
 pci_nvme_identify_ns(uint16_t ns) "identify namespace, nsid=%"PRIu16""
+pci_nvme_identify_ns_csi(uint16_t ns, uint8_t csi) "identify namespace, nsid=%"PRIu16", csi=0x%"PRIx8""
 pci_nvme_identify_nslist(uint16_t ns) "identify namespace list, nsid=%"PRIu16""
+pci_nvme_identify_nslist_csi(uint16_t ns, uint8_t csi) "identify namespace list, nsid=%"PRIu16", csi=0x%"PRIx8""
+pci_nvme_list_ns_descriptors(void) "identify namespace descriptors"
+pci_nvme_identify_cmd_set(void) "identify i/o command set"
 pci_nvme_getfeat_vwcache(const char* result) "get feature volatile write cache, result=%s"
 pci_nvme_getfeat_numq(int result) "get feature number of queues, result=%d"
 pci_nvme_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "requested cq_count=%d sq_count=%d, responding with cq_count=%d sq_count=%d"
@@ -59,6 +64,8 @@ pci_nvme_mmio_stopped(void) "cleared controller enable bit"
 pci_nvme_mmio_shutdown_set(void) "shutdown bit set"
 pci_nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
 pci_nvme_cmd_supp_and_effects_log_read(void) "commands supported and effects log read"
+pci_nvme_css_nvm_cset_selected_by_host(uint32_t cc) "NVM command set selected by host, bar.cc=0x%"PRIx32""
+pci_nvme_css_all_csets_sel_by_host(uint32_t cc) "all supported command sets selected by host, bar.cc=0x%"PRIx32""
 
 # nvme traces for error conditions
 pci_nvme_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
@@ -72,6 +79,9 @@ pci_nvme_err_invalid_admin_opc(uint8_t opc) "invalid admin opcode 0x%"PRIx8""
 pci_nvme_err_invalid_lba_range(uint64_t start, uint64_t len, uint64_t limit) "Invalid LBA start=%"PRIu64" len=%"PRIu64" limit=%"PRIu64""
 pci_nvme_err_invalid_effects_log_offset(uint64_t ofs) "commands supported and effects log offset must be 0, got %"PRIu64""
 pci_nvme_err_invalid_effects_log_len(uint32_t len) "commands supported and effects log size is 4096, got %"PRIu32""
+pci_nvme_err_change_css_when_enabled(void) "changing CC.CSS while controller is enabled"
+pci_nvme_err_only_nvm_cmd_set_avail(void) "setting 110b CC.CSS, but only NVM command set is enabled"
+pci_nvme_err_invalid_iocsci(uint32_t idx) "unsupported command set combination index %"PRIu32""
 pci_nvme_err_invalid_del_sq(uint16_t qid) "invalid submission queue deletion, sid=%"PRIu16""
 pci_nvme_err_invalid_create_sq_cqid(uint16_t cqid) "failed creating submission queue, invalid cqid=%"PRIu16""
 pci_nvme_err_invalid_create_sq_sqid(uint16_t sqid) "failed creating submission queue, invalid sqid=%"PRIu16""
@@ -127,6 +137,7 @@ pci_nvme_ub_db_wr_invalid_cqhead(uint32_t qid, uint16_t new_head) "completion qu
 pci_nvme_ub_db_wr_invalid_sq(uint32_t qid) "submission queue doorbell write for nonexistent queue, sqid=%"PRIu32", ignoring"
 pci_nvme_ub_db_wr_invalid_sqtail(uint32_t qid, uint16_t new_tail) "submission queue doorbell write value beyond queue size, sqid=%"PRIu32", new_head=%"PRIu16", ignoring"
 pci_nvme_unsupported_log_page(uint16_t lid) "unsupported log page 0x%"PRIx16""
+pci_nvme_ub_unknown_css_value(void) "unknown value in cc.css field"
 
 # xen-block.c
 xen_block_realize(const char *type, uint32_t disk, uint32_t partition) "%s d%up%u"
-- 
2.21.0



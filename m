Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE5FC4346E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 02:45:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB4C622207
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 02:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qrrWb9zR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB4C622207
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMjAC-0000Au-Pb
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 22:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5334b480d=dmitry.fomichev@wdc.com>)
 id 1kMj1D-0006rw-Iy; Sun, 27 Sep 2020 22:35:59 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:21635)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5334b480d=dmitry.fomichev@wdc.com>)
 id 1kMj17-0003Me-Ha; Sun, 27 Sep 2020 22:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601260553; x=1632796553;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jniklUrqzx+BB7Pz//D7wlZglx+Rllx3WLHWKqAdUlk=;
 b=qrrWb9zRq+9nvycG8dz76Gm4JsUoI7LRRsspdireeWpUu3dvNg1uZsqQ
 moqIqoA+SwguW0zk+9gGK2Njkh/G3wkhLyafRyXnxXT4Lo92XPpZ8qEhX
 7cjuJoYSYCm781rdGGN/8tC6bjhJHQ8Xf0S6L798cRqgKIgV5jWR/obVn
 gFOzNvtjn4/bw1W45MF0BkdeUZEPS+G2Y5RBCmGgLirEPTVy/NTjqUNjs
 tTWYvDDpFt9qzBlu3t8HXc9dJ2HYlepCe0ESXEHeScajL4biGxoBncj3V
 4e+mQ44BbYnIo57tIIHmDkfJ/pl5R6IXkaJ+9fI8eKEttuaayC6ZJe02p A==;
IronPort-SDR: OLo0ejfxB303/9i2rH/gMJ2bzVAIjj4/hSutYqqsvkPRZ6th7srdSLT/A5kLse438/QPw3BBzY
 JiozYG3pNks2+9VZZ9rHUR6zIN1OZVGha+Y43CdEEDuxo9eaRdM68pGH0aPGDQu24N4YgKH2h/
 I+k7CauHJmCnWmuVPoNLFWxV9F49bvPkr5+wP8kiKgwvfSir5Ktq59p6Js6kbPa6Qjj0MCNzCZ
 /P5e5zdJAiMlM/5ETYPXr0xrU7cz9SjVE2izYHpgS8Je76DxRfpJqhvSlTIlZ02egKybX0ZgWg
 CCY=
X-IronPort-AV: E=Sophos;i="5.77,312,1596470400"; d="scan'208";a="258125244"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 10:35:52 +0800
IronPort-SDR: IhlJltbQ5i2V1zLUxs8ha7ySw4SYPDG8WsbXMWy4kkYukNApCIWX3lAlq0wC8Hc7+kr6Lr8BP5
 hxjYFJGe6F9w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2020 19:22:48 -0700
IronPort-SDR: MhkeFBnnzESjG0hN3VXTWtAZOU9jq5SETkKCybn8ACkqnwSU1IdNAaaXQ9AAekj6lGlBpwyYSW
 iMrxuv2b+qrQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 27 Sep 2020 19:35:50 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v5 08/14] hw/block/nvme: Define Zoned NS Command Set trace
 events
Date: Mon, 28 Sep 2020 11:35:22 +0900
Message-Id: <20200928023528.15260-9-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=5334b480d=dmitry.fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/27 22:35:35
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Zoned Namespace Command Set / Namespace Types implementation that
is being introduced in this series adds a good number of trace events.
Combine all tracepoint definitions into a separate patch to make
reviewing more convenient.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 hw/block/trace-events | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/hw/block/trace-events b/hw/block/trace-events
index b93429b04c..386f28e457 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -93,6 +93,17 @@ pci_nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
 pci_nvme_cmd_supp_and_effects_log_read(void) "commands supported and effects log read"
 pci_nvme_css_nvm_cset_selected_by_host(uint32_t cc) "NVM command set selected by host, bar.cc=0x%"PRIx32""
 pci_nvme_css_all_csets_sel_by_host(uint32_t cc) "all supported command sets selected by host, bar.cc=0x%"PRIx32""
+pci_nvme_open_zone(uint64_t slba, uint32_t zone_idx, int all) "open zone, slba=%"PRIu64", idx=%"PRIu32", all=%"PRIi32""
+pci_nvme_close_zone(uint64_t slba, uint32_t zone_idx, int all) "close zone, slba=%"PRIu64", idx=%"PRIu32", all=%"PRIi32""
+pci_nvme_finish_zone(uint64_t slba, uint32_t zone_idx, int all) "finish zone, slba=%"PRIu64", idx=%"PRIu32", all=%"PRIi32""
+pci_nvme_reset_zone(uint64_t slba, uint32_t zone_idx, int all) "reset zone, slba=%"PRIu64", idx=%"PRIu32", all=%"PRIi32""
+pci_nvme_offline_zone(uint64_t slba, uint32_t zone_idx, int all) "offline zone, slba=%"PRIu64", idx=%"PRIu32", all=%"PRIi32""
+pci_nvme_set_descriptor_extension(uint64_t slba, uint32_t zone_idx) "set zone descriptor extension, slba=%"PRIu64", idx=%"PRIu32""
+pci_nvme_zd_extension_set(uint32_t zone_idx) "set descriptor extension for zone_idx=%"PRIu32""
+pci_nvme_power_on_close(uint32_t state, uint64_t slba) "zone state=%"PRIu32", slba=%"PRIu64" transitioned to Closed state"
+pci_nvme_power_on_reset(uint32_t state, uint64_t slba) "zone state=%"PRIu32", slba=%"PRIu64" transitioned to Empty state"
+pci_nvme_power_on_full(uint32_t state, uint64_t slba) "zone state=%"PRIu32", slba=%"PRIu64" transitioned to Full state"
+pci_nvme_mapped_zone_file(char *zfile_name, int ret) "mapped zone file %s, error %d"
 
 # nvme traces for error conditions
 pci_nvme_err_mdts(uint16_t cid, size_t len) "cid %"PRIu16" len %zu"
@@ -111,9 +122,23 @@ pci_nvme_err_invalid_prp(void) "invalid PRP"
 pci_nvme_err_invalid_opc(uint8_t opc) "invalid opcode 0x%"PRIx8""
 pci_nvme_err_invalid_admin_opc(uint8_t opc) "invalid admin opcode 0x%"PRIx8""
 pci_nvme_err_invalid_lba_range(uint64_t start, uint64_t len, uint64_t limit) "Invalid LBA start=%"PRIu64" len=%"PRIu64" limit=%"PRIu64""
+pci_nvme_err_unaligned_zone_cmd(uint8_t action, uint64_t slba, uint64_t zslba) "unaligned zone op 0x%"PRIx32", got slba=%"PRIu64", zslba=%"PRIu64""
+pci_nvme_err_invalid_zone_state_transition(uint8_t state, uint8_t action, uint64_t slba, uint8_t attrs) "0x%"PRIx32"->0x%"PRIx32", slba=%"PRIu64", attrs=0x%"PRIx32""
+pci_nvme_err_write_not_at_wp(uint64_t slba, uint64_t zone, uint64_t wp) "writing at slba=%"PRIu64", zone=%"PRIu64", but wp=%"PRIu64""
+pci_nvme_err_append_not_at_start(uint64_t slba, uint64_t zone) "appending at slba=%"PRIu64", but zone=%"PRIu64""
+pci_nvme_err_zone_write_not_ok(uint64_t slba, uint32_t nlb, uint32_t status) "slba=%"PRIu64", nlb=%"PRIu32", status=0x%"PRIx16""
+pci_nvme_err_zone_read_not_ok(uint64_t slba, uint32_t nlb, uint32_t status) "slba=%"PRIu64", nlb=%"PRIu32", status=0x%"PRIx16""
+pci_nvme_err_append_too_large(uint64_t slba, uint32_t nlb, uint8_t zasl) "slba=%"PRIu64", nlb=%"PRIu32", zasl=%"PRIu8""
+pci_nvme_err_insuff_active_res(uint32_t max_active) "max_active=%"PRIu32" zone limit exceeded"
+pci_nvme_err_insuff_open_res(uint32_t max_open) "max_open=%"PRIu32" zone limit exceeded"
+pci_nvme_err_zone_file_invalid(int error) "validation error=%"PRIi32""
+pci_nvme_err_zd_extension_map_error(uint32_t zone_idx) "can't map descriptor extension for zone_idx=%"PRIu32""
+pci_nvme_err_invalid_changed_zone_list_offset(uint64_t ofs) "changed zone list log offset must be 0, got %"PRIu64""
+pci_nvme_err_invalid_changed_zone_list_len(uint32_t len) "changed zone list log size is 4096, got %"PRIu32""
 pci_nvme_err_invalid_effects_log_offset(uint64_t ofs) "commands supported and effects log offset must be 0, got %"PRIu64""
 pci_nvme_err_change_css_when_enabled(void) "changing CC.CSS while controller is enabled"
 pci_nvme_err_only_nvm_cmd_set_avail(void) "setting 110b CC.CSS, but only NVM command set is enabled"
+pci_nvme_err_only_zoned_cmd_set_avail(void) "setting 001b CC.CSS, but only ZONED+NVM command set is enabled"
 pci_nvme_err_invalid_iocsci(uint32_t idx) "unsupported command set combination index %"PRIu32""
 pci_nvme_err_invalid_del_sq(uint16_t qid) "invalid submission queue deletion, sid=%"PRIu16""
 pci_nvme_err_invalid_create_sq_cqid(uint16_t cqid) "failed creating submission queue, invalid cqid=%"PRIu16""
@@ -147,6 +172,7 @@ pci_nvme_err_startfail_sqent_too_large(uint8_t log2ps, uint8_t maxlog2ps) "nvme_
 pci_nvme_err_startfail_asqent_sz_zero(void) "nvme_start_ctrl failed because the admin submission queue size is zero"
 pci_nvme_err_startfail_acqent_sz_zero(void) "nvme_start_ctrl failed because the admin completion queue size is zero"
 pci_nvme_err_startfail(void) "setting controller enable bit failed"
+pci_nvme_err_invalid_mgmt_action(int action) "action=0x%"PRIx8""
 
 # Traces for undefined behavior
 pci_nvme_ub_mmiowr_misaligned32(uint64_t offset) "MMIO write not 32-bit aligned, offset=0x%"PRIx64""
-- 
2.21.0



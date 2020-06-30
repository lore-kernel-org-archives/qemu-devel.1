Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225A6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:15:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB99A2073E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB99A2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqFAk-0006ps-7S
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 08:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqFA7-0006GG-66; Tue, 30 Jun 2020 08:14:55 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47880)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqFA4-0000xT-Jp; Tue, 30 Jun 2020 08:14:54 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 34FE1BF676;
 Tue, 30 Jun 2020 12:14:50 +0000 (UTC)
Date: Tue, 30 Jun 2020 14:14:46 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v2 09/18] hw/block/nvme: Define Zoned NS Command Set
 trace events
Message-ID: <20200630121446.skc22rf5wfzv5p6h@apples.localdomain>
References: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
 <20200617213415.22417-10-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200617213415.22417-10-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 04:46:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Keith Busch <kbusch@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 18 06:34, Dmitry Fomichev wrote:
> The Zoned Namespace Command Set / Namespace Types implementation that
> is being introduced in this series adds a good number of trace events.
> Combine all tracepoint definitions into a separate patch to make
> reviewing more convenient.
> 
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>

I would prefer that LBAs was reported in hex, but it's just personal
preference.

> ---
>  hw/block/trace-events | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 3f3323fe38..984db8a20c 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -66,6 +66,31 @@ pci_nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
>  pci_nvme_cmd_supp_and_effects_log_read(void) "commands supported and effects log read"
>  pci_nvme_css_nvm_cset_selected_by_host(uint32_t cc) "NVM command set selected by host, bar.cc=0x%"PRIx32""
>  pci_nvme_css_all_csets_sel_by_host(uint32_t cc) "all supported command sets selected by host, bar.cc=0x%"PRIx32""
> +pci_nvme_open_zone(uint64_t slba, uint32_t zone_idx, int all) "open zone, slba=%"PRIu64", idx=%"PRIu32", all=%"PRIi32""
> +pci_nvme_close_zone(uint64_t slba, uint32_t zone_idx, int all) "close zone, slba=%"PRIu64", idx=%"PRIu32", all=%"PRIi32""
> +pci_nvme_finish_zone(uint64_t slba, uint32_t zone_idx, int all) "finish zone, slba=%"PRIu64", idx=%"PRIu32", all=%"PRIi32""
> +pci_nvme_reset_zone(uint64_t slba, uint32_t zone_idx, int all) "reset zone, slba=%"PRIu64", idx=%"PRIu32", all=%"PRIi32""
> +pci_nvme_offline_zone(uint64_t slba, uint32_t zone_idx, int all) "offline zone, slba=%"PRIu64", idx=%"PRIu32", all=%"PRIi32""
> +pci_nvme_set_descriptor_extension(uint64_t slba, uint32_t zone_idx) "set zone descriptor extension, slba=%"PRIu64", idx=%"PRIu32""
> +pci_nvme_zone_reset_recommended(uint64_t slba) "slba=%"PRIu64""
> +pci_nvme_zone_reset_internal_op(uint64_t slba) "slba=%"PRIu64""
> +pci_nvme_zone_finish_recommended(uint64_t slba) "slba=%"PRIu64""
> +pci_nvme_zone_finish_internal_op(uint64_t slba) "slba=%"PRIu64""
> +pci_nvme_zone_finished_by_controller(uint64_t slba) "slba=%"PRIu64""
> +pci_nvme_zd_extension_set(uint32_t zone_idx) "set descriptor extension for zone_idx=%"PRIu32""
> +pci_nvme_power_on_close(uint32_t state, uint64_t slba) "zone state=%"PRIu32", slba=%"PRIu64" transitioned to Closed state"
> +pci_nvme_power_on_reset(uint32_t state, uint64_t slba) "zone state=%"PRIu32", slba=%"PRIu64" transitioned to Empty state"
> +pci_nvme_power_on_full(uint32_t state, uint64_t slba) "zone state=%"PRIu32", slba=%"PRIu64" transitioned to Full state"
> +pci_nvme_zone_ae_not_enabled(int info, int log_page, int nsid) "zone async event not enabled, info=0x%"PRIx32", lp=0x%"PRIx32", nsid=%"PRIu32""
> +pci_nvme_zone_ae_not_cleared(int info, int log_page, int nsid) "zoned async event not cleared, info=0x%"PRIx32", lp=0x%"PRIx32", nsid=%"PRIu32""

Can we use uintxx_t's here?

> +pci_nvme_zone_aen_not_requested(uint32_t oaes) "zone descriptor AEN are not requested by host, oaes=0x%"PRIx32""
> +pci_nvme_getfeat_aen_cfg(uint64_t res) "reporting async event config res=%"PRIu64""
> +pci_nvme_setfeat_zone_info_aer_on(void) "zone info change notices enabled"
> +pci_nvme_setfeat_zone_info_aer_off(void) "zone info change notices disabled"
> +pci_nvme_changed_zone_log_read(uint16_t nsid) "changed zone list log of ns %"PRIu16""

nsid should be uint32_t.

> +pci_nvme_reporting_changed_zone(uint64_t zslba, uint8_t za) "zslba=%"PRIu64", attr=0x%"PRIx8""
> +pci_nvme_empty_changed_zone_list(void) "no changes zones to report"

s/changes/changed

> +pci_nvme_mapped_zone_file(char *zfile_name, int ret) "mapped zone file %s, error %d"
>  
>  # nvme traces for error conditions
>  pci_nvme_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
> @@ -77,10 +102,25 @@ pci_nvme_err_invalid_ns(uint32_t ns, uint32_t limit) "invalid namespace %u not w
>  pci_nvme_err_invalid_opc(uint8_t opc) "invalid opcode 0x%"PRIx8""
>  pci_nvme_err_invalid_admin_opc(uint8_t opc) "invalid admin opcode 0x%"PRIx8""
>  pci_nvme_err_invalid_lba_range(uint64_t start, uint64_t len, uint64_t limit) "Invalid LBA start=%"PRIu64" len=%"PRIu64" limit=%"PRIu64""
> +pci_nvme_err_capacity_exceeded(uint64_t zone_id, uint64_t nr_zones) "zone capacity exceeded, zone_id=%"PRIu64", nr_zones=%"PRIu64""

Change the name to pci_nvme_err_ZONE_capacity_exceeded maybe?

> +pci_nvme_err_unaligned_zone_cmd(uint8_t action, uint64_t slba, uint64_t zslba) "unaligned zone op 0x%"PRIx32", got slba=%"PRIu64", zslba=%"PRIu64""
> +pci_nvme_err_invalid_zone_state_transition(uint8_t state, uint8_t action, uint64_t slba, uint8_t attrs) "0x%"PRIx32"->0x%"PRIx32", slba=%"PRIu64", attrs=0x%"PRIx32""
> +pci_nvme_err_write_not_at_wp(uint64_t slba, uint64_t zone, uint64_t wp) "writing at slba=%"PRIu64", zone=%"PRIu64", but wp=%"PRIu64""
> +pci_nvme_err_append_not_at_start(uint64_t slba, uint64_t zone) "appending at slba=%"PRIu64", but zone=%"PRIu64""
> +pci_nvme_err_zone_write_not_ok(uint64_t slba, uint32_t nlb, uint32_t status) "slba=%"PRIu64", nlb=%"PRIu32", status=0x%"PRIx16""
> +pci_nvme_err_zone_read_not_ok(uint64_t slba, uint32_t nlb, uint32_t status) "slba=%"PRIu64", nlb=%"PRIu32", status=0x%"PRIx16""
> +pci_nvme_err_append_too_large(uint64_t slba, uint32_t nlb, uint8_t zamds) "slba=%"PRIu64", nlb=%"PRIu32", zamds=%"PRIu8""
> +pci_nvme_err_insuff_active_res(uint32_t max_active) "max_active=%"PRIu32" zone limit exceeded"
> +pci_nvme_err_insuff_open_res(uint32_t max_open) "max_open=%"PRIu32" zone limit exceeded"
> +pci_nvme_err_zone_file_invalid(int error) "validation error=%"PRIi32""
> +pci_nvme_err_zd_extension_map_error(uint32_t zone_idx) "can't map descriptor extension for zone_idx=%"PRIu32""
> +pci_nvme_err_invalid_changed_zone_list_offset(uint64_t ofs) "changed zone list log offset must be 0, got %"PRIu64""
> +pci_nvme_err_invalid_changed_zone_list_len(uint32_t len) "changed zone list log size is 4096, got %"PRIu32""
>  pci_nvme_err_invalid_effects_log_offset(uint64_t ofs) "commands supported and effects log offset must be 0, got %"PRIu64""
>  pci_nvme_err_invalid_effects_log_len(uint32_t len) "commands supported and effects log size is 4096, got %"PRIu32""
>  pci_nvme_err_change_css_when_enabled(void) "changing CC.CSS while controller is enabled"
>  pci_nvme_err_only_nvm_cmd_set_avail(void) "setting 110b CC.CSS, but only NVM command set is enabled"
> +pci_nvme_err_only_zoned_cmd_set_avail(void) "setting 001b CC.CSS, but only ZONED+NVM command set is enabled"
>  pci_nvme_err_invalid_iocsci(uint32_t idx) "unsupported command set combination index %"PRIu32""
>  pci_nvme_err_invalid_del_sq(uint16_t qid) "invalid submission queue deletion, sid=%"PRIu16""
>  pci_nvme_err_invalid_create_sq_cqid(uint16_t cqid) "failed creating submission queue, invalid cqid=%"PRIu16""
> @@ -113,6 +153,7 @@ pci_nvme_err_startfail_sqent_too_large(uint8_t log2ps, uint8_t maxlog2ps) "nvme_
>  pci_nvme_err_startfail_asqent_sz_zero(void) "nvme_start_ctrl failed because the admin submission queue size is zero"
>  pci_nvme_err_startfail_acqent_sz_zero(void) "nvme_start_ctrl failed because the admin completion queue size is zero"
>  pci_nvme_err_startfail(void) "setting controller enable bit failed"
> +pci_nvme_err_invalid_mgmt_action(int action) "action=0x%"PRIx32""

uint8_t for action here.

>  
>  # Traces for undefined behavior
>  pci_nvme_ub_mmiowr_misaligned32(uint64_t offset) "MMIO write not 32-bit aligned, offset=0x%"PRIx64""
> -- 
> 2.21.0
> 
> 


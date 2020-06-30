Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557CEC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 20:28:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EDCC20772
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 20:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmQh2pdO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EDCC20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqMs6-00039n-ED
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 16:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jqMrQ-0002gA-6w; Tue, 30 Jun 2020 16:28:08 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:40045)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jqMrO-0000IV-GW; Tue, 30 Jun 2020 16:28:07 -0400
Received: by mail-il1-x144.google.com with SMTP id e18so8305099ilr.7;
 Tue, 30 Jun 2020 13:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FHrHcTzze7zQdyxECIXPNcwUxE2Nx2ychXxykp9UAbI=;
 b=gmQh2pdOXnvyBSKnIGKKXUQCYxJcJRbQnoE9JOvo/5ZjKcHv9jUUupdvGOqt8MoAAQ
 m9cF628thIvRQUFCyBUApLZ+Q2fUiHJevCMQTG+zCLHd+IK0T33HTOt/p/8QyXc0eAL7
 UmlGbWdAFjGHmbk+2ynL+zYUELTyF7vpNN3S/db84ujWk5+UDNCyrXkhp9DQ/f0M4/d5
 hCue3an7Yx5RGScakItQuzFMpLCH8fHYnsNuDPHCnc9MU6UWz/5DRk6HlCEB3QbCY3gk
 npxuslz1fAuv+Ev03uHImGcb7zURSpvypFuUdJwtxYo8sRIXxS05E0FMIo39w4L2zYEd
 0ZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FHrHcTzze7zQdyxECIXPNcwUxE2Nx2ychXxykp9UAbI=;
 b=r3Y96dQJQGNHQl44ZJ6ZYz2EfwBvn7Mv5vh7jI08z9V+r0U/sarbSoXi9xWwMgEzH6
 vbDQezSIvGzosWd/0GTxWWbCbq6TF29WQa6zg9sBanB90/KRPfvcJ5RuAoC2kLdTwK61
 OOgTV0FWPqOOrEtMLJTMIChyBAQsHToTb2g9cnQUQrdXkUEkgdMninRTwtAo6XhnAFCR
 YrhKV0W7s/NacjgIXP48l8Ck+y4kbZ212vt0okCHj+/Q8Z68LT99xn2BLQ3E6J05CUjt
 SISwm+YffiPOLWisGupMvh5Vv/qeDNLLLcU3rHStjHDohFCBbEU26to9DJgq80VLhICU
 QWRw==
X-Gm-Message-State: AOAM532Xbh4bk/cH3KuTbWik48ZlbWPiGxujMhBXakNMW/MsfQ1PhB1l
 j6Un8+0D/64lYnahnRa/OaO8dLh83jhDe3Ea4fc=
X-Google-Smtp-Source: ABdhPJzTqgfrczWUhw0lDvlcd0U0JYjHY5ggg3AhHv38T4UXrJ4CB1yZZV3NUR4QaDSBwbR/LGs82aelCd4974dA9NA=
X-Received: by 2002:a92:5f12:: with SMTP id t18mr4506499ilb.267.1593548885135; 
 Tue, 30 Jun 2020 13:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
 <20200617213415.22417-7-dmitry.fomichev@wdc.com>
In-Reply-To: <20200617213415.22417-7-dmitry.fomichev@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Jun 2020 13:18:21 -0700
Message-ID: <CAKmqyKObR_cW_MZ4O3JRNf5DcVosdHA0iMkpnAWpXRQeW+MTQw@mail.gmail.com>
Subject: Re: [PATCH v2 06/18] hw/block/nvme: Define trace events related to NS
 Types
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
 Damien Le Moal <damien.lemoal@wdc.com>, Qemu-block <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Keith Busch <kbusch@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 17, 2020 at 2:46 PM Dmitry Fomichev <dmitry.fomichev@wdc.com> wrote:
>
> A few trace events are defined that are relevant to implementing
> Namespace Types (NVMe TP 4056).
>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/block/trace-events | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 423d491e27..3f3323fe38 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -39,8 +39,13 @@ pci_nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size,
>  pci_nvme_del_sq(uint16_t qid) "deleting submission queue sqid=%"PRIu16""
>  pci_nvme_del_cq(uint16_t cqid) "deleted completion queue, cqid=%"PRIu16""
>  pci_nvme_identify_ctrl(void) "identify controller"
> +pci_nvme_identify_ctrl_csi(uint8_t csi) "identify controller, csi=0x%"PRIx8""
>  pci_nvme_identify_ns(uint16_t ns) "identify namespace, nsid=%"PRIu16""
> +pci_nvme_identify_ns_csi(uint16_t ns, uint8_t csi) "identify namespace, nsid=%"PRIu16", csi=0x%"PRIx8""
>  pci_nvme_identify_nslist(uint16_t ns) "identify namespace list, nsid=%"PRIu16""
> +pci_nvme_identify_nslist_csi(uint16_t ns, uint8_t csi) "identify namespace list, nsid=%"PRIu16", csi=0x%"PRIx8""
> +pci_nvme_list_ns_descriptors(void) "identify namespace descriptors"
> +pci_nvme_identify_cmd_set(void) "identify i/o command set"
>  pci_nvme_getfeat_vwcache(const char* result) "get feature volatile write cache, result=%s"
>  pci_nvme_getfeat_numq(int result) "get feature number of queues, result=%d"
>  pci_nvme_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "requested cq_count=%d sq_count=%d, responding with cq_count=%d sq_count=%d"
> @@ -59,6 +64,8 @@ pci_nvme_mmio_stopped(void) "cleared controller enable bit"
>  pci_nvme_mmio_shutdown_set(void) "shutdown bit set"
>  pci_nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
>  pci_nvme_cmd_supp_and_effects_log_read(void) "commands supported and effects log read"
> +pci_nvme_css_nvm_cset_selected_by_host(uint32_t cc) "NVM command set selected by host, bar.cc=0x%"PRIx32""
> +pci_nvme_css_all_csets_sel_by_host(uint32_t cc) "all supported command sets selected by host, bar.cc=0x%"PRIx32""
>
>  # nvme traces for error conditions
>  pci_nvme_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
> @@ -72,6 +79,9 @@ pci_nvme_err_invalid_admin_opc(uint8_t opc) "invalid admin opcode 0x%"PRIx8""
>  pci_nvme_err_invalid_lba_range(uint64_t start, uint64_t len, uint64_t limit) "Invalid LBA start=%"PRIu64" len=%"PRIu64" limit=%"PRIu64""
>  pci_nvme_err_invalid_effects_log_offset(uint64_t ofs) "commands supported and effects log offset must be 0, got %"PRIu64""
>  pci_nvme_err_invalid_effects_log_len(uint32_t len) "commands supported and effects log size is 4096, got %"PRIu32""
> +pci_nvme_err_change_css_when_enabled(void) "changing CC.CSS while controller is enabled"
> +pci_nvme_err_only_nvm_cmd_set_avail(void) "setting 110b CC.CSS, but only NVM command set is enabled"
> +pci_nvme_err_invalid_iocsci(uint32_t idx) "unsupported command set combination index %"PRIu32""
>  pci_nvme_err_invalid_del_sq(uint16_t qid) "invalid submission queue deletion, sid=%"PRIu16""
>  pci_nvme_err_invalid_create_sq_cqid(uint16_t cqid) "failed creating submission queue, invalid cqid=%"PRIu16""
>  pci_nvme_err_invalid_create_sq_sqid(uint16_t sqid) "failed creating submission queue, invalid sqid=%"PRIu16""
> @@ -127,6 +137,7 @@ pci_nvme_ub_db_wr_invalid_cqhead(uint32_t qid, uint16_t new_head) "completion qu
>  pci_nvme_ub_db_wr_invalid_sq(uint32_t qid) "submission queue doorbell write for nonexistent queue, sqid=%"PRIu32", ignoring"
>  pci_nvme_ub_db_wr_invalid_sqtail(uint32_t qid, uint16_t new_tail) "submission queue doorbell write value beyond queue size, sqid=%"PRIu32", new_head=%"PRIu16", ignoring"
>  pci_nvme_unsupported_log_page(uint16_t lid) "unsupported log page 0x%"PRIx16""
> +pci_nvme_ub_unknown_css_value(void) "unknown value in cc.css field"
>
>  # xen-block.c
>  xen_block_realize(const char *type, uint32_t disk, uint32_t partition) "%s d%up%u"
> --
> 2.21.0
>
>


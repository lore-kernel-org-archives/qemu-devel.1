Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697E1C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 00:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5B65208B3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 00:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJo9TDO7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B65208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSV0r-00038f-27
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 20:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kSV05-0002Za-F0; Tue, 13 Oct 2020 20:50:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43026)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kSV03-0006bD-N2; Tue, 13 Oct 2020 20:50:41 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DA43E208B3;
 Wed, 14 Oct 2020 00:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602636637;
 bh=JT81JcxJ6SVJSz5eTE3p4dW4bzg1nl818/ANAxJlYls=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nJo9TDO7jVlgULiKsqWjjVNgt2RZRdP1mLr4gQotBOvapIDcHBBYaJHuPT7IAafXf
 fXTzryV+wLNAwzQjxvmcDdPEWAXR2aonyKJXS/g7K+uyS/a+KWdUDYGFQIo1XxUs9p
 dmI/MDj8WRBCQhVtiVsOYHbTLtuWb2nHnv2T1mIg=
Date: Tue, 13 Oct 2020 17:50:34 -0700
From: Keith Busch <kbusch@kernel.org>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v6 01/11] hw/block/nvme: Add Commands Supported and
 Effects log
Message-ID: <20201014005034.GA1264232@dhcp-10-100-145-180.wdl.wdc.com>
References: <20201013214212.2152-1-dmitry.fomichev@wdc.com>
 <20201013214212.2152-2-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013214212.2152-2-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 20:50:38
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 Niklas Cassel <niklas.cassel@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 14, 2020 at 06:42:02AM +0900, Dmitry Fomichev wrote:
> +{
> +    NvmeEffectsLog log = {};
> +    uint32_t *dst_acs = log.acs, *dst_iocs = log.iocs;
> +    uint32_t trans_len;
> +    int i;
> +
> +    trace_pci_nvme_cmd_supp_and_effects_log_read();
> +
> +    if (off >= sizeof(log)) {
> +        trace_pci_nvme_err_invalid_effects_log_offset(off);
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    for (i = 0; i < 256; i++) {
> +        dst_acs[i] = nvme_cse_acs[i];
> +    }
> +
> +    for (i = 0; i < 256; i++) {
> +        dst_iocs[i] = nvme_cse_iocs_nvm[i];
> +    }

You're just copying the array, so let's do it like this:

    memcpy(log.acs, nvme_cse_acs, sizeof(nvme_cse_acs));
    memcpy(log.iocs, nvme_cse_iocs_nvm, sizeof(nvme_cse_iocs_nvm));

I think you also need to check

    if (NVME_CC_CSS(n->bar.cc) != NVME_CC_CSS_ADMIN_ONLY)

before copying iocs.


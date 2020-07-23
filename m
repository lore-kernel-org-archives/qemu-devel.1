Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C9EC433EC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 01:04:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E30112086A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 01:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30112086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyPed-0005Kb-88
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 21:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guang.zeng@intel.com>)
 id 1jyPbi-0001VQ-GJ
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 21:01:10 -0400
Received: from mga11.intel.com ([192.55.52.93]:15170)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guang.zeng@intel.com>)
 id 1jyPbf-0007R1-KI
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 21:01:09 -0400
IronPort-SDR: HsOqlbOz178T6wNDXE6cKTCcgeDKhrJI+InVzqTGA0pbZhvhoRtvZzsQqhhC+SumbHZBpxrWpP
 /QtNs0c4dqxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="148385497"
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; d="scan'208";a="148385497"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2020 18:01:03 -0700
IronPort-SDR: W/HWfaItXgle0qSdtTODqvSQtc9/JjpDTtmlwum0zJa3sm106gL6lVrjxuoknrHjz2xoUd/2/e
 5B76V5nxducQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; d="scan'208";a="488185534"
Received: from zengguan-mobl.ccr.corp.intel.com (HELO [10.238.0.188])
 ([10.238.0.188])
 by fmsmga006.fm.intel.com with ESMTP; 22 Jul 2020 18:01:01 -0700
Subject: Re: [PATCH] hw/misc/edu: support pci device state migration
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200722081323.9893-1-guang.zeng@intel.com>
 <CAFEAcA-M6OghOCX76q2kZDh_Nf1YLEDSLZcwa2ZVJgzwjdDaWw@mail.gmail.com>
From: Zeng Guang <guang.zeng@intel.com>
Message-ID: <03961ed0-f917-8f2c-0262-442d768ce3e4@intel.com>
Date: Thu, 23 Jul 2020 09:01:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-M6OghOCX76q2kZDh_Nf1YLEDSLZcwa2ZVJgzwjdDaWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=192.55.52.93; envelope-from=guang.zeng@intel.com;
 helo=mga11.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 21:01:03
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, wei.w.wang@intel.com,
 Jiri Slaby <jslaby@suse.cz>, chao.gao@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/2020 4:37 PM, Peter Maydell wrote:
> On Wed, 22 Jul 2020 at 09:31, Zeng Guang <guang.zeng@intel.com> wrote:
>> Currently edu device doesn't support live migration. Part of PCI
>> configuration information would be lost after migration.
>>
>> PCI device state in source VM:
>>       Bus  0, device   3, function 0:
>>       Class 0255: PCI device 1234:11e8
>>       PCI subsystem 1af4:1100
>>       IRQ 11, pin A
>>       BAR0: 32 bit memory at 0xfea00000 [0xfeafffff].
>>       id ""
>>
>> PCI device state in destination VM:
>>       Bus  0, device   3, function 0:
>>       Class 0255: PCI device 1234:11e8
>>       PCI subsystem 1af4:1100
>>       IRQ 0, pin A
>>       BAR0: 32 bit memory at 0xffffffffffffffff [0x000ffffe].
>>       id ""
>>
>> Add VMState for edu device to support migration.
>>
>> Signed-off-by: Gao Chao <chao.gao@intel.com>
>> Signed-off-by: Zeng Guang <guang.zeng@intel.com>
>> Reviewed-by: Wei Wang <wei.w.wang@intel.com>
> Hi; thanks for adding migration support for this device.
>
>
>> +static const VMStateDescription vmstate_edu = {
>> +    .name = "edu",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_PCI_DEVICE(pdev, EduState),
> This isn't the only state that the device has. You
> also need to migrate:
> stopping, addr4, fact, status, irq_status, the struct dma_state members,
> the dma_timer, dma_buf and dma_mask.
Right . I will add those params in VMstate and update patch. Thanks.
>
> thanks
> -- PMM


Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6654AC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 07:30:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AEC524679
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 07:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AEC524679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiCkD-000855-DA
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 02:30:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuzenghui@huawei.com>) id 1iiCjE-0007Pz-36
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 02:29:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuzenghui@huawei.com>) id 1iiCjC-0003I4-3c
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 02:29:39 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:51698 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuzenghui@huawei.com>)
 id 1iiCj5-00039h-2i; Fri, 20 Dec 2019 02:29:32 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 7EF0A9E8FB0866428E41;
 Fri, 20 Dec 2019 15:29:27 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Fri, 20 Dec 2019
 15:29:16 +0800
Subject: Re: [kvm-unit-tests PATCH 12/16] arm/arm64: ITS: commands
To: Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <maz@kernel.org>, <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20191216140235.10751-1-eric.auger@redhat.com>
 <20191216140235.10751-13-eric.auger@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <d56a4973-ac01-65e6-8e5d-f48da9458b5c@huawei.com>
Date: Fri, 20 Dec 2019 15:29:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191216140235.10751-13-eric.auger@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: andre.przywara@arm.com, drjones@redhat.com, alexandru.elisei@arm.com,
 thuth@redhat.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eric,

On 2019/12/16 22:02, Eric Auger wrote:
> Implement main ITS commands. The code is largely inherited from
> the ITS driver.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---

[...]

> diff --git a/lib/arm/asm/gic-v3-its.h b/lib/arm/asm/gic-v3-its.h
> index 245ef61..d074c17 100644
> --- a/lib/arm/asm/gic-v3-its.h
> +++ b/lib/arm/asm/gic-v3-its.h
> @@ -161,5 +179,23 @@ extern void its_enable_defaults(void);
>   extern struct its_device *its_create_device(u32 dev_id, int nr_ites);
>   extern struct its_collection *its_create_collection(u32 col_id, u32 target_pe);
>   
> +extern void its_send_mapd(struct its_device *dev, int valid);
> +extern void its_send_mapc(struct its_collection *col, int valid);
> +extern void its_send_mapti(struct its_device *dev, u32 irq_id,
> +			   u32 event_id, struct its_collection *col);
> +extern void its_send_int(struct its_device *dev, u32 event_id);
> +extern void its_send_inv(struct its_device *dev, u32 event_id);
> +extern void its_send_discard(struct its_device *dev, u32 event_id);
> +extern void its_send_clear(struct its_device *dev, u32 event_id);
> +extern void its_send_invall(struct its_collection *col);
> +extern void its_send_movi(struct its_device *dev,
> +			  struct its_collection *col, u32 id);
> +extern void its_send_sync(struct its_collection *col);
> +extern void its_print_cmd_state(void);

This function is not used by later patches, I guess it's mostly used
for debug.

(Assuming the Linux ITS driver has done the right thing ;-), I just skip
looking at this patch.)


Thanks,
Zenghui



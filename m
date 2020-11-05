Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B270EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 03:09:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0739420715
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 03:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0739420715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaVe3-0005Vc-TQ
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 22:09:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cenjiahui@huawei.com>)
 id 1kaVcr-00052i-MJ
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 22:07:49 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2390)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cenjiahui@huawei.com>)
 id 1kaVco-0004N3-PL
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 22:07:49 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CRT374BJnz15RqM;
 Thu,  5 Nov 2020 11:07:31 +0800 (CST)
Received: from [10.174.184.155] (10.174.184.155) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 5 Nov 2020 11:07:25 +0800
Subject: Re: [PATCH v9 2/8] fw_cfg: Write the extra roots into the fw_cfg
To: Laszlo Ersek <lersek@redhat.com>, <qemu-devel@nongnu.org>
References: <20201103120157.2286-1-cenjiahui@huawei.com>
 <20201103120157.2286-3-cenjiahui@huawei.com>
 <dadc89f2-bff2-358a-b15d-1302018286a5@redhat.com>
 <25c7d6a0-98e4-6287-2da3-bbdf9836fb95@redhat.com>
From: Jiahui Cen <cenjiahui@huawei.com>
Message-ID: <290337e3-6e6c-28c9-838d-1c293a744117@huawei.com>
Date: Thu, 5 Nov 2020 11:07:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <25c7d6a0-98e4-6287-2da3-bbdf9836fb95@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.184.155]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190; envelope-from=cenjiahui@huawei.com;
 helo=szxga04-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:07:38
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: xieyingtai@huawei.com, peter.maydell@linaro.org, berrange@redhat.com,
 mst@redhat.com, xiexiangyou@huawei.com, shannon.zhaosl@gmail.com,
 miaoyubo@huawei.com, Gerd Hoffmann <kraxel@redhat.com>, imammedo@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/11/5 4:05, Laszlo Ersek wrote:
> +Phil, +Gerd
> 
> On 11/04/20 20:54, Laszlo Ersek wrote:
>> +Marcel
>>
>> On 11/03/20 13:01, Jiahui Cen wrote:
>>> From: Yubo Miao <miaoyubo@huawei.com>
>>>
>>> Write the extra roots into the fw_cfg, therefore the uefi could
>>> get the extra roots. Only if the uefi knows there are extra roots,
>>> the config space of devices behind the root could be obtained.
>>>
>>> Signed-off-by: Yubo Miao <miaoyubo@huawei.com>
>>> Signed-off-by: Jiahui Cen <cenjiahui@huawei.com>
>>> ---
>>>  hw/arm/virt.c              |  8 ++++++++
>>>  hw/i386/pc.c               | 18 ++----------------
>>>  hw/nvram/fw_cfg.c          | 20 ++++++++++++++++++++
>>>  include/hw/nvram/fw_cfg.h  |  2 ++
>>>  include/hw/pci/pcie_host.h |  4 ++++
>>>  5 files changed, 36 insertions(+), 16 deletions(-)
> 
> I realize I never reacted to this patch before (and we're at v9), so you
> might not welcome my feedback at this point.

Hi Laszlo,

Thanks for your comments. Any feedback is welcomed at any time :)

> The explanation why I've only reacted now is the following: there's an
> agreement between Phil and myself that Phil handles fw_cfg reviews
> primarily, and I review only (or almost only) Phil's patches for fw_cfg.
> Furthermore, all versions of this particular patch, as far as I can see,
> CC'd me but not Phil. So Phil never knew to look, and I never checked
> (this being an fw_cfg patch, per subject line) beyond the author being
> Phil or not.

I did not know the agreement between you and Phil before, and it's
my mistake forgetting to CC Phil. I'll check the CC list in the
future patches.

Thanks
Jiahui

> The solution is of course to use the get_maintainer.pl script for
> determining reviewers, and adding them with "Cc:" tags to the commit
> message. (You also missed Marcel at the least; see my previous
> response.) git-send-email is supposed to adhere to those "Cc:" tags.
> 
> The reason I've looked now is... I guess I was too tired to remember our
> agreement with Phil.
>> Thanks
> Laszlo
> 
> .
> 


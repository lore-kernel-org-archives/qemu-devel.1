Return-Path: <SRS0=YAkC=B2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9701C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 11:14:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 656C0206C0
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 11:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTkVyV/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 656C0206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7Gcs-0001ww-NY
	for qemu-devel@archiver.kernel.org; Sun, 16 Aug 2020 07:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7Gc2-0001MJ-As; Sun, 16 Aug 2020 07:14:06 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50610)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7Gc0-0001cX-Nt; Sun, 16 Aug 2020 07:14:06 -0400
Received: by mail-wm1-x341.google.com with SMTP id c80so11015505wme.0;
 Sun, 16 Aug 2020 04:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=M4gnjLQtdYLi06PBoVtI7NLXK2qp/DDGd2nfG3a8ok4=;
 b=VTkVyV/fd1KmBfOaPVM5Pg+Gezecu0uihkzAxaEtiK7PlbPFEkp8v74nURTj5ELHWy
 3/JsRXE8kWjrjLxbRcShlm9tbRVN7JcTXz1jBncM9OZuiak0FzCcmBAt/g0zs8WpSJ5p
 XHSPRnJ7x5L9UKx6AxoCBPzrk306FMAxcOdMS7bTGsJJV2fsciEjXg08brgi101UYZPU
 wBxE07cWZgF0yNuMKnDRsvP7PO4rCGtNJBaI78dZIJGqEwMZMgsGafzNJ4jUjlamCY/F
 bmoeSQtDYB+sKxrrQ3F4mujM35pCPHqXJ6kDP/t2FA45c+biQClqyrPzItXBeBW6XsXI
 yeDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M4gnjLQtdYLi06PBoVtI7NLXK2qp/DDGd2nfG3a8ok4=;
 b=Cyxwon3yrcIyvMXRFoLjWaBnzDXe5CGIDucZMAm7soaeNCoFv9HgoOYbwHY4WnUppY
 5XLNGufpN008ElRbDQSEdA0MIdFBgJYZQ06B5AZl6AL59O5L7zgS5qwsQfi/QtI4NPqK
 mFLFCCipeOWIRzCUcbKCzCnWxcgZvLJn3j+yt+SNL/so6hAH6YQExFvsYzXDzpMTlGMH
 ie6moEylnJjeti9TsAE3fWI5zYcPUzeiMLydUxF4/OHsION+39B6s01hbZq2vfvwXkFU
 nWQGf6Pw4zn03ZFqqGqyjA8ZeXACBkr2HEKsvWHOS77ZmXbADhUGmWQwuJooJ3ANbRn4
 bRYA==
X-Gm-Message-State: AOAM530wK5mB0qVnguBxZe9t0MF3bJD2NhZ5T1EI5A1/HLpffVCl+Ao/
 iz2JkF2FI0n9QHgGgR1c9Pg=
X-Google-Smtp-Source: ABdhPJy9/+Sx8H8G50EF/7xQdptZx9pPyWSFAsa1hPc4F25F9v2MgxVxdxI6vm01kEKKeE2/ZY9ODQ==
X-Received: by 2002:a1c:5f54:: with SMTP id t81mr10117997wmb.2.1597576442028; 
 Sun, 16 Aug 2020 04:14:02 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id v15sm25520698wrm.23.2020.08.16.04.14.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2020 04:14:01 -0700 (PDT)
Subject: Re: [PATCH 14/18] hw/net: cadence_gem: Add a new 'phy-addr' property
To: Bin Meng <bmeng.cn@gmail.com>, John Linn <john.linn@xilinx.com>,
 "Peter A. G. Crosthwaite" <peter.crosthwaite@petalogix.com>,
 Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
 Nathan Rossi <nathan@nathanrossi.com>
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
 <1597423256-14847-15-git-send-email-bmeng.cn@gmail.com>
 <e97e1bc4-277d-9fdd-1372-f69d22b4a7e4@amsat.org>
 <CAEUhbmX6O7gGc2+sZFXSve=rBJLZQ5ts2sfWM=OU6k+4j-uryg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <919b9233-c616-7ee7-5696-70e3563dd14c@amsat.org>
Date: Sun, 16 Aug 2020 13:14:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAEUhbmX6O7gGc2+sZFXSve=rBJLZQ5ts2sfWM=OU6k+4j-uryg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Jason Wang <jasowang@redhat.com>, Bin Meng <bin.meng@windriver.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmerdabbelt@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/16/20 10:29 AM, Bin Meng wrote:
> On Sat, Aug 15, 2020 at 5:06 PM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> On 8/14/20 6:40 PM, Bin Meng wrote:
>>> From: Bin Meng <bin.meng@windriver.com>
>>>
>>> At present the PHY address of the PHY connected to GEM is hard-coded
>>> to either 23 (BOARD_PHY_ADDRESS) or 0. This might not be the case for
>>> all boards. Add a new 'phy-addr' property so that board can specify
>>> the PHY address for each GEM instance.
>>>
>>> Signed-off-by: Bin Meng <bin.meng@windriver.com>
>>> ---
>>>
>>>  hw/net/cadence_gem.c         | 7 +++++--
>>>  include/hw/net/cadence_gem.h | 2 ++
>>>  2 files changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
>>> index a93b5c0..9fa03de 100644
>>> --- a/hw/net/cadence_gem.c
>>> +++ b/hw/net/cadence_gem.c
>>> @@ -1446,7 +1446,8 @@ static uint64_t gem_read(void *opaque, hwaddr offset, unsigned size)
>>>              uint32_t phy_addr, reg_num;
>>>
>>>              phy_addr = (retval & GEM_PHYMNTNC_ADDR) >> GEM_PHYMNTNC_ADDR_SHFT;
>>> -            if (phy_addr == BOARD_PHY_ADDRESS || phy_addr == 0) {
>>> +            if (phy_addr == BOARD_PHY_ADDRESS || phy_addr == 0 ||
>>> +                phy_addr == s->phy_addr) {
>>>                  reg_num = (retval & GEM_PHYMNTNC_REG) >> GEM_PHYMNTNC_REG_SHIFT;
>>>                  retval &= 0xFFFF0000;
>>>                  retval |= gem_phy_read(s, reg_num);
>>> @@ -1569,7 +1570,8 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
>>>              uint32_t phy_addr, reg_num;
>>>
>>>              phy_addr = (val & GEM_PHYMNTNC_ADDR) >> GEM_PHYMNTNC_ADDR_SHFT;
>>> -            if (phy_addr == BOARD_PHY_ADDRESS || phy_addr == 0) {
>>> +            if (phy_addr == BOARD_PHY_ADDRESS || phy_addr == 0 ||
>>> +                phy_addr == s->phy_addr) {
>>>                  reg_num = (val & GEM_PHYMNTNC_REG) >> GEM_PHYMNTNC_REG_SHIFT;
>>>                  gem_phy_write(s, reg_num, val);
>>>              }
>>> @@ -1682,6 +1684,7 @@ static Property gem_properties[] = {
>>>      DEFINE_NIC_PROPERTIES(CadenceGEMState, conf),
>>>      DEFINE_PROP_UINT32("revision", CadenceGEMState, revision,
>>>                         GEM_MODID_VALUE),
>>> +    DEFINE_PROP_UINT8("phy-addr", CadenceGEMState, phy_addr, 0),
>>
>> This patch would be complete by moving the BOARD_PHY_ADDRESS definition
>> to each board using this NIC, and setting the "phy-addr" property to
>> this value.
> 
> I actually have no idea which board in QEMU is using this special PHY
> address instead of default 0.

It seems safe to assume all do use address 23.

Anyway you can simply get ride of BOARD_PHY_ADDRESS in the read/write
using:

    DEFINE_PROP_UINT8("phy-addr", CadenceGEMState,
                      phy_addr, BOARD_PHY_ADDRESS),

> 
> It looks BOARD_PHY_ADDRESS has been there since the initial version of
> the cadence_gem model.
> 
> commit e9f186e514a70557d695cadd2c2287ef97737023
> Author: Peter A. G. Crosthwaite <peter.crosthwaite@petalogix.com>
> Date:   Mon Mar 5 14:39:12 2012 +1000
> 
>     cadence_gem: initial version of device model
> 
>     Device model for cadence gem ethernet controller.
> 
>     Signed-off-by: Peter A. G. Crosthwaite <peter.crosthwaite@petalogix.com>
>     Signed-off-by: John Linn <john.linn@xilinx.com>
>     Acked-by: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>     Signed-off-by: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> 
> Later PHY address 0 was added via the following commit:
> 
> commit 553893736885e4f2dda424bff3e2200e1b6482a5
> Author: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
> Date:   Thu Apr 3 23:55:19 2014 -0700
> 
>     net: cadence_gem: Make phy respond to broadcast
> 
>     Phys must respond to address 0 by specification. Implement.
> 
>     Signed-off-by: Nathan Rossi <nathan.rossi@xilinx.com>
>     Signed-off-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
>     Message-id:
> 6f4d53b04ddbfb19895bfb61a595e69f1c08859a.1396594056.git.peter.crosthwaite@xilinx.com
>     Reviewed-by: Beniamino Galvani <b.galvani@gmail.com>
>     Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> 
> I doubt the commit message said that PHYs must respond to address 0. I
> am not aware of such specs. The issue was probably that whatever board
> 2nd commit was tested against did not have a PHY at address
> BOARD_PHY_ADDRESS.
> 
> + a couple of Xilinx folks to comment.
> 
>>
>>>      DEFINE_PROP_UINT8("num-priority-queues", CadenceGEMState,
>>>                        num_priority_queues, 1),
>>>      DEFINE_PROP_UINT8("num-type1-screeners", CadenceGEMState,
>>> diff --git a/include/hw/net/cadence_gem.h b/include/hw/net/cadence_gem.h
>>> index 54e646f..01c6189 100644
>>> --- a/include/hw/net/cadence_gem.h
>>> +++ b/include/hw/net/cadence_gem.h
>>> @@ -73,6 +73,8 @@ typedef struct CadenceGEMState {
>>>      /* Mask of register bits which are write 1 to clear */
>>>      uint32_t regs_w1c[CADENCE_GEM_MAXREG];
>>>
>>> +    /* PHY address */
>>> +    uint8_t phy_addr;
>>>      /* PHY registers backing store */
>>>      uint16_t phy_regs[32];
> 
> Regards,
> Bin
> 


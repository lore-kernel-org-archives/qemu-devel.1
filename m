Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D427EC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:05:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97A1B23101
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSETcpZs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A1B23101
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6xko-0000sC-Pl
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6xgN-0003ls-1G; Sat, 15 Aug 2020 11:01:19 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39190)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6xgL-00065o-Be; Sat, 15 Aug 2020 11:01:18 -0400
Received: by mail-wm1-x344.google.com with SMTP id g75so10262765wme.4;
 Sat, 15 Aug 2020 08:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xn08/tCXD2hq75/8vWCwbqv7ZGe+tb9E/jIVsKQ6dH8=;
 b=RSETcpZsO+BM7Eihox3hFHz7koLZ9oMYTn/CAsNrHc2dD6F8N+LnWSEtuL1QMfkPLg
 4LLb4N+F7WgjSvOAy3wN1SBJK4UhJUkw7eVCT3vCD4PGiR5gb3CVz1Ztk2U5d00PLsG6
 8ZqQBbGYvRFIkJvdX+2MIo7iMXa12i5KI3BTR898li41lvebvwKeMVgOqgLSyCHlQpqg
 i5kJefEq9HvQ//UTGN65VT6zzeblEOgpeIW9jewD43pVOduKdT3rBcL6GOeHJEvAJSlV
 YIfvEMC2FgRHD5OlIaeSc59RGKKUH1P9Y3E713Ku8plgmgy2wdjOH68ZJmLONHzdg7O2
 RXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xn08/tCXD2hq75/8vWCwbqv7ZGe+tb9E/jIVsKQ6dH8=;
 b=i01hoeBdvQvIBqO76WvjFrGXbSun6d5VmKlgnnbbMDYHDtl6VFCrgM774waw9xOfwQ
 sTuO/PL40ztj0/fe5ANKO8spY9rpm93PMNJU+8zqcnGe1N1MVm7ZRh6MDK+iQrAPgocm
 yr0Kf/So9R1U5kGWaUlinWntP1dkwcIvn7hLKNI4L7xjKc26tKZs7RHZdtb6z23Zouqp
 eT0HQ1tyMLu/etglj6cQO6Z66k8b9m+7arnpVcnC1P8Ig2/+H4RtwTHoci8qxjr5w6GB
 Kq+uyX/DBhUwtDa0QFx1xB8qOtdDFO2M47YrNhjPuifHys/V6V/o+CrTyXngB/6pxMqH
 +gOA==
X-Gm-Message-State: AOAM5304t+jH2sreQ18L2tKLypRPYxto7vToC1FMfF1xkI0/yMBjSnOH
 +Qbb6V3QRk78ppbnleQubrgVaTzLLgk=
X-Google-Smtp-Source: ABdhPJx1XNNorJJMdunI64iPJxc6y7h0iJi/Asrz83xSTeZvMy9flrgTkaxNoL+75Vi5vzJE3gq+XA==
X-Received: by 2002:a1c:32c3:: with SMTP id y186mr5956407wmy.15.1597482408096; 
 Sat, 15 Aug 2020 02:06:48 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id t189sm21362506wmf.47.2020.08.15.02.06.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Aug 2020 02:06:47 -0700 (PDT)
Subject: Re: [PATCH 14/18] hw/net: cadence_gem: Add a new 'phy-addr' property
To: Bin Meng <bmeng.cn@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
 <1597423256-14847-15-git-send-email-bmeng.cn@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e97e1bc4-277d-9fdd-1372-f69d22b4a7e4@amsat.org>
Date: Sat, 15 Aug 2020 11:06:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1597423256-14847-15-git-send-email-bmeng.cn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
 Alistair Francis <alistair@alistair23.me>, Jason Wang <jasowang@redhat.com>,
 Bin Meng <bin.meng@windriver.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/14/20 6:40 PM, Bin Meng wrote:
> From: Bin Meng <bin.meng@windriver.com>
> 
> At present the PHY address of the PHY connected to GEM is hard-coded
> to either 23 (BOARD_PHY_ADDRESS) or 0. This might not be the case for
> all boards. Add a new 'phy-addr' property so that board can specify
> the PHY address for each GEM instance.
> 
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> ---
> 
>  hw/net/cadence_gem.c         | 7 +++++--
>  include/hw/net/cadence_gem.h | 2 ++
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index a93b5c0..9fa03de 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -1446,7 +1446,8 @@ static uint64_t gem_read(void *opaque, hwaddr offset, unsigned size)
>              uint32_t phy_addr, reg_num;
>  
>              phy_addr = (retval & GEM_PHYMNTNC_ADDR) >> GEM_PHYMNTNC_ADDR_SHFT;
> -            if (phy_addr == BOARD_PHY_ADDRESS || phy_addr == 0) {
> +            if (phy_addr == BOARD_PHY_ADDRESS || phy_addr == 0 ||
> +                phy_addr == s->phy_addr) {
>                  reg_num = (retval & GEM_PHYMNTNC_REG) >> GEM_PHYMNTNC_REG_SHIFT;
>                  retval &= 0xFFFF0000;
>                  retval |= gem_phy_read(s, reg_num);
> @@ -1569,7 +1570,8 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
>              uint32_t phy_addr, reg_num;
>  
>              phy_addr = (val & GEM_PHYMNTNC_ADDR) >> GEM_PHYMNTNC_ADDR_SHFT;
> -            if (phy_addr == BOARD_PHY_ADDRESS || phy_addr == 0) {
> +            if (phy_addr == BOARD_PHY_ADDRESS || phy_addr == 0 ||
> +                phy_addr == s->phy_addr) {
>                  reg_num = (val & GEM_PHYMNTNC_REG) >> GEM_PHYMNTNC_REG_SHIFT;
>                  gem_phy_write(s, reg_num, val);
>              }
> @@ -1682,6 +1684,7 @@ static Property gem_properties[] = {
>      DEFINE_NIC_PROPERTIES(CadenceGEMState, conf),
>      DEFINE_PROP_UINT32("revision", CadenceGEMState, revision,
>                         GEM_MODID_VALUE),
> +    DEFINE_PROP_UINT8("phy-addr", CadenceGEMState, phy_addr, 0),

This patch would be complete by moving the BOARD_PHY_ADDRESS definition
to each board using this NIC, and setting the "phy-addr" property to
this value.

>      DEFINE_PROP_UINT8("num-priority-queues", CadenceGEMState,
>                        num_priority_queues, 1),
>      DEFINE_PROP_UINT8("num-type1-screeners", CadenceGEMState,
> diff --git a/include/hw/net/cadence_gem.h b/include/hw/net/cadence_gem.h
> index 54e646f..01c6189 100644
> --- a/include/hw/net/cadence_gem.h
> +++ b/include/hw/net/cadence_gem.h
> @@ -73,6 +73,8 @@ typedef struct CadenceGEMState {
>      /* Mask of register bits which are write 1 to clear */
>      uint32_t regs_w1c[CADENCE_GEM_MAXREG];
>  
> +    /* PHY address */
> +    uint8_t phy_addr;
>      /* PHY registers backing store */
>      uint16_t phy_regs[32];
>  
> 



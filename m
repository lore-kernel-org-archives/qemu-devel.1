Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE4CC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 10:46:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC183206E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 10:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P38Nz/od"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC183206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDQHk-0002nB-Sk
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 06:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kDQGj-000271-Oz; Wed, 02 Sep 2020 06:45:33 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:35620)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kDQGi-0006fD-7T; Wed, 02 Sep 2020 06:45:33 -0400
Received: by mail-lf1-x141.google.com with SMTP id w11so2555723lfn.2;
 Wed, 02 Sep 2020 03:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=DTAs/kcJaltCNKBEfHuYmku6va+chymOmOLA/aDpIZc=;
 b=P38Nz/odx1rJfgTbSS4rnVAfFCVJCp9qONK0G4tuadWJwv5jYgh9/yW7ekU+3XEHGV
 kYRdC40SBzKrG7YyyQ/06p9Z+WxSu37Uuo1/zLdpUPHz16yflr4UQisj1wx03QjjY7fJ
 R/oIa5WUYjB5ZGbODdghSU/PWUHyMlGJwWVq8y0lV6PojUiD7yj4QcNeWAO1n2Wc9m5d
 DZamsfY2wZCQ/UeTRmQYUSGopouCz53lRwWgDM/CXvpYSYBM9OurgKST11jVJ+70zBju
 efyljvNmsUbaDHq6S2rQ0nBxFVox62dJgMLbpj/4CpyKsFeQyCTW/71HvCmMr6XcjDZR
 qDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DTAs/kcJaltCNKBEfHuYmku6va+chymOmOLA/aDpIZc=;
 b=MdIHokEAQjIo9f4/i48t2zXvQHTX0SB6olxJ8tdm9NXpm3g5WWaGkZkNi12U4WU6LI
 F+uJ7WdoyGiZATd8dGYrmNQ/gnUjiDyiVdbW+NN0hd5pfXHPDMoIM9EoDQBeOTUx3nSf
 889zSflaOoU8EGziMocd5Mh3an5vCi5aj2xWXJ8ljkag7rZRZfYPnik1jcb5QnoqNmpB
 N8MiGYrcag/zqXMIAeqgJq89B7Iva0DhOzZLWqedPfsH4Ibs6sQW55XxwLTGQFfnclCZ
 1spxqGC44TMYegyXDbbLhsFXGaksEZgswi5H2UhRrSkmQFuAlXv9dn8svbi4RN6+3DPk
 Oshg==
X-Gm-Message-State: AOAM532iIgGWISJEN9p5Pni7JOI9SAxuiJrpJiL5QnAolJ/bU2ecDfdD
 xJxlLoETuJMHraaNBPiWRx0=
X-Google-Smtp-Source: ABdhPJzf7IlpapGd/caRnXmj9xy+QNRTb1BfC+0shOG4/h3CAWigaymLxsop4BaosRMzjGAUPTESpg==
X-Received: by 2002:ac2:5597:: with SMTP id v23mr95661lfg.5.1599043529823;
 Wed, 02 Sep 2020 03:45:29 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id s3sm889096ljd.44.2020.09.02.03.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 03:45:28 -0700 (PDT)
Date: Wed, 2 Sep 2020 12:45:28 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH v3 11/16] hw/net: cadence_gem: Add a new 'phy-addr'
 property
Message-ID: <20200902104528.GW2954729@toto>
References: <1598924352-89526-1-git-send-email-bmeng.cn@gmail.com>
 <1598924352-89526-12-git-send-email-bmeng.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598924352-89526-12-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=2.346, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 Palmer Dabbelt <palmerdabbelt@google.com>, qemu-riscv@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Bin Meng <bin.meng@windriver.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 01, 2020 at 09:39:06AM +0800, Bin Meng wrote:
> From: Bin Meng <bin.meng@windriver.com>
> 
> At present the PHY address of the PHY connected to GEM is hard-coded
> to either 23 (BOARD_PHY_ADDRESS) or 0. This might not be the case for
> all boards. Add a new 'phy-addr' property so that board can specify
> the PHY address for each GEM instance.
> 
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Hi Bin,

It looks like there's a change here compared to v2 to keep addr 0
as broadcast?

Perhaps it would be useful to add a comment in the code about it.

Anyway:
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> 
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - change "phy-addr" default value to BOARD_PHY_ADDRESS
> 
>  include/hw/net/cadence_gem.h | 2 ++
>  hw/net/cadence_gem.c         | 5 +++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
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
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index a93b5c0..d80096b 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -1446,7 +1446,7 @@ static uint64_t gem_read(void *opaque, hwaddr offset, unsigned size)
>              uint32_t phy_addr, reg_num;
>  
>              phy_addr = (retval & GEM_PHYMNTNC_ADDR) >> GEM_PHYMNTNC_ADDR_SHFT;
> -            if (phy_addr == BOARD_PHY_ADDRESS || phy_addr == 0) {
> +            if (phy_addr == s->phy_addr || phy_addr == 0) {
>                  reg_num = (retval & GEM_PHYMNTNC_REG) >> GEM_PHYMNTNC_REG_SHIFT;
>                  retval &= 0xFFFF0000;
>                  retval |= gem_phy_read(s, reg_num);
> @@ -1569,7 +1569,7 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
>              uint32_t phy_addr, reg_num;
>  
>              phy_addr = (val & GEM_PHYMNTNC_ADDR) >> GEM_PHYMNTNC_ADDR_SHFT;
> -            if (phy_addr == BOARD_PHY_ADDRESS || phy_addr == 0) {
> +            if (phy_addr == s->phy_addr || phy_addr == 0) {
>                  reg_num = (val & GEM_PHYMNTNC_REG) >> GEM_PHYMNTNC_REG_SHIFT;
>                  gem_phy_write(s, reg_num, val);
>              }
> @@ -1682,6 +1682,7 @@ static Property gem_properties[] = {
>      DEFINE_NIC_PROPERTIES(CadenceGEMState, conf),
>      DEFINE_PROP_UINT32("revision", CadenceGEMState, revision,
>                         GEM_MODID_VALUE),
> +    DEFINE_PROP_UINT8("phy-addr", CadenceGEMState, phy_addr, BOARD_PHY_ADDRESS),
>      DEFINE_PROP_UINT8("num-priority-queues", CadenceGEMState,
>                        num_priority_queues, 1),
>      DEFINE_PROP_UINT8("num-type1-screeners", CadenceGEMState,
> -- 
> 2.7.4
> 


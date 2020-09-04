Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B8AC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:46:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAB7D2083B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqxam5oh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB7D2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEHeo-0002HL-Uj
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 15:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kEHeC-0001f1-ED; Fri, 04 Sep 2020 15:45:20 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:37058)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kEHeA-0005QM-Rx; Fri, 04 Sep 2020 15:45:20 -0400
Received: by mail-io1-xd42.google.com with SMTP id b16so8321291ioj.4;
 Fri, 04 Sep 2020 12:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jti0ZuYCgmfytFFLQngxNpTZ1nIGb6XcsfBSNsJvqJU=;
 b=mqxam5ohJk+U/eBwRnBW2lIZRj0GdAIic3BwqHeqotkHRp2RLHLpL2tp+FgLB7EFMK
 fl7s+H6Qd0s+KyPPHAXA8svROQ8aewJadPkBwbMp7Y4k9kbtwOnAuE9xmg+ERuB4XvcL
 p5t3fCA3IM31ryw180SQyC58MGt7gotaHg966hor3f3M5lABhmM+okrW1uh1scgiwJtQ
 mzCxgEw9mkhj65tKjRaM6Mu4JTHjeEYF9Ngw0PlyTCliKix4HVfRd/xJmBSy8dv1UO5U
 J8nYKVD0zCD9m/XtSZVhhOrWRDAfzrfFKwlEHZwt93R51fT6+e9MNkqki+2tDNJ72Eax
 /htA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jti0ZuYCgmfytFFLQngxNpTZ1nIGb6XcsfBSNsJvqJU=;
 b=n3KK4YYhf72p3ROFp2MrSPBo2oAuyrfwtCUMQvePJOVdkJdJ+XHO7jUQ0Zlx7LvybB
 g5/u2b6FZxG+zgdSOQ770RiXgRcXoOG7n3aoX29/2klDxsyZ/SAypNz8jhmC1ERUuctj
 5a08+0Wwn2DGi3FE1WpfzxE+lqINpio5m+XnDfDEBsQB1t2xo0y/wO0GjUa+q/vwzsOl
 7U3sBdP1vGWjeVToJ0bUke8cYGzPnPAKAxGDplDn5nfqtn9Jmgs/6G9satnJkg/oqQaK
 wQlCGAt5OXLjegoF5uCI1AwaHq7hgYcBRW/zCKsm01B6qVfOg2OTksapcl03Ety+u9Jr
 NIaQ==
X-Gm-Message-State: AOAM532xsy2ebHGO/Na8L0K/F/CdSuHp+x2wX03Ypk1ULAkPTbroBT+2
 tSpIojd540ad6P7UZ6TP7T+hPZeeJ5XjPJRKviI=
X-Google-Smtp-Source: ABdhPJzPTpx9K8fHTc06Wnev6lldC2jSWJfTrPuk6p0/Su7PhIUFFIpWDMKrcpMq/+5Tdxv0IW8PhhuR5z6MKtnYFgc=
X-Received: by 2002:a5d:995a:: with SMTP id v26mr8839340ios.176.1599248717185; 
 Fri, 04 Sep 2020 12:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <1598924352-89526-1-git-send-email-bmeng.cn@gmail.com>
 <1598924352-89526-12-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1598924352-89526-12-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Sep 2020 12:34:22 -0700
Message-ID: <CAKmqyKM_m7hHnyGwf7e9WJivwra8ANM2Z8mXRhtjRjgkPek=VQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/16] hw/net: cadence_gem: Add a new 'phy-addr'
 property
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Bin Meng <bin.meng@windriver.com>,
 Jason Wang <jasowang@redhat.com>, Palmer Dabbelt <palmerdabbelt@google.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 31, 2020 at 6:42 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> At present the PHY address of the PHY connected to GEM is hard-coded
> to either 23 (BOARD_PHY_ADDRESS) or 0. This might not be the case for
> all boards. Add a new 'phy-addr' property so that board can specify
> the PHY address for each GEM instance.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

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
>


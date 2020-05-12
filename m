Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A22C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:21:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82B01206CC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GesP0CaQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B01206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYWj8-0000o7-Kw
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 11:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jYWhA-0007nq-0h; Tue, 12 May 2020 11:19:48 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:34904)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jYWh8-0006zw-1x; Tue, 12 May 2020 11:19:47 -0400
Received: by mail-lj1-x241.google.com with SMTP id g4so14117857ljl.2;
 Tue, 12 May 2020 08:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=S6ITkXEFMuyOg9l4iYA8P7jYSsc9ZK40Dag0etBqLKA=;
 b=GesP0CaQF0LYnd2oNy2HoTgkYi2RVoY52dGFvPHHCg8eqRBqQj9yem1/t7gtbTwDtV
 lYrmgFgNOIQo85NXX5vB0hbuUOGMYHbZi4Fhopq9L/BKhv6e+QeRknX1ecakskjnwNKx
 sn+hHQFC5Evhd8xRWQtzBtglEM2HeSdm0EpPUDv44MYQZ3ONqM9guLc0gXVnbHeCI2e7
 M4YAGH2ZpDsZkklzag6xkcQZm1Q6ZtDRtgDHPuNtAYPs/M4R/ogl0saOq1i43vi46Jeb
 JYsaPilQJmoky+e3QANo4HBYPoCksWKwVNuvtaBu/uYzU6e/X5hPHDFhUTYL3GA95MlT
 DzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=S6ITkXEFMuyOg9l4iYA8P7jYSsc9ZK40Dag0etBqLKA=;
 b=EHU4q0py41hW8nrNZ2cSkNoR9gCNzdDEIGdG1NsDuf1dQssU2egnqWhusA4ITeMIvf
 V79W3B3nDRV3e4KYC9ZST2LzExCMbEff90KbfefEh6CfbVr1Ltk7I//BUiM/rS+1NE93
 AOuoMI4lQpMjMX6W7k06eed7vOy3JHksz/KS72pQlFkC3cawBOth7Ms9zqRgGyU98jdy
 29Imrfjn653HyuDFT4slaCymTA/XM9VeUt5ecj0rwXa1ks0GIyQWA3w7KeuFS3NqNehg
 FszIZdaWOvxAyH0iooxK8pAX3mq/jHiuDqOyp1QFonI8hJr2r0L1j87D8J6fuqH5VEpk
 UXhA==
X-Gm-Message-State: AOAM531hT5UgC2BJJMXrpsamT67TypuBKuRB9/7TMRms35VMeLge1f59
 rZFQfmaibP2omQ6t7Wrp5HA=
X-Google-Smtp-Source: ABdhPJyn9mGsSPPyuyyUy/f1Px/0NXvh9KjP7bbfqtdMwofMnyvb+fkQLZYmX7TvulsCGKq4vWAAiw==
X-Received: by 2002:a05:651c:1b9:: with SMTP id
 c25mr10043788ljn.285.1589296783863; 
 Tue, 12 May 2020 08:19:43 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id d19sm14312513lfj.8.2020.05.12.08.19.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 08:19:43 -0700 (PDT)
Date: Tue, 12 May 2020 17:19:26 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH v5 07/12] net: cadence_gem: Fix up code style
Message-ID: <20200512151926.GT5519@toto>
References: <1589295294-26466-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1589295294-26466-8-git-send-email-sai.pavan.boddu@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589295294-26466-8-git-send-email-sai.pavan.boddu@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Tong Ho <tong.ho@xilinx.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Ramon Fried <rfried.dev@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 12, 2020 at 08:24:49PM +0530, Sai Pavan Boddu wrote:
> Fix the code style for register definitions.
> 

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> ---
>  hw/net/cadence_gem.c | 204 ++++++++++++++++++++++++++-------------------------
>  1 file changed, 103 insertions(+), 101 deletions(-)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index 11e36d0..f6ff27c 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -43,110 +43,112 @@
>      } \
>  } while (0)
>  
> -#define GEM_NWCTRL        (0x00000000/4) /* Network Control reg */
> -#define GEM_NWCFG         (0x00000004/4) /* Network Config reg */
> -#define GEM_NWSTATUS      (0x00000008/4) /* Network Status reg */
> -#define GEM_USERIO        (0x0000000C/4) /* User IO reg */
> -#define GEM_DMACFG        (0x00000010/4) /* DMA Control reg */
> -#define GEM_TXSTATUS      (0x00000014/4) /* TX Status reg */
> -#define GEM_RXQBASE       (0x00000018/4) /* RX Q Base address reg */
> -#define GEM_TXQBASE       (0x0000001C/4) /* TX Q Base address reg */
> -#define GEM_RXSTATUS      (0x00000020/4) /* RX Status reg */
> -#define GEM_ISR           (0x00000024/4) /* Interrupt Status reg */
> -#define GEM_IER           (0x00000028/4) /* Interrupt Enable reg */
> -#define GEM_IDR           (0x0000002C/4) /* Interrupt Disable reg */
> -#define GEM_IMR           (0x00000030/4) /* Interrupt Mask reg */
> -#define GEM_PHYMNTNC      (0x00000034/4) /* Phy Maintenance reg */
> -#define GEM_RXPAUSE       (0x00000038/4) /* RX Pause Time reg */
> -#define GEM_TXPAUSE       (0x0000003C/4) /* TX Pause Time reg */
> -#define GEM_TXPARTIALSF   (0x00000040/4) /* TX Partial Store and Forward */
> -#define GEM_RXPARTIALSF   (0x00000044/4) /* RX Partial Store and Forward */
> -#define GEM_HASHLO        (0x00000080/4) /* Hash Low address reg */
> -#define GEM_HASHHI        (0x00000084/4) /* Hash High address reg */
> -#define GEM_SPADDR1LO     (0x00000088/4) /* Specific addr 1 low reg */
> -#define GEM_SPADDR1HI     (0x0000008C/4) /* Specific addr 1 high reg */
> -#define GEM_SPADDR2LO     (0x00000090/4) /* Specific addr 2 low reg */
> -#define GEM_SPADDR2HI     (0x00000094/4) /* Specific addr 2 high reg */
> -#define GEM_SPADDR3LO     (0x00000098/4) /* Specific addr 3 low reg */
> -#define GEM_SPADDR3HI     (0x0000009C/4) /* Specific addr 3 high reg */
> -#define GEM_SPADDR4LO     (0x000000A0/4) /* Specific addr 4 low reg */
> -#define GEM_SPADDR4HI     (0x000000A4/4) /* Specific addr 4 high reg */
> -#define GEM_TIDMATCH1     (0x000000A8/4) /* Type ID1 Match reg */
> -#define GEM_TIDMATCH2     (0x000000AC/4) /* Type ID2 Match reg */
> -#define GEM_TIDMATCH3     (0x000000B0/4) /* Type ID3 Match reg */
> -#define GEM_TIDMATCH4     (0x000000B4/4) /* Type ID4 Match reg */
> -#define GEM_WOLAN         (0x000000B8/4) /* Wake on LAN reg */
> -#define GEM_IPGSTRETCH    (0x000000BC/4) /* IPG Stretch reg */
> -#define GEM_SVLAN         (0x000000C0/4) /* Stacked VLAN reg */
> -#define GEM_MODID         (0x000000FC/4) /* Module ID reg */
> -#define GEM_OCTTXLO       (0x00000100/4) /* Octects transmitted Low reg */
> -#define GEM_OCTTXHI       (0x00000104/4) /* Octects transmitted High reg */
> -#define GEM_TXCNT         (0x00000108/4) /* Error-free Frames transmitted */
> -#define GEM_TXBCNT        (0x0000010C/4) /* Error-free Broadcast Frames */
> -#define GEM_TXMCNT        (0x00000110/4) /* Error-free Multicast Frame */
> -#define GEM_TXPAUSECNT    (0x00000114/4) /* Pause Frames Transmitted */
> -#define GEM_TX64CNT       (0x00000118/4) /* Error-free 64 TX */
> -#define GEM_TX65CNT       (0x0000011C/4) /* Error-free 65-127 TX */
> -#define GEM_TX128CNT      (0x00000120/4) /* Error-free 128-255 TX */
> -#define GEM_TX256CNT      (0x00000124/4) /* Error-free 256-511 */
> -#define GEM_TX512CNT      (0x00000128/4) /* Error-free 512-1023 TX */
> -#define GEM_TX1024CNT     (0x0000012C/4) /* Error-free 1024-1518 TX */
> -#define GEM_TX1519CNT     (0x00000130/4) /* Error-free larger than 1519 TX */
> -#define GEM_TXURUNCNT     (0x00000134/4) /* TX under run error counter */
> -#define GEM_SINGLECOLLCNT (0x00000138/4) /* Single Collision Frames */
> -#define GEM_MULTCOLLCNT   (0x0000013C/4) /* Multiple Collision Frames */
> -#define GEM_EXCESSCOLLCNT (0x00000140/4) /* Excessive Collision Frames */
> -#define GEM_LATECOLLCNT   (0x00000144/4) /* Late Collision Frames */
> -#define GEM_DEFERTXCNT    (0x00000148/4) /* Deferred Transmission Frames */
> -#define GEM_CSENSECNT     (0x0000014C/4) /* Carrier Sense Error Counter */
> -#define GEM_OCTRXLO       (0x00000150/4) /* Octects Received register Low */
> -#define GEM_OCTRXHI       (0x00000154/4) /* Octects Received register High */
> -#define GEM_RXCNT         (0x00000158/4) /* Error-free Frames Received */
> -#define GEM_RXBROADCNT    (0x0000015C/4) /* Error-free Broadcast Frames RX */
> -#define GEM_RXMULTICNT    (0x00000160/4) /* Error-free Multicast Frames RX */
> -#define GEM_RXPAUSECNT    (0x00000164/4) /* Pause Frames Received Counter */
> -#define GEM_RX64CNT       (0x00000168/4) /* Error-free 64 byte Frames RX */
> -#define GEM_RX65CNT       (0x0000016C/4) /* Error-free 65-127B Frames RX */
> -#define GEM_RX128CNT      (0x00000170/4) /* Error-free 128-255B Frames RX */
> -#define GEM_RX256CNT      (0x00000174/4) /* Error-free 256-512B Frames RX */
> -#define GEM_RX512CNT      (0x00000178/4) /* Error-free 512-1023B Frames RX */
> -#define GEM_RX1024CNT     (0x0000017C/4) /* Error-free 1024-1518B Frames RX */
> -#define GEM_RX1519CNT     (0x00000180/4) /* Error-free 1519-max Frames RX */
> -#define GEM_RXUNDERCNT    (0x00000184/4) /* Undersize Frames Received */
> -#define GEM_RXOVERCNT     (0x00000188/4) /* Oversize Frames Received */
> -#define GEM_RXJABCNT      (0x0000018C/4) /* Jabbers Received Counter */
> -#define GEM_RXFCSCNT      (0x00000190/4) /* Frame Check seq. Error Counter */
> -#define GEM_RXLENERRCNT   (0x00000194/4) /* Length Field Error Counter */
> -#define GEM_RXSYMERRCNT   (0x00000198/4) /* Symbol Error Counter */
> -#define GEM_RXALIGNERRCNT (0x0000019C/4) /* Alignment Error Counter */
> -#define GEM_RXRSCERRCNT   (0x000001A0/4) /* Receive Resource Error Counter */
> -#define GEM_RXORUNCNT     (0x000001A4/4) /* Receive Overrun Counter */
> -#define GEM_RXIPCSERRCNT  (0x000001A8/4) /* IP header Checksum Error Counter */
> -#define GEM_RXTCPCCNT     (0x000001AC/4) /* TCP Checksum Error Counter */
> -#define GEM_RXUDPCCNT     (0x000001B0/4) /* UDP Checksum Error Counter */
> -
> -#define GEM_1588S         (0x000001D0/4) /* 1588 Timer Seconds */
> -#define GEM_1588NS        (0x000001D4/4) /* 1588 Timer Nanoseconds */
> -#define GEM_1588ADJ       (0x000001D8/4) /* 1588 Timer Adjust */
> -#define GEM_1588INC       (0x000001DC/4) /* 1588 Timer Increment */
> -#define GEM_PTPETXS       (0x000001E0/4) /* PTP Event Frame Transmitted (s) */
> -#define GEM_PTPETXNS      (0x000001E4/4) /* PTP Event Frame Transmitted (ns) */
> -#define GEM_PTPERXS       (0x000001E8/4) /* PTP Event Frame Received (s) */
> -#define GEM_PTPERXNS      (0x000001EC/4) /* PTP Event Frame Received (ns) */
> -#define GEM_PTPPTXS       (0x000001E0/4) /* PTP Peer Frame Transmitted (s) */
> -#define GEM_PTPPTXNS      (0x000001E4/4) /* PTP Peer Frame Transmitted (ns) */
> -#define GEM_PTPPRXS       (0x000001E8/4) /* PTP Peer Frame Received (s) */
> -#define GEM_PTPPRXNS      (0x000001EC/4) /* PTP Peer Frame Received (ns) */
> +#define GEM_NWCTRL        (0x00000000 / 4) /* Network Control reg */
> +#define GEM_NWCFG         (0x00000004 / 4) /* Network Config reg */
> +#define GEM_NWSTATUS      (0x00000008 / 4) /* Network Status reg */
> +#define GEM_USERIO        (0x0000000C / 4) /* User IO reg */
> +#define GEM_DMACFG        (0x00000010 / 4) /* DMA Control reg */
> +#define GEM_TXSTATUS      (0x00000014 / 4) /* TX Status reg */
> +#define GEM_RXQBASE       (0x00000018 / 4) /* RX Q Base address reg */
> +#define GEM_TXQBASE       (0x0000001C / 4) /* TX Q Base address reg */
> +#define GEM_RXSTATUS      (0x00000020 / 4) /* RX Status reg */
> +#define GEM_ISR           (0x00000024 / 4) /* Interrupt Status reg */
> +#define GEM_IER           (0x00000028 / 4) /* Interrupt Enable reg */
> +#define GEM_IDR           (0x0000002C / 4) /* Interrupt Disable reg */
> +#define GEM_IMR           (0x00000030 / 4) /* Interrupt Mask reg */
> +#define GEM_PHYMNTNC      (0x00000034 / 4) /* Phy Maintenance reg */
> +#define GEM_RXPAUSE       (0x00000038 / 4) /* RX Pause Time reg */
> +#define GEM_TXPAUSE       (0x0000003C / 4) /* TX Pause Time reg */
> +#define GEM_TXPARTIALSF   (0x00000040 / 4) /* TX Partial Store and Forward */
> +#define GEM_RXPARTIALSF   (0x00000044 / 4) /* RX Partial Store and Forward */
> +#define GEM_HASHLO        (0x00000080 / 4) /* Hash Low address reg */
> +#define GEM_HASHHI        (0x00000084 / 4) /* Hash High address reg */
> +#define GEM_SPADDR1LO     (0x00000088 / 4) /* Specific addr 1 low reg */
> +#define GEM_SPADDR1HI     (0x0000008C / 4) /* Specific addr 1 high reg */
> +#define GEM_SPADDR2LO     (0x00000090 / 4) /* Specific addr 2 low reg */
> +#define GEM_SPADDR2HI     (0x00000094 / 4) /* Specific addr 2 high reg */
> +#define GEM_SPADDR3LO     (0x00000098 / 4) /* Specific addr 3 low reg */
> +#define GEM_SPADDR3HI     (0x0000009C / 4) /* Specific addr 3 high reg */
> +#define GEM_SPADDR4LO     (0x000000A0 / 4) /* Specific addr 4 low reg */
> +#define GEM_SPADDR4HI     (0x000000A4 / 4) /* Specific addr 4 high reg */
> +#define GEM_TIDMATCH1     (0x000000A8 / 4) /* Type ID1 Match reg */
> +#define GEM_TIDMATCH2     (0x000000AC / 4) /* Type ID2 Match reg */
> +#define GEM_TIDMATCH3     (0x000000B0 / 4) /* Type ID3 Match reg */
> +#define GEM_TIDMATCH4     (0x000000B4 / 4) /* Type ID4 Match reg */
> +#define GEM_WOLAN         (0x000000B8 / 4) /* Wake on LAN reg */
> +#define GEM_IPGSTRETCH    (0x000000BC / 4) /* IPG Stretch reg */
> +#define GEM_SVLAN         (0x000000C0 / 4) /* Stacked VLAN reg */
> +#define GEM_MODID         (0x000000FC / 4) /* Module ID reg */
> +#define GEM_OCTTXLO       (0x00000100 / 4) /* Octects transmitted Low reg */
> +#define GEM_OCTTXHI       (0x00000104 / 4) /* Octects transmitted High reg */
> +#define GEM_TXCNT         (0x00000108 / 4) /* Error-free Frames transmitted */
> +#define GEM_TXBCNT        (0x0000010C / 4) /* Error-free Broadcast Frames */
> +#define GEM_TXMCNT        (0x00000110 / 4) /* Error-free Multicast Frame */
> +#define GEM_TXPAUSECNT    (0x00000114 / 4) /* Pause Frames Transmitted */
> +#define GEM_TX64CNT       (0x00000118 / 4) /* Error-free 64 TX */
> +#define GEM_TX65CNT       (0x0000011C / 4) /* Error-free 65-127 TX */
> +#define GEM_TX128CNT      (0x00000120 / 4) /* Error-free 128-255 TX */
> +#define GEM_TX256CNT      (0x00000124 / 4) /* Error-free 256-511 */
> +#define GEM_TX512CNT      (0x00000128 / 4) /* Error-free 512-1023 TX */
> +#define GEM_TX1024CNT     (0x0000012C / 4) /* Error-free 1024-1518 TX */
> +#define GEM_TX1519CNT     (0x00000130 / 4) /* Error-free larger than 1519 TX */
> +#define GEM_TXURUNCNT     (0x00000134 / 4) /* TX under run error counter */
> +#define GEM_SINGLECOLLCNT (0x00000138 / 4) /* Single Collision Frames */
> +#define GEM_MULTCOLLCNT   (0x0000013C / 4) /* Multiple Collision Frames */
> +#define GEM_EXCESSCOLLCNT (0x00000140 / 4) /* Excessive Collision Frames */
> +#define GEM_LATECOLLCNT   (0x00000144 / 4) /* Late Collision Frames */
> +#define GEM_DEFERTXCNT    (0x00000148 / 4) /* Deferred Transmission Frames */
> +#define GEM_CSENSECNT     (0x0000014C / 4) /* Carrier Sense Error Counter */
> +#define GEM_OCTRXLO       (0x00000150 / 4) /* Octects Received register Low */
> +#define GEM_OCTRXHI       (0x00000154 / 4) /* Octects Received register High */
> +#define GEM_RXCNT         (0x00000158 / 4) /* Error-free Frames Received */
> +#define GEM_RXBROADCNT    (0x0000015C / 4) /* Error-free Broadcast Frames RX */
> +#define GEM_RXMULTICNT    (0x00000160 / 4) /* Error-free Multicast Frames RX */
> +#define GEM_RXPAUSECNT    (0x00000164 / 4) /* Pause Frames Received Counter */
> +#define GEM_RX64CNT       (0x00000168 / 4) /* Error-free 64 byte Frames RX */
> +#define GEM_RX65CNT       (0x0000016C / 4) /* Error-free 65-127B Frames RX */
> +#define GEM_RX128CNT      (0x00000170 / 4) /* Error-free 128-255B Frames RX */
> +#define GEM_RX256CNT      (0x00000174 / 4) /* Error-free 256-512B Frames RX */
> +#define GEM_RX512CNT      (0x00000178 / 4) /* Error-free 512-1023B Frames RX */
> +#define GEM_RX1024CNT     (0x0000017C / 4) /* Error-free 1024-1518B Frames RX */
> +#define GEM_RX1519CNT     (0x00000180 / 4) /* Error-free 1519-max Frames RX */
> +#define GEM_RXUNDERCNT    (0x00000184 / 4) /* Undersize Frames Received */
> +#define GEM_RXOVERCNT     (0x00000188 / 4) /* Oversize Frames Received */
> +#define GEM_RXJABCNT      (0x0000018C / 4) /* Jabbers Received Counter */
> +#define GEM_RXFCSCNT      (0x00000190 / 4) /* Frame Check seq. Error Counter */
> +#define GEM_RXLENERRCNT   (0x00000194 / 4) /* Length Field Error Counter */
> +#define GEM_RXSYMERRCNT   (0x00000198 / 4) /* Symbol Error Counter */
> +#define GEM_RXALIGNERRCNT (0x0000019C / 4) /* Alignment Error Counter */
> +#define GEM_RXRSCERRCNT   (0x000001A0 / 4) /* Receive Resource Error Counter */
> +#define GEM_RXORUNCNT     (0x000001A4 / 4) /* Receive Overrun Counter */
> +#define GEM_RXIPCSERRCNT  (0x000001A8 / 4) /* IP header Checksum Err Counter */
> +#define GEM_RXTCPCCNT     (0x000001AC / 4) /* TCP Checksum Error Counter */
> +#define GEM_RXUDPCCNT     (0x000001B0 / 4) /* UDP Checksum Error Counter */
> +
> +#define GEM_1588S         (0x000001D0 / 4) /* 1588 Timer Seconds */
> +#define GEM_1588NS        (0x000001D4 / 4) /* 1588 Timer Nanoseconds */
> +#define GEM_1588ADJ       (0x000001D8 / 4) /* 1588 Timer Adjust */
> +#define GEM_1588INC       (0x000001DC / 4) /* 1588 Timer Increment */
> +#define GEM_PTPETXS       (0x000001E0 / 4) /* PTP Event Frame Transmitted (s) */
> +#define GEM_PTPETXNS      (0x000001E4 / 4) /*
> +                                            * PTP Event Frame Transmitted (ns)
> +                                            */
> +#define GEM_PTPERXS       (0x000001E8 / 4) /* PTP Event Frame Received (s) */
> +#define GEM_PTPERXNS      (0x000001EC / 4) /* PTP Event Frame Received (ns) */
> +#define GEM_PTPPTXS       (0x000001E0 / 4) /* PTP Peer Frame Transmitted (s) */
> +#define GEM_PTPPTXNS      (0x000001E4 / 4) /* PTP Peer Frame Transmitted (ns) */
> +#define GEM_PTPPRXS       (0x000001E8 / 4) /* PTP Peer Frame Received (s) */
> +#define GEM_PTPPRXNS      (0x000001EC / 4) /* PTP Peer Frame Received (ns) */
>  
>  /* Design Configuration Registers */
> -#define GEM_DESCONF       (0x00000280/4)
> -#define GEM_DESCONF2      (0x00000284/4)
> -#define GEM_DESCONF3      (0x00000288/4)
> -#define GEM_DESCONF4      (0x0000028C/4)
> -#define GEM_DESCONF5      (0x00000290/4)
> -#define GEM_DESCONF6      (0x00000294/4)
> +#define GEM_DESCONF       (0x00000280 / 4)
> +#define GEM_DESCONF2      (0x00000284 / 4)
> +#define GEM_DESCONF3      (0x00000288 / 4)
> +#define GEM_DESCONF4      (0x0000028C / 4)
> +#define GEM_DESCONF5      (0x00000290 / 4)
> +#define GEM_DESCONF6      (0x00000294 / 4)
>  #define GEM_DESCONF6_64B_MASK (1U << 23)
> -#define GEM_DESCONF7      (0x00000298/4)
> +#define GEM_DESCONF7      (0x00000298 / 4)
>  
>  #define GEM_INT_Q1_STATUS               (0x00000400 / 4)
>  #define GEM_INT_Q1_MASK                 (0x00000640 / 4)
> -- 
> 2.7.4
> 


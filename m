Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98EFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 05:48:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D723208B8
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 05:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D723208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeXss-0006EJ-3Y
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 01:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jeXsJ-0005ph-Ir
 for qemu-devel@nongnu.org; Fri, 29 May 2020 01:48:11 -0400
Received: from 4.mo177.mail-out.ovh.net ([46.105.37.72]:52043)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jeXsI-00036J-E8
 for qemu-devel@nongnu.org; Fri, 29 May 2020 01:48:11 -0400
Received: from player697.ha.ovh.net (unknown [10.108.42.119])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 27D18135A4E
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 07:48:05 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player697.ha.ovh.net (Postfix) with ESMTPSA id F37F012D5E7E7;
 Fri, 29 May 2020 05:48:00 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G0034b3fc16a-4c9b-4633-9e67-6b451a230320,E8A128A1AF80B485D2678A34BACBEE7037B50529)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH] spapr: Fix typos in comments and macro indentation
To: Gustavo Romero <gromero@linux.ibm.com>, qemu-ppc@nongnu.org,
 QEMU Developers <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
References: <1590710681-12873-1-git-send-email-gromero@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <17b397c4-f138-d844-45dd-1b2a6079440e@kaod.org>
Date: Fri, 29 May 2020 07:47:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1590710681-12873-1-git-send-email-gromero@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11679241210006506470
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedruddvjedgleefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefffdvtddugeeifeduuefghfejgfeigeeigeeltedthefgieeiveeuiefhgeefgfenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.37.72; envelope-from=clg@kaod.org;
 helo=4.mo177.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 01:48:06
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All QEMU patches should be sent to the qemu-devel mailing list also 
and to David as he is the PPC maintainer.

On 5/29/20 2:04 AM, Gustavo Romero wrote:
> This commit fixes typos in spapr_vio_reg_to_irq() comments and a macro
> indentation.
> 
> Signed-off-by: Gustavo Romero <gromero@linux.ibm.com>

Acked-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C. 


> ---
>  hw/ppc/spapr_vio.c         | 6 +++---
>  include/hw/ppc/xive_regs.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
> index 0b085ea..741fdbf 100644
> --- a/hw/ppc/spapr_vio.c
> +++ b/hw/ppc/spapr_vio.c
> @@ -420,7 +420,7 @@ static void spapr_vio_busdev_reset(DeviceState *qdev)
>  }
>  
>  /*
> - * The register property of a VIO device is defined in livirt using
> + * The register property of a VIO device is defined in libvirt using
>   * 0x1000 as a base register number plus a 0x1000 increment. For the
>   * VIO tty device, the base number is changed to 0x30000000. QEMU uses
>   * a base register number of 0x71000000 and then a simple increment.
> @@ -450,7 +450,7 @@ static inline uint32_t spapr_vio_reg_to_irq(uint32_t reg)
>  
>      } else if (reg >= 0x30000000) {
>          /*
> -         * VIO tty devices register values, when allocated by livirt,
> +         * VIO tty devices register values, when allocated by libvirt,
>           * are mapped in range [0xf0 - 0xff], gives us a maximum of 16
>           * vtys.
>           */
> @@ -459,7 +459,7 @@ static inline uint32_t spapr_vio_reg_to_irq(uint32_t reg)
>      } else {
>          /*
>           * Other VIO devices register values, when allocated by
> -         * livirt, should be mapped in range [0x00 - 0xef]. Conflicts
> +         * libvirt, should be mapped in range [0x00 - 0xef]. Conflicts
>           * will be detected when IRQ is claimed.
>           */
>          irq = (reg >> 12) & 0xff;
> diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
> index 09f2436..7879692 100644
> --- a/include/hw/ppc/xive_regs.h
> +++ b/include/hw/ppc/xive_regs.h
> @@ -71,7 +71,7 @@
>   * QW word 2 contains the valid bit at the top and other fields
>   * depending on the QW.
>   */
> -#define TM_WORD2                0x8
> +#define   TM_WORD2              0x8
>  #define   TM_QW0W2_VU           PPC_BIT32(0)
>  #define   TM_QW0W2_LOGIC_SERV   PPC_BITMASK32(1, 31) /* XX 2,31 ? */
>  #define   TM_QW1W2_VO           PPC_BIT32(0)
> 



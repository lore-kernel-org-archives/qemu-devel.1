Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB73C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 13:26:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 027942065F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 13:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027942065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jafmY-0007Ey-8X
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 09:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jafl8-00064m-0e
 for qemu-devel@nongnu.org; Mon, 18 May 2020 09:24:46 -0400
Received: from 4.mo173.mail-out.ovh.net ([46.105.34.219]:54777)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jafl6-00084m-Rd
 for qemu-devel@nongnu.org; Mon, 18 May 2020 09:24:45 -0400
Received: from player795.ha.ovh.net (unknown [10.110.208.43])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id AB0DE13A10D
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 15:24:42 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player795.ha.ovh.net (Postfix) with ESMTPSA id C066C12587748;
 Mon, 18 May 2020 13:24:27 +0000 (UTC)
Subject: Re: [PATCH 11/24] pnv/phb4: Bury unwanted "pnv-phb4-pec-stack" devices
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-12-armbru@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <cda0c610-d2a4-503f-ba05-09a974bb0f02@kaod.org>
Date: Mon, 18 May 2020 15:24:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200518050408.4579-12-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10131410315895278419
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedruddthedgieefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefffdvtddugeeifeduuefghfejgfeigeeigeeltedthefgieeiveeuiefhgeefgfenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.34.219; envelope-from=clg@kaod.org;
 helo=4.mo173.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 09:24:42
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
Cc: qemu-ppc@nongnu.org, pbonzini@redhat.com, berrange@redhat.com,
 ehabkost@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 7:03 AM, Markus Armbruster wrote:
> The number of stacks is controlled by property "num-stacks".
> pnv_pec_instance_init() creates the maximum supported number, because
> the property has not been set then.  pnv_pec_realize() realizes only
> the wanted number.  Works, although it can leave unrealized devices
> hanging around in the QOM composition tree.  Affects machine powernv9.



> Bury the unwanted devices by making pnv_pec_realize() unparent them.
> Visible in "info qom-tree":
> 
>      /machine (powernv9-machine)
>        /chip[0] (power9_v2.0-pnv-chip)
>          [...]
>          /pec[0] (pnv-phb4-pec)
>            /stack[0] (pnv-phb4-pec-stack)
>              [...]
>     -      /stack[1] (pnv-phb4-pec-stack)
>     -        /phb (pnv-phb4)
>     -          /pcie-mmcfg-mmio[0] (qemu:memory-region)
>     -          /root (pnv-phb4-root-port)
>     -          /source (xive-source)
>     -      /stack[2] (pnv-phb4-pec-stack)
>     -        /phb (pnv-phb4)
>     -          /pcie-mmcfg-mmio[0] (qemu:memory-region)
>     -          /root (pnv-phb4-root-port)
>     -          /source (xive-source)
>            /xscom-pec-0.0-nest[0] (qemu:memory-region)
>            /xscom-pec-0.0-pci[0] (qemu:memory-region)
>          /pec[1] (pnv-phb4-pec)
>            /stack[0] (pnv-phb4-pec-stack)
>              [...]
>            /stack[1] (pnv-phb4-pec-stack)
>              [...]
>     -      /stack[2] (pnv-phb4-pec-stack)
>     -        /phb (pnv-phb4)
>     -          /pcie-mmcfg-mmio[0] (qemu:memory-region)
>     -          /root (pnv-phb4-root-port)
>     -          /source (xive-source)
>            /xscom-pec-0.1-nest[0] (qemu:memory-region)
>            /xscom-pec-0.1-pci[0] (qemu:memory-region)
>          /pec[2] (pnv-phb4-pec)
>            /stack[0] (pnv-phb4-pec-stack)
>              [...]
>            /stack[1] (pnv-phb4-pec-stack)
>              [...]
>            /stack[2] (pnv-phb4-pec-stack)
>              [...]
> 
> Cc: Cédric Le Goater <clg@kaod.org>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C. 

> ---
>  hw/pci-host/pnv_phb4_pec.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/pci-host/pnv_phb4_pec.c b/hw/pci-host/pnv_phb4_pec.c
> index 911d147ffd..565345a018 100644
> --- a/hw/pci-host/pnv_phb4_pec.c
> +++ b/hw/pci-host/pnv_phb4_pec.c
> @@ -397,6 +397,9 @@ static void pnv_pec_realize(DeviceState *dev, Error **errp)
>              return;
>          }
>      }
> +    for (; i < PHB4_PEC_MAX_STACKS; i++) {
> +        object_unparent(OBJECT(&pec->stacks[i]));
> +    }
>  
>      /* Initialize the XSCOM regions for the PEC registers */
>      snprintf(name, sizeof(name), "xscom-pec-%d.%d-nest", pec->chip_id,
> 



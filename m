Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97B3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 07:14:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADEDC25444
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 07:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADEDC25444
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnGf8-0006kL-0A
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 03:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jnGeT-00069H-GJ
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 03:13:57 -0400
Received: from 17.mo6.mail-out.ovh.net ([46.105.36.150]:54619)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jnGeR-00066y-Av
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 03:13:57 -0400
Received: from player734.ha.ovh.net (unknown [10.110.171.40])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 40EC621B347
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 09:13:52 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-921-245.w86-210.abo.wanadoo.fr
 [86.210.152.245]) (Authenticated sender: clg@kaod.org)
 by player734.ha.ovh.net (Postfix) with ESMTPSA id C82261372D4E2;
 Mon, 22 Jun 2020 07:13:46 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R0055b57b814-8399-42c7-ae6f-8f6be8795fa0,D5B34DF2F1998B4AFDB97B5973F1BB92C24DD330)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH] ppc/pnv: Silence missing BMC warning with qtest
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <159280903824.485572.831378159272329707.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <47741f1f-0070-4325-9690-9549211f266c@kaod.org>
Date: Mon, 22 Jun 2020 09:13:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <159280903824.485572.831378159272329707.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6498412788160564051
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudekuddguddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfeffvddtudegieefudeugffhjefgieegieegleettdehgfeiieevueeihfegfefgnecukfhppedtrddtrddtrddtpdekiedrvddutddrudehvddrvdegheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeegrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.36.150; envelope-from=clg@kaod.org;
 helo=17.mo6.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 03:13:52
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/22/20 8:57 AM, Greg Kurz wrote:
> The device introspect test in qtest emits some warnings with the
> the pnv machine types during the "nodefaults" phase:
> 
> TEST check-qtest-ppc64: tests/qtest/device-introspect-test
> qemu-system-ppc64: warning: machine has no BMC device. Use '-device
> ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10' to define
> one
> qemu-system-ppc64: warning: machine has no BMC device. Use '-device
> ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10' to define
> one
> qemu-system-ppc64: warning: machine has no BMC device. Use '-device
> ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10' to define
> one
> 
> This is expected since the pnv machine doesn't create the internal
> BMC simulator fallback when "-nodefaults" is passed on the command
> line, but these warnings appear in ci logs and confuse people.
> 
> Not having a BMC isn't recommended but it is still a supported
> configuration, so a straightforward fix is to just silent this
> warning when qtest is enabled.
> 
> Fixes: 25f3170b0654 ("ppc/pnv: Create BMC devices only when defaults are enabled")
> Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

It looks good but could you reproduce ? 

C.

> ---
>  hw/ppc/pnv.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 806a5d9a8d34..1622d29b4ba7 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -21,6 +21,7 @@
>  #include "qemu-common.h"
>  #include "qemu/units.h"
>  #include "qapi/error.h"
> +#include "sysemu/qtest.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/numa.h"
>  #include "sysemu/reset.h"
> @@ -587,9 +588,11 @@ static void pnv_reset(MachineState *machine)
>      bmc = pnv_bmc_find(&error_fatal);
>      if (!pnv->bmc) {
>          if (!bmc) {
> -            warn_report("machine has no BMC device. Use '-device "
> -                        "ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10' "
> -                        "to define one");
> +            if (!qtest_enabled()) {
> +                warn_report("machine has no BMC device. Use '-device "
> +                            "ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10' "
> +                            "to define one");
> +            }
>          } else {
>              pnv_bmc_set_pnor(bmc, pnv->pnor);
>              pnv->bmc = bmc;
> 
> 



Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D42CC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:43:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47D2A207E8
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D2A207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jairJ-0006SL-GA
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jaijQ-0000oL-Pv
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:35:12 -0400
Received: from 8.mo177.mail-out.ovh.net ([46.105.61.98]:56069)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jaijP-0004GS-FR
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:35:12 -0400
Received: from player694.ha.ovh.net (unknown [10.108.57.18])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 336F813148D
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 18:35:09 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player694.ha.ovh.net (Postfix) with ESMTPSA id 9CFCD12675EAA;
 Mon, 18 May 2020 16:35:01 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R003f4d9a749-ae72-4d6c-b92f-c371044073bb,2E2A9519E3FAC9D985F861812C9F86F7BE89492F)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH 16/24] ppc/pnv: Put "*-pnv-chip" and "pnv-xive" on the
 main system bus
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-17-armbru@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <5abeb1b9-16d4-2984-720f-2f0d776ec19e@kaod.org>
Date: Mon, 18 May 2020 18:34:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200518050408.4579-17-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13347824871068306259
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedruddthedguddtudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfeffvddtudegieefudeugffhjefgieegieegleettdehgfeiieevueeihfegfefgnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieelgedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.61.98; envelope-from=clg@kaod.org;
 helo=8.mo177.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 12:35:09
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

On 5/18/20 7:04 AM, Markus Armbruster wrote:
> pnv_init() creates "power10_v1.0-pnv-chip", "power8_v2.0-pnv-chip",
> "power8e_v2.1-pnv-chip", "power8nvl_v1.0-pnv-chip", or
> "power9_v2.0-pnv-chip" sysbus devices in a way that leaves them
> unplugged.
> 
> pnv_chip_power9_instance_init() creates a "pnv-xive" sysbus device in
> a way that leaves it unplugged.
> 
> Create them the common way that puts them into the main system bus.
> Affects machines powernv8, powernv9, and powernv10.  Visible in "info
> qtree".  Here's the change for powernv9:
> 
>      bus: main-system-bus
>        type System
>     +  dev: power9_v2.0-pnv-chip, id ""
>     +    chip-id = 0 (0x0)
>     +    ram-start = 0 (0x0)
>     +    ram-size = 1879048192 (0x70000000)
>     +    nr-cores = 1 (0x1)
>     +    cores-mask = 72057594037927935 (0xffffffffffffff)
>     +    nr-threads = 1 (0x1)
>     +    num-phbs = 6 (0x6)
>     +    mmio 000603fc00000000/0000000400000000
>     [...]
>     +  dev: pnv-xive, id ""
>     +    ic-bar = 1692157036462080 (0x6030203100000)
>     +    vc-bar = 1689949371891712 (0x6010000000000)
>     +    pc-bar = 1690499127705600 (0x6018000000000)
>     +    tm-bar = 1692157036986368 (0x6030203180000)
> 
> Cc: "Cédric Le Goater" <clg@kaod.org>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/ppc/pnv.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index da637822f9..8d4fc8109a 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -818,7 +818,7 @@ static void pnv_init(MachineState *machine)
>      pnv->chips = g_new0(PnvChip *, pnv->num_chips);
>      for (i = 0; i < pnv->num_chips; i++) {
>          char chip_name[32];
> -        Object *chip = object_new(chip_typename);
> +        Object *chip = OBJECT(qdev_create(NULL, chip_typename));
>  
>          pnv->chips[i] = PNV_CHIP(chip);
>  
> @@ -1317,8 +1317,8 @@ static void pnv_chip_power9_instance_init(Object *obj)
>      PnvChipClass *pcc = PNV_CHIP_GET_CLASS(obj);
>      int i;
>  
> -    object_initialize_child(obj, "xive", &chip9->xive, sizeof(chip9->xive),
> -                            TYPE_PNV_XIVE, &error_abort, NULL);
> +    sysbus_init_child_obj(obj, "xive", &chip9->xive, sizeof(chip9->xive),
> +                          TYPE_PNV_XIVE);
>      object_property_add_alias(obj, "xive-fabric", OBJECT(&chip9->xive),
>                                "xive-fabric");

OK. But why only XIVE and not all sub-devices of the PnvChip device ? 

Shouldn't they be initialized in the same way, calling sysbus_init_child_obj ? 

Thanks,

C.
 



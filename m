Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F21C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 09:25:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B2242073A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 09:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2242073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is1Of-0002vo-QO
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 04:25:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37630)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1is1O4-0002PU-9T
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 04:24:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1is1O0-0007Wl-RM
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 04:24:24 -0500
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:45749)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1is1O0-0007W0-Ku
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 04:24:20 -0500
Received: from player734.ha.ovh.net (unknown [10.109.143.220])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 47F351BF9F3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 10:24:17 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player734.ha.ovh.net (Postfix) with ESMTPSA id 2CED2E252228;
 Thu, 16 Jan 2020 09:24:08 +0000 (UTC)
Subject: Re: [PATCH v2 10/86] arm:aspeed: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-11-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <8473fe69-36da-35f7-930b-f800bb899732@kaod.org>
Date: Thu, 16 Jan 2020 10:24:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1579100861-73692-11-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 3152801215351720880
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrtdehgddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeegrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.58.226
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
Cc: andrew@aj.id.au, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/15/20 4:06 PM, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>   MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>


We need to check 'max_ram' is still needed. I remember that old firmwares
were testing the RAM size by doing write/read checks at the top of the RA=
M.
This was breaking QEMU sometime ago.

C.

> ---
> CC: clg@kaod.org
> CC: peter.maydell@linaro.org
> CC: andrew@aj.id.au
> CC: joel@jms.id.au
> CC: qemu-arm@nongnu.org
> ---
>  hw/arm/aspeed.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 525c547..330254b 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -35,7 +35,6 @@ static struct arm_boot_info aspeed_board_binfo =3D {
>  struct AspeedBoardState {
>      AspeedSoCState soc;
>      MemoryRegion ram_container;
> -    MemoryRegion ram;
>      MemoryRegion max_ram;
>  };
> =20
> @@ -184,6 +183,7 @@ static void aspeed_machine_init(MachineState *machi=
ne)
> =20
>      memory_region_init(&bmc->ram_container, NULL, "aspeed-ram-containe=
r",
>                         UINT32_MAX);
> +    memory_region_add_subregion(&bmc->ram_container, 0, machine->ram);
> =20
>      object_initialize_child(OBJECT(machine), "soc", &bmc->soc,
>                              (sizeof(bmc->soc)), amc->soc_name, &error_=
abort,
> @@ -215,8 +215,6 @@ static void aspeed_machine_init(MachineState *machi=
ne)
>      object_property_set_bool(OBJECT(&bmc->soc), true, "realized",
>                               &error_fatal);
> =20
> -    memory_region_allocate_system_memory(&bmc->ram, NULL, "ram", ram_s=
ize);
> -    memory_region_add_subregion(&bmc->ram_container, 0, &bmc->ram);
>      memory_region_add_subregion(get_system_memory(),
>                                  sc->memmap[ASPEED_SDRAM],
>                                  &bmc->ram_container);
> @@ -393,6 +391,7 @@ static void aspeed_machine_class_init(ObjectClass *=
oc, void *data)
>      mc->no_floppy =3D 1;
>      mc->no_cdrom =3D 1;
>      mc->no_parallel =3D 1;
> +    mc->default_ram_id =3D "ram";
>  }
> =20
>  static void aspeed_machine_palmetto_class_init(ObjectClass *oc, void *=
data)
>=20



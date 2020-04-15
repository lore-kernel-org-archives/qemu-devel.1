Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB63FC2BB85
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:54:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A403320768
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A403320768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOcrx-00068G-O6
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 03:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jOcqS-0004GA-Eo
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:52:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jOcqR-0008Vt-A5
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:52:28 -0400
Received: from 3.mo6.mail-out.ovh.net ([178.33.253.26]:51892)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jOcqR-0008V5-3P
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:52:27 -0400
Received: from player695.ha.ovh.net (unknown [10.110.103.118])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id C31E920AAED
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 09:52:24 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player695.ha.ovh.net (Postfix) with ESMTPSA id BE71F114BA640;
 Wed, 15 Apr 2020 07:51:47 +0000 (UTC)
Subject: Re: [PATCH-for-5.1 v3 18/24] hw/pci-host/pnv_phb3: Move some code
 from realize() to init()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200412223619.11284-1-f4bug@amsat.org>
 <20200412223619.11284-19-f4bug@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2e60d4fa-36b0-bc4d-a61b-540cd2e03756@kaod.org>
Date: Wed, 15 Apr 2020 09:51:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200412223619.11284-19-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 13634647873948847024
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrfedvgdduvdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.253.26
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>, Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 qemu-riscv@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Wen Congyang <wencongyang2@huawei.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/13/20 12:36 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Coccinelle reported:
>=20
>   $ spatch ... --timeout 60 --sp-file \
>     scripts/coccinelle/simplify-init-realize-error_propagate.cocci
>   HANDLING: ./hw/pci-host/pnv_phb3.c
>   >>> possible moves from pnv_phb3_instance_init() to pnv_phb3_realize(=
) in ./hw/pci-host/pnv_phb3.c:992
>=20
> Move the calls using &error_abort which don't depend on input
> updated before realize() to init().
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>



Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
> v3: Typo 'depend of' -> 'depend on' (eblake)
> ---
>  hw/pci-host/pnv_phb3.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
> index 74618fadf0..57d717ed23 100644
> --- a/hw/pci-host/pnv_phb3.c
> +++ b/hw/pci-host/pnv_phb3.c
> @@ -970,6 +970,8 @@ static void pnv_phb3_instance_init(Object *obj)
>      /* LSI sources */
>      object_initialize_child(obj, "lsi", &phb->lsis, sizeof(phb->lsis),
>                               TYPE_ICS, &error_abort, NULL);
> +    object_property_set_int(OBJECT(&phb->lsis), PNV_PHB3_NUM_LSI, "nr-=
irqs",
> +                            &error_abort);
> =20
>      /* Default init ... will be fixed by HW inits */
>      phb->lsis.offset =3D 0;
> @@ -977,6 +979,8 @@ static void pnv_phb3_instance_init(Object *obj)
>      /* MSI sources */
>      object_initialize_child(obj, "msi", &phb->msis, sizeof(phb->msis),
>                              TYPE_PHB3_MSI, &error_abort, NULL);
> +    object_property_set_int(OBJECT(&phb->msis), PHB3_MAX_MSI, "nr-irqs=
",
> +                            &error_abort);
> =20
>      /* Power Bus Common Queue */
>      object_initialize_child(obj, "pbcq", &phb->pbcq, sizeof(phb->pbcq)=
,
> @@ -1005,8 +1009,6 @@ static void pnv_phb3_realize(DeviceState *dev, Er=
ror **errp)
>      /* LSI sources */
>      object_property_set_link(OBJECT(&phb->lsis), OBJECT(pnv), "xics",
>                                     &error_abort);
> -    object_property_set_int(OBJECT(&phb->lsis), PNV_PHB3_NUM_LSI, "nr-=
irqs",
> -                            &error_abort);
>      object_property_set_bool(OBJECT(&phb->lsis), true, "realized", &lo=
cal_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> @@ -1024,8 +1026,6 @@ static void pnv_phb3_realize(DeviceState *dev, Er=
ror **errp)
>                                     &error_abort);
>      object_property_set_link(OBJECT(&phb->msis), OBJECT(pnv), "xics",
>                                     &error_abort);
> -    object_property_set_int(OBJECT(&phb->msis), PHB3_MAX_MSI, "nr-irqs=
",
> -                            &error_abort);
>      object_property_set_bool(OBJECT(&phb->msis), true, "realized", &lo=
cal_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>=20



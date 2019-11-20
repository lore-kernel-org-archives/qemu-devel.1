Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03882C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:28:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8ED22067D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8ED22067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXTmV-0001JT-0h
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 12:28:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iXTln-0000lS-Ri
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:28:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iXTlm-0007tA-6m
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:27:59 -0500
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:58988)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iXTlm-0007sg-1T
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:27:58 -0500
Received: from player778.ha.ovh.net (unknown [10.108.57.188])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id A8C611B566E
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 18:27:55 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player778.ha.ovh.net (Postfix) with ESMTPSA id 28DD9C480C5F;
 Wed, 20 Nov 2019 17:27:51 +0000 (UTC)
Date: Wed, 20 Nov 2019 18:27:49 +0100
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH for-5.0 v5 12/23] ppc/xive: Introduce a XiveFabric
 interface
Message-ID: <20191120182749.7e985a5b@bahia.lan>
In-Reply-To: <20191115162436.30548-13-clg@kaod.org>
References: <20191115162436.30548-1-clg@kaod.org>
 <20191115162436.30548-13-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 8618482316022552971
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudehtddguddttdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.165.38
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 Nov 2019 17:24:25 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> The XiveFabric QOM interface acts as the PowerBUS interface between
> the interrupt controller and the system and should be implemented by
> the QEMU machine. On HW, the XIVE sub-engine is responsible for the
> communication with the other chip is the Common Queue (CQ) bridge
> unit.
>=20
> This interface offers a 'match_nvt' handler to perform the CAM line
> matching when looking for a XIVE Presenter with a dispatched NVT.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  include/hw/ppc/xive.h | 22 ++++++++++++++++++++++
>  hw/intc/xive.c        | 10 ++++++++++
>  2 files changed, 32 insertions(+)
>=20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index f9aa0fa0dac3..b00af988779b 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -399,6 +399,28 @@ int xive_presenter_tctx_match(XivePresenter *xptr, X=
iveTCTX *tctx,
>                                uint8_t nvt_blk, uint32_t nvt_idx,
>                                bool cam_ignore, uint32_t logic_serv);
> =20
> +/*
> + * XIVE Fabric (Interface between Interrupt Controller and Machine)
> + */
> +
> +typedef struct XiveFabric XiveFabric;
> +
> +#define TYPE_XIVE_FABRIC "xive-fabric"
> +#define XIVE_FABRIC(obj)                                     \
> +    INTERFACE_CHECK(XiveFabric, (obj), TYPE_XIVE_FABRIC)
> +#define XIVE_FABRIC_CLASS(klass)                                     \
> +    OBJECT_CLASS_CHECK(XiveFabricClass, (klass), TYPE_XIVE_FABRIC)
> +#define XIVE_FABRIC_GET_CLASS(obj)                                   \
> +    OBJECT_GET_CLASS(XiveFabricClass, (obj), TYPE_XIVE_FABRIC)
> +
> +typedef struct XiveFabricClass {
> +    InterfaceClass parent;
> +    int (*match_nvt)(XiveFabric *xfb, uint8_t format,
> +                     uint8_t nvt_blk, uint32_t nvt_idx,
> +                     bool cam_ignore, uint8_t priority,
> +                     uint32_t logic_serv, XiveTCTXMatch *match);
> +} XiveFabricClass;
> +
>  /*
>   * XIVE END ESBs
>   */
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index da6196ca958f..1c9e58f8deac 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1893,8 +1893,18 @@ static const TypeInfo xive_presenter_info =3D {
>      .class_size =3D sizeof(XivePresenterClass),
>  };
> =20
> +/*
> + * XIVE Fabric
> + */
> +static const TypeInfo xive_fabric_info =3D {
> +    .name =3D TYPE_XIVE_FABRIC,
> +    .parent =3D TYPE_INTERFACE,
> +    .class_size =3D sizeof(XiveFabricClass),
> +};
> +
>  static void xive_register_types(void)
>  {
> +    type_register_static(&xive_fabric_info);
>      type_register_static(&xive_source_info);
>      type_register_static(&xive_notifier_info);
>      type_register_static(&xive_presenter_info);



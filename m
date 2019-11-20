Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8FEC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 18:35:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 432E8206DA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 18:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432E8206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXUp8-0004DO-0d
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 13:35:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37764)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iXUk0-0000vW-Et
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:30:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iXUjy-00011V-Ni
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:30:12 -0500
Received: from 14.mo6.mail-out.ovh.net ([46.105.56.113]:39418)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iXUjy-0000zc-HI
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:30:10 -0500
Received: from player711.ha.ovh.net (unknown [10.109.143.246])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 064BE1ECA62
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 19:30:07 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player711.ha.ovh.net (Postfix) with ESMTPSA id 37449C3BC99B;
 Wed, 20 Nov 2019 18:30:03 +0000 (UTC)
Date: Wed, 20 Nov 2019 19:30:01 +0100
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH for-5.0 v5 15/23] ppc/xive: Use the XiveFabric and
 XivePresenter interfaces
Message-ID: <20191120193001.5b9229a2@bahia.lan>
In-Reply-To: <20191115162436.30548-16-clg@kaod.org>
References: <20191115162436.30548-1-clg@kaod.org>
 <20191115162436.30548-16-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 9668946925167876491
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudehtddgudduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejuddurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.56.113
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

On Fri, 15 Nov 2019 17:24:28 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> Now that the machines have handlers implementing the XiveFabric and
> XivePresenter interfaces, remove xive_presenter_match() and make use
> of the 'match_nvt' handler of the machine.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/xive.c | 48 +++++++++++++++++-------------------------------
>  1 file changed, 17 insertions(+), 31 deletions(-)
>=20

Nice diffstat :)

> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 1c9e58f8deac..ab62bda85788 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1423,30 +1423,6 @@ int xive_presenter_tctx_match(XivePresenter *xptr,=
 XiveTCTX *tctx,
>      return -1;
>  }
> =20
> -static bool xive_presenter_match(XiveRouter *xrtr, uint8_t format,
> -                                 uint8_t nvt_blk, uint32_t nvt_idx,
> -                                 bool cam_ignore, uint8_t priority,
> -                                 uint32_t logic_serv, XiveTCTXMatch *mat=
ch)
> -{
> -    XivePresenter *xptr =3D XIVE_PRESENTER(xrtr);
> -    XivePresenterClass *xpc =3D XIVE_PRESENTER_GET_CLASS(xptr);
> -    int count;
> -
> -    count =3D xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, cam_ignore,
> -                           priority, logic_serv, match);
> -    if (count < 0) {
> -        return false;
> -    }
> -
> -    if (!match->tctx) {
> -        qemu_log_mask(LOG_UNIMP, "XIVE: NVT %x/%x is not dispatched\n",
> -                      nvt_blk, nvt_idx);

Maybe keep this trace...

> -        return false;
> -    }
> -
> -    return true;
> -}
> -
>  /*
>   * This is our simple Xive Presenter Engine model. It is merged in the
>   * Router as it does not require an extra object.
> @@ -1462,22 +1438,32 @@ static bool xive_presenter_match(XiveRouter *xrtr=
, uint8_t format,
>   *
>   * The parameters represent what is sent on the PowerBus
>   */
> -static bool xive_presenter_notify(XiveRouter *xrtr, uint8_t format,
> +static bool xive_presenter_notify(uint8_t format,
>                                    uint8_t nvt_blk, uint32_t nvt_idx,
>                                    bool cam_ignore, uint8_t priority,
>                                    uint32_t logic_serv)
>  {
> +    XiveFabric *xfb =3D XIVE_FABRIC(qdev_get_machine());
> +    XiveFabricClass *xfc =3D XIVE_FABRIC_GET_CLASS(xfb);
>      XiveTCTXMatch match =3D { .tctx =3D NULL, .ring =3D 0 };
> -    bool found;
> +    int count;
> =20
> -    found =3D xive_presenter_match(xrtr, format, nvt_blk, nvt_idx, cam_i=
gnore,
> -                                 priority, logic_serv, &match);
> -    if (found) {
> +    /*
> +     * Ask the machine to scan the interrupt controllers for a match
> +     */
> +    count =3D xfc->match_nvt(xfb, format, nvt_blk, nvt_idx, cam_ignore,
> +                           priority, logic_serv, &match);
> +    if (count < 0) {
> +        return false;
> +    }
> +
> +    /* handle CPU exception delivery */
> +    if (count) {
>          ipb_update(&match.tctx->regs[match.ring], priority);
>          xive_tctx_notify(match.tctx, match.ring);
>      }

... in an else block here ^^ ?

> =20
> -    return found;
> +    return count;

Implicit cast is ok I guess, but !!count would ensure no paranoid
compiler ever complains.

>  }
> =20
>  /*
> @@ -1590,7 +1576,7 @@ static void xive_router_end_notify(XiveRouter *xrtr=
, uint8_t end_blk,
>          return;
>      }
> =20
> -    found =3D xive_presenter_notify(xrtr, format, nvt_blk, nvt_idx,
> +    found =3D xive_presenter_notify(format, nvt_blk, nvt_idx,
>                            xive_get_field32(END_W7_F0_IGNORE, end.w7),
>                            priority,
>                            xive_get_field32(END_W7_F1_LOG_SERVER_ID, end.=
w7));



Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52155C4360C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 02:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D5F6222C0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 02:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="dsxkJBXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5F6222C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFr7M-0001ql-RG
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 22:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iFr5K-000051-4W
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 22:43:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iFr5H-0000wj-BY
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 22:43:17 -0400
Received: from ozlabs.org ([203.11.71.1]:33441)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iFr5F-0000wA-RY; Wed, 02 Oct 2019 22:43:14 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46kHP94545z9sPJ; Thu,  3 Oct 2019 12:43:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570070589;
 bh=Bl11ws5UVSYncs6cKehoc+wEXCdueTorraOVxmUFb7Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dsxkJBXg5cpNtbHYM9TDRYeH2R6QY1GxBRTYYamgt6S5KDZ22GF3AoCOdxcJuF1F2
 QEf4TW15Gu3CwofAL5S0Ffk8Pf/4rwPBeV2l+Ap5LicoIdZ2T5/T6QeuE9vWpU8aJ+
 xPJtCNKeSUy84iSbYkjphCbaFk37Eb+3DDuh04cE=
Date: Thu, 3 Oct 2019 11:54:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v4 05/25] ppc/xive: Introduce a XiveFabric interface
Message-ID: <20191003015409.GG11105@umbus.fritz.box>
References: <20190918160645.25126-1-clg@kaod.org>
 <20190918160645.25126-6-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="M8g8Xvd1npd+rU3W"
Content-Disposition: inline
In-Reply-To: <20190918160645.25126-6-clg@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--M8g8Xvd1npd+rU3W
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 06:06:25PM +0200, C=E9dric Le Goater wrote:
> The XiveFabric QOM interface should be implemented by the machine. It
> acts as the PowerBUS interface between the interrupt controller and
> the system. On HW, the XIVE sub-engine is responsible for the
> communication with the other chip is the Common Queue (CQ) bridge
> unit.
>=20
> This interface offers a 'match_nvt' handler to perform the CAM line
> matching when looking for a XIVE Presenter with a dispatched NVT.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Um.. this has basically the same single method as the XivePresented
interface you just introduced.  What's the distinction between them?

> ---
>  include/hw/ppc/xive.h | 22 ++++++++++++++++++++++
>  hw/intc/xive.c        | 10 ++++++++++
>  2 files changed, 32 insertions(+)
>=20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 39de45b87cb9..3c2910e10e25 100644
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
> index fff50429f8ac..7a15a64ed7fe 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1841,8 +1841,18 @@ static const TypeInfo xive_presenter_info =3D {
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

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--M8g8Xvd1npd+rU3W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2VVMEACgkQbDjKyiDZ
s5Lhuw/9EpdW2GeqbwLRrlOJ4Q/tdsj4LsSJ1QZboUZng2XGEnkezeGfryGN4GI+
0zvoCyA10/+Hnft3qdpDEU1nPl8zdaxMnXSvv4C9soE1+y8yPms/Xa2KXWCsO5Uq
ZtJS/brLmEN278js263szbjEnbGE27fw4utXFI5wqfaMQaqXYP9xK7jajbwOjPRD
qSImeeQHiYy5csgI4CbK56hSc2ezxqkptX5QcdyqzOhmXPvyZVm6WtW7gNcuolFx
OjqxE0y9i83C1sUTU9PDG8faX56iVPt9An7n8nS/0Onincu2PT7iFMzTF3314pw9
Cgly5xVYy7RiJahSKpCnDgnELAt3d/SYIUt16BZXCDssEKiulDHYYu/HbGpH0KRs
wv0ef50yYMqbMGLxCdeWrQyLWl4Je/c3bw3X5dZgrkhnTv/2T+hl10ACgoX6baG8
i6URt/J9ef6UgQxD5F2ILz+z43xlPF0VFYInVSI23jbGAdKoLTspzHCpVGvXI+My
5tXw8GzNmMGYQPJtk0v26GpYZIYV22RVixLzflxz4VYasVI4NrDtrHysoHocPTqp
Srqob3Dm8x9rnE9xuZUzPv+TqcEgDL4pwGBx7a88YDu+/MzzK/VHO2HHwTEprx64
Xv1KIk6Cu3XrtH7q1dvzTvgCxP3Pkw3XxlyJpZasLIaHP6apg5U=
=qILI
-----END PGP SIGNATURE-----

--M8g8Xvd1npd+rU3W--


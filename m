Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4BBC10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 02:45:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4FC5222C0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 02:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nO7YjVkQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4FC5222C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFr7N-0001r3-9U
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 22:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40600)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iFr5K-000052-3r
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 22:43:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iFr5H-0000wd-BN
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 22:43:17 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46771 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iFr5F-0000wC-Ta; Wed, 02 Oct 2019 22:43:14 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46kHP954gtz9sPZ; Thu,  3 Oct 2019 12:43:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570070589;
 bh=PmaToBwo/KJ6dcDZROnMivxc7CwJBCpATM7MQzZ4d+w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nO7YjVkQQ+0uSfbPgM0HN3EoXGAjVunKBbGWY6aU0DcBECyFeEGPmiJRWbprLiJMo
 4A/9X5NUHQbExLflQx4WhBVUVNR4p+StFKjjqUsGJmJUpsdCzEnbmNv3tf7P4uuGOh
 /T25gQJZSe2mALmoCIDuatQIIwKyluEOgiKYBzAY=
Date: Thu, 3 Oct 2019 11:55:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v4 06/25] ppc/pnv: Implement the XiveFabric interface
Message-ID: <20191003015555.GH11105@umbus.fritz.box>
References: <20190918160645.25126-1-clg@kaod.org>
 <20190918160645.25126-7-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zVyz+SkbhTrRQGHt"
Content-Disposition: inline
In-Reply-To: <20190918160645.25126-7-clg@kaod.org>
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


--zVyz+SkbhTrRQGHt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 06:06:26PM +0200, C=E9dric Le Goater wrote:
> The CAM line matching on the PowerNV machine now scans all chips of
> the system and all CPUs of a chip to find a dispatched NVT in the
> thread contexts.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/ppc/pnv.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 77a86c6a2301..ca24dd62df23 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1378,6 +1378,35 @@ static void pnv_pic_print_info(InterruptStatsProvi=
der *obj,
>      }
>  }
> =20
> +static int pnv_xive_match_nvt(XiveFabric *xfb, uint8_t format,
> +                               uint8_t nvt_blk, uint32_t nvt_idx,
> +                               bool cam_ignore, uint8_t priority,
> +                               uint32_t logic_serv,
> +                               XiveTCTXMatch *match)
> +{
> +    PnvMachineState *pnv =3D PNV_MACHINE(xfb);
> +    int total_count =3D 0;
> +    int i;
> +
> +    for (i =3D 0; i < pnv->num_chips; i++) {
> +        Pnv9Chip *chip9 =3D PNV9_CHIP(pnv->chips[i]);
> +        XivePresenter *xptr =3D XIVE_PRESENTER(&chip9->xive);
> +        XivePresenterClass *xpc =3D XIVE_PRESENTER_GET_CLASS(xptr);
> +        int count;
> +
> +        count =3D xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, cam_ign=
ore,
> +                               priority, logic_serv, match);
> +
> +        if (count < 0) {
> +            return count;
> +        }
> +
> +        total_count +=3D count;
> +    }
> +
> +    return total_count;
> +}
> +
>  static void pnv_get_num_chips(Object *obj, Visitor *v, const char *name,
>                                void *opaque, Error **errp)
>  {
> @@ -1441,9 +1470,11 @@ static void pnv_machine_power8_class_init(ObjectCl=
ass *oc, void *data)
>  static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> +    XiveFabricClass *xfc =3D XIVE_FABRIC_CLASS(oc);
> =20
>      mc->desc =3D "IBM PowerNV (Non-Virtualized) POWER9";
>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power9_v2.0");
> +    xfc->match_nvt =3D pnv_xive_match_nvt;
> =20
>      mc->alias =3D "powernv";
>  }
> @@ -1495,6 +1526,7 @@ static void pnv_machine_class_init(ObjectClass *oc,=
 void *data)
>          .interfaces =3D (InterfaceInfo[]) {               \
>              { TYPE_XICS_FABRIC },                       \
>              { TYPE_INTERRUPT_STATS_PROVIDER },          \
> +            { TYPE_XIVE_FABRIC },                       \

Hmm.. this should probably be on the powernv9 machine only, not
powernv8 as well, yes?

>              { },                                        \
>          },                                              \
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zVyz+SkbhTrRQGHt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2VVSoACgkQbDjKyiDZ
s5JIFA/462wezaKiHqThY3tOi3RGMCEZB4StQCPmli3bFRB6X1CTNg5rWTh6wsby
lV7+lJJ2ZZf+2YVZX7hT6PX+hlX6PiO5X15zWsMJzgo6jB09ObcCeZqhgH0+UVEG
PyRfnaWaTtDJ/6dD2bqwwmjxh1S41g9I64YzmN3hfyw0DXr3O1JbzkrpeYf3sANZ
swkgpeoQY/5AcBacnKsANR1c6Q/HnoiPXxVD27ANIjPrPRzOistHWmjOmqx5MpMN
dNsZ4rzw3Sbyjm/W5HummH1D4LVUUbrxT4XerUr6VxMNcg61wHNBUGPlW0IKXl82
v93kWuXFzJCeyHjC12ApqQwE/gbx4u9K0u0pZcxvNnIgnIs2LhEtJ1pAfpipJ/6A
3Bpvczpn8IYRXphw+9bEHLN5fzhDIcyBeZJFlbqgx4XZRTHwYd0xUjVFdC7wAvuA
qx+q1z+DTLWm6ff8WMx98cBDOR8sphsqEnmhFwqcQgG15dPvxEJO3WN1ix+Do9JN
3OflXtoVvL3Z/wQ1KhzzchK2w5GJ76jxQKEHE0uCzc5jR7k/TxoALod3JUicOLwR
XEC43S9X/t0J+XLNNj4hPUGWFQ4lVrUT2lGlMgF8QXLfGFyMktzZP6sg2X/9RPFl
5i4qP7uM7sG7txtioD0owPniGOknorG2GvQbr9Gnc9RRkD2J5A==
=GrzQ
-----END PGP SIGNATURE-----

--zVyz+SkbhTrRQGHt--


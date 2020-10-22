Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC18C388F2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 04:18:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D4F922267
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 04:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="S40iZZnP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D4F922267
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVS3n-0004jh-TW
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 00:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kVS2v-0003DJ-HR; Thu, 22 Oct 2020 00:17:50 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:37453 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kVS2s-0000Ed-Hd; Thu, 22 Oct 2020 00:17:48 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CGvGP3HNfz9sVK; Thu, 22 Oct 2020 15:17:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1603340253;
 bh=THEf6+olDZKx0/d/9mnlKgZDwqVHlqPAqh43xMoN+rU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=S40iZZnPB2uX0WPd/YvbBNoV4GdnlFW+wAuES+Fc6GeYpCLiWvivOjvHC4rlzMVsD
 aVuxHpOchPUTgw7HXlmmGHgadL+w7ST6PoxVWR7055k1oPDKpC6446brGQht/TgRAk
 aZoc0IgNbzLtth1FcleGE3QNTTqq1GRkn9b2/7ls=
Date: Thu, 22 Oct 2020 15:08:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 3/5] spapr: Use appropriate getter for PC_DIMM_SLOT_PROP
Message-ID: <20201022040817.GF1821515@yekko.fritz.box>
References: <160309727218.2739814.14722724927730985344.stgit@bahia.lan>
 <160309730758.2739814.15821922745424652642.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1Y7d0dPL928TPQbc"
Content-Disposition: inline
In-Reply-To: <160309730758.2739814.15821922745424652642.stgit@bahia.lan>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--1Y7d0dPL928TPQbc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2020 at 10:48:27AM +0200, Greg Kurz wrote:
> The PC_DIMM_SLOT_PROP property is defined as:
>=20
>     DEFINE_PROP_INT32(PC_DIMM_SLOT_PROP, PCDIMMDevice, slot,
>                       PC_DIMM_UNASSIGNED_SLOT),
>=20
> Use object_property_get_int() instead of object_property_get_uint().
> Since spapr_memory_plug() only gets called if pc_dimm_pre_plug()
> succeeded, we expect to have a valid >=3D 0 slot number, either because
> the user passed a valid slot number or because pc_dimm_get_free_slot()
> picked one up for us.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 115fc52e3b06..1b173861152f 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3433,7 +3433,8 @@ static void spapr_memory_plug(HotplugHandler *hotpl=
ug_dev, DeviceState *dev,
>      Error *local_err =3D NULL;
>      SpaprMachineState *ms =3D SPAPR_MACHINE(hotplug_dev);
>      PCDIMMDevice *dimm =3D PC_DIMM(dev);
> -    uint64_t size, addr, slot;
> +    uint64_t size, addr;
> +    int64_t slot;
>      bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
> =20
>      size =3D memory_device_get_region_size(MEMORY_DEVICE(dev), &error_ab=
ort);
> @@ -3450,11 +3451,13 @@ static void spapr_memory_plug(HotplugHandler *hot=
plug_dev, DeviceState *dev,
>                         spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
>                         &local_err);
>      } else {
> -        slot =3D object_property_get_uint(OBJECT(dimm),
> -                                        PC_DIMM_SLOT_PROP, &local_err);
> +        slot =3D object_property_get_int(OBJECT(dimm),
> +                                       PC_DIMM_SLOT_PROP, &local_err);
>          if (local_err) {
>              goto out_unplug;
>          }
> +        /* We should have valid slot number at this point */
> +        g_assert(slot >=3D 0);
>          spapr_add_nvdimm(dev, slot, &local_err);
>      }
> =20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1Y7d0dPL928TPQbc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+RBbEACgkQbDjKyiDZ
s5IovBAAnXemXa+W3qx7H/MIW/15BmyQChWxgl+XdQVWwQpPP9RdvMLYjpNa8unI
m/seKNHBURH7xV0LDboE+XjrvougeLAIG4inY+2lnSj6I0K/PP4GgQh4TGZz5yD9
GfwABbyoeC6E5H7HE+cu5Guw6jtD6KbNUJQ2hC9ltWmH4FapDWlu0K+ykzPxXvMh
H4Qfy/lCbH9hsQk+6elAUScZio37SmXsxbWo9sU+s9IkzZZxTifiUDS1xLOYWEvU
ERMnckIAmXYbTqy/6CClVOT1Xl3E2ynU3kDZBpDYVttQ1sewl/YfENwPqmdW42Pj
W0V7uPtwsFg1x8qMSnrldnk+UYzF79JpxYR1iKRzlPvw3wHZ/4Cl37zJBuPEcYI2
QS71E9MZzGg7KCq97ShhCExTmKXCN5Qmf3DTJjvO2ZGSUsX5vos8dKSPHXJBwOj3
hrz30OkXJsGt6BP1YbBtO7noJOGvh/pwJCdaR2kR8HSOwEssbo75EYRrHuM2qXyN
C8Vjo0NiEWTiThNLUYgENTOBDOISRUDt5LRMy96WjbRSgUDrRZJmpRF9Lc1pSXIw
JHxYK5E0Z6YmlfZ5pxUFMk0LJ5vE/3J8UJkWULWaxdxwozxKaAzCi6XWzBNlbbV/
Q7ligCeQ7rPvL6px1O69+8ZN29Scb+MrMcTufd1aX4ezB+iVsRk=
=MQdP
-----END PGP SIGNATURE-----

--1Y7d0dPL928TPQbc--


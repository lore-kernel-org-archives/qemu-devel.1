Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D284C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 02:21:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 217C9214AF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 02:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PN0sDap8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 217C9214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izAJg-0003fJ-A1
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 21:21:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36385)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1izAIx-00037j-JN
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 21:20:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1izAIv-0001pm-NX
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 21:20:38 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:51757 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1izAIt-0001JY-QR; Tue, 04 Feb 2020 21:20:37 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48C4zK1c2Rz9sSR; Wed,  5 Feb 2020 13:20:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580869229;
 bh=clN/iZ7l+cjfhQHuLH/v295pD9eU52Rd3W3Ar0Xk9/Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PN0sDap8zlH0hmpoAq636XUFZx4GY37kVHqoBOrpASv3f0ALrrvKrkvBn3h1n4+rH
 rCRybzH2jAm2N0Jr+kWXgnYrRYHIObd3OcN4MWVkoXJMboayLPEp7zBhYfqVBm8uUF
 Lq9Q4vUmHtCGwbVbd5aOuhvzf4HpXWFtQVE54WpI=
Date: Wed, 5 Feb 2020 11:49:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v5 2/4] nvdimm: add uuid property to nvdimm
Message-ID: <20200205004917.GE60221@umbus.fritz.box>
References: <158038485571.16440.14734905006978949612.stgit@lep8c.aus.stglabs.ibm.com>
 <158038487514.16440.10078356123772690069.stgit@lep8c.aus.stglabs.ibm.com>
 <20200204155523.16d551d5@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JBi0ZxuS5uaEhkUZ"
Content-Disposition: inline
In-Reply-To: <20200204155523.16d551d5@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: xiaoguangrong.eric@gmail.com, Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 mst@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 sbhat@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--JBi0ZxuS5uaEhkUZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 04, 2020 at 03:55:23PM +0100, Igor Mammedov wrote:
> On Thu, 30 Jan 2020 05:47:59 -0600
> Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:
>=20
> > For ppc64, PAPR requires the nvdimm device to have UUID property
> > set in the device tree. Add an option to get it from the user.
> >=20
> > Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/mem/nvdimm.c         |   40 ++++++++++++++++++++++++++++++++++++++++
> >  include/hw/mem/nvdimm.h |    7 +++++++
> >  2 files changed, 47 insertions(+)
> >=20
> > diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> > index 39f1426d1f..8e426d24bb 100644
> > --- a/hw/mem/nvdimm.c
> > +++ b/hw/mem/nvdimm.c
> > @@ -69,11 +69,51 @@ out:
> >      error_propagate(errp, local_err);
> >  }
> > =20
> > +static void nvdimm_get_uuid(Object *obj, Visitor *v, const char *name,
> > +                                  void *opaque, Error **errp)
> > +{
> > +    NVDIMMDevice *nvdimm =3D NVDIMM(obj);
> > +    char *value =3D NULL;
> > +
> > +    value =3D qemu_uuid_unparse_strdup(&nvdimm->uuid);
> > +
> > +    visit_type_str(v, name, &value, errp);
> > +    g_free(value);
> > +}
> > +
> > +
> > +static void nvdimm_set_uuid(Object *obj, Visitor *v, const char *name,
> > +                                  void *opaque, Error **errp)
> > +{
> > +    NVDIMMDevice *nvdimm =3D NVDIMM(obj);
> > +    Error *local_err =3D NULL;
> > +    char *value;
> > +
> > +    visit_type_str(v, name, &value, &local_err);
> > +    if (local_err) {
> > +        goto out;
> > +    }
> > +
> > +    if (qemu_uuid_parse(value, &nvdimm->uuid) !=3D 0) {
> > +        error_setg(errp, "Property '%s.%s' has invalid value",
> > +                   object_get_typename(obj), name);
> > +        goto out;
> > +    }
> > +    g_free(value);
> > +
> > +out:
> > +    error_propagate(errp, local_err);
> > +}
> > +
> > +
> >  static void nvdimm_init(Object *obj)
> >  {
> >      object_property_add(obj, NVDIMM_LABEL_SIZE_PROP, "int",
> >                          nvdimm_get_label_size, nvdimm_set_label_size, =
NULL,
> >                          NULL, NULL);
> > +
> > +    object_property_add(obj, NVDIMM_UUID_PROP, "QemuUUID", nvdimm_get_=
uuid,
> why it's named "QemuUUID" and not just "uuid"

I almost got caught by that one.  The name is NVDIMM_UUID_PROP, which
is indeed just "uuid".  The "QemuUUID" is the property type identifier.

>=20
>=20
> > +                        nvdimm_set_uuid, NULL, NULL, NULL);
> >  }
> > =20
> >  static void nvdimm_finalize(Object *obj)
> > diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
> > index 523a9b3d4a..4807ca615b 100644
> > --- a/include/hw/mem/nvdimm.h
> > +++ b/include/hw/mem/nvdimm.h
> > @@ -25,6 +25,7 @@
> > =20
> >  #include "hw/mem/pc-dimm.h"
> >  #include "hw/acpi/bios-linker-loader.h"
> > +#include "qemu/uuid.h"
> > =20
> >  #define NVDIMM_DEBUG 0
> >  #define nvdimm_debug(fmt, ...)                                \
> > @@ -49,6 +50,7 @@
> >                                                 TYPE_NVDIMM)
> > =20
> >  #define NVDIMM_LABEL_SIZE_PROP "label-size"
> > +#define NVDIMM_UUID_PROP       "uuid"
> >  #define NVDIMM_UNARMED_PROP    "unarmed"
> > =20
> >  struct NVDIMMDevice {
> > @@ -83,6 +85,11 @@ struct NVDIMMDevice {
> >       * the guest write persistence.
> >       */
> >      bool unarmed;
> > +
> > +    /*
> > +     * The PPC64 - spapr requires each nvdimm device have a uuid.
> > +     */
> > +    QemuUUID uuid;
> >  };
> >  typedef struct NVDIMMDevice NVDIMMDevice;
> > =20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JBi0ZxuS5uaEhkUZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl46EQgACgkQbDjKyiDZ
s5LEiBAAx777OUjSF45qHEabJ5+vmbru4vWVijvBZTWBgudQrolNxIDh8WKjTTv5
PQMKoy+0hS9u1RWqBoFaq0mB71Wv4JwAnMLmA5XsWVmIFe4dh7JawylrNxHM8LzY
uMkGWjeU/rIzDKpbviE0taSItgYoSdmM/vZwzW1SZ3G5CNqzgeIqTgG0uzvOPn7z
93BpKn9LH8BW2ul+JC4lojf4y1vNTdAsNWR2POJEy1go1M6BHD4DSlcFfsl7/QKX
JVK4sX3sUFWJL7kxlCJL9cbAWKY+G0hWNTQ+IztoRmhSzmDFJyBYa9KHlZ3OgLq8
SJ0rJy5wcDitSUVkOlkAN3oCrjg+308q0FWbEy/0ji9aetvT4UXrtcDb4tOFzUeb
cd3R1DcvY8+xex9/yiHdZ2f5kr5tYUnk6EPdZ3lewCYGeuQnkmMn5Uf7gtT+UT7Z
V6xI/P3jLGgGRT169JWJDVD5xa5HKnZ7I1t+984WqQhz89rYn9i2aid9EPsP1yKs
ub/hoLhYaX5iECIj+RvnkXt1YvPllMEOToBTn0LiZcTdKshhoJyAfvI7B3cRrL7g
HjdI/epbH+lucchgdRdYM9Q0DLmdJbNS8lz96VOMy3lq8DxaP54FLSrTh9nHkb08
x+C4WM/DdZ3FE4y0tlZSq8265IMXxscxx6DlrsDYjhJBPeV2v2c=
=9mOQ
-----END PGP SIGNATURE-----

--JBi0ZxuS5uaEhkUZ--


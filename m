Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2515C28CC2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 04:26:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95AFA2543E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 04:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Da84EH8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95AFA2543E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58576 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWCdn-00047O-NO
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 00:26:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hWCc3-00032D-Uj
	for qemu-devel@nongnu.org; Thu, 30 May 2019 00:24:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hWCc2-0002Yk-M4
	for qemu-devel@nongnu.org; Thu, 30 May 2019 00:24:23 -0400
Received: from ozlabs.org ([203.11.71.1]:33459)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hWCc2-0002Qi-1x; Thu, 30 May 2019 00:24:22 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45Dvbm2YF2z9sTQ; Thu, 30 May 2019 14:24:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559190244;
	bh=XVxw3ERjlDugDDZ6YiL892/5uMMY8wQg/GV7q6ZSQts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Da84EH8xRpLjSQiLAHQARZyVnJVE775c36S6TerqaGDXjhg3eFymNhYq0xwpTz2+M
	GNxTlYv2AphujTt/N94h5WpRCXR9wKGa9cRMRgm9JRLcKadr2nbY2PIde96z6RSdj8
	mpwhYO1aXTup8FSS55S5lFnTEdoDTXLcX2zpfb1A=
Date: Thu, 30 May 2019 11:50:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190530015035.GC2017@umbus.fritz.box>
References: <20190523052918.1129-1-david@gibson.dropbear.id.au>
	<20190524153219.15b21c74@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
Content-Disposition: inline
In-Reply-To: <20190524153219.15b21c74@bahia.lan>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 1/8] spapr: Clean up device node name
 generation for PCI devices
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: mdroth@linux.ibm.com, mst@redhat.com, qemu-ppc@nongnu.org, clg@kaod.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2019 at 03:32:19PM +0200, Greg Kurz wrote:
> On Thu, 23 May 2019 15:29:11 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > spapr_populate_pci_child_dt() adds a 'name' property to the device tree
> > node for PCI devices.  This is never necessary for a flattened device t=
ree,
> > it is implicit in the name added when the node is constructed.  In fact
> > anything we do add to a 'name' property will be overwritten with someth=
ing
> > derived from the structural name in the guest firmware (but in fact it =
is
> > exactly the same bytes).
> >=20
> > So, remove that.  In addition, pci_get_node_name() is very simple, so f=
old
> > it into its (also simple) sole caller spapr_create_pci_child_dt().
> >=20
> > While we're there rename pci_find_device_name() to the shorter and more
> > accurate dt_name_from_class().
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr_pci.c | 43 +++++++++++++++++--------------------------
> >  1 file changed, 17 insertions(+), 26 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index 97961b0128..b2db46ef1d 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -1173,8 +1173,8 @@ static const PCIClass pci_classes[] =3D {
> >      { "data-processing-controller", spc_subclass },
> >  };
> > =20
> > -static const char *pci_find_device_name(uint8_t class, uint8_t subclas=
s,
> > -                                        uint8_t iface)
> > +static const char *dt_name_from_class(uint8_t class, uint8_t subclass,
> > +                                      uint8_t iface)
> >  {
> >      const PCIClass *pclass;
> >      const PCISubClass *psubclass;
> > @@ -1216,23 +1216,6 @@ static const char *pci_find_device_name(uint8_t =
class, uint8_t subclass,
> >      return name;
> >  }
> > =20
> > -static gchar *pci_get_node_name(PCIDevice *dev)
> > -{
> > -    int slot =3D PCI_SLOT(dev->devfn);
> > -    int func =3D PCI_FUNC(dev->devfn);
> > -    uint32_t ccode =3D pci_default_read_config(dev, PCI_CLASS_PROG, 3);
> > -    const char *name;
> > -
> > -    name =3D pci_find_device_name((ccode >> 16) & 0xff, (ccode >> 8) &=
 0xff,
> > -                                ccode & 0xff);
> > -
> > -    if (func !=3D 0) {
> > -        return g_strdup_printf("%s@%x,%x", name, slot, func);
> > -    } else {
> > -        return g_strdup_printf("%s@%x", name, slot);
> > -    }
> > -}
> > -
> >  static uint32_t spapr_phb_get_pci_drc_index(SpaprPhbState *phb,
> >                                              PCIDevice *pdev);
> > =20
> > @@ -1300,11 +1283,6 @@ static void spapr_populate_pci_child_dt(PCIDevic=
e *dev, void *fdt, int offset,
> >          _FDT(fdt_setprop(fdt, offset, "udf-supported", NULL, 0));
> >      }
> > =20
> > -    _FDT(fdt_setprop_string(fdt, offset, "name",
> > -                            pci_find_device_name((ccode >> 16) & 0xff,
> > -                                                 (ccode >> 8) & 0xff,
> > -                                                 ccode & 0xff)));
> > -
> >      buf =3D spapr_phb_get_loc_code(sphb, dev);
> >      _FDT(fdt_setprop_string(fdt, offset, "ibm,loc-code", buf));
> >      g_free(buf);
> > @@ -1348,10 +1326,23 @@ static int spapr_create_pci_child_dt(SpaprPhbSt=
ate *phb, PCIDevice *dev,
> >                                       void *fdt, int node_offset)
> >  {
> >      int offset;
> > -    gchar *nodename;
> > +    const gchar *basename;
> > +    char *nodename;
>=20
> Not sure why you're changing nodename to be a char * instead of a gchar *=
 ...

Uh... by mistake.  I'll remove that.

> Apart from that, LGTM.
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> > +    int slot =3D PCI_SLOT(dev->devfn);
> > +    int func =3D PCI_FUNC(dev->devfn);
> > +    uint32_t ccode =3D pci_default_read_config(dev, PCI_CLASS_PROG, 3);
> > +
> > +    basename =3D dt_name_from_class((ccode >> 16) & 0xff, (ccode >> 8)=
 & 0xff,
> > +                                  ccode & 0xff);
> > +
> > +    if (func !=3D 0) {
> > +        nodename =3D g_strdup_printf("%s@%x,%x", basename, slot, func);
> > +    } else {
> > +        nodename =3D g_strdup_printf("%s@%x", basename, slot);
> > +    }
> > =20
> > -    nodename =3D pci_get_node_name(dev);
> >      _FDT(offset =3D fdt_add_subnode(fdt, node_offset, nodename));
> > +
> >      g_free(nodename);
> > =20
> >      spapr_populate_pci_child_dt(dev, fdt, offset, phb);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzvNugACgkQbDjKyiDZ
s5KbJg//Qoijg6MUMO9kYgTvT6SQbUebZ0RTDRW2OIxVeVkK5Ji5QM0SOmOcYmOc
zlP/iLHLUMkc38ux+TRh1zPzq/nw+2Ks+skPlkvClt9FQ5rAjWJ6g3t1z3GMS74Q
Gqrq0D/ZEkQ7tJc56Sz8cz3GOgHYQi1qklui5PLXvE9c1+Xi++7ga8Zdl1TqSM6O
5seBAfPkjkszPqPnqBo7Gt/W7TIRj6buHiu7tY0yP2SSFqjE3McvNG2Tp2PYO7YP
7Bd1aeBcUl2vflC19kPBTwH6rcDLPfylazRuXIIAbVTNDE7+LfiySOqz+YqPsPBG
prcN1oea8QABJEeFQwWsFmGLJShxJzG9YDkj10obk2VrWKa6LbBp9Q7zVkCjcrpT
pRDUwTQQMkOpQ7hUAWKthFUfAJbMS3vGWVieF4sPutJMMe++C/1leCVtvFWX4iKn
sj7WYugG9RDKYTMrdn0JS+0/fMYDh1wO9tCnVbrplJOOc3gewe13v2VGdcjVPuj8
r3lYkC396nN5tgPYPLdPNmLYFDS+ujdUlfAYIDdd6F7b0s1kcCI5HacddIw2Bvio
PjWOCVaIjxQzu4wAcMfOo+ONINB21sBMwt5MlNgiWA1z/XJ4/Lhuv1Np5BoqeZqf
6nuYTsu3lhv7XZsAgiA08zyv+bZosCelvg16dnpLIyftg05siAk=
=lXBz
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--


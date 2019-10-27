Return-Path: <SRS0=q9Vo=YU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD975CA9EAF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 17:32:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8784A20679
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 17:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="FGC1MKb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8784A20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOmPM-0001mk-Pk
	for qemu-devel@archiver.kernel.org; Sun, 27 Oct 2019 13:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iOmJp-0004H5-RZ
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 13:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iOmJo-0006hf-2h
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 13:27:09 -0400
Received: from ozlabs.org ([203.11.71.1]:48859)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iOmJn-0006ap-Bd; Sun, 27 Oct 2019 13:27:08 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 471Psw3jX7z9sPd; Mon, 28 Oct 2019 04:27:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1572197220;
 bh=egzIHRGugMEiGbxMKPt4sqHOok6DX7V2QhAAblPiauA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FGC1MKb4W7RfefCh1KOILq+8lTxsBGIlcFzhS4tw251LRe2Rseci7iz73DRWLQ+mQ
 vORAVzkibky8p7kRCGoC2DzdriBNSb1Fln4Dq1QGxm3318d49uzr2fw0L1DFSjnRog
 HB0yzgk1+JQMCZRvYf91djobQEN06QEaKWYf7K8E=
Date: Sun, 27 Oct 2019 18:03:35 +0100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 6/6] xive: Don't use CPU_FOREACH() to perform CAM line
 matching
Message-ID: <20191027170335.GG3552@umbus.metropole.lan>
References: <157184231371.3053790.17713393349394736594.stgit@bahia.lan>
 <157184234731.3053790.18369348907304339634.stgit@bahia.lan>
 <20191024030536.GW6439@umbus.fritz.box>
 <20191024143327.2fa79b2a@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Wtrm9ATX0sn6fFKv"
Content-Disposition: inline
In-Reply-To: <20191024143327.2fa79b2a@bahia.lan>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Wtrm9ATX0sn6fFKv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 02:33:27PM +0200, Greg Kurz wrote:
> On Thu, 24 Oct 2019 14:05:36 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Wed, Oct 23, 2019 at 04:52:27PM +0200, Greg Kurz wrote:
> > > Now that the TCTX objects are children of the XIVE router, stop
> > > using CPU_FOREACH() when looking for a matching VCPU target.
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >  hw/intc/xive.c |  100 +++++++++++++++++++++++++++++++++++-----------=
----------
> > >  1 file changed, 62 insertions(+), 38 deletions(-)
> > >=20
> > > diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> > > index 40ce43152456..ec5e7d0ee39a 100644
> > > --- a/hw/intc/xive.c
> > > +++ b/hw/intc/xive.c
> > > @@ -1403,55 +1403,79 @@ typedef struct XiveTCTXMatch {
> > >      uint8_t ring;
> > >  } XiveTCTXMatch;
> > > =20
> > > -static bool xive_presenter_match(XiveRouter *xrtr, uint8_t format,
> > > -                                 uint8_t nvt_blk, uint32_t nvt_idx,
> > > -                                 bool cam_ignore, uint8_t priority,
> > > -                                 uint32_t logic_serv, XiveTCTXMatch =
*match)
> > > +typedef struct XivePresenterMatch {
> > > +    uint8_t format;
> > > +    uint8_t nvt_blk;
> > > +    uint32_t nvt_idx;
> > > +    bool cam_ignore;
> > > +    uint8_t priority;
> > > +    uint32_t logic_serv;
> > > +    XiveTCTXMatch *match;
> > > +    int count;
> > > +} XivePresenterMatch;
> > > +
> > > +static int do_xive_presenter_match(Object *child, void *opaque)
> > >  {
> > > -    CPUState *cs;
> > > +    XiveTCTX *tctx =3D XIVE_TCTX(child);
> > > +    XivePresenterMatch *xpm =3D opaque;
> > > +    int ring;
> > > =20
> > >      /*
> > >       * TODO (PowerNV): handle chip_id overwrite of block field for
> > >       * hardwired CAM compares
> > >       */
> > > =20
> > > -    CPU_FOREACH(cs) {
> > > -        XiveTCTX *tctx =3D xive_router_get_tctx(xrtr, cs);
> > > -        int ring;
> > > +    /*
> > > +     * HW checks that the CPU is enabled in the Physical Thread
> > > +     * Enable Register (PTER).
> > > +     */
> > > =20
> > > -        /*
> > > -         * Skip partially initialized vCPUs. This can happen when
> > > -         * vCPUs are hotplugged.
> > > -         */
> > > -        if (!tctx) {
> > > -            continue;
> > > +    /*
> > > +     * Check the thread context CAM lines and record matches. We
> > > +     * will handle CPU exception delivery later
> > > +     */
> > > +    ring =3D xive_presenter_tctx_match(tctx, xpm->format, xpm->nvt_b=
lk,
> > > +                                     xpm->nvt_idx, xpm->cam_ignore,
> > > +                                     xpm->logic_serv);
> > > +
> > > +    /*
> > > +     * Save the context and follow on to catch duplicates, that we
> > > +     * don't support yet.
> > > +     */
> > > +    if (ring !=3D -1) {
> > > +        if (xpm->match->tctx) {
> > > +            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: already found a th=
read "
> > > +                          "context NVT %x/%x\n", xpm->nvt_blk, xpm->=
nvt_idx);
> > > +            return -1;
> > >          }
> > > =20
> > > -        /*
> > > -         * HW checks that the CPU is enabled in the Physical Thread
> > > -         * Enable Register (PTER).
> > > -         */
> > > +        xpm->match->ring =3D ring;
> > > +        xpm->match->tctx =3D tctx;
> > > +        xpm->count++;
> > > +    }
> > > =20
> > > -        /*
> > > -         * Check the thread context CAM lines and record matches. We
> > > -         * will handle CPU exception delivery later
> > > -         */
> > > -        ring =3D xive_presenter_tctx_match(tctx, format, nvt_blk, nv=
t_idx,
> > > -                                         cam_ignore, logic_serv);
> > > -        /*
> > > -         * Save the context and follow on to catch duplicates, that =
we
> > > -         * don't support yet.
> > > -         */
> > > -        if (ring !=3D -1) {
> > > -            if (match->tctx) {
> > > -                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: already found =
a thread "
> > > -                              "context NVT %x/%x\n", nvt_blk, nvt_id=
x);
> > > -                return false;
> > > -            }
> > > -
> > > -            match->ring =3D ring;
> > > -            match->tctx =3D tctx;
> > > -        }
> > > +    return 0;
> > > +}
> > > +
> > > +static bool xive_presenter_match(XiveRouter *xrtr, uint8_t format,
> > > +                                 uint8_t nvt_blk, uint32_t nvt_idx,
> > > +                                 bool cam_ignore, uint8_t priority,
> > > +                                 uint32_t logic_serv, XiveTCTXMatch =
*match)
> > > +{
> > > +    XivePresenterMatch xpm =3D {
> > > +        .format     =3D format,
> > > +        .nvt_blk    =3D nvt_blk,
> > > +        .nvt_idx    =3D nvt_idx,
> > > +        .cam_ignore =3D cam_ignore,
> > > +        .priority   =3D priority,
> > > +        .logic_serv =3D logic_serv,
> > > +        .match      =3D match,
> > > +        .count      =3D 0,
> > > +    };
> > > +
> > > +    if (object_child_foreach_type(OBJECT(xrtr), TYPE_XIVE_TCTX,
> > > +                                  do_xive_presenter_match, &xpm) < 0=
) {
> > > +        return false;
> >=20
> > Hrm... xive_presenter_match() is potentially a pretty hot path, it's
> > called on every interrupt delivery - especially since we don't have a
> > usable KVM irq chip for Boston machines.  I'm concerned that using
> > something as heavyweight as object_child_foreach() might have a
> > noticeable performance impact.
> >=20
>=20
> Well, the XiveRouter _only_ has 3 extra children (XiveSource,
> XiveENDSource and TIMA) but indeed object_child_foreach() might
> cost more than QTAILQ_FOREACH_RCU().

Right, it's not so much the redundant children, but whatever we have
to do to delve into the children data structure I'm concerned about
here.

> A possible option could be
> to have a QTAILQ of presenters under the machine for sPAPR or
> under the chip for PNV, in order to avoid the need to filter out
> VCPUs that we don't want to consider, ie. partly realized with
> sPAPR and from another chip with PNV.

If we can manage it, I'd actually suggest a plain old array/vector of
them, rather than a QTAILQ.

> But as said in another mail, the safer for 4.2 is probably to
> fix the CPU_FOREACH() users, which is already the case here for
> sPAPR.
>=20
> > >      }
> > > =20
> > >      if (!match->tctx) {
> > >=20
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Wtrm9ATX0sn6fFKv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl21zecACgkQbDjKyiDZ
s5KRwg//bcdz2EnN6d0RUbzKTNpWxbQKl5917M4Pdnbnrjbt/N/zu8UOQFLrX3QM
XL95wpc3/U6sobfyGUNFZ1aIcfjl4oIIoFhKOirW/YZE+1pA2BiLCIPpgyrupUj1
Sva9+xJhTJ3fSB5t87zIcm11ia6os19ZOX2MtrudxDnzvNsgF3nxIt8wgbqAmG5R
6OSAmh1vpOsAXFtb9boiTNf70CHqWz4lLFxAvOM3tCOMJjrSXa6GoGOuB9GZimQu
y4T1Biop6i5ImDMKMhnVU6f6TtvdmiamS+NBbL+AmDAUebGheL1Z0uwvLArRPhMh
+1IMLLzN0eujgU7viDBRSGxKVqQv1t/bFFP6JjOSBg7mDG2vWX0XhUw9/QNLVTtk
DyXADxMlSyfoI4gu6Fh2ABHb1J9FOXKqJv6EDFsgSdHeQ67D0p7BWYC9OtOS+U+C
dr9asJt3W7iFTsex3dMMJ+YAq2c6fh8SoN2nV/Sf9f2JM0+Gy5WjlGWcMxzYgYBO
J2kjXSkfFmXy07Pjr+rwexiHE8ybh5KzTOFJJ482YAKUe5GnLffUxb4T7ut5a5AN
qmeIKyUQ4fGo4crOeqqJx4GbmAX84n1aRbRXf8hLr6UOmlkSlkbHPkoLKTn/k+Te
H57axkHJOv/5OhI/8iJihwXQUOa2z/bNkDlTiZ9x4QKvbtL/AVY=
=4qpw
-----END PGP SIGNATURE-----

--Wtrm9ATX0sn6fFKv--


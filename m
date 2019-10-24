Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4D6CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:08:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 810B220659
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 810B220659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNcqP-0005e2-0m
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 09:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iNcJB-0000Nc-Qg
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iNcJ9-0005W2-TO
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:33:41 -0400
Received: from 20.mo6.mail-out.ovh.net ([178.32.124.17]:50442)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iNcJ9-0005VP-IK
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:33:39 -0400
Received: from player763.ha.ovh.net (unknown [10.108.57.50])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 064CF1E724C
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 14:33:36 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player763.ha.ovh.net (Postfix) with ESMTPSA id 8E740B5B5BAD;
 Thu, 24 Oct 2019 12:33:28 +0000 (UTC)
Date: Thu, 24 Oct 2019 14:33:27 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 6/6] xive: Don't use CPU_FOREACH() to perform CAM line
 matching
Message-ID: <20191024143327.2fa79b2a@bahia.lan>
In-Reply-To: <20191024030536.GW6439@umbus.fritz.box>
References: <157184231371.3053790.17713393349394736594.stgit@bahia.lan>
 <157184234731.3053790.18369348907304339634.stgit@bahia.lan>
 <20191024030536.GW6439@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vgo7xe6/.SjY1q144Tf1F=p";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 11105876683048393190
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrledugdehvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.32.124.17
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
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/vgo7xe6/.SjY1q144Tf1F=p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Oct 2019 14:05:36 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Oct 23, 2019 at 04:52:27PM +0200, Greg Kurz wrote:
> > Now that the TCTX objects are children of the XIVE router, stop
> > using CPU_FOREACH() when looking for a matching VCPU target.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/intc/xive.c |  100 +++++++++++++++++++++++++++++++++++-------------=
--------
> >  1 file changed, 62 insertions(+), 38 deletions(-)
> >=20
> > diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> > index 40ce43152456..ec5e7d0ee39a 100644
> > --- a/hw/intc/xive.c
> > +++ b/hw/intc/xive.c
> > @@ -1403,55 +1403,79 @@ typedef struct XiveTCTXMatch {
> >      uint8_t ring;
> >  } XiveTCTXMatch;
> > =20
> > -static bool xive_presenter_match(XiveRouter *xrtr, uint8_t format,
> > -                                 uint8_t nvt_blk, uint32_t nvt_idx,
> > -                                 bool cam_ignore, uint8_t priority,
> > -                                 uint32_t logic_serv, XiveTCTXMatch *m=
atch)
> > +typedef struct XivePresenterMatch {
> > +    uint8_t format;
> > +    uint8_t nvt_blk;
> > +    uint32_t nvt_idx;
> > +    bool cam_ignore;
> > +    uint8_t priority;
> > +    uint32_t logic_serv;
> > +    XiveTCTXMatch *match;
> > +    int count;
> > +} XivePresenterMatch;
> > +
> > +static int do_xive_presenter_match(Object *child, void *opaque)
> >  {
> > -    CPUState *cs;
> > +    XiveTCTX *tctx =3D XIVE_TCTX(child);
> > +    XivePresenterMatch *xpm =3D opaque;
> > +    int ring;
> > =20
> >      /*
> >       * TODO (PowerNV): handle chip_id overwrite of block field for
> >       * hardwired CAM compares
> >       */
> > =20
> > -    CPU_FOREACH(cs) {
> > -        XiveTCTX *tctx =3D xive_router_get_tctx(xrtr, cs);
> > -        int ring;
> > +    /*
> > +     * HW checks that the CPU is enabled in the Physical Thread
> > +     * Enable Register (PTER).
> > +     */
> > =20
> > -        /*
> > -         * Skip partially initialized vCPUs. This can happen when
> > -         * vCPUs are hotplugged.
> > -         */
> > -        if (!tctx) {
> > -            continue;
> > +    /*
> > +     * Check the thread context CAM lines and record matches. We
> > +     * will handle CPU exception delivery later
> > +     */
> > +    ring =3D xive_presenter_tctx_match(tctx, xpm->format, xpm->nvt_blk,
> > +                                     xpm->nvt_idx, xpm->cam_ignore,
> > +                                     xpm->logic_serv);
> > +
> > +    /*
> > +     * Save the context and follow on to catch duplicates, that we
> > +     * don't support yet.
> > +     */
> > +    if (ring !=3D -1) {
> > +        if (xpm->match->tctx) {
> > +            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: already found a thre=
ad "
> > +                          "context NVT %x/%x\n", xpm->nvt_blk, xpm->nv=
t_idx);
> > +            return -1;
> >          }
> > =20
> > -        /*
> > -         * HW checks that the CPU is enabled in the Physical Thread
> > -         * Enable Register (PTER).
> > -         */
> > +        xpm->match->ring =3D ring;
> > +        xpm->match->tctx =3D tctx;
> > +        xpm->count++;
> > +    }
> > =20
> > -        /*
> > -         * Check the thread context CAM lines and record matches. We
> > -         * will handle CPU exception delivery later
> > -         */
> > -        ring =3D xive_presenter_tctx_match(tctx, format, nvt_blk, nvt_=
idx,
> > -                                         cam_ignore, logic_serv);
> > -        /*
> > -         * Save the context and follow on to catch duplicates, that we
> > -         * don't support yet.
> > -         */
> > -        if (ring !=3D -1) {
> > -            if (match->tctx) {
> > -                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: already found a =
thread "
> > -                              "context NVT %x/%x\n", nvt_blk, nvt_idx);
> > -                return false;
> > -            }
> > -
> > -            match->ring =3D ring;
> > -            match->tctx =3D tctx;
> > -        }
> > +    return 0;
> > +}
> > +
> > +static bool xive_presenter_match(XiveRouter *xrtr, uint8_t format,
> > +                                 uint8_t nvt_blk, uint32_t nvt_idx,
> > +                                 bool cam_ignore, uint8_t priority,
> > +                                 uint32_t logic_serv, XiveTCTXMatch *m=
atch)
> > +{
> > +    XivePresenterMatch xpm =3D {
> > +        .format     =3D format,
> > +        .nvt_blk    =3D nvt_blk,
> > +        .nvt_idx    =3D nvt_idx,
> > +        .cam_ignore =3D cam_ignore,
> > +        .priority   =3D priority,
> > +        .logic_serv =3D logic_serv,
> > +        .match      =3D match,
> > +        .count      =3D 0,
> > +    };
> > +
> > +    if (object_child_foreach_type(OBJECT(xrtr), TYPE_XIVE_TCTX,
> > +                                  do_xive_presenter_match, &xpm) < 0) {
> > +        return false;
>=20
> Hrm... xive_presenter_match() is potentially a pretty hot path, it's
> called on every interrupt delivery - especially since we don't have a
> usable KVM irq chip for Boston machines.  I'm concerned that using
> something as heavyweight as object_child_foreach() might have a
> noticeable performance impact.
>=20

Well, the XiveRouter _only_ has 3 extra children (XiveSource,
XiveENDSource and TIMA) but indeed object_child_foreach() might
cost more than QTAILQ_FOREACH_RCU(). A possible option could be
to have a QTAILQ of presenters under the machine for sPAPR or
under the chip for PNV, in order to avoid the need to filter out
VCPUs that we don't want to consider, ie. partly realized with
sPAPR and from another chip with PNV.

But as said in another mail, the safer for 4.2 is probably to
fix the CPU_FOREACH() users, which is already the case here for
sPAPR.

> >      }
> > =20
> >      if (!match->tctx) {
> >=20
>=20


--Sig_/vgo7xe6/.SjY1q144Tf1F=p
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl2xmhcACgkQcdTV5YIv
c9ZpgRAAu+h/yWoVTNuecFXCkQwbTri9kOfhsvb+5gyFTG2Ds3dL/NEMQrdd98cP
sFWDGVpqG2+9JginWN68Gg0aO3XOhV/jziyFZFXGZl7mg3nl4zm8O68mYL365TeN
AbmnRAHnb1/+4s0Q8TxsSKi7MRXxTWEV0x7rNmi+Vey6V3alEPsEbn8h0X8pdXfk
L4kdzBXq0iilB5pVRcKuRDrjtkmNWhToN986hUs7T3yQ44fP8sjbpNyAOJHkxLNY
7rJBvRzFvUK/RzctheytKE1yuxhlncop9t+HgEr0NAkVUrPKkV3vcYH5JVG8FEPQ
Bns/IyCxA3fp7bzB7Sw90pfw7FhxHbl1aKIf589E1PbrElJrnzwS8+MxX20Z3u9x
F5kRvcXe+vNuyuWY3+OeFrJ8B8FXHfX22zBs+948r8D228XEHMCxteZdhQHFRzFa
RjieiN/M2HUS42qpY8mz9Mi/XezL8ybN6uHmaniXKKwVB0dNAwJ5J+Vk/nkZ0Njp
RTyxjGbk13fzbktESscIEAC8ptyJwzcC12Iv6m0ZFhaAZiScf9dKV1E2F+BOEBRl
leM69X+evwWFhbEXzsEBvh67OPtb/BIP6yd5/gi+o+YeSkJWOOiAmjVT9MTbwug1
wcBHGQsVPyB57At2V43Xfr/vs7Mkgbj3WIQpSdVzN+cQcFhS8vM=
=brJr
-----END PGP SIGNATURE-----

--Sig_/vgo7xe6/.SjY1q144Tf1F=p--


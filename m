Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7ADEC43215
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 04:29:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77FD422460
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 04:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BYGmKxs4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FD422460
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXHcf-0001EO-FZ
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 23:29:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iXHb7-0000M7-Vy
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 23:28:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iXHb6-0007QB-0x
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 23:28:09 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:40313 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1iXHb5-0007I9-4m
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 23:28:07 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47HqS21Nf8z9sPc; Wed, 20 Nov 2019 15:28:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574224082;
 bh=LaH01KzXUG8osJf+FKzF3QRxkjm9zL46s4Srl7HjQoc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BYGmKxs4qkqt04SO11Mw73RB3d6ihXaPKcpXsZPh/faswGUo+hmDImBaC88Xj+YYa
 f444AvqgTlEAzl5xy19ZvJcf1FmSyqhaZt1P38yLL5htzuzKYfodPHRBN+0f4bzdkf
 8Dgo0Vk7dN/01FZy3uJ0KFIOqJbICyDSwSSF7Mxo=
Date: Wed, 20 Nov 2019 15:27:52 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [RFC v2 09/22] vfio/pci: add iommu_context notifier for pasid
 alloc/free
Message-ID: <20191120042752.GF5582@umbus.fritz.box>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
 <1571920483-3382-10-git-send-email-yi.l.liu@intel.com>
 <20191029121544.GS3552@umbus.metropole.lan>
 <A2975661238FB949B60364EF0F2C25743A0EF2CE@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hNrJFWHEm0TKGkuH"
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A0EF2CE@SHSMSX104.ccr.corp.intel.com>
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
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--hNrJFWHEm0TKGkuH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2019 at 12:14:50PM +0000, Liu, Yi L wrote:
> > From: David Gibson [mailto:david@gibson.dropbear.id.au]
> > Sent: Tuesday, October 29, 2019 8:16 PM
> > To: Liu, Yi L <yi.l.liu@intel.com>
> > Subject: Re: [RFC v2 09/22] vfio/pci: add iommu_context notifier for pa=
sid alloc/free
> >=20
> > On Thu, Oct 24, 2019 at 08:34:30AM -0400, Liu Yi L wrote:
> > > This patch adds pasid alloc/free notifiers for vfio-pci. It is
> > > supposed to be fired by vIOMMU. VFIO then sends PASID allocation
> > > or free request to host.
> > >
> > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Cc: Peter Xu <peterx@redhat.com>
> > > Cc: Eric Auger <eric.auger@redhat.com>
> > > Cc: Yi Sun <yi.y.sun@linux.intel.com>
> > > Cc: David Gibson <david@gibson.dropbear.id.au>
> > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > ---
> > >  hw/vfio/common.c         |  9 ++++++
> > >  hw/vfio/pci.c            | 81
> > ++++++++++++++++++++++++++++++++++++++++++++++++
> > >  include/hw/iommu/iommu.h | 15 +++++++++
> > >  3 files changed, 105 insertions(+)
> > >
> > > diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > > index d418527..e6ad21c 100644
> > > --- a/hw/vfio/common.c
> > > +++ b/hw/vfio/common.c
> > > @@ -1436,6 +1436,7 @@ static void vfio_disconnect_container(VFIOGroup
> > *group)
> > >      if (QLIST_EMPTY(&container->group_list)) {
> > >          VFIOAddressSpace *space =3D container->space;
> > >          VFIOGuestIOMMU *giommu, *tmp;
> > > +        VFIOIOMMUContext *giommu_ctx, *ctx;
> > >
> > >          QLIST_REMOVE(container, next);
> > >
> > > @@ -1446,6 +1447,14 @@ static void vfio_disconnect_container(VFIOGroup
> > *group)
> > >              g_free(giommu);
> > >          }
> > >
> > > +        QLIST_FOREACH_SAFE(giommu_ctx, &container->iommu_ctx_list,
> > > +                                                   iommu_ctx_next, c=
tx) {
> > > +            iommu_ctx_notifier_unregister(giommu_ctx->iommu_ctx,
> > > +                                                      &giommu_ctx->n=
);
> > > +            QLIST_REMOVE(giommu_ctx, iommu_ctx_next);
> > > +            g_free(giommu_ctx);
> > > +        }
> > > +
> > >          trace_vfio_disconnect_container(container->fd);
> > >          close(container->fd);
> > >          g_free(container);
> > > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > > index 12fac39..8721ff6 100644
> > > --- a/hw/vfio/pci.c
> > > +++ b/hw/vfio/pci.c
> > > @@ -2699,11 +2699,80 @@ static void
> > vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
> > >      vdev->req_enabled =3D false;
> > >  }
> > >
> > > +static void vfio_register_iommu_ctx_notifier(VFIOPCIDevice *vdev,
> > > +                                             IOMMUContext *iommu_ctx,
> > > +                                             IOMMUCTXNotifyFn fn,
> > > +                                             IOMMUCTXEvent event)
> > > +{
> > > +    VFIOContainer *container =3D vdev->vbasedev.group->container;
> > > +    VFIOIOMMUContext *giommu_ctx;
> > > +
> > > +    giommu_ctx =3D g_malloc0(sizeof(*giommu_ctx));
> > > +    giommu_ctx->container =3D container;
> > > +    giommu_ctx->iommu_ctx =3D iommu_ctx;
> > > +    QLIST_INSERT_HEAD(&container->iommu_ctx_list,
> > > +                      giommu_ctx,
> > > +                      iommu_ctx_next);
> > > +    iommu_ctx_notifier_register(iommu_ctx,
> > > +                                &giommu_ctx->n,
> > > +                                fn,
> > > +                                event);
> > > +}
> > > +
> > > +static void vfio_iommu_pasid_alloc_notify(IOMMUCTXNotifier *n,
> > > +                                          IOMMUCTXEventData *event_d=
ata)
> > > +{
> > > +    VFIOIOMMUContext *giommu_ctx =3D container_of(n, VFIOIOMMUContex=
t, n);
> > > +    VFIOContainer *container =3D giommu_ctx->container;
> > > +    IOMMUCTXPASIDReqDesc *pasid_req =3D
> > > +                              (IOMMUCTXPASIDReqDesc *) event_data->d=
ata;
> > > +    struct vfio_iommu_type1_pasid_request req;
> > > +    unsigned long argsz;
> > > +    int pasid;
> > > +
> > > +    argsz =3D sizeof(req);
> > > +    req.argsz =3D argsz;
> > > +    req.flag =3D VFIO_IOMMU_PASID_ALLOC;
> > > +    req.min_pasid =3D pasid_req->min_pasid;
> > > +    req.max_pasid =3D pasid_req->max_pasid;
> > > +
> > > +    pasid =3D ioctl(container->fd, VFIO_IOMMU_PASID_REQUEST, &req);
> > > +    if (pasid < 0) {
> > > +        error_report("%s: %d, alloc failed", __func__, -errno);
> > > +    }
> > > +    pasid_req->alloc_result =3D pasid;
> >=20
> > Altering the event data from the notifier doesn't make sense.  By
> > definition there can be multiple notifiers on the chain, so in that
> > case which one is responsible for updating the writable field?
>=20
> I guess you mean multiple pasid_alloc nofitiers. right?
>=20
> It works for VT-d now, as Intel vIOMMU maintains the IOMMUContext
> per-bdf. And there will be only 1 pasid_alloc notifier in the chain. But,=
 I
> agree it is not good if other module just share an IOMMUConext across
> devices. Definitely, it would have multiple pasid_alloc notifiers.

Right.

> How about enforcing IOMMUContext layer to only invoke one successful
> pasid_alloc/free notifier if PASID_ALLOC/FREE event comes? pasid
> alloc/free are really special as it requires feedback. And a potential
> benefit is that the pasid_alloc/free will not be affected by hot plug
> scenario. There will be always a notifier to work for pasid_alloc/free
> work unless all passthru devices are hot plugged. How do you think? Or
> if any other idea?

Hrm, that still doesn't seem right to me.  I don't think a notifier is
really the right mechanism for something that needs to return values.
This seems like something where you need to find a _single_
responsible object and call a method / callback on that specifically.

But it seems to me there's a more fundamental problem here.  AIUI the
idea is that a single IOMMUContext could hold multiple devices.  But
if the devices are responsible for assigning their own pasid values
(by passing that decisionon to the host through vfio) then that really
can't work.

I'm assuming it's impossible from the hardware side to virtualize the
pasids (so that we could assign them from qemu without host
intervention).

If so, then the pasid allocation really has to be a Context level, not
device level operation.  We'd have to wire the VFIO backend up to the
context itself, not a device... I'm not immediately sure how to do
that, though.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hNrJFWHEm0TKGkuH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3UwMEACgkQbDjKyiDZ
s5KZsA//XoelIlgONN7f19PheYAfU+DR8erhYyZtmWqzjeD9DmyWMXY+R2IRUWFd
Pm8XaGqVAgL030DECHdv8LubB/qXT9+6Vj1mgMYE5jsAds/+UpVmtTZyKyKBKJkx
pU6TwW9nzdOrHoz1tWF5RNbrLV850F+qVIHEuuEeB8DHunxf4iNos9hSGQ3eisZ1
cNxWzmB64CknY0TuVBTvUm9oe0/UXIFCdx+Tvy/hHfKFXV+M6b6YisYfR4yIKmyo
UUV9jJePXgSv1j4/94KnUxGgvu7XVr+bFccb2jsA4qaHDV3QK+QB6SymdrUJIF7Y
9u/R8Ju6tE4joENQZh4/XhiZs2rR9DtboBdBFryeASy7UN3Exw1lHQiaC0bGgGCY
q4nmM3Oj2kpjEXO1SHVG/pQv4G5U3uq8XPfMHSdTObLwwnehQlLWgk3ZQlpG0H44
NI3xhQnCsHoiUmXbI7IKxEqdJ4wjT/KN0axZIz+Gz8tZXTF6y1vtNg47ow75+ZNF
6KzwGB4EVkqKTp5kTNFPg27bXSXPbv9Pyc8+J0sQnhUL/0PfsHxaUvf1dPD3c8Iu
4sBh4siqZ1wlBtOdjyynehUUTIBw3/snScdKZ2YTR8YrSfLJWcJaoX0Tm32yuy75
XPfPvQyoRs8U+gYRbkqqns+YTprs6Uk89e/us17fbdV+AR7Oew8=
=5vxW
-----END PGP SIGNATURE-----

--hNrJFWHEm0TKGkuH--


Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D92FC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 07:38:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 873942080C
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 07:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 873942080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMnjq-0001uy-IO
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 03:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kMnj3-0001Ub-VP
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 03:37:33 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:54191)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kMnj1-0007RP-Kd
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 03:37:33 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.177])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 23B626622ABC;
 Mon, 28 Sep 2020 09:37:20 +0200 (CEST)
Received: from kaod.org (37.59.142.101) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Mon, 28 Sep
 2020 09:37:20 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G00427dca21c-b90e-48d9-8b03-9c1c3f51c91b,
 F88D0AEEDB05633BAD79021379F5935115469930) smtp.auth=groug@kaod.org
Date: Mon, 28 Sep 2020 09:37:18 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] vhost: Ignore vrings in dirty log when using a vIOMMU
Message-ID: <20200928093718.334774b2@bahia.lan>
In-Reply-To: <20200928062343.GA501872@yekko.fritz.box>
References: <160105498386.68108.2145229309875282336.stgit@bahia.lan>
 <20200928062343.GA501872@yekko.fritz.box>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Q2ENVXG=DH=TNy_UxOJ.mNZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG1EX2.mxp5.local (172.16.2.2) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 54e931f7-a5c3-4fc7-9ef9-b6f6da31a791
X-Ovh-Tracer-Id: 10569948327365089699
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrvdehgdduvdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtihesghdtreerredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepkefffeeuuefhveeutddtudeujedvfffhgfdvteeuudfhvdeggfdvieeugfekheeunecuffhomhgrihhnpehrvgguhhgrthdrtghomhenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepjhgrshhofigrnhhgsehrvgguhhgrthdrtghomh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:37:21
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.462, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <laurent@vivier.eu>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/Q2ENVXG=DH=TNy_UxOJ.mNZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Sep 2020 16:23:43 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Sep 25, 2020 at 07:29:43PM +0200, Greg Kurz wrote:
> > When a vIOMMU is present, any address comming from the guest is an IO
> > virtual address, including those of the vrings. The backend's accesses
> > to the vrings happen through vIOMMU translation : the backend hence
> > only logs the final guest physical address, not the IO virtual one.
> > It thus doesn't make sense to make room for the vring addresses in the
> > dirty log in this case.
> >=20
> > This fixes a crash of the source when migrating a guest using in-kernel
> > vhost-net and iommu_platform=3Don on POWER, because DMA regions are put
> > at very high addresses and the resulting log size is likely to cause
> > g_malloc0() to abort.
> >=20
> > BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1879349
> > Signed-off-by: Greg Kurz <groug@kaod.org>
>=20
> I'm a little confused as to what's going on here.  Obviously
> allocating dirty bitmaps in IOVA space doesn't make much sense.
> But.. in all cases isn't the ring ending up in guest memory, whether
> translated or not.  So why do specific addresses of the ring make a
> difference in *any* case.
>=20

I admit I'm a bit surprised as well... I can't think of a scenario
where the address of the used ring would be higher than the guest
memory... Maybe MST can shed some light here ?

> > ---
> >  hw/virtio/vhost.c |   38 ++++++++++++++++++++++++--------------
> >  1 file changed, 24 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index 1a1384e7a642..0b83d6b8e65e 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -106,6 +106,20 @@ static void vhost_dev_sync_region(struct vhost_dev=
 *dev,
> >      }
> >  }
> > =20
> > +static int vhost_dev_has_iommu(struct vhost_dev *dev)
> > +{
> > +    VirtIODevice *vdev =3D dev->vdev;
> > +
> > +    /*
> > +     * For vhost, VIRTIO_F_IOMMU_PLATFORM means the backend support
> > +     * incremental memory mapping API via IOTLB API. For platform that
> > +     * does not have IOMMU, there's no need to enable this feature
> > +     * which may cause unnecessary IOTLB miss/update trnasactions.
> > +     */
> > +    return vdev->dma_as !=3D &address_space_memory &&
> > +           virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
> > +}
> > +
> >  static int vhost_sync_dirty_bitmap(struct vhost_dev *dev,
> >                                     MemoryRegionSection *section,
> >                                     hwaddr first,
> > @@ -130,6 +144,11 @@ static int vhost_sync_dirty_bitmap(struct vhost_de=
v *dev,
> >                                range_get_last(reg->guest_phys_addr,
> >                                               reg->memory_size));
> >      }
> > +
> > +    if (vhost_dev_has_iommu(dev)) {
> > +        return 0;
> > +    }
> > +
> >      for (i =3D 0; i < dev->nvqs; ++i) {
> >          struct vhost_virtqueue *vq =3D dev->vqs + i;
> > =20
> > @@ -172,6 +191,11 @@ static uint64_t vhost_get_log_size(struct vhost_de=
v *dev)
> >                                         reg->memory_size);
> >          log_size =3D MAX(log_size, last / VHOST_LOG_CHUNK + 1);
> >      }
> > +
> > +    if (vhost_dev_has_iommu(dev)) {
> > +        return log_size;
> > +    }
> > +
> >      for (i =3D 0; i < dev->nvqs; ++i) {
> >          struct vhost_virtqueue *vq =3D dev->vqs + i;
> > =20
> > @@ -287,20 +311,6 @@ static inline void vhost_dev_log_resize(struct vho=
st_dev *dev, uint64_t size)
> >      dev->log_size =3D size;
> >  }
> > =20
> > -static int vhost_dev_has_iommu(struct vhost_dev *dev)
> > -{
> > -    VirtIODevice *vdev =3D dev->vdev;
> > -
> > -    /*
> > -     * For vhost, VIRTIO_F_IOMMU_PLATFORM means the backend support
> > -     * incremental memory mapping API via IOTLB API. For platform that
> > -     * does not have IOMMU, there's no need to enable this feature
> > -     * which may cause unnecessary IOTLB miss/update trnasactions.
> > -     */
> > -    return vdev->dma_as !=3D &address_space_memory &&
> > -           virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
> > -}
> > -
> >  static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
> >                                hwaddr *plen, bool is_write)
> >  {
> >=20
> >=20
>=20


--Sig_/Q2ENVXG=DH=TNy_UxOJ.mNZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl9xkq4ACgkQcdTV5YIv
c9ZNTxAAiD5b/POL55ypPdlSG5MHYdVqQmKWtNUVjIUOwRgLMS1NHfzLPRfZ9TVn
3qMISG1/Pa4RmEHKMqnQhXE+rCfuvCGnu2lq/vUlQG3YKqbsllMjOSmIYpY4VN7z
R7yK8K+mkpMEG53hgvLsERZ/gF2YmwJNYQzjLqeLcBlcZfJFpNkAOaSgO0zj4VKv
5Z46KCC6EK93KGmTeKppKiqbtyC26gba8Et5dE/A6cck+fbKLgXA2WLkABV4UDlJ
GoRkN/hFf5bxqEwtEIow/LIdGmlwHp4fx1JZ9kQmC+QJweTwnw7Xji2mQHLVc9jd
/pHivrq9JHQt7Z8LXyeVCfH8qxE72+EV4Dv2/ipBa33gjqnkuW4R15cY+FV0smib
G/y6c9KxswzZXgOm4S7OpQlwXhp4QB/SvQyas4IGvnjFpqR//1ocZxetqes/zFJA
RFFjzUFMq6OB9jwN71IiYb+h4h6H2L8U/1RWh0usWiPmUx36NnsAqMcgUVNL0+4I
1DZh2+Kb40tJijGk3lrZ2YbbDBdJx8mI11SkTRAw2BjC7ipwAJtMpBm2lCShBvkv
o6dn3dkfBQb3buCHrxuTG9CrWeyNupcDSMmmgvlkv407CJvg3LYL7cDdjiuNwuRO
jhg6lv6+ynulKI9xzJR0wTxQ2oB7gPHjM3dBzPAhtiwMgpbHUQo=
=H4Yx
-----END PGP SIGNATURE-----

--Sig_/Q2ENVXG=DH=TNy_UxOJ.mNZ--


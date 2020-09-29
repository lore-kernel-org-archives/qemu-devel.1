Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAAAC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 16:52:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3AFB208B8
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 16:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3AFB208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNIr8-0004G5-6v
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 12:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNImR-0003Mr-17; Tue, 29 Sep 2020 12:47:07 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:41917)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNImN-0006Yr-F1; Tue, 29 Sep 2020 12:47:06 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 0DAE6412;
 Tue, 29 Sep 2020 12:46:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 29 Sep 2020 12:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=hDAMa3Mm1h3cu6CcxY5rx6n3wrM
 hWUc4o/XpKzecEDI=; b=vi8/wEtDhXx7UDmGiVBzdDSasML8kXMRQ0CtsDjnDug
 9XAuWM8V5aHFYWXXqUAk8w59MbkirS7qMAPuK8OFJYy60s9h6q5VyAEP3iXWBncQ
 Ih4oPlWIjBj785Y9tcTZOB6pGXBKqapNQJ0Z7BWqKuHW2QLMN2eurO9qKETUPlhN
 83jWyzfFAq1HYcZedalv9fm5Df1aYn+qWnKBJVHR9o+GaPqis4Q1mP7HTbh3iBpg
 5YHnrN3f52+/JppkDPsOqwN+cMsuuQgNoglYSr9l0Xp6GJ70dE//kaFBjsww+JjG
 EPCz1+ERmlM8vy7RA+AIj3eL7JCnoW3JXdWxZOp1YhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=hDAMa3
 Mm1h3cu6CcxY5rx6n3wrMhWUc4o/XpKzecEDI=; b=d3PmW3ckCwC+zPCKo6aFAU
 QhCRFx/mDj78dhC/Iq++7v4E/ZbYgsQjbpeC1K53ZoFkDP34a9LetU0efuEMBkXW
 40sCxke/6U0s5kLYEVV+W5ljkGiyllL5vsfQcYse6FglaHrldpSC47U+C/eCfMbb
 lRqyxo2ulacx5+OfubU0m7HP/Dvw8NiOH2anjbgkv3UZV1KdEvNCkBNuS+8wi+ao
 4RjBCRr4rZqcPNluXilnnLdaqWaNvkF0w6vQOxadgYGdRqnkf5r/fYNTfmLV9B4z
 dGY6DabU06mc4I2GSlV9fGQSNNKgKiVbADb2mb/vmve987edfGHhT6ZRPXB2JDgA
 ==
X-ME-Sender: <xms:-GRzXx2K06r9Az6x81oBGS3PPdzmu0u_72II0wgicGLeDiZqypqKqQ>
 <xme:-GRzX4H42YoaQ3scWTH5awdbnHGgZGGskDfWk9FZ6qvxZ7KGk2-M-U5eBwqwPSmSw
 9FmHSdlFdnk4CL36ts>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdekgddutdehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:-GRzXx4NX-BoLX36UBJM2ubPDNTSHjdie-bhekW-U_GZwKwc16u0Vw>
 <xmx:-GRzX-31zE4WpKMROnLMgrbV5CLX1ERX5dQ_6a3dOSaihG2tiBGv0Q>
 <xmx:-GRzX0Fo9yp6esbBeXH8pzROuhkwu1CGedsYDwx1lz5tDZKKSD6Kyw>
 <xmx:-mRzX8-MfAV9ZZZGAJAhyVxtCYgcTNvZhylL1EbYPUaSvx4JzuA-Q2g5IXEhaSY6>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 186F53280060;
 Tue, 29 Sep 2020 12:46:46 -0400 (EDT)
Date: Tue, 29 Sep 2020 18:46:45 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
Subject: Re: [PATCH v5 13/14] hw/block/nvme: Use zone metadata file for
 persistence
Message-ID: <20200929164645.GB286786@apples.localdomain>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
 <20200928023528.15260-14-dmitry.fomichev@wdc.com>
 <20200928075140.GC1967@apples.localdomain>
 <MN2PR04MB59511B0C4F1DB91B38085DB0E1320@MN2PR04MB5951.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
In-Reply-To: <MN2PR04MB59511B0C4F1DB91B38085DB0E1320@MN2PR04MB5951.namprd04.prod.outlook.com>
Received-SPF: pass client-ip=64.147.123.17; envelope-from=its@irrelevant.dk;
 helo=wnew3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 12:36:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Niklas Cassel <Niklas.Cassel@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 29 15:43, Dmitry Fomichev wrote:
>=20
>=20
> > -----Original Message-----
> > From: Klaus Jensen <its@irrelevant.dk>
> > Sent: Monday, September 28, 2020 3:52 AM
> > To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
> > Cc: Keith Busch <kbusch@kernel.org>; Klaus Jensen
> > <k.jensen@samsung.com>; Kevin Wolf <kwolf@redhat.com>; Philippe
> > Mathieu-Daud=C3=A9 <philmd@redhat.com>; Maxim Levitsky
> > <mlevitsk@redhat.com>; Fam Zheng <fam@euphon.net>; Niklas Cassel
> > <Niklas.Cassel@wdc.com>; Damien Le Moal <Damien.LeMoal@wdc.com>;
> > qemu-block@nongnu.org; qemu-devel@nongnu.org; Alistair Francis
> > <Alistair.Francis@wdc.com>; Matias Bjorling <Matias.Bjorling@wdc.com>
> > Subject: Re: [PATCH v5 13/14] hw/block/nvme: Use zone metadata file for
> > persistence
> >=20
> > On Sep 28 11:35, Dmitry Fomichev wrote:
> > > A ZNS drive that is emulated by this module is currently initialized
> > > with all zones Empty upon startup. However, actual ZNS SSDs save the
> > > state and condition of all zones in their internal NVRAM in the event
> > > of power loss. When such a drive is powered up again, it closes or
> > > finishes all zones that were open at the moment of shutdown. Besides
> > > that, the write pointer position as well as the state and condition
> > > of all zones is preserved across power-downs.
> > >
> > > This commit adds the capability to have a persistent zone metadata
> > > to the device. The new optional module property, "zone_file",
> > > is introduced. If added to the command line, this property specifies
> > > the name of the file that stores the zone metadata. If "zone_file" is
> > > omitted, the device will be initialized with all zones empty, the same
> > > as before.
> > >
> > > If zone metadata is configured to be persistent, then zone descriptor
> > > extensions also persist across controller shutdowns.
> > >
> > > Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> > > ---
> > >  hw/block/nvme-ns.c    | 341
> > ++++++++++++++++++++++++++++++++++++++++--
> > >  hw/block/nvme-ns.h    |  33 ++++
> > >  hw/block/nvme.c       |   2 +
> > >  hw/block/trace-events |   1 +
> > >  4 files changed, 362 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
> > > index 47751f2d54..a94021da81 100644
> > > --- a/hw/block/nvme-ns.c
> > > +++ b/hw/block/nvme-ns.c
> > > @@ -293,12 +421,180 @@ static void
> > nvme_init_zone_meta(NvmeNamespace *ns)
> > >              i--;
> > >          }
> > >      }
> > > +
> > > +    if (ns->params.zone_file) {
> > > +        nvme_set_zone_meta_dirty(ns);
> > > +    }
> > > +}
> > > +
> > > +static int nvme_open_zone_file(NvmeNamespace *ns, bool *init_meta,
> > > +                               Error **errp)
> > > +{
> > > +    Object *file_be;
> > > +    HostMemoryBackend *fb;
> > > +    struct stat statbuf;
> > > +    int ret;
> > > +
> > > +    ret =3D stat(ns->params.zone_file, &statbuf);
> > > +    if (ret && errno =3D=3D ENOENT) {
> > > +        *init_meta =3D true;
> > > +    } else if (!S_ISREG(statbuf.st_mode)) {
> > > +        error_setg(errp, "\"%s\" is not a regular file",
> > > +                   ns->params.zone_file);
> > > +        return -1;
> > > +    }
> > > +
> > > +    file_be =3D object_new(TYPE_MEMORY_BACKEND_FILE);
> > > +    object_property_set_str(file_be, "mem-path", ns->params.zone_fil=
e,
> > > +                            &error_abort);
> > > +    object_property_set_int(file_be, "size", ns->meta_size, &error_a=
bort);
> > > +    object_property_set_bool(file_be, "share", true, &error_abort);
> > > +    object_property_set_bool(file_be, "discard-data", false, &error_=
abort);
> > > +    if (!user_creatable_complete(USER_CREATABLE(file_be), errp)) {
> > > +        object_unref(file_be);
> > > +        return -1;
> > > +    }
> > > +    object_property_add_child(OBJECT(ns), "_fb", file_be);
> > > +    object_unref(file_be);
> > > +
> > > +    fb =3D MEMORY_BACKEND(file_be);
> > > +    ns->zone_mr =3D host_memory_backend_get_memory(fb);
> > > +
> > > +    return 0;
> > > +}
> > > +
> > > +static int nvme_map_zone_file(NvmeNamespace *ns, bool *init_meta)
> > > +{
> > > +    ns->zone_meta =3D (void *)memory_region_get_ram_ptr(ns->zone_mr);
> >=20
> > I forgot that the HostMemoryBackend doesn't magically make the memory
> > available to the device, so of course this is still needed.
> >=20
> > Anyway.
> >=20
> > No reason for me to keep complaining about this. I do not like it, I
> > will not ACK it and I think I made my reasons pretty clear.
>=20
> So, memory_region_msync() is ok, but memory_region_get_ram_ptr() is not??
> This is the same API! You are really splitting hairs here to suit your ag=
enda.
> Moving goal posts again....
>=20
> The "I do not like it" part is priceless. It is great that we have mail a=
rchives available.
>=20

If you read my review again, its pretty clear that I am calling out the
abstraction. I was clear that if it *really* had to be mmap based, then
it should use hostmem. Sorry for moving your patchset forward by
suggesting an improvement.

But again, I also made it pretty clear that I did not agree with the
abstraction. And that I very much disliked that it was non-portable. And
had endiannes issues. I made it SUPER clear that that was why I "did not
like it".

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9zZPMACgkQTeGvMW1P
DenNIgf/fDQHE5b2p/6/07ZmfmmP/QSISNkWQR9SJpVKMYO3XXka8GLmLT3apvvq
L295ZT2a+f06cZnpEYcCoCoqQyCez+c1pZgSuXAJRjMcZ40PVUtNe7LWaVVAx7ea
Ep7uL9ND86Bx0YSRe3tIF1VHlawt2xdBhb7rrVxplJm624H0W/AjJ/vs3kkLerzD
8Cnzxzrz+kHP0Y0EK3pw8n/v8qQur60ZnLG81maivN+aMu3qrRtT+0Vou2QdYaDj
zaisYxOWGymenNCskLlgyCYa5iHBSf36LSn9AWuMbKedPT/zYiMftXR8ABTtXL1e
qXOSkvHfI/bEGr1OOm33VLufqmabAA==
=QJC8
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--


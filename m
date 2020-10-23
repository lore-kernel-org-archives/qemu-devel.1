Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDB6C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 05:28:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D62D20882
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 05:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D62D20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVpcz-0007zN-Qe
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 01:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kVpZo-0007Ge-U9; Fri, 23 Oct 2020 01:25:21 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55075)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kVpZl-0001XA-NG; Fri, 23 Oct 2020 01:25:20 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 0B1CC5C00A8;
 Fri, 23 Oct 2020 01:25:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Fri, 23 Oct 2020 01:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=ItKq3YsCOizz20JB//42WIBo1j2
 tTvFEFGMK/NxD544=; b=z/KxKGgtPm1dcNQnTNcvEAxwdVIw6bkNMUHwWltyelW
 GYOCfbDzmzcE04AGMy2YQirr6QAbsVybUvurU9LmxcXl91YQW/Wn6t/YTDTJyOal
 CfIiQtMs+i1nl7Pl0ogYHl05GsyN0KSeCiMbsCoY8tyrNiljI/dSbc9uG3IZNRKW
 /RkyRAoPx1NPNWCU6ObuVjtwymjNd4qvbhyKhtB7+JHnWh1lFX6r+ATyzgST8ODr
 ScUHJPTf0nAH7BKLAj9URVMqY23Kd+G6BrKq6tRDcZW5DqOxar98oK39azVaaDel
 wWMBzcngRgQSOvAla2ard6sGhy7UiqhWRjwnOcM8EoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ItKq3Y
 sCOizz20JB//42WIBo1j2tTvFEFGMK/NxD544=; b=Mc3KOYTmzuwgLdosY7+0i2
 ysARXItskd4TLiScHbHfKTjouEAmIe4U9hlUkw4dNU7BdBzAth40lVYUqm3QrJEB
 rScK+nKqYrYdWH7lytjOuRtlh6NTZFTFHC/85NzUUZdEr5qgaVPiHdhjA85TPvdT
 fmZOF8OxEViTuCSUK9aUceP22LGsckiDSbJPAbG/qyRGAdxtAw+0JRhVFdzrvwC7
 8VTfdR8hfZU5UdxqU38IzubdLaxKjxbidfuVRVT3L97cFCspktC80YA0ulQvbI4B
 NR0YoH43isomD+EXmYI7Ar+AeqB6MS4ZMwJr3mfsV6s6A+nFzROCKO/qag4+1LxQ
 ==
X-ME-Sender: <xms:O2mSX9bETxlzFqJYhwm7YsjPxQOwjUyWGmkS_BZS3ULCtrFG0Re1FQ>
 <xme:O2mSX0YvDcOrQvQ3dfdygs7e9_zdhHergap7YdP3rFDSzejlg191mOs1FvnA06hXK
 7NIN-Khgk3VpktzNjo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeelgdeljecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:O2mSX_9c_iRx67-sePLnKkyDIqRiE8pBN340XG_GUKslm7rsal6zSQ>
 <xmx:O2mSX7oe0mk2ryLdkDVhsv4PZwwdEINfGq7_zeN7lOQVqOovhEGTOw>
 <xmx:O2mSX4r1zbErR4j9yV4QT7pKAxCYOSIsQtKxLOifdD_RzFoJi5lF6g>
 <xmx:PGmSX9BydlxhLz2VB98PUfjxAcAYfP817ibLBxua9XlbZhjjYfTVTQ>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 20F55328005A;
 Fri, 23 Oct 2020 01:25:14 -0400 (EDT)
Date: Fri, 23 Oct 2020 07:25:12 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v5 2/2] hw/block/nvme: add the dataset management command
Message-ID: <20201023052512.GA244769@apples.localdomain>
References: <20201022184959.240505-1-its@irrelevant.dk>
 <20201022184959.240505-3-its@irrelevant.dk>
 <05c41ab7-039f-f327-c6a0-5864430f5ba6@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <05c41ab7-039f-f327-c6a0-5864430f5ba6@redhat.com>
Received-SPF: pass client-ip=66.111.4.28; envelope-from=its@irrelevant.dk;
 helo=out4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:25:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 22 23:02, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Klaus,
>=20

Hi Philippe,

Thanks for your comments!

> On 10/22/20 8:49 PM, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> >=20
> > Add support for the Dataset Management command and the Deallocate
> > attribute. Deallocation results in discards being sent to the underlying
> > block device. Whether of not the blocks are actually deallocated is
> > affected by the same factors as Write Zeroes (see previous commit).
> >=20
> >       format | discard | dsm (512b)  dsm (4kb)  dsm (64kb)
>=20
> Please use B/KiB units which are unambiguous (kb is for kbits)
> (if you queue this yourself, you can fix when applying, no need
> to repost).
>=20

Thanks, I'll change it.

> >      ------------------------------------------------------
> >        qcow2    ignore   n           n          n
> >        qcow2    unmap    n           n          y
> >        raw      ignore   n           n          n
> >        raw      unmap    n           y          y
> >=20
> > Again, a raw format and 4kb LBAs are preferable.
> >=20
> > In order to set the Namespace Preferred Deallocate Granularity and
> > Alignment fields (NPDG and NPDA), choose a sane minimum discard
> > granularity of 4kb. If we are using a passthru device supporting discard
> > at a 512b granularity, user should set the discard_granularity property
>=20
> Ditto.
>=20
> > explicitly. NPDG and NPDA will also account for the cluster_size of the
> > block driver if required (i.e. for QCOW2).
> >=20
> > See NVM Express 1.3d, Section 6.7 ("Dataset Management command").
> >=20
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > ---
> >   hw/block/nvme.h      |   2 +
> >   include/block/nvme.h |   7 ++-
> >   hw/block/nvme-ns.c   |  36 +++++++++++++--
> >   hw/block/nvme.c      | 101 ++++++++++++++++++++++++++++++++++++++++++-
> >   4 files changed, 140 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> > index e080a2318a50..574333caa3f9 100644
> > --- a/hw/block/nvme.h
> > +++ b/hw/block/nvme.h
> > @@ -28,6 +28,7 @@ typedef struct NvmeRequest {
> >       struct NvmeNamespace    *ns;
> >       BlockAIOCB              *aiocb;
> >       uint16_t                status;
> > +    void                    *opaque;
> >       NvmeCqe                 cqe;
> >       NvmeCmd                 cmd;
> >       BlockAcctCookie         acct;
> > @@ -60,6 +61,7 @@ static inline const char *nvme_io_opc_str(uint8_t opc)
> >       case NVME_CMD_WRITE:            return "NVME_NVM_CMD_WRITE";
> >       case NVME_CMD_READ:             return "NVME_NVM_CMD_READ";
> >       case NVME_CMD_WRITE_ZEROES:     return "NVME_NVM_CMD_WRITE_ZEROES=
";
> > +    case NVME_CMD_DSM:              return "NVME_NVM_CMD_DSM";
> >       default:                        return "NVME_NVM_CMD_UNKNOWN";
> >       }
> >   }
> > diff --git a/include/block/nvme.h b/include/block/nvme.h
> > index 966c3bb304bd..e95ff6ca9b37 100644
> > --- a/include/block/nvme.h
> > +++ b/include/block/nvme.h
> > @@ -990,7 +990,12 @@ typedef struct QEMU_PACKED NvmeIdNs {
> >       uint16_t    nabspf;
> >       uint16_t    noiob;
> >       uint8_t     nvmcap[16];
> > -    uint8_t     rsvd64[40];
> > +    uint16_t    npwg;
> > +    uint16_t    npwa;
> > +    uint16_t    npdg;
> > +    uint16_t    npda;
> > +    uint16_t    nows;
> > +    uint8_t     rsvd74[30];
> >       uint8_t     nguid[16];
> >       uint64_t    eui64;
> >       NvmeLBAF    lbaf[16];
>=20
> If you consider "block/nvme.h" shared by 2 different subsystems,
> it is better to add the changes in a separate patch. That way
> the changes can be acked individually.
>=20

Sure. Some other stuff here warrents a v6 I think, so I will split it.

> > diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
> > index f1cc734c60f5..840651db7256 100644
> > --- a/hw/block/nvme-ns.c
> > +++ b/hw/block/nvme-ns.c
> > @@ -28,10 +28,14 @@
> >   #include "nvme.h"
> >   #include "nvme-ns.h"
> > -static void nvme_ns_init(NvmeNamespace *ns)
> > +#define MIN_DISCARD_GRANULARITY (4 * KiB)
> > +
> > +static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
>=20
> Hmm the Error* argument could be squashed in "hw/block/nvme:
> support multiple namespaces". Else better split patch in dumb
> units IMHO (maybe a reviewer's taste).
>=20

Yeah, I guess I can squash that in.

> >   {
> > +    BlockDriverInfo bdi;
> >       NvmeIdNs *id_ns =3D &ns->id_ns;
> >       int lba_index =3D NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
> > +    int npdg, ret;
> >       ns->id_ns.dlfeat =3D 0x9;
> > @@ -43,8 +47,25 @@ static void nvme_ns_init(NvmeNamespace *ns)
> >       id_ns->ncap =3D id_ns->nsze;
> >       id_ns->nuse =3D id_ns->ncap;
> > -    /* support DULBE */
> > -    id_ns->nsfeat |=3D 0x4;
> > +    /* support DULBE and I/O optimization fields */
> > +    id_ns->nsfeat |=3D (0x4 | 0x10);
>=20
> The comment helps, but isn't needed if you use explicit definitions
> for these flags. You already introduced the NVME_ID_NS_NSFEAT_DULBE
> and NVME_ID_NS_FLBAS_EXTENDED but they are restricted to extract bits.
> This is why I personally prefer the registerfields API (see
> "hw/registerfields.h").
>=20

I've been wanting to fix those constants - but the convention that they
only extract bits pre-dates the nvme device and is from when the nvme
block driver was introduced - I have just been following the precedence
by defining them like that.

> > +
> > +    npdg =3D ns->blkconf.discard_granularity / ns->blkconf.logical_blo=
ck_size;
> > +
> > +    ret =3D bdrv_get_info(blk_bs(ns->blkconf.blk), &bdi);
> > +    if (ret < 0) {
> > +        error_setg_errno(errp, -ret, "could not get block driver info"=
);
> > +        return ret;
> > +    }
> > +
> > +    if (bdi.cluster_size &&
> > +        bdi.cluster_size > ns->blkconf.discard_granularity) {
> > +        npdg =3D bdi.cluster_size / ns->blkconf.logical_block_size;
> > +    }
> > +
> > +    id_ns->npda =3D id_ns->npdg =3D npdg - 1;
> > +
> > +    return 0;
> >   }
> >   static int nvme_ns_init_blk(NvmeCtrl *n, NvmeNamespace *ns, Error **e=
rrp)
> > @@ -59,6 +80,11 @@ static int nvme_ns_init_blk(NvmeCtrl *n, NvmeNamespa=
ce *ns, Error **errp)
> >           return -1;
> >       }
> > +    if (ns->blkconf.discard_granularity =3D=3D -1) {
> > +        ns->blkconf.discard_granularity =3D
> > +            MAX(ns->blkconf.logical_block_size, MIN_DISCARD_GRANULARIT=
Y);
> > +    }
> > +
> >       ns->size =3D blk_getlength(ns->blkconf.blk);
> >       if (ns->size < 0) {
> >           error_setg_errno(errp, -ns->size, "could not get blockdev siz=
e");
> > @@ -92,7 +118,9 @@ int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Er=
ror **errp)
> >           return -1;
> >       }
> > -    nvme_ns_init(ns);
> > +    if (nvme_ns_init(ns, errp)) {
> > +        return -1;
> > +    }
> >       if (nvme_register_namespace(n, ns, errp)) {
> >           return -1;
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index 4ab0705f5a92..7acb9e9dc38a 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -959,6 +959,103 @@ static void nvme_rw_cb(void *opaque, int ret)
> >       nvme_enqueue_req_completion(nvme_cq(req), req);
> >   }
> > +static void nvme_aio_discard_cb(void *opaque, int ret)
> > +{
> > +    NvmeRequest *req =3D opaque;
> > +    int *discards =3D req->opaque;
> > +
> > +    trace_pci_nvme_aio_discard_cb(nvme_cid(req));
> > +
> > +    if (ret) {
> > +        req->status =3D NVME_INTERNAL_DEV_ERROR;
> > +        trace_pci_nvme_err_aio(nvme_cid(req), strerror(ret),
> > +                               req->status);
> > +    }
> > +
> > +    if (discards && --(*discards) > 0) {
>=20
> This line is hard to read.
>=20

Yes. Probably too clever for my own good. I'll fix it up.

> > +        return;
> > +    }
> > +
> > +    g_free(req->opaque);
> > +    req->opaque =3D NULL;
> > +
> > +    nvme_enqueue_req_completion(nvme_cq(req), req);
> > +}
> > +
> > +static uint16_t nvme_dsm(NvmeCtrl *n, NvmeRequest *req)
> > +{
> > +    NvmeNamespace *ns =3D req->ns;
> > +    NvmeDsmCmd *dsm =3D (NvmeDsmCmd *) &req->cmd;
> > +    NvmeDsmRange *range =3D NULL;
>=20
> g_autofree?
>=20

What sorcery is this?! I think I'll just replace it with a stack
allocation like Keith suggested.

> > +    int *discards =3D NULL;
> > +
> > +    uint32_t attr =3D le32_to_cpu(dsm->attributes);
> > +    uint32_t nr =3D (le32_to_cpu(dsm->nr) & 0xff) + 1;
> > +
> > +    uint16_t status =3D NVME_SUCCESS;
> > +
> > +    trace_pci_nvme_dsm(nvme_cid(req), nvme_nsid(ns), nr, attr);
> > +
> > +    if (attr & NVME_DSMGMT_AD) {
> > +        int64_t offset;
> > +        size_t len;
> > +
> > +        range =3D g_new(NvmeDsmRange, nr);
> > +
> > +        status =3D nvme_dma(n, (uint8_t *)range, nr * sizeof(NvmeDsmRa=
nge),
> > +                          DMA_DIRECTION_TO_DEVICE, req);
> > +        if (status) {
> > +            goto out;
> > +        }
> > +
> > +        discards =3D g_new(int, 1);
> > +        *discards =3D 1;
> > +        req->opaque =3D discards;
>=20
> If opaque is a pointer, why not instead using it as an uintptr_t
> discards directly without using the heap?
>=20

It was a "keep it simple, stupid" thing to just do the allocation. DSM
is typically not on the fast path ;)

But there is really no reason not to use that here.

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+SaTMACgkQTeGvMW1P
Denjkgf+LbO0GuHrhGqdX6MqgVl1zsJHDnmoo2SL+axmVBGa9YAA2Dr2rMaI7vCU
Haz0FNTzdUkHP8jELoPr5RcngWlxaKGxzamkgH/IRl9ztXfDvZqyE3in/K4nrjGB
Gf3h2Z3EZStKQxel34jMrcbXL9UAEzPiBQhn1okdlS+GW07ZEgu+VSnx8/teLADU
YzErRYG0vlkjknrXu1pDAouDljMJ0FZ5qprFGqcwcvjJT2lK5dYKMVpAwPjLdfc4
sk73xV9GmlbVqWXeJ7OsB/RhDEm83wyqHfwxfMy81+hkK8E1pQtKoXc6GyKpbqFS
0rUt+gnXr9p+1KiFb7tcDAH0UV/cPQ==
=Vgn0
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--


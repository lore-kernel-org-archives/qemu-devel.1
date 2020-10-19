Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17A5C43457
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 09:56:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E2932225F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 09:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E2932225F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kURtX-0004CY-5R
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 05:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kURov-0001yZ-7v; Mon, 19 Oct 2020 05:51:18 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:46517)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kURoo-0002iy-Ni; Mon, 19 Oct 2020 05:51:12 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 8F3CB3CD;
 Mon, 19 Oct 2020 05:51:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Mon, 19 Oct 2020 05:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=A4QACLM/1VKK7cseYV/OVbrmUD/
 X8BL3XQF1J89Gc2g=; b=SkmfvxTGqR2O/kpPj6gZW35X/yVPMCXPwj0nfAhSYh3
 7RX6lGzbAdA4GyiXPFDN2EvOzxz4TCs3wDLkB7G5B/GIxsYlnZkkpJzlJ2s7at0o
 0Es9xV0fb2vczLFi7ztzZMbJ9JbUQmaJwUXLoQn/pZRmtD8+NH3WEw0HM7Lj+I02
 yC0sVN8essFYsKGyezq/Szad0oBEW0d5S+69BBbIDbh58ZPg7+fsMrOCF6bY4NkD
 tpjcTrW/LUdTibEC9kDWXvBE15y6fX0n1tOshGvnrENWnsLSnRc6qCgo0JKLHGv1
 hI6zlqm/ETmqA+uuBUpZOzJvnTAzgV4iz+ypqVjZXvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=A4QACL
 M/1VKK7cseYV/OVbrmUD/X8BL3XQF1J89Gc2g=; b=jVqot7rBhCeGVOxKm5LL95
 ingdCGc6Kmwbs4dohauM90dr4lAyYgcqH3/hEtN0wrIXGqovmSh4TquifxQQhjZw
 bB6v1Vkb1TaqipO+BVp2jM+FT7F7fwkeygJUWHDcg1ef5e6e876qsRdiapsNME6R
 upZKQTNsy4tAy41t3pu/+LiNhJrr9C6+arIg1OZRZgZxCzIQqNWrxlzHm67IZ7hp
 CzpDoq/GLcf05o1OZUFU25rX6UILeRO2cgSa1WkD/iYcnKViNX92Y6nh2EZhICIR
 yIDxniOvHIBzMbFgO5TIDg81qOn6i01HAq09txEOwpN7nvCF6WC0laZTSn1VBjsw
 ==
X-ME-Sender: <xms:hGGNXz0WvGdxFWH6WE2ZSAK3eEa8lFeEyiDm1ZVintlkWaRGTj0lLw>
 <xme:hGGNXyFiQtVhtZqdrLKI3RWt52wLL3fEOR9Qv9rBYou_rzcVyh03I_uLsQnmmJdnz
 1MVOThUH6jU9JFjoE4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjedugddvudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:hGGNXz7GOX2JhFemMyRUa5jygJu-vmnkYgTJzkO3DMJhLZ89PBldjA>
 <xmx:hGGNX42IwAPMpfFwqMIdGdb9-h-nlcLPhvbP6iii279QeFt6Yb0E7A>
 <xmx:hGGNX2GW6PcFQLeejDlggHV49eWyD_jjKSDswjXgfPpBkcmeqftUpw>
 <xmx:hWGNXx-CHUmDlo245I2LU_Vimjhhesd-6Cf4q3dx7jGEFCe16CQ4qWUY_ZeLlItX>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id E1B84328005A;
 Mon, 19 Oct 2020 05:50:58 -0400 (EDT)
Date: Mon, 19 Oct 2020 11:50:57 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v7 05/11] hw/block/nvme: Support Zoned Namespace Command
 Set
Message-ID: <20201019095057.GA10549@apples.localdomain>
References: <20201019021726.12048-1-dmitry.fomichev@wdc.com>
 <20201019021726.12048-6-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <20201019021726.12048-6-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=64.147.123.27; envelope-from=its@irrelevant.dk;
 helo=wnew2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 05:51:04
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
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 Niklas Cassel <niklas.cassel@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 19 11:17, Dmitry Fomichev wrote:
> The emulation code has been changed to advertise NVM Command Set when
> "zoned" device property is not set (default) and Zoned Namespace
> Command Set otherwise.
>=20
> Define values and structures that are needed to support Zoned
> Namespace Command Set (NVMe TP 4053) in PCI NVMe controller emulator.
> Define trace events where needed in newly introduced code.
>=20
> In order to improve scalability, all open, closed and full zones
> are organized in separate linked lists. Consequently, almost all
> zone operations don't require scanning of the entire zone array
> (which potentially can be quite large) - it is only necessary to
> enumerate one or more zone lists.
>=20
> Handlers for three new NVMe commands introduced in Zoned Namespace
> Command Set specification are added, namely for Zone Management
> Receive, Zone Management Send and Zone Append.
>=20
> Device initialization code has been extended to create a proper
> configuration for zoned operation using device properties.
>=20
> Read/Write command handler is modified to only allow writes at the
> write pointer if the namespace is zoned. For Zone Append command,
> writes implicitly happen at the write pointer and the starting write
> pointer value is returned as the result of the command. Write Zeroes
> handler is modified to add zoned checks that are identical to those
> done as a part of Write flow.
>=20
> Subsequent commits in this series add ZDE support and checks for
> active and open zone limits.
>=20
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
> Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Signed-off-by: Matias Bjorling <matias.bjorling@wdc.com>
> Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  block/nvme.c          |   2 +-
>  hw/block/nvme-ns.c    | 193 +++++++++
>  hw/block/nvme-ns.h    |  54 +++
>  hw/block/nvme.c       | 975 ++++++++++++++++++++++++++++++++++++++++--
>  hw/block/nvme.h       |   9 +
>  hw/block/trace-events |  21 +
>  include/block/nvme.h  | 113 ++++-
>  7 files changed, 1339 insertions(+), 28 deletions(-)
>=20
> diff --git a/block/nvme.c b/block/nvme.c
> index 05485fdd11..7a513c9a17 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> +static void nvme_fill_read_data(NvmeRequest *req, uint64_t offset,
> +                                uint32_t max_len, uint8_t pattern)
> +{
> +    QEMUSGList *qsg =3D &req->qsg;
> +    QEMUIOVector *iov =3D &req->iov;
> +    ScatterGatherEntry *entry;
> +    uint32_t len, ent_len;
> +
> +    if (qsg->nsg > 0) {
> +        entry =3D qsg->sg;
> +        len =3D qsg->size;
> +        if (max_len) {
> +            len =3D MIN(len, max_len);
> +        }
> +        for (; len > 0; len -=3D ent_len) {
> +            ent_len =3D MIN(len, entry->len);
> +            if (offset > ent_len) {
> +                offset -=3D ent_len;
> +            } else if (offset !=3D 0) {
> +                dma_memory_set(qsg->as, entry->base + offset,
> +                               pattern, ent_len - offset);
> +                offset =3D 0;
> +            } else {
> +                dma_memory_set(qsg->as, entry->base, pattern, ent_len);
> +            }
> +            entry++;

dma_memory_set can fail. In that case, I think just fail the command
with NVME_DATA_TRAS_ERROR.

But I think this should be removed in any case, see below.

> +static uint16_t nvme_check_zone_read(NvmeNamespace *ns, NvmeZone *zone,
> +                                     uint64_t slba, uint32_t nlb,
> +                                     NvmeReadFillCtx *rfc)
> +{
> +    NvmeZone *next_zone;
> +    uint64_t bndry =3D nvme_zone_rd_boundary(ns, zone);
> +    uint64_t end =3D slba + nlb, wp1, wp2;
> +    uint16_t status;
> +
> +    rfc->pre_rd_fill_slba =3D ~0ULL;
> +    rfc->pre_rd_fill_nlb =3D 0;
> +    rfc->read_slba =3D slba;
> +    rfc->read_nlb =3D nlb;
> +    rfc->post_rd_fill_slba =3D ~0ULL;
> +    rfc->post_rd_fill_nlb =3D 0;
> +
> +    status =3D nvme_zone_state_ok_to_read(zone);
> +    if (status !=3D NVME_SUCCESS) {
> +        ;
> +    } else if (likely(end <=3D bndry)) {
> +        if (end > zone->w_ptr) {
> +            wp1 =3D zone->w_ptr;
> +            if (slba >=3D wp1) {
> +                /* No i/o necessary, just fill */
> +                rfc->pre_rd_fill_slba =3D slba;
> +                rfc->pre_rd_fill_nlb =3D nlb;
> +                rfc->read_nlb =3D 0;
> +            } else {
> +                rfc->read_nlb =3D wp1 - slba;
> +                rfc->post_rd_fill_slba =3D wp1;
> +                rfc->post_rd_fill_nlb =3D nlb - rfc->read_nlb;
> +           }
> +        }
> +    } else if (!ns->params.cross_zone_read) {
> +        status =3D NVME_ZONE_BOUNDARY_ERROR;
> +    } else {
> +        /*
> +         * Read across zone boundary, look at the next zone.
> +         * Earlier bounds checks ensure that the current zone
> +         * is not the last one.
> +         */
> +        next_zone =3D zone + 1;
> +        status =3D nvme_zone_state_ok_to_read(next_zone);
> +        if (status !=3D NVME_SUCCESS) {
> +            ;
> +        } else if (end > nvme_zone_rd_boundary(ns, next_zone)) {
> +            /*
> +             * As zone size is much larger than a typical maximum
> +             * i/o size in real hardware, allow the i/o range
> +             * to span no more than one pair of zones.
> +             */
> +            status =3D NVME_ZONE_BOUNDARY_ERROR;

While assumptious, it seems totally fair. But irrelevant if removed as I
propose below.

> +        } else {
> +            wp1 =3D zone->w_ptr;
> +            wp2 =3D next_zone->w_ptr;
> +            if (wp2 =3D=3D bndry) {
> +                if (slba >=3D wp1) {
> +                    /* Again, no i/o necessary, just fill */
> +                    rfc->pre_rd_fill_slba =3D slba;
> +                    rfc->pre_rd_fill_nlb =3D nlb;
> +                    rfc->read_nlb =3D 0;
> +                } else {
> +                    rfc->read_nlb =3D wp1 - slba;
> +                    rfc->post_rd_fill_slba =3D wp1;
> +                    rfc->post_rd_fill_nlb =3D nlb - rfc->read_nlb;
> +                }
> +            } else if (slba < wp1) {
> +                if (end > wp2) {
> +                    if (wp1 =3D=3D bndry) {
> +                        rfc->post_rd_fill_slba =3D wp2;
> +                        rfc->post_rd_fill_nlb =3D end - wp2;
> +                        rfc->read_nlb =3D wp2 - slba;
> +                    } else {
> +                        rfc->pre_rd_fill_slba =3D wp2;
> +                        rfc->pre_rd_fill_nlb =3D end - wp2;
> +                        rfc->read_nlb =3D wp2 - slba;
> +                        rfc->post_rd_fill_slba =3D wp1;
> +                        rfc->post_rd_fill_nlb =3D bndry - wp1;
> +                    }
> +                } else {
> +                    rfc->post_rd_fill_slba =3D wp1;
> +                    rfc->post_rd_fill_nlb =3D bndry - wp1;
> +                }
> +            } else {
> +                if (end > wp2) {
> +                    rfc->pre_rd_fill_slba =3D slba;
> +                    rfc->pre_rd_fill_nlb =3D end - slba;
> +                    rfc->read_slba =3D bndry;
> +                    rfc->read_nlb =3D wp2 - bndry;
> +                } else {
> +                    rfc->read_slba =3D bndry;
> +                    rfc->read_nlb =3D end - bndry;
> +                    rfc->post_rd_fill_slba =3D slba;
> +                    rfc->post_rd_fill_nlb =3D bndry - slba;
> +                }
> +            }
> +        }

This seems to use the read boundary (zone size), the gap between ZCAP
and ZSZE should also be filled with the fill pattern. This brings in one
more gap which causes this code to have even more edge cases.

This feels like an ad-hoc solution and this pre/post filling strategy is
going to fall short if (when) we implement support for DSM since that
may introduce deallocated blocks all over the place. Technically, this
is not your problem, (but then it is probably going to be my headache
soon since I'd like to introduce DSM support), so I would prefer that we
find a better solution here. I think my work on DULBE and relying on the
ability of the block layer to guarantee zeroes in most cases is useful
here and a better solution than faking it like this.

I fear that adding fill_pattern support in a way that only works for
zoned namespaces is going to cause us a lot of headaches if we want to
support it (and DSM) for NVM namespaces as well.

I propose that you drop the fill_pattern feature and just rely on the
block layer for this (by possibly integrating with the DULBE support
that I posted). This would allow RAZB to still be trivially supported
(and even across more than one boundary). For reference, my ZNS proposal
supports this (but not RAZB) along with the required discards on zone
resets, though I think it is missing a check on the zone size being a
multiple of the cluster size of the underlying blockdev for zeroes to be
guaranteed for non-zero cluster sizes.

> +    }
> +
> +    return status;
> +}
> +
> +static bool nvme_finalize_zoned_write(NvmeNamespace *ns, NvmeRequest *re=
q,
> +                                      bool failed)
> +{
> +    NvmeRwCmd *rw =3D (NvmeRwCmd *)&req->cmd;
> +    NvmeZone *zone;
> +    uint64_t slba, start_wp =3D req->cqe.result64;
> +    uint32_t nlb;
> +
> +    if (rw->opcode !=3D NVME_CMD_WRITE &&
> +        rw->opcode !=3D NVME_CMD_ZONE_APPEND &&
> +        rw->opcode !=3D NVME_CMD_WRITE_ZEROES) {
> +        return false;
> +    }
> +
> +    slba =3D le64_to_cpu(rw->slba);
> +    nlb =3D le16_to_cpu(rw->nlb) + 1;
> +    zone =3D nvme_get_zone_by_slba(ns, slba);
> +
> +    if (!failed && zone->w_ptr < start_wp + nlb) {
> +        /*
> +         * A preceding queued write to the zone has failed,
> +         * now this write is not at the WP, fail it too.
> +         */
> +        failed =3D true;
> +    }
> +
> +    if (failed) {
> +        if (zone->w_ptr > start_wp) {
> +            zone->w_ptr =3D start_wp;
> +            zone->d.wp =3D start_wp;
> +        }

This doesn't fix the data corruption. The example from my last review
still applies.

> +        req->cqe.result64 =3D 0;
> +    } else if (zone->w_ptr =3D=3D nvme_zone_wr_boundary(zone)) {
> +        switch (nvme_get_zone_state(zone)) {
> +        case NVME_ZONE_STATE_IMPLICITLY_OPEN:
> +        case NVME_ZONE_STATE_EXPLICITLY_OPEN:
> +        case NVME_ZONE_STATE_CLOSED:
> +        case NVME_ZONE_STATE_EMPTY:
> +            nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_FULL);
> +            /* fall through */
> +        case NVME_ZONE_STATE_FULL:
> +            break;
> +        default:
> +            assert(false);
> +        }
> +        zone->d.wp =3D zone->w_ptr;
> +    } else {
> +        zone->d.wp +=3D nlb;
> +    }
> +
> +    return failed;
> +}

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+NYXsACgkQTeGvMW1P
DenC8QgAhatfsHrH55IILuCNO0alRisOQBTI19SJg3o+aqTqnHNQTrBKnqa0f2sY
gtbT9dARjPNIAj/cKjuupjLrgst/ZkVVO5bm+X56Mtg0HebzNeJTTJdY2B5pJTOv
lT2lqsLandGLSVhzgUvUGX+qaPg5xcMSKdrKOsyMoqq0WSP6d6eAtEcwtV0ivtD2
jx7bUBb9fCC+mC7uvrULjAUl34GeHz51AJsb+72vlVaS3SQMq2U69tNusjhj1gP7
AVtZdjj3L1OP13Oz1PodP95tf61ByWyMfgGwvjudC69t4oaEdxjRn065RbRT23X7
owzzMQGTqhu15WZdZ81G1Sk5FT6k1Q==
=X4CO
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--


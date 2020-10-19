Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4783C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:59:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E547122283
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E547122283
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUXZS-0006Mx-J1
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 11:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kUXVm-0004RE-Ef; Mon, 19 Oct 2020 11:55:50 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:56597)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kUXVj-00008n-TO; Mon, 19 Oct 2020 11:55:50 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 95DBFDE5;
 Mon, 19 Oct 2020 11:55:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Mon, 19 Oct 2020 11:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=JTOFj3pXmvLfYp1geWlSrHoTMnP
 4kdKEiWWBmN2i6ws=; b=l212NkjxWBayDwntl42CaUcCCTD4GKjeBrvQMpndcNN
 8UQOQWvQrQ0R70ukKVJkCEvaP60Fk/zzgljTF3RMav4bpFBXJSHF6zV3pa9OW1Ee
 Rkys4WkrEo6BKrO2SwFLcacDEhcwExn2ukK0wKlJmVyl0KNUlyi2bylj+aX0rz7t
 gopwAh3tcv2Mc7p7Lu0Rtl6aTHgjJWvkSl0Edj4yQqLGiDAznKAEpnrklI0sspVQ
 Y11wizsXe7rfIdcxN0F11BX2+Rm7tM9vohszvsdu0JO+fPz7TZxTke0lTytzRngl
 bV5ciXGMaDdnKnGXyoFPtkztavDTmBcfrNpVjJdYtmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=JTOFj3
 pXmvLfYp1geWlSrHoTMnP4kdKEiWWBmN2i6ws=; b=bKZiu1gOlL5GmOGBL3J4/l
 OXcKeJb/6N+rjePAOlRqYG/sgYJEVMYOYolYTETwktu/YzAYtoiZKpdr1x/P0p2Z
 0RIsPTO9XEK6TIgP0yJbUHTImRpW3IlBhmSwidkZcJPQWz14WsrNHVMvsHgEQmgt
 1m8knPxLvtLp8CuKRUhwCwZxC2e4e/SkMQnSihozJXZLFu1eKxcMImvXF9pjygsW
 wpbNmEFP2RRNaiLoE2Qz1Jpic5WmYVDCJb1X0VQS6Bfp6l7l2/HDsaDAt0hPvm+4
 M73u6ReEceAMm859BeXd4y1vZOQ1DHtpG86KbY4iy8nNPckWABxUV6ycrkuibKCQ
 ==
X-ME-Sender: <xms:_baNX_WH2vBstboy9iJ1Gz633n_yJuM4Ze_tfNMA0TPNIv6P2WhuKQ>
 <xme:_baNX3kdBPcqNwJne9kR6nGzpbau3kVHmKBelvX2DlKpobzxwzOUdd10mu14jQazl
 Y6zfnJ4ivjaSeeOZoE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjedugdelhecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:_baNX7aaJ_DAcJ4aWl5FjEGThkXD2AZHdurd8SVFnf4Ge7xuNx5RMg>
 <xmx:_baNX6XPh46EZPQdK3MTAA7_i9wqEsQsmAfP-ksgTUlxIcQxRz7nbQ>
 <xmx:_baNX5lrwXKQtYp1A_m0jLwmI989sHi0UDcKpvCRPQ5H_C9OWItyiQ>
 <xmx:_7aNXycWrlctA-09jsYRiY9PGYdWiVVh3yjDKs26MOcYgcemGwMMeIuQEeGOHk-2>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 01D3F306467D;
 Mon, 19 Oct 2020 11:55:39 -0400 (EDT)
Date: Mon, 19 Oct 2020 17:55:37 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v7 05/11] hw/block/nvme: Support Zoned Namespace Command
 Set
Message-ID: <20201019155537.GD10549@apples.localdomain>
References: <20201019021726.12048-1-dmitry.fomichev@wdc.com>
 <20201019021726.12048-6-dmitry.fomichev@wdc.com>
 <20201019095057.GA10549@apples.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9dgjiU4MmWPVapMU"
Content-Disposition: inline
In-Reply-To: <20201019095057.GA10549@apples.localdomain>
Received-SPF: pass client-ip=64.147.123.17; envelope-from=its@irrelevant.dk;
 helo=wnew3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 11:55:44
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
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Keith Busch <kbusch@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--9dgjiU4MmWPVapMU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 19 11:50, Klaus Jensen wrote:
> On Oct 19 11:17, Dmitry Fomichev wrote:
> > +static bool nvme_finalize_zoned_write(NvmeNamespace *ns, NvmeRequest *=
req,
> > +                                      bool failed)
> > +{
> > +    NvmeRwCmd *rw =3D (NvmeRwCmd *)&req->cmd;
> > +    NvmeZone *zone;
> > +    uint64_t slba, start_wp =3D req->cqe.result64;
> > +    uint32_t nlb;
> > +
> > +    if (rw->opcode !=3D NVME_CMD_WRITE &&
> > +        rw->opcode !=3D NVME_CMD_ZONE_APPEND &&
> > +        rw->opcode !=3D NVME_CMD_WRITE_ZEROES) {
> > +        return false;
> > +    }
> > +
> > +    slba =3D le64_to_cpu(rw->slba);
> > +    nlb =3D le16_to_cpu(rw->nlb) + 1;
> > +    zone =3D nvme_get_zone_by_slba(ns, slba);
> > +
> > +    if (!failed && zone->w_ptr < start_wp + nlb) {
> > +        /*
> > +         * A preceding queued write to the zone has failed,
> > +         * now this write is not at the WP, fail it too.
> > +         */
> > +        failed =3D true;
> > +    }
> > +
> > +    if (failed) {
> > +        if (zone->w_ptr > start_wp) {
> > +            zone->w_ptr =3D start_wp;
> > +            zone->d.wp =3D start_wp;
> > +        }
>=20
> This doesn't fix the data corruption. The example from my last review
> still applies.
>=20

An easy fix is to just unconditionally advance the write pointer in all
cases.

--9dgjiU4MmWPVapMU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+NtvcACgkQTeGvMW1P
DelsOgf6A4q9ZWDM/V1K6OYO8xna+j9zY7iuxt9JpcWf81kcRWFbhmaxAUnbUut9
pVmBq023CTEAIXeuL81fY7hbo7S2hMaf+I5WvW/ee/6J2W++muvSKODwDXGY3dTE
3bErXeUjSx3U7sP7r8fqsOPCWJ5scN8q62X242YSJ39VowBNP+t8trSo5fvqj4ew
eZd72PMaZmAz5j3JqRjCytTTJEnekmRuEiq2wxD2jL3Z/aEx4i1GyRbbYSlt1ZzN
XBsNS/ChPyC/GAJO0Kg/Mr79R166nDAIf5zsIYUQHIbDbZKX8E8qvi0YRgwGJXwI
pIdsaOU4Jc3zt/aKcKx496qX757SHQ==
=vMrl
-----END PGP SIGNATURE-----

--9dgjiU4MmWPVapMU--


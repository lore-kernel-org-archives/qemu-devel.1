Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62068C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 09:08:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0E0F208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 09:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E0F208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSGIE-0004KR-JX
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 05:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kSGE8-0002tf-DR; Tue, 13 Oct 2020 05:04:12 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:51133)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kSGE5-0000s8-IV; Tue, 13 Oct 2020 05:04:12 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id D2A94580379;
 Tue, 13 Oct 2020 05:04:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 13 Oct 2020 05:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=TNoXdq3qvFBkuj8109Cm5+VzSHJ
 dNe8yTX0XvCN6ig8=; b=uylCJnJEVAhMVW8KMwQlk174rNwdkCn2QnjWOtCLriq
 U9z9ymvCEx/rncfM1W7/2Si9o/70vGkZyu5ZRgDmv5a2Hdfav3zOK9v0eXg7QExZ
 Op0unNjslXEpuSUYtMFh3XuppFP/59JzZCTU9+XXhzVt6NT+kMWtf9ur1EOJo3v/
 1W0P/Sfd5jzqVKvb+hZaKkg8OJ1zyvpbj3NwcQA4MR2utIv5uBMM7ussqUw3g07/
 NLF29mPzZ73ONuSMw/KLwr83bEuUaiKqcIMurr38b+VRwKci8KlgInAehWYx2fbl
 X6L7SFZ5llz8+1vRbHTMWpTPVyNMNK/d+KzZORXGjLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=TNoXdq
 3qvFBkuj8109Cm5+VzSHJdNe8yTX0XvCN6ig8=; b=cBI7w8J+Y/8XE8gmAJ2Q/T
 dRFtEmHD85lOTMckfIqes3lxXwPd/7eG2L5CF7CTAuG8ERm4fROXMVTNgTIMh3Gz
 x9vaQNF1L52eHKS0QvkFSKElf0upaTQBzzx0Q0D78sbiz6PctOQiEWng6IOLXXW+
 Y505TfSiaOGHwERlSjv/MB2Z+aQ/d/R3OGW5m/j2l+govqWhBb1kZ1x0bbhNTedh
 4u5L00vBVP3AAn3unLzP+tyGvQjQPSwipA0RpPAFNDsl9CgPlD/KYOUGtjYfxImK
 qNMVFL4EqL1s8i7CgKV+ElouMzprK+jyuoF1kqWpCAVG+A3SucTiTXNtDSlRoImw
 ==
X-ME-Sender: <xms:hW2FX5gj0IJL3GxyPCnQthBNv59bnyMgTE05Si0KeNVeiA9an0XIGg>
 <xme:hW2FX-DTr5qYbluh4A3PZw_uqytPOjG4JW68Qu1a8uhgHmbfcmhW30xvsbw1Q1P4d
 y72xWj-DCb9WFbPgrY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrheelgdduudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepuddtheelledvtedvfeeuheegvefhjeeuleeihfduhfeiffffhfdutdekkeeikeef
 necuffhomhgrihhnpehinhhfrhgruggvrggurdhorhhgnecukfhppeektddrudeijedrle
 ekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
 mhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:hW2FX5HOGF_ECaG_qmOWiCllfuUcBVC1S6ddh5TTW5Hjndr8wjkMfg>
 <xmx:hW2FX-SltTddcgG9xefj5NQ0cs2xOfCwBC7_EYrK6jzXVBB02wojEg>
 <xmx:hW2FX2w-1s2SAJNilqXFBdyvFCPmJwKLHSAk4Uz7sap2I3g4rsD4vA>
 <xmx:hm2FX9pxBWRZQlcQI0Cv12tqtf_7u1E3HUBGrXgwF3rnQNyBFXxtrQ>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 060F53280064;
 Tue, 13 Oct 2020 05:04:03 -0400 (EDT)
Date: Tue, 13 Oct 2020 11:04:01 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 0/9] nvme qemu cleanups and fixes
Message-ID: <20201013090401.GC168093@apples.localdomain>
References: <20200930220414.562527-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Content-Disposition: inline
In-Reply-To: <20200930220414.562527-1-kbusch@kernel.org>
Received-SPF: pass client-ip=66.111.4.229; envelope-from=its@irrelevant.dk;
 helo=new3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 04:27:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 30 15:04, Keith Busch wrote:
> After going through the zns enabling, I notice the controller enabling
> is not correct. Then I just continued maked more stuff. The series, I
> think, contains some of the less controversial patches from the two
> conflicting zns series, preceeded by some cleanups and fixes from me.
>=20
> If this is all fine, I took the liberty of porting the zns enabling to
> it and made a public branch for consideration here:
>=20
>  http://git.infradead.org/qemu-nvme.git/shortlog/refs/heads/kb-zns=20
>=20
> Dmitry Fomichev (1):
>   hw/block/nvme: report actual LBA data shift in LBAF
>=20
> Keith Busch (5):
>   hw/block/nvme: remove pointless rw indirection
>   hw/block/nvme: fix log page offset check
>   hw/block/nvme: support per-namespace smart log
>   hw/block/nvme: validate command set selected
>   hw/block/nvme: support for admin-only command set
>=20
> Klaus Jensen (3):
>   hw/block/nvme: reject io commands if only admin command set selected
>   hw/block/nvme: add nsid to get/setfeat trace events
>   hw/block/nvme: add trace event for requests with non-zero status code
>=20
>  hw/block/nvme-ns.c    |   5 ++
>  hw/block/nvme.c       | 194 ++++++++++++++++++++----------------------
>  hw/block/trace-events |   6 +-
>  include/block/nvme.h  |  11 +++
>  4 files changed, 114 insertions(+), 102 deletions(-)
>=20
> --=20
> 2.24.1
>=20
>=20

These fixes all look good to me apart from the odd fixes that has been
mentioned in the reviews. Since soft freeze is only two weeks away (Oct
27th), it would be nice to get this staged on nvme-next so we can get a
pull sent off to Peter.

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+FbX8ACgkQTeGvMW1P
DemuBQf/foStdQi6w5whyDVM70gG+s6ZdZWEEXmDBy5S4z4LqW4/qc6Q+M7igTJj
9fWEuOpA44KoskZfmKB9UYWPNAF/XTc9RJhoVTzexixwX6ZQz69acCOWGO8AhoFC
HK/EGU9Bp18ggdUKe+PsJbv5OHYLo1JZyp8cNOLL268vCq6zlhFMV2WXv0HthMRO
r3c+ciUs7F3aCl9lN74Bfp1wIJmEbg7usfU6lZ5PKdiP2lERjXw526Ue9NuAbBwa
FzEG2AH7Q5mt6a/YZEIkhDW8WSZ4CsamjGDSTvahnNoTNwJVpHyj2DFJENffrq4Y
zYtczmRJaiqe0YkKZPjgfCOWfDbF6A==
=Cxce
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--


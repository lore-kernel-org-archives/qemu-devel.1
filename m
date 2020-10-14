Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20890C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 08:51:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 440E72080A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 08:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 440E72080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kScVZ-0004x5-VT
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 04:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kScRU-0003Ud-1r; Wed, 14 Oct 2020 04:47:28 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:38331)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kScRR-0002O9-BR; Wed, 14 Oct 2020 04:47:27 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id 8800F5802D5;
 Wed, 14 Oct 2020 04:47:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Wed, 14 Oct 2020 04:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=SS9f0A0RQbjwSNc82ISYKi5RDX+
 r1koVT0h5tPqPTRA=; b=DlDDxEL5tjbtwUaYM0m+mMoffVrWHlB8shtg/miEpiM
 hLHztCZkWbvaJf/2E0RdrVJaGK6N4JrMOe0WFAMeoSJdjMpfPTLNiS6iMp3bzDok
 66uL4RR+nHmolm6e8AZ99UTs9bAPWMOg8rB/VHYiXuBDKGLKGGiwrQNoA2g2r0xs
 RMYgzUHYSAxfqhuvRX+cXhntDAB8rbYR7zViteHWOcTDH40kRR3yCAzgIiqU3K1m
 vc6XZAEdytVfrxcl3jp9D9+uAWpopffNHusXiKknnkKOx68rteO1QAxCQG+wXfjw
 Nrtl3m4RQGk9YxDCbd0McWXENt9apZ6S8XDqJtx/yVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=SS9f0A
 0RQbjwSNc82ISYKi5RDX+r1koVT0h5tPqPTRA=; b=K02DdQ8sXEIzQCM2Q9EHeR
 dm0w6QAVbdgqyQKXEf+am0+j7fOl0uYn/N0L0V29iE95UGS8/i8BlMRmbdimEFZL
 PBizi7mN+yJHwzF3YkIoNXcT+ldd2ZqGA182mU0aXkefjbLdkzA7g0pNaC5HVbmo
 US3ZR8+22upya1JmXqeKPLvOZR3ibVWjHHCoScBRJ/cLUpToMU1KbximSwiQBmj6
 16SB+kGDh8ehGs33q/V+z7W1JI0A06bJApOLkfrZ1MGBLNMQ6SODuqwa/Nj4EcsB
 LSZo2Okb5bLbZb70OsDPKrP5dpa2Xvclp9EjY3s52bXiywetZ3xm8y1YqoW96Wjw
 ==
X-ME-Sender: <xms:G7uGXzG3lT_Z36vXn2G22BUCpv7lTpQb_z9iUE2v_p_88gBdnyPe1w>
 <xme:G7uGXwUidzxU5_8zFQQEt1wms4VaUvMNFpM6RD0CgoIjnGSrd7E7f-1qO31cn4VKq
 kycPuyG-jJJb_xLrcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedriedugddtkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:G7uGX1JSRnEvcE22sG3gHJILsvmTfEZbVw2BgKylCpkUNgh9AMMSxg>
 <xmx:G7uGXxElYq3ktZeeLVdPD6Ku7ZBapIm589nn3B_W6Wie2LdUTZOBRg>
 <xmx:G7uGX5XSBiYYja5vZ9uFrYxkWVD_I7m5OyMOXnTA_ElqfEtSyXhblg>
 <xmx:HLuGX_zQSptGE8C7Cxb-01AhEdcdhgIlMoeOqixelcR8Ilvi2x105A>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id E55873064610;
 Wed, 14 Oct 2020 04:47:22 -0400 (EDT)
Date: Wed, 14 Oct 2020 10:47:21 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] hw/block/nvme: add block utilization tracking
Message-ID: <20201014084721.GB267924@apples.localdomain>
References: <20201013190846.260841-1-its@irrelevant.dk>
 <20201013210636.GA1049395@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline
In-Reply-To: <20201013210636.GA1049395@dhcp-10-100-145-180.wdl.wdc.com>
Received-SPF: pass client-ip=66.111.4.221; envelope-from=its@irrelevant.dk;
 helo=new1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 04:43:28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 13 14:06, Keith Busch wrote:
> On Tue, Oct 13, 2020 at 09:08:46PM +0200, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> >=20
> > This adds support for reporting the Deallocated or Unwritten Logical
> > Block error (DULBE). This requires tracking the allocated/deallocated
> > status of all logical blocks.
> >=20
> > Introduce a bitmap that does this. The bitmap is always intialized to
> > all ones (aka, all blocks are allocated) on boot up. Blocks can then be
> > specifically deallocated using Write Zeroes. This ensures that we can
> > always guarantee zeroes to be returned from deallocated blocks.
> >=20
> > When the device gains support for persistent state, the intention is to
> > remove the "allocated by default" behavior.
>=20
> I think this is a rather odd feature for this device to support. The
> implementation is slow can end up allocating quite a bit of memory.

Totally true - but the bitmap was the best way I could find to do this
on a per LBA basis.

> If we were going to support it here, wouldn't it make more sense to
> tie it to the filesystem's ability to support fallocate hole punch for
> the backing namespace, and check if the range is allocated with
> SEEK_HOLE?  Then you don't even need to track persistent state, and
> we're actually getting the genuine capability.
>=20

Yes, this would be optimal, definitely. I think we have to rely on what
we can do with the QEMU block layer, so please see my v2 that uses
bdrv_block_status. I did do something like this initially, but was
unsure if we could live with the fact that block drivers such as qcow2
cannot honor a discard unless an entire cluster is discard/zeroed.

But see my commit message, I think we can work with it and still be in
compliance with the spec.

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+GuxcACgkQTeGvMW1P
DekwkQf/bCz3gPdZgNKC7ojxLZqYhcGV2e+pJoMUYZ2/JGXOR1qdZr8DT7gVvwnV
wLDpbFqP7DTfCr9yB1+9SrE0OmUGMkbOSEcea9XlmWqTAxVkxs/JKPzoSdIktai8
bsymYj2cg7sSqjdXwsf8nkVOI+zzzHoCUPV2mNnUfDOeQHN7b8u3vJlPlC0iP2ch
sJaPxEvZDFH0/xKT4t8zM+dDaV52+GNtQaMvBSbjE0iHgEe8XyuiItHR6rvmG0Is
JPueZJs+T9l9DLV1a4yt+YhApBQA9gi6pspaCGuEspy6PGZEwyjhUq+fJ7kf3m+5
yE8pD+OMv+ZqzXgCt3YM5wBlXTRfqg==
=kh/M
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--


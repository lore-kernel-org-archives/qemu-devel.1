Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B813FC4742C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 06:39:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B512122202
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 06:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B512122202
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYO4O-0005E4-7o
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 02:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kYNyi-0002P3-J4; Fri, 30 Oct 2020 02:33:36 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:55503)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kYNyg-0000QV-0p; Fri, 30 Oct 2020 02:33:36 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 4CA14A53;
 Fri, 30 Oct 2020 02:33:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Fri, 30 Oct 2020 02:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=QMyK1XK6AWldGHbHvLUzyXdHLdx
 /c48wkIV8tvPtppY=; b=cL+iJAc7YpfnskrXHLvc84GQkCrp91LvODx6+DjzzcS
 caXp0LRg/ZC90nm2D9HsSTW9uQ/Rd1s+lLXQk4dnP8SaxS8EOh0qfdMHQfH2k163
 kA41G8JxD+7lEdn+lt++FGk5XymRzhaGw0p7PeSCV5m7H70zRqJHBoAAEXSX4G/3
 g/yosjvTbvyxAyZfC53lZyXKwrG7LAqF+P4ecRqYLsXNLk/SMBPeoxdOmmocSj1j
 QbH5G+915D25eB3It0r7vNRNPY9ejiD9gAb7TtlZpYYrPN+OeLBkmxlGGKRrPYe2
 JVjupXzoedUBaKHW9Gd3b/fc4YRI8n/vvDB07fnuowg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=QMyK1X
 K6AWldGHbHvLUzyXdHLdx/c48wkIV8tvPtppY=; b=YMmoG0haPbLgRhsnTbnKsV
 IyEPme0ixDHtNkoklccQXwMjlARvllaKf6UR8hBN9dI7W+AHwhKt7yREZHXqOqh6
 ciTIyLFmhReBT/m8Sr2OdZJ/iRtpZZ1hlGoEZUWdmhWLGJoSbYwx/L0W6CRforar
 MXU6s2Q5je8/TjNEGhKVAgCBCfH+BkE1N2RF/Mkpgy02YTLk8MR4iPAil8G4gqCP
 cBe5gVJbtOor9a1+Fhc2EjBPXotMN0ko6exeQ/8vNAc5nklovYOL2N0UbXGdOF6p
 lqA9sHaJIqhgVfnV7bwT8EG70250+MiUTtaxAFYASt42Wmm6MyfCGrZl+muqLXyg
 ==
X-ME-Sender: <xms:urObX9G4eLZkUt2SUAZ47hjujh8haSGS1aTyObj_gJjaG5OPb7yy8A>
 <xme:urObXyWTFA6j8Kg7d5UTv8QeSu7f5iafNJ-uPJ0jW9w1Ryoi4sVs65UGWLKfUNQzc
 wFJxSYz0JIug23uMOk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrleeggdelhecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:urObX_I8ci63aUdVBF088fNK7wcCasDWI2NeAVief-FCvDVkXA45jw>
 <xmx:urObXzHLYLnT1W8Of4sGFtKqjxE9kA3ujqgtbPXhUDOGg5V11aMyBw>
 <xmx:urObXzVONPAIiD-zFmq3LnCmrUUYh500UUHxgjbK09jKJt-ap2dIlg>
 <xmx:urObX5y5VNJAgqcffX2hyWpLxM_hQvnWp0-R7TpplusNu_fH_fSmQw>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 244A13064674;
 Fri, 30 Oct 2020 02:33:29 -0400 (EDT)
Date: Fri, 30 Oct 2020 07:33:27 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v7 0/3] hw/block/nvme: dulbe and dsm support
Message-ID: <20201030063327.GA1079527@apples.localdomain>
References: <20201027175725.586890-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <20201027175725.586890-1-its@irrelevant.dk>
Received-SPF: pass client-ip=64.147.123.21; envelope-from=its@irrelevant.dk;
 helo=wout5-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 02:33:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 Keith Busch <kbusch@kernel.org>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 27 18:57, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> This adds support for the Deallocated or Unwritten Logical Block error
> recovery feature as well as the Dataset Management command.
>=20
> v7:
>   - Handle negative return value from bdrv_block_status.
>   - bdrv_get_info may not be supported on all block drivers, so do not
>     consider it a fatal error.
>=20
> v6:
>   - Skip the allocation of the discards integer and just use the opaque
>     value directly (Philippe)
>   - Split changes to include/block/nvme.h into a separate patch
>     (Philippe)
>   - Clean up some convoluted checks on the discards value (Philippe)
>   - Use unambiguous units in the commit messages (Philippe)
>   - Stack allocate the range array (Keith)
>=20
> v5:
>   - Restore status code from callback (Keith)
>=20
> v4:
>   - Removed mixed declaration and code (Keith)
>   - Set NPDG and NPDA and account for the blockdev cluster size.
>=20
> Klaus Jensen (3):
>   hw/block/nvme: add dulbe support
>   nvme: add namespace I/O optimization fields to shared header
>   hw/block/nvme: add the dataset management command
>=20
>  hw/block/nvme-ns.h    |   4 +
>  hw/block/nvme.h       |   2 +
>  include/block/nvme.h  |  12 ++-
>  hw/block/nvme-ns.c    |  34 ++++++--
>  hw/block/nvme.c       | 193 +++++++++++++++++++++++++++++++++++++++++-
>  hw/block/trace-events |   4 +
>  6 files changed, 240 insertions(+), 9 deletions(-)
>=20
> --=20
> 2.29.1
>=20

Keith, I cleared your R-b's from both patch 1 and 3 - please re-review.
The diff from v6 is very small, but it does include functional changes.

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+bs7MACgkQTeGvMW1P
DelsQAf/Sof3YBnBzuRy5K/Fe+oda9X7MKJjJxSKs1cath/l8EvuagsixZPqROde
W3B7k9ktL1cuJJ6olV1+JWI6VS7korcVMuvTLqfhrQxlb95b/XGXDIn7TLWp5IYr
LQRxvqzoEmTUVMqz6HIdv8zppammtxceVA25w1noCNUTQVISQ61o/5l0D2j3gtmt
Q3zQxoknA4nL18FH5mQvm+vq/T3UlOqh0KuMO7A/LdJkzyzPPw4kKeZDAp3xNe3j
UORQ9du4D/JWn7eW0wjoCGi9q6ED8hZE+wVhwCUYqc5tvIRBz9lSZJdsYGmhv61S
QARCm5w+is/HR9su1E0igeKw8tG2rg==
=9d9g
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--


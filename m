Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAC1C47420
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 05:31:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D3552085B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 05:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D3552085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLgJw-0006it-Bi
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 01:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLgH6-0006AU-OB; Fri, 25 Sep 2020 01:28:04 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:36047)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLgH3-00079x-Ub; Fri, 25 Sep 2020 01:28:04 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 90C3D58031C;
 Fri, 25 Sep 2020 01:28:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Fri, 25 Sep 2020 01:28:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=6fEy7Fs/dx1VtqTnuZoxt0adG8w
 N+t1idcCWjjhTniw=; b=wJHzNm7WgPxnnF4D1695Y8NkDusd7oHdcNu673pSO8T
 1goGcOqYamLLUjtLcScifJiiNhZmQpQDAQPQiJWp8LMDuU3l5eOO/iGAL4PC36Qm
 y6tBNEZwfgWDRer6vQR9nuw/pI6d6UklHFyi07JJMI/9sy5Tm3MxvNhriQFcMkHr
 qMY8C/z+7cqZVfwBKbwsUMto+f/1uPW8Xlg6eFasMBqEd72li4eGIpLGnKWzvBW4
 lgUsEi9rkfVchfhXbeEk3KdXJPPgAkv5+qVhZ7svTJaIG4envgWk+Vfmi4MHbG9C
 HSW3kfo/ec4/DR4jwz5j0C73rI3bPx7jl5ap1fv8ZEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=6fEy7F
 s/dx1VtqTnuZoxt0adG8wN+t1idcCWjjhTniw=; b=fKu/e8wTtCx6Gm89kGjaJN
 CUILdofTS1qbhKJ5EGRH7EGMBXr+8vPC7YrEgjMXEiIfKzTx06/QN8ktVEM4qh9n
 CWOXoeelJ6Kdok6sepIYSxl8bgTJ4KMXRJWahJI85aIu5cJYCz8HwFaaKCh8SaB6
 H9QISFx7knyMaWNsdMmrFZ5dFhjKHDYgaKtck2zoBwG5mJf+yKAHmJd9fo5Vj0TR
 +LYK4xP8X2suy6xgcLGN3rN/7PVzEkqA82xagmISrAE+2DDeKQtcNOOzFPEYgGTI
 CZ6zY2n74k/DyZgA5ZSgm23zgQBhR5toSIyvb4Ycq5Au+w7+s3GSwh7FSp0GHiIg
 ==
X-ME-Sender: <xms:339tX0JszhOvq4mvlH7kAnIwUD8ll9y69AbFO0uQ9Yw3i-gKkzuDnQ>
 <xme:339tX0KA9TQMqkz6sKXUof3VYjRnU16I1wz2U8-gvuf2cpliwTzOuiAnvuNqAi1tk
 SQCCeaGoQ2UDijYWyM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudelgdeludcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:339tX0tA-43MoU3QmWQqzyyvC2E8U9xZ0SvkfhLFFqkbNRYmmRzVRA>
 <xmx:339tXxYuxcO6Bl89MB3_hfDgUfPEPRmlKA1AdhnRBWAa1Kjsg4KbbA>
 <xmx:339tX7Yn6E5z4PS58rmKH03rodb1szyKMDy_SPgUmOg-tY57mBINuQ>
 <xmx:4H9tX2wjl4zfQ25IegcfJIx9ayfDqaerRXd6VwS9d_bVFogSR0yRbw>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id E8D6B328005D;
 Fri, 25 Sep 2020 01:27:57 -0400 (EDT)
Date: Fri, 25 Sep 2020 07:27:56 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 00/16] hw/block/nvme: zoned namespace command set
Message-ID: <20200925052756.GA1899703@apples.localdomain>
References: <20200924204516.1881843-1-its@irrelevant.dk>
 <20200925012407.GA5897@C02WT3WMHTD6>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <20200925012407.GA5897@C02WT3WMHTD6>
Received-SPF: pass client-ip=66.111.4.229; envelope-from=its@irrelevant.dk;
 helo=new3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:28:00
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 24 19:24, Keith Busch wrote:
> On Thu, Sep 24, 2020 at 10:45:00PM +0200, Klaus Jensen wrote:
> > Finally, I wrote this. I am *NOT* saying that this somehow makes it
> > better, but as a maintainer, is a big deal to me since both series are
> > arguably a lot of code to maintain and support (both series are about
> > the same size). But - I am not the only maintainer, so if Keith (now
> > suddenly placed in the grim role as some sort of arbiter) signs off on
> > Dmitry's series, then so be it, I will rest my case.
>=20
> I think it's neat there's enough interest in ZNS that we have multiple
> solutions to consider.
>=20

Yes - it is a luxury problem :)

> I'm still catching up from virtual conferencing, but I should be able to =
have a
> look over the weekend. I know everyone's put a lot of work into the devel=
opment
> of this capability, so maybe there's something to be taken from both? Not=
 sure
> yet if that's feasible, but I'll have a better idea on that later.

Thanks Keith, sounds good.

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9tf9cACgkQTeGvMW1P
Denatwf/d2XNqwuHV9su+QANmyJQ9rFuRG9FOo3GYjNb8E+mq8T8S9ooEVrHISKc
j/9uktWnpUSoGaXjhwcgVrsrk4B/GDsI+CzbH6V1RdtSyDB55abeI/ck601Erixj
qFsYLl3v5V3xFm0PlxfiMUM8jw7P3OeO3XdeXAZyGwT4pGEveBrCWH/PP7MrAmj7
0VsrVj0O9uoIqR7GhEGzDX4704twHlYYROnOiS8HaeBmEJczrYv51ZniXnkOie7W
WU95efWo/GunKW6X4ib/T76pAEaWS3kKoacur3R0M+LMfb1h7ythxtYJIAVqWFXL
GEnLNKu9KfjSZzN0NLK82uo+QcCohQ==
=3OHw
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--


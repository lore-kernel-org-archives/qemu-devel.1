Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46A6C55178
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 13:18:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5DAE2067D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 13:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5DAE2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY7oX-0007rL-E8
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 09:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kY7l0-0006Kq-TY; Thu, 29 Oct 2020 09:14:22 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44021)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kY7ky-0003Lg-L1; Thu, 29 Oct 2020 09:14:22 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 6AF295C007C;
 Thu, 29 Oct 2020 09:14:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Thu, 29 Oct 2020 09:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=/hFL0HvrLcnD+feQL7F8JhgR5kT
 cgIVJMIg/0RKOumw=; b=YfTx7ThriDjsscZmZaBE4yHewinShx0jyNahYejKkT9
 g7YmX3oD1ChVNCRYDnR0Nlho9Bc8iWM30joDG+YsChBfStq+OCCer33SCW0AMEa/
 +CyCe4QuVsGUO5OTpI6Z4W3KrrWy5+ZvNxHIXlP0ND4MxCq4BmqNI9LyjPgLuIGm
 Sag6YOufsJhrdUpfHsyfvKiptda4Lin/zzbsgtn3bhUgb23mvLrbPzPN6Z6fP/e0
 U5VkHZzvEPaeysnxnFD54UtxyfpJ+cK9aNiGfvc99DMR+hVUUgY9IZ9vVVT4FMHw
 PaOOBY6XMkGhvjgKz42+efUehCwpkSn6hvKr09xi/KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=/hFL0H
 vrLcnD+feQL7F8JhgR5kTcgIVJMIg/0RKOumw=; b=cyhxxxenxr4yXO6IkkPqdQ
 GfZ5HvgsYxXy+Jqzv4ga00IGcUyaPHCJIalzQwXz57hGKb9ZOxpqZ+Lou1e9WTGf
 qzXAYF6FY+ij85kzKi5PvdISFbso2QugcpZtlTSmT7wBY1PdR6wVMF+xMEpMjTGJ
 Bf38K6pYLaz8gwWIhmAThayJsPFjzbVWdZx4X7TgKwn5+ajw5Pg3mNz0+WRGQrGr
 2KAGvwNoe9qytZs9FdvoKH3BIwx+jCJWlgW+8Ffo+AnmwAv2Z35Ixa2gGbE2kHBy
 HNOoGIhKMVyjohjTUffECAR9Feo33d7m8nVtMzWqUyCltraDBmvgmnjjvjuvHmZA
 ==
X-ME-Sender: <xms:KcCaX8YF7ca3UCXfxYKOwe4uDGeWRpAsSkR62HXanKZkKa75e3_eVg>
 <xme:KcCaX3Z1mfTdSe4eKx4TJGf-CWDtC0Xe-L1LPK_lC_W9pqOgbd3UwRW_5HGzHfYk3
 041pJYlfsNVxfiU30A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrleefgdeglecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepuddtheelledvtedvfeeuheegvefhjeeuleeihfduhfeiffffhfdutdekkeeikeef
 necuffhomhgrihhnpehinhhfrhgruggvrggurdhorhhgnecukfhppeektddrudeijedrle
 ekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
 mhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:KcCaX29fB5ngWhr-rgagTAU7fW7rCJVUcnzgMfODnz7tJmHeYiyBUw>
 <xmx:KcCaX2rIGEmJMp9_j0IvsabqpWciQL0NohqDgBnDLfLjRps8Bnv0uw>
 <xmx:KcCaX3pVmE3pTIojYeIcfN1JPjh6sK-7Zr8RJ9dlCk_rvWciSQcVfQ>
 <xmx:KsCaX4njPUhBjWSQ2py_WbnhcGnkRSpO5NMpofxP8Rso709Zspakzw>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 3E4A73280063;
 Thu, 29 Oct 2020 09:14:16 -0400 (EDT)
Date: Thu, 29 Oct 2020 14:14:14 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PULL 00/30] nvme emulation patches for 5.2
Message-ID: <20201029131414.GB777050@apples.localdomain>
References: <20201027104932.558087-1-its@irrelevant.dk>
 <CAFEAcA8EcEfaFZYUicbL5ShA5y5sTP7hmNNX5Ot=3ZyAGnV81A@mail.gmail.com>
 <20201029115254.GA777050@apples.localdomain>
 <1cd6447c-66f2-df28-a3ce-94456a17fcf4@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
In-Reply-To: <1cd6447c-66f2-df28-a3ce-94456a17fcf4@redhat.com>
Received-SPF: pass client-ip=66.111.4.27; envelope-from=its@irrelevant.dk;
 helo=out3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 09:14:18
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
Cc: Keith Busch <kbusch@kernel.org>, Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Klaus Jensen <k.jensen@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 29 13:20, Philippe Mathieu-Daud=C3=A9 wrote:
> On 10/29/20 12:52 PM, Klaus Jensen wrote:
> > On Oct 29 11:39, Peter Maydell wrote:
> >> On Tue, 27 Oct 2020 at 10:49, Klaus Jensen <its@irrelevant.dk> wrote:
> >>>
> >>> From: Klaus Jensen <k.jensen@samsung.com>
> >>>
> >>> Hi Peter,
> >>>
> >>> The following changes since commit 1dc887329a10903940501b43e8c0cc67af=
7c06d5:
> >>>
> >>>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/sd-next-20=
201026' into staging (2020-10-26 17:19:26 +0000)
> >>>
> >>> are available in the Git repository at:
> >>>
> >>>   git://git.infradead.org/qemu-nvme.git tags/nvme-next-pull-request
> >>>
> >>> for you to fetch changes up to 843c8f91a7ad63f8f3e4e564d3f41f3d030ab8=
a9:
> >>>
> >>>   hw/block/nvme: fix queue identifer validation (2020-10-27 11:29:25 =
+0100)
> >>>
> >>> ----------------------------------------------------------------
> >>> nvme emulation patches for 5.2
> >>>
> >>>   - lots of cleanups
> >>>   - add support for scatter/gather lists
> >>>   - add support for multiple namespaces (adds new nvme-ns device)
> >>>   - change default pci vendor/device id
> >>>   - add support for per-namespace smart log
> >>
> >> Hi. This tag appears to have been signed with a GPG key
> >> which isn't one that's been used before for an nvme pullreq
> >> and which isn't on the public GPG servers...
> >>
> >=20
> > Uhm. Keith, can we coordinate a keysigning?
> >=20
> > Would a signature by Keith on my key be acceptable to you Peter? That
> > way Keith doesn't have to create a new tag and bomb the list again.
>=20
> Although list bombing isn't really a problem, if you don't modify
> the patches, then you can simply post the cover (as v2) without
> the patches.
>=20
> You can also get your key signed and ask Peter to retry your tag,
> or push a different tag and ask again, replying to this cover.
>=20

Thanks Phil!

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+awCQACgkQTeGvMW1P
Dek2lQf/Q3YH5auqi20rMdosW60Hy66VzA7/ntcpRbsT+foUfyLaABT7EGdNMJ46
tYfpSJ8dW1NWivg2xYN6Im6dGWLTAsmExqNBAzquTVRqvoovoVaq8iseIcouHBk1
FRbhmijCOE/AtLcbMmEHOp23CRYM0NloJbMkEUOvlsBmuVwMwJ6R7t9TVSxwQiZi
cv2+q/SAfgWkehhHA87pRMugzZtdQAAeLMiUps170rDBoX5zRyHMNJ7ttiHbDOuk
yMEwT62B0EbLf7g07tZOYpxCGOUPcvdOOMhbkbUXT+byn0SsW5QVYA019jSdkrM7
vcoSFEx16bEAvmBYdrl0HRru8dkAzg==
=QAvW
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--


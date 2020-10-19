Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB55DC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 19:35:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5552E222EA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 19:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5552E222EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUavz-00027c-09
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 15:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kUasD-0000bV-Qu; Mon, 19 Oct 2020 15:31:13 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:45561)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kUas7-0004le-8j; Mon, 19 Oct 2020 15:31:13 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 7B1EE10D8;
 Mon, 19 Oct 2020 15:31:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Mon, 19 Oct 2020 15:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=MKxz3KSapZ/tiIQ4VHe1rmw6c5Q
 KsDPnhdrRmvlA4WE=; b=GRMkotzZjW1N+f9QFhkHLRVVhZzkCrg+YeSrFbMwO/R
 9uCAyWV5+dGPykhuoufyBDfwtHz588b/YYdmYxQuoDhpuPVe0sMi+9i/b6PXjltP
 xEq+Ti6j46lX87T7eLmCLvjny53sTpXWz7f/1IukOJCwVDihhQ/8MGecfTqI+BM1
 equrvAIo0epwcpWhwVucDKLuyXNcTB9c/xQfuVkSToHIyyXmSGdyaMhN+z0cZECn
 khMBHHabJk+SMWRVvcN4UlHzAM3Bt9B0TP0c8NPOfdAJQY3QFFe9DE+vsWWhlqtt
 nRgaveNIK4FfmqPC8+SORUwbtP4bsfd+ae8ioTuMoCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=MKxz3K
 SapZ/tiIQ4VHe1rmw6c5QKsDPnhdrRmvlA4WE=; b=PJ24RKgaBSu5tCVXsIyNmi
 yk1yqNynwXI9ZjQtu0Up/uj0U6Nf8GXPcvQnzegdETxe+a+Uqsna/CGpn2daZBkx
 YFPcuufIcyuAXwbNDguzALCIzCEgHtxMJJYcCcg9GelVKGBulSMeV+Q7xtXlFAcX
 zNrcuUi1cwfMDSZ5M2V0wiLwtEB/4O9UO8V3IyQU0tbHwl61QRfxj2KwokZyw6ff
 sx6JHtxxPYwlzmGYfMkjWMZ+Iv3ovLukQJQWdZYEbpwlYFtzH/EA26hdp2n6mk9k
 4b2/j8nm+WaGtN7UzZDXQnd0SHcM8qMJzalKJDqNVXixAq6Q5zZvQPcpE+0uoDjg
 ==
X-ME-Sender: <xms:demNX-TM0AFz4JlvALBpTVQI36n5Q3qjbm-Yut1ZucsM5BFAntvfLw>
 <xme:demNXzwxIkD7aSlLqS3q96Yah907yoOZ5-jEZxRXmx0oaV3zDD4uoOIYC84f_rFVb
 uXqsB44eCZqUd_Bpgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjedvgddtvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:demNX702e2n7k8yD8Aec9l2yttAPiIi0wWbwO5bdOkOALpyfYe9ajA>
 <xmx:demNX6CIwz2EL14bOTT3bYkoeI4HnFcRnqoIAUqEAY2b2llbiYkUNA>
 <xmx:demNX3iwxOg_kWhUZVhpIOMZp2ZF0Bhk-S2TZRTU_fcWg5k-Rj_O0w>
 <xmx:dumNX6pQ8iPJtF2Xe9VqdnkKB3Si25Zxx7d2SB1JWsa0nSkjdEThPxqr81LXkbPQ>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 9BFCE328005E;
 Mon, 19 Oct 2020 15:30:59 -0400 (EDT)
Date: Mon, 19 Oct 2020 21:30:57 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v7 02/11] hw/block/nvme: Generate namespace UUIDs
Message-ID: <20201019193057.GG10549@apples.localdomain>
References: <20201019021726.12048-1-dmitry.fomichev@wdc.com>
 <20201019021726.12048-3-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vJguvTgX93MxBIIe"
Content-Disposition: inline
In-Reply-To: <20201019021726.12048-3-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=64.147.123.26; envelope-from=its@irrelevant.dk;
 helo=wnew1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 13:31:09
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


--vJguvTgX93MxBIIe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 19 11:17, Dmitry Fomichev wrote:
> In NVMe 1.4, a namespace must report an ID descriptor of UUID type
> if it doesn't support EUI64 or NGUID. Add a new namespace property,
> "uuid", that provides the user the option to either specify the UUID
> explicitly or have a UUID generated automatically every time a
> namespace is initialized.
>=20
> Suggested-by: Klaus Jansen <its@irrelevant.dk>

s/Jansen/Jensen

:)

--vJguvTgX93MxBIIe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+N6W8ACgkQTeGvMW1P
Den4NAf6A1RjXrLCtgI2coo3YVCT/5dj7hworVEKc+XgJj6xxSXfNzVQDZZpAbCw
pFwm+x08A0My7BDjOUemgqPl2oO8YO1BZzf33HofEEU1+XRiZp5w9X1vcQovfmrr
jgnIXQ08zqX8rRCbrfHgkT/MDf1NNZh6UsefciwBYPsA7MvvdX7Kj7kXM0ov5Ner
GW/jGsLW5GYrUF6mDqfkRwlDBlUknTr6JU/rVEvzUxDDb4Qk/vWG32+ks7DD0obZ
QWqL0CDuI25UTzfXPYrTO9puq9E1LVzZFFlJXksgzTo8icir/0myq8aes+zgB8qp
ZFGHrpZ65+AHq+SZZWijb2wbSZXF7Q==
=r7a8
-----END PGP SIGNATURE-----

--vJguvTgX93MxBIIe--


Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C99C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:33:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32E382222F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E382222F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUn5O-0001Cx-Ue
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 04:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kUn18-00076U-8Q; Tue, 20 Oct 2020 04:29:14 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:56117)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kUn16-0007Ht-Fl; Tue, 20 Oct 2020 04:29:13 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 0D0A79E7;
 Tue, 20 Oct 2020 04:29:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Tue, 20 Oct 2020 04:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=4Md/RH6R/JODYqrDMQ+BP8xCRJW
 X9txwAmGCTkc9Yw4=; b=VDsV3RIDRCqX0NlmNwh0yvt/W1trFTIBzyK38He6JsJ
 /3E3w7XVzH89nKIuAAtW0mKB/MVSxZDtNlcyRTC++bf2BLQrGqvNYDU2qj87wDOT
 r/GTYFgVBk1Gr/4icDVmpTCEfVTbkocJKs24lt0amGpIJpOojW9rfyuXZEK2t/P5
 GcvFQgwnXiy84siR5DDYt1oVfzzwX2fNwp50+TCBeqlGaWVa/sgCY+0Ak3yMN3l/
 6dUUHmIeUAamGtq+M/x7TcGSGOuwVWH6pKBeHkNBuIUp4EfJLbxyiQfe9qfrWZmQ
 4cFt9znz+Hd7Bj3CEwnEmYq/BFVu0zrT0Y/dADQFyoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=4Md/RH
 6R/JODYqrDMQ+BP8xCRJWX9txwAmGCTkc9Yw4=; b=Qylv8xthy5Xe4ev7qhE34n
 EuET6k/03aO/y26BimgdeqNVplUDnI/F22GV2Yx3GfQFiR7JKOR1HaUGDp+vWUAm
 93Eouyy/KOYM7iux3RXDIrzm/ExGLtqIhA6wa7lpvM4Z6Hqe0wDuJvwFg3xbGCDp
 apVDX2Nig9D1bnFXR+EPS8LldjFDGaby5Qq/bL2SoKZXXEzhkTqhW9WIFXtytLMg
 TQfF0B4w7pMffmByWVN+p90F1TdVI31yRENuAZBGQGHUChRRVbB/KQkLdKha4kvF
 P+Hlw7mAOLWq8DBuFv+DTJh3Ug6s7t+5G3/zKyboRYtLzSVFUubdQ6VSLzyj/WyA
 ==
X-ME-Sender: <xms:1Z-OX53jHm4ztqBDgzbMG4PW4RChRT9mNeTVktMzCVSufuyk-6jmUg>
 <xme:1Z-OXwEUWOYkSHzK8aXXwwW-6jB3ymZmJC2Xa0xI1yN83qv9Wi1DEHGxDv0BGYOcc
 WHz7Iv-jTQIqDM5a4k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeefgddtfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgepudenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:1Z-OX57CxXuDM-VLhldQwxwv0SItdDci1iINrHPDoxpRHqb9SWlqCA>
 <xmx:1Z-OX209mRKUjlPs5CVTDvpIST9xBy3WkvO1p13As08kP8goZl_QUA>
 <xmx:1Z-OX8HZLvtaIhQYP7gKshEyKs5G-w-nKSQtNaT63-gS2nS5DVOa_g>
 <xmx:1Z-OX_8pLD_EH4o9pnb-KrJPRV57xJ-CloX0RuWUPg1IzdABFNIx8z24YBg>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id C6B323064684;
 Tue, 20 Oct 2020 04:29:07 -0400 (EDT)
Date: Tue, 20 Oct 2020 10:29:06 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v7 11/11] hw/block/nvme: Merge nvme_write_zeroes() with
 nvme_write()
Message-ID: <20201020082906.GC178548@apples.localdomain>
References: <20201019021726.12048-1-dmitry.fomichev@wdc.com>
 <20201019021726.12048-12-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Content-Disposition: inline
In-Reply-To: <20201019021726.12048-12-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=64.147.123.26; envelope-from=its@irrelevant.dk;
 helo=wnew1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 04:21:24
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


--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 19 11:17, Dmitry Fomichev wrote:
> nvme_write() now handles WRITE, WRITE ZEROES and ZONE_APPEND.
>=20

Same here, Acked, but maybe move it in front as a preparation patch as
well?

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+On9AACgkQTeGvMW1P
DenpIAf/SYhr8M114IqdPYVz9k4rCd10gBTvxqsikdMAifftPlwSEkDliQ3pf9a5
MK5Lfa0wdVTI/6E2dKZhGE5MQybQ1uj+/sXbXxQHwWLocOv5U1S1GAI1pPrDQsuD
8PkxbgR33etU6wLthK3IAMNgcT8SohK13P9fTnCVOSFwJ7nigGGdQXF+9QZDQOgI
rpfXk0Gv0xu9R6hixMxjbx7o9AxoWsMhVFIDTXFauwgYmt9flD6gqjZTNsicHxa5
iP5D5Ss+L4v9WP8dm5MDc4iE93USlbZqqdX+rVfqg4+dJ6/wMUrRrTY9z0kK6/A8
LXzuFJqqchnvgUjhPmLT+XOaWMlPpQ==
=0M6y
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--


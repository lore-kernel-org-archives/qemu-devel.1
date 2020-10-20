Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A7AC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:26:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DB1D222C8
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB1D222C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUmy8-0003SV-DQ
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 04:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kUmtg-0007JF-75; Tue, 20 Oct 2020 04:21:32 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:57053)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kUmtc-0004PB-Jz; Tue, 20 Oct 2020 04:21:31 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 0C439B47;
 Tue, 20 Oct 2020 04:21:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 20 Oct 2020 04:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=sNjh9PPK3pOaPfYbDpJQNCXgkQR
 cUV4hdxAA544JLN8=; b=XYstEw0WilkQDHYXT7JpkrSe2Unt02YcvkDTS5CGzNv
 o9wiOkS83oraR3SaYpm4iMzm0FcCZuTCM4E8StfXWZt6QpP+oQCSfFPGvi6Dq7zm
 B98cfW79bQblzijAGgBwumiN43d2xj45lH+wwMlX/z9R5Gx6EeGyXib2vGtjP9Uc
 t3IVg69Gb+ydHqUqgIHzq7YJQmOpls1l5ymR8TLM2MLwK9tiPfywCpQLZ3VAA8hw
 Sut+vvACK/AKsAV8OtticVkbOUsfHklE7rtEnh3GbjIc9WMdCU8yCfO50wRKWDtp
 RLQrcBIRvCbgtM+OxDWV67UDm+HKmqjNdGl9Y5bdEnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=sNjh9P
 PK3pOaPfYbDpJQNCXgkQRcUV4hdxAA544JLN8=; b=A1V6Y/q4G0KX3RELiFXjUH
 kc0wI9PAdupcZDpx6g4uGcZGbifLFwe1npFyfegwzl/wBHjKfeKVyGn58Wd5574e
 zhaKU1/LIC/78RD0y9+2AbUNng1MCyI2A7sNKGJd8fe1dJOyUxE8yTHTVaPCs+Tc
 eSSkwIQ08O4EIeELS/8U2qjqxCwU9WCeuxV2fihMawI/RjcT34mBavmWl17L/uaS
 9oNkBKwKt2d/PoQsLFlNcwO0VHpi4bCwXMt2K7ox9rYW0AtIxigPQYOfQFI/NmT1
 35MeSNePE3Ac3K1h0C95BpnSFObx7bthr/ji0pk3oH8hNPZqg+pSsv3iLv90A+Rw
 ==
X-ME-Sender: <xms:AZ6OXwao8WcLiUdfa4NE4Q97_hL5UHayAoFV4iTGF8C8bzCTE3s1Sg>
 <xme:AZ6OX7YKWMCmDxqEp1By5uqHJgJyCbkGctWeiTIBhu2K3Ud5ivVBLUYI_KbatnzfX
 FIoecek0JlT0437aWI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeefgddtvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:AZ6OX69rRKoHhBQb4qsy4HC1q4ly450PSsgBVGOd_iURW3MgpriQyg>
 <xmx:AZ6OX6p_GEQJAznvprU_CBoMSxj5QuaNHid8hn5tZ5w6viVCuPl3iQ>
 <xmx:AZ6OX7rbHFoxUvI5rHOpip64-NpLsdqkkQUb_J2RJ1dFUVqLzUcV2Q>
 <xmx:Ap6OX0QCVoHzvQ-exxWbGBZg4Dr1RjEnRu9b9yB-8wJUyjIpUDfFpSEW3W8>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id EAD7D328005A;
 Tue, 20 Oct 2020 04:21:19 -0400 (EDT)
Date: Tue, 20 Oct 2020 10:21:18 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v7 04/11] hw/block/nvme: Support allocated CNS command
 variants
Message-ID: <20201020082118.GA178548@apples.localdomain>
References: <20201019021726.12048-1-dmitry.fomichev@wdc.com>
 <20201019021726.12048-5-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <20201019021726.12048-5-dmitry.fomichev@wdc.com>
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


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 19 11:17, Dmitry Fomichev wrote:

(snip)

> CAP.CSS (together with the I/O Command Set data structure) defines
> what command sets are supported by the controller.
>=20
> CC.CSS (together with Set Profile) can be set to enable a subset of
> the available command sets.
>=20
> Even if a user configures CC.CSS to e.g. Admin only, NVM namespaces
> will still be attached (and thus marked as active).
> Similarly, if a user configures CC.CSS to e.g. NVM, ZNS namespaces
> will still be attached (and thus marked as active).
>=20
> However, any operation from a disabled command set will result in a
> Invalid Command Opcode.
>=20

This part of the commit message seems irrelevant to the patch.

> Add a new Boolean namespace property, "attached", to provide the most
> basic namespace attachment support. The default value for this new
> property is true. Also, implement the logic in the new CNS values to
> include/exclude namespaces based on this new property. The only thing
> missing is hooking up the actual Namespace Attachment command opcode,
> which will allow a user to toggle the "attached" flag per namespace.
>=20

Without Namespace Attachment support, the sole purpose of this parameter
is to allow unusable namespace IDs to be reported. I have no problems
with adding support for the additional CNS values. They will return
identical responses, but I think that is good enough for now.

When it is not really needed, we should be wary of adding a parameter
that is really hard to get rid of again.

> The reason for not hooking up this command completely is because the
> NVMe specification requires the namespace management command to be
> supported if the namespace attachment command is supported.
>=20

There are many ways to support Namespace Management, and there are a lot
of quirks with each of them. Do we use a big blockdev and carve out
namespaces? Then, what are the semantics of an image resize operation?

Do we dynamically create blockdev devices - thats sounds pretty nice,
but might have other quirks and the attachment is not really persistent.

I think at least the "attached" parameter should be x-prefixed, but
better, leave it out for now until we know how we want Namespace
Attachment and Management to be implemented.

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+OnfkACgkQTeGvMW1P
DelmmggAns78TcOR8S003gbK3JlLkiLL6pfqp0oWBpPzthhfsqIqVjGI2TmCeuDJ
LksmvI5dWv8uiG6LrGTAFh2R5If2yUnPfqa19oGTvIacLHveubhMQmZj1GYdFFlI
xq6/sgRINYb2NiCdFJFZFHgyCDp+XDhcIlZ1hNmLDN2aGmsJXyS0KThh4Rz1CXyJ
yNugoqhQFNBhv+WqC5O/yxBZN2rTa4kK+UFeZ5lXjWlupLEV1cEiysGqQzw0hhF5
WCJCsbiF7ZPJot7iBqL+5h9RMWTz0vAJC2HUgx0kGwYRAhK3+vxAScpSsAWW1eZ4
7sumbSs5+X3IweKJyxQ5Oave4Ml7AA==
=QIyQ
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--


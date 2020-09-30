Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B346C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 08:18:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE58E20738
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 08:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE58E20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNXK4-0000Me-IV
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 04:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNXHE-0007oM-Tv; Wed, 30 Sep 2020 04:15:53 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:55037)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNXHD-0006DK-09; Wed, 30 Sep 2020 04:15:52 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id C856EF94;
 Wed, 30 Sep 2020 04:15:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Wed, 30 Sep 2020 04:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=H82lk7FzpkAUz9vmBiWHeb9QjI5
 GPmC5U+IUuvpVA3M=; b=uMv0TtxNBwD+dAV+qw8RXctppju0S9ALQ4t8ENgxDBu
 JIF72oeCQArRN1cu4YFXohW3djymQ3Lh3Edl7tiwnEkha6Q/2SR/zX7ZtLPgp55z
 iFVGJL4oCdBgdTH60EQYgv0MNomvXkURzBBax9o5L0sQfXqy/t9VluKyAVN/ldPL
 Z44YVzqInba0clLldYBEfOHahc1OcC/Gm1U4QbhWfhd5p5FAA0Lnfmr3I3uRqAIE
 uZrDs8wZrBU7fKF2MQvZYnn/UvP5ywIJIDUqcduZEXrbldDAC+C/DcWSftcwt5A+
 FQ2QPpY1uBnRcPG4JVeu4AcVZNPNOf9K/d2tkSeAd0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=H82lk7
 FzpkAUz9vmBiWHeb9QjI5GPmC5U+IUuvpVA3M=; b=FvjyBnPLOgJkK/+C+pG9EI
 K+XnIudTlFHi40IgOpG/Tvw2Ur0CRwFpCn8Mie1S0fzJHSAveLReTy0QqYVH40SI
 Yk16ctKRzETvRb8zy9r7gNExjd2Q0PyoPU2LFpGhp7hzqgaoA8DYQOY7bvRHSM9y
 GBfIPDgmUAi/a0ti69CbOFLjYKDfahDd3eCx+MoJbkNwwc08JRMfMqaJ3wQgrybE
 mu8E7cLg0BjHQEpksEsMs9uK62RPoELMGs86tMPiDZWG3Iq+eG+kVYzTCLq39cLl
 jaEuq3G5Sa0tiocJb7QvqJ63dQ+wKV19BglWa1EPjz/0QkX+MTAYoZXEyFT/WIVQ
 ==
X-ME-Sender: <xms:sj50Xyk0pQ_gsa65I1wTrkvMm_PCU2Vztc_bLYqDRKUd-s72y9M2Cg>
 <xme:sj50X50n9gHhraB1HJ0jXlD6PJUOpyv51Xx9F21BoY0sMIuOLSE8hgQ0_SaFclwgo
 nTyJsf1GY0hbapQfRY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfedtgdduvdekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:sj50XwpEgp_3XfgJKLFfLb4btvKHfChOzebBPFjtinWoWI-HxMtiHg>
 <xmx:sj50X2lgs52sMUGapHL0ZfUxqoqDEDwE6-S4474NMNOGFoAvhJ24ZA>
 <xmx:sj50Xw0nDnkg-dFLM9YpTnJtf5GE7YgHD-Xj1zJ8Xlj-FPfZbiBacA>
 <xmx:sz50X1tqYRBwupiPZPlooHJzJ1CNZCUActb9Fkk0KUk-2w7sLpi5XbJK9_huFaeh>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 6757A328005A;
 Wed, 30 Sep 2020 04:15:44 -0400 (EDT)
Date: Wed, 30 Sep 2020 10:15:42 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v5 05/14] hw/block/nvme: Add support for Namespace Types
Message-ID: <20200930081542.GD436843@apples.localdomain>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
 <20200928023528.15260-6-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mSxgbZZZvrAyzONB"
Content-Disposition: inline
In-Reply-To: <20200928023528.15260-6-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=64.147.123.26; envelope-from=its@irrelevant.dk;
 helo=wnew1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 04:08:08
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


--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 28 11:35, Dmitry Fomichev wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
>=20
> Namespace Types introduce a new command set, "I/O Command Sets",
> that allows the host to retrieve the command sets associated with
> a namespace. Introduce support for the command set and enable
> detection for the NVM Command Set.
>=20
> The new workflows for identify commands rely heavily on zero-filled
> identify structs. E.g., certain CNS commands are defined to return
> a zero-filled identify struct when an inactive namespace NSID
> is supplied.
>=20
> Add a helper function in order to avoid code duplication when
> reporting zero-filled identify structures.
>=20
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  hw/block/nvme-ns.c |   3 +
>  hw/block/nvme.c    | 210 +++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 175 insertions(+), 38 deletions(-)
>=20
> diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
> index bbd7879492..31b7f986c3 100644
> --- a/hw/block/nvme-ns.c
> +++ b/hw/block/nvme-ns.c
> @@ -40,6 +40,9 @@ static void nvme_ns_init(NvmeNamespace *ns)
> =20
>      id_ns->nsze =3D cpu_to_le64(nvme_ns_nlbas(ns));
> =20
> +    ns->params.csi =3D NVME_CSI_NVM;
> +    qemu_uuid_generate(&ns->params.uuid); /* TODO make UUIDs persistent =
*/
> +

It is straight-forward to put this into a 'uuid' nvme-ns parameter using
DEFINE_PROP_UUID. That will default to 'auto' which will generate an
UUID for each invocation, but if the user requires it to be
"persistent", it can be specified explicitly.

If you choose to do this, please extract to separate patch. Or I can
post it on top of nvme-next if you like.

--mSxgbZZZvrAyzONB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl90PqwACgkQTeGvMW1P
DeneAwgAsvCqsFpJ/k4shj03xeG67mVL+qfwNVc7Zq+RScSpB6B2EXlOkZk0AaUx
zF2uUEOfo09XV5Mlm9eXBNxYjVeCLd2461x3SEfHICWBSNAuuS9hS9jk8ZZeCBBD
/SOBZyJhz/nnE3tsbIEn7BYaZCIRCSF/aBzsrs3Lvy0KuyJqanqY0prNb9yBwcyC
fXOQ/yaWuoDLfGqLZJGJJB1RQqk7Hjp/n56iCjMz3JBKNdR5kKXK5MdM+ZmGYgFg
Wse+HJlaRruwkmHqpSZZJQp1cBZPj2dnqTS5erAI18lGd8W0abGCU7S5iZXL7o1G
jEXp94eg8lYLFyCbwibHHDoALaJGDA==
=amdx
-----END PGP SIGNATURE-----

--mSxgbZZZvrAyzONB--


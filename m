Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8ECC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:49:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 650E922268
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 650E922268
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUTex-000452-V7
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 07:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kUTYn-0000Ds-6l; Mon, 19 Oct 2020 07:42:41 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:39607)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kUTYk-0008NM-PG; Mon, 19 Oct 2020 07:42:40 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id D2D6E340;
 Mon, 19 Oct 2020 07:42:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Mon, 19 Oct 2020 07:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=bNunAICK0DwTzC4dKY9RkLQT4q8
 uE7a0C83wfeZ58uU=; b=HMaH4K16tw6DFfzuhQ9WF1XWI11WjNT1lyDO+EILcde
 VuTV07rJsbwmwGGLHyXkPfUkJVGnoyXSwHrVXLoITqB88tH1XYZQq77yg+AsEnKK
 sHUw517DaZ5G0u2RwuZNylOOP3VfKyUwhkNzb41wCAef/7S4dY//hb9A4zCYujjS
 EDHfK9mVzB8yVN1OBZTAPaeOp4tKAql/CEIYFgelx+HhLwfzlliSnNrmLXEoAMCk
 VXXsYTgN/9dH1elyvxwyAQ56b3+OzPh8nJ2WmMJracyPrmf3g9Br+oT46FOJakul
 YKuViM0gTlixwAmzgnc+qkjLqv+rTabRgXnBjslGCeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=bNunAI
 CK0DwTzC4dKY9RkLQT4q8uE7a0C83wfeZ58uU=; b=ick9uLYJZK6od0FJMbYGOV
 6ltGKQvo3rD4RLzBrKwpUiipMDJykXj/947WWrjJJCdvsbyXQnqsWqpcElTNc+zr
 bFuuO/zZm3K7kNbnRY5uajvVmI1sqogJD8jnKXkIALdHrMwDPXrOxTWKLwue5Y4K
 qT7blfbL/8Icf+W4tyBuzXAwbuUg/cZaPkAarux5WLTz0c+sOAUIpG6Cdccx+F1i
 T7KXYoPRgZyvRFJiijiby8YeQsjnmZna84l2Y75rG4aCxdtlVgwcl3J/gLsV/abX
 wgvYXQ7PpGrrwVx1o+zdh4qQvi+o3IBIJ0l1fLWwoIMK/4PA5u1mR7TAbysaYQ6A
 ==
X-ME-Sender: <xms:qnuNX3wVm3JtZdc00ojLgFYrTktPtEYTDW99eOh84aFnCQ_zhwFgPg>
 <xme:qnuNX_Spm78fRKPEDny7QhEQT1n_FRg2PpBrqL7GFnWpDLkU_5TNbTs-G3FDl5rEZ
 PpKV0DyA8xfkbdcvJk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjedugdeggecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:qnuNXxXtSKw3e65_py8hfDBvPeFxU2nbmsY5szLr_jEmtRs3lMVDTw>
 <xmx:qnuNXxg8TeqwORJpmHJ8L9F5JaTlvl4W4LcF8f6Qg2IMUiw65KbKqg>
 <xmx:qnuNX5DqQ5k7wjF5N7S-qBRUa-7z6j4U9kvVXAHpmDBGW9xzUV0uvQ>
 <xmx:q3uNX-IauxkPnw5xsRSw0hJh5HgXJcGgDhvPfUthgKRX10f63BY50H1Mr9aOiIC4>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 4B14A306467E;
 Mon, 19 Oct 2020 07:42:32 -0400 (EDT)
Date: Mon, 19 Oct 2020 13:42:30 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v7 08/11] hw/block/nvme: Add injection of
 Offline/Read-Only zones
Message-ID: <20201019114230.GB10549@apples.localdomain>
References: <20201019021726.12048-1-dmitry.fomichev@wdc.com>
 <20201019021726.12048-9-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
In-Reply-To: <20201019021726.12048-9-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=64.147.123.18; envelope-from=its@irrelevant.dk;
 helo=wnew4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 07:30:44
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


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 19 11:17, Dmitry Fomichev wrote:
> ZNS specification defines two zone conditions for the zones that no
> longer can function properly, possibly because of flash wear or other
> internal fault. It is useful to be able to "inject" a small number of
> such zones for testing purposes.
>=20
> This commit defines two optional device properties, "offline_zones"
> and "rdonly_zones". Users can assign non-zero values to these variables
> to specify the number of zones to be initialized as Offline or
> Read-Only. The actual number of injected zones may be smaller than the
> requested amount - Read-Only and Offline counts are expected to be much
> smaller than the total number of zones on a drive.
>=20
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  hw/block/nvme-ns.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++
>  hw/block/nvme-ns.h |  2 ++
>  2 files changed, 66 insertions(+)
>=20
> diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
> index 255ded2b43..d050f97909 100644
> --- a/hw/block/nvme-ns.c
> +++ b/hw/block/nvme-ns.c
> @@ -21,6 +21,7 @@
>  #include "sysemu/sysemu.h"
>  #include "sysemu/block-backend.h"
>  #include "qapi/error.h"
> +#include "crypto/random.h"
> =20
>  #include "hw/qdev-properties.h"
>  #include "hw/qdev-core.h"
> @@ -132,6 +133,32 @@ static int nvme_calc_zone_geometry(NvmeNamespace *ns=
, Error **errp)
>          return -1;
>      }
> =20
> +    if (ns->params.zd_extension_size) {
> +        if (ns->params.zd_extension_size & 0x3f) {
> +            error_setg(errp,
> +                "zone descriptor extension size must be a multiple of 64=
B");
> +            return -1;
> +        }
> +        if ((ns->params.zd_extension_size >> 6) > 0xff) {
> +            error_setg(errp, "zone descriptor extension size is too larg=
e");
> +            return -1;
> +        }
> +    }

Looks like this should have been added in the previous patch.

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+Ne6MACgkQTeGvMW1P
DenAsggAkvuxQLC5ADkQyCUVpI/ZtYu44yadhDSQa1NkR2dAcarpIyxSNWsqWPwb
6vshuF99+LzgTouhNQh5y1X68FvZDSzqJEhe1Ugsv0YrNiIjY6gYNiMlTGgfzMwF
2rkExRN6FYZDY0AimvQYELfaQu2f1YrL72h5hFp4A9oe9Fi16ejZWjzFJz/1KB8k
nGXTDddioUIx6ie1X3NELoRDT+lBG33mC+KiWT70CimnqMmFYd605MaOWqusu5vN
XdiQ04s9smQ3EvkUJJbul6o8w4OtnN71S7raYFw14Xo6qMo3o/kh7kjuKlI4k28t
gCyqoWILzN+lRg6P+f/httLiphzwog==
=7s1E
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--


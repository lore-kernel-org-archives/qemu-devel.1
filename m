Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31F2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:19:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 101D72223C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 101D72223C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUpfd-0005LY-Oj
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 07:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kUpVt-0004LW-4p; Tue, 20 Oct 2020 07:09:09 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:38807)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kUpVq-0007Tt-5d; Tue, 20 Oct 2020 07:09:08 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id B71B39BB;
 Tue, 20 Oct 2020 07:09:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 20 Oct 2020 07:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=rkkANjUEmk9AiHck3nmkkDVCxsd
 JkoyluQDidlpuNyc=; b=vqbxv6qYhu5+F0+BlZGrpr/24a8Z5oslpQDEA4VF8IA
 n+STidQkdFG4VOfRiLbeGwXtdOC+AReYzA8tqffz9WQOs0ExtZRL2oxzGUOT8A3O
 SnVjrDG5F8PAnVOlSaGHjS1H4tO9IxIIgA5Hg11veYxOEEJVmmQOd4CQnEG1gweT
 zIhfRYnkPq1tnnRcsXpHEPB8ihtHs0QbXpl4xYnkcyGqDXsQkZDB0lLmKgGGWyDc
 XF1/VWwr1pb7SHBsBu2v7o3kwiBdeoA7OI02P39WSut6blzO5rFbi0jQjmSkuaME
 w1rmZwnx92/XEd/nIni/jtxNOV/Ei5OQOCPmeDOItqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=rkkANj
 UEmk9AiHck3nmkkDVCxsdJkoyluQDidlpuNyc=; b=n06uR3+8Jccd3/coaXu8Rj
 Tt5lWk+Gyl+3uokgeTEeQ/8jjmm+Sht7O8fRC1Orb+xfBKk7GIOL2MbI3CVGDiWS
 TnGq075UMjgRAYq4as09RxGIuN5bpZoW9HCEXRpSjwnEVk3RwuYFplkVuDzZnKkb
 kewXW0mKP7ue0jNNbhkCL6lBaW38h7b4n/7OshDno6dj7Aydnnp9WnG9LeBkw35H
 W/tOHUUDWdR3RR94rurf1NOj6FeRiRsY/Xd6uS5VCb7cEq10Z3hqDv331TYvg6gQ
 D6EjK5fAboLdbS5fPQSChlT1IKvrQIDwsIVhwGQnjI6fL7mPn9RdS2GqlLgdcs7Q
 ==
X-ME-Sender: <xms:TcWOXwttsS3SVs41rUoNE170bq4BVOsGwivl-vmxSX-nQO-y2SGfEw>
 <xme:TcWOX9drnTRsBVjoXVBgutoPqyzYaq6X8Yr5pxQ-ahbCMUJZWP9xZwWTQEHdNQoXt
 VXhGCqTEIQFg3bjBas>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeefgdefhecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:TcWOX7xsfqlhVPnrLIMIViXIUmB0eRA0mp2kxb968QwWy4qkVdkpyw>
 <xmx:TcWOXzOguEoT0NAtNPcjl7lFM6neNlFGAEJCF3h0w3cTp16JphS6vg>
 <xmx:TcWOXw_M0dWKoVuoTJhrTPxbjXeaNEjlqA8mvKFM8gm82RYakfXcFg>
 <xmx:TsWOX7Wi7dnm7wnp8OQ75p75PLlO79ZdN6BlUq3MEjR_xqz3Zep5z4OvT18>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 6A11D328005D;
 Tue, 20 Oct 2020 07:08:59 -0400 (EDT)
Date: Tue, 20 Oct 2020 13:08:57 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v7 05/11] hw/block/nvme: Support Zoned Namespace Command
 Set
Message-ID: <20201020110857.GE178548@apples.localdomain>
References: <20201019021726.12048-1-dmitry.fomichev@wdc.com>
 <20201019021726.12048-6-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SNIs70sCzqvszXB4"
Content-Disposition: inline
In-Reply-To: <20201019021726.12048-6-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=64.147.123.27; envelope-from=its@irrelevant.dk;
 helo=wnew2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 07:09:04
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


--SNIs70sCzqvszXB4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Oct 19 11:17, Dmitry Fomichev wrote:
> diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
> index 974aea33f7..fedfad595c 100644
> --- a/hw/block/nvme-ns.c
> +++ b/hw/block/nvme-ns.c
> @@ -133,6 +320,12 @@ static Property nvme_ns_props[] = {
>      DEFINE_PROP_UINT32("nsid", NvmeNamespace, params.nsid, 0),
>      DEFINE_PROP_UUID("uuid", NvmeNamespace, params.uuid),
>      DEFINE_PROP_BOOL("attached", NvmeNamespace, params.attached, true),
> +    DEFINE_PROP_BOOL("zoned", NvmeNamespace, params.zoned, false),

Instead of using a 'zoned' property here, can we add an 'iocs' or 'csi'
property in the namespace types patch? Then, in the future if we add
additional command sets we won't need another property (like 'kv').

> +    DEFINE_PROP_SIZE("zone_size", NvmeNamespace, params.zone_size_bs,
> +                     NVME_DEFAULT_ZONE_SIZE),
> +    DEFINE_PROP_SIZE("zone_capacity", NvmeNamespace, params.zone_cap_bs, 0),

I would like that the zone_size and zone_capacity were named zoned.zsze
and zoned.zcap and were in terms of logical blocks, like in the spec.
Putting them in a pseudo-namespace makes it clear that the options
affect the zoned command set and reduces the risk of anything clashing
with the addition of other command sets (like 'kv') in the future.

> +    DEFINE_PROP_BOOL("cross_zone_read", NvmeNamespace,
> +                     params.cross_zone_read, false),

Instead of cluttering the parameters with a bunch of these when others
zone operational characteristics are added, can we use a 'zoned.zoc'
parameter that matches the spec?

> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 93728e51b3..34d0d0250d 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -3079,6 +4001,9 @@ static Property nvme_props[] = {
>      DEFINE_PROP_UINT32("aer_max_queued", NvmeCtrl, params.aer_max_queued, 64),
>      DEFINE_PROP_UINT8("mdts", NvmeCtrl, params.mdts, 7),
>      DEFINE_PROP_BOOL("use-intel-id", NvmeCtrl, params.use_intel_id, false),
> +    DEFINE_PROP_UINT8("fill_pattern", NvmeCtrl, params.fill_pattern, 0),
> +    DEFINE_PROP_SIZE32("zone_append_size_limit", NvmeCtrl, params.zasl_bs,
> +                       NVME_DEFAULT_MAX_ZA_SIZE),

Similar to my reasoning above, I would like this to be zoned.zasl and in
terms of logical blocks like the spec. Also, I think '0' is a better
default since zero values typically identify a default value in the spec
as well.

I know this might sound like bikeshedding, but I wanna make sure that we
get the parameters right since we cannot get rid of them once they are
there. Following the definitions of the spec makes it very clear what
their meaning are and should be. 'mdts' is currently the only other
parameter like this, but that is also specified as in the spec, and not
as an absolute value.

My preference also applies to subsequent patches, like using `zoned.mor`
and `zoned.mar` for the resource limits.

--SNIs70sCzqvszXB4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+OxUcACgkQTeGvMW1P
Demx+Qf9FD2fnVC1UCrwIBQ8CAx/y2lHdRQrUGt+QkR8VnIGOol0jfMEqTXXOFu7
gj3jQjnoDNhX4WEUju6fYKbTppYgvr+bDKvkX6jL0e5YMdxbYFZfJ4HJHzBW6US0
RLZy+naBLBoKAobzFgkVfsJE7HDvFEFWkqc/N2sq7UYcjh7LwUjOCr4oJ7GNzbDM
snvG7mQvDi0H7CF3UJ58Q2KOxd29Aj8fdIL41i283mXH3gaFuyjoakNmhzQZsbLC
/pXEOn0MYsockSiaWf769ZR4REXnz34S92Jwg5DPSVL1pgCn5pSl/EyyKW5LWFAu
dqLRPUNvRf0fNEAzAwcRUv0GN1fl8Q==
=HT2i
-----END PGP SIGNATURE-----

--SNIs70sCzqvszXB4--


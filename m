Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11141C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:29:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D1FD20795
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1FD20795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVBND-0002oI-Tj
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 06:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kVBK0-0001OO-Is; Wed, 21 Oct 2020 06:26:20 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:56379)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kVBJw-0005z3-T9; Wed, 21 Oct 2020 06:26:20 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 07B60C0C;
 Wed, 21 Oct 2020 06:26:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Wed, 21 Oct 2020 06:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=ZRnphZMK598dwePkZcrcymcrkmz
 Ub+Sn0l/tr+KX7bs=; b=HNvodfLxZUJv0TdxDs8quNJRCQzH4UoeQjHlXFr47mv
 QJgNvPLHZpa9CN59i3soBoQhE/LQJUbtsYN5IoqMNoM2CAfuEiXnxqs5cagwiSl2
 fBpk7g29m9nIKEJ28JrgD+x/5LmiN0eCQmPBjTMd7KfzjZJhbJc0LaTWitcXM55+
 LjLxgK6yeGPpWAzNEjnHuw9g2838eNgfAjibYTdiTbg+s5wwH1w8bAWdJRMBXgQ0
 dT4+Np6LcH065jzPgEWbdrKo9AOS9L1kglGRaHCqykwiCyDCrfYAgCzmaw8j7OkY
 QzZciOXXB5Pb0+ICie8AskUlLBAGRGS6Fp6QCWAiISw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ZRnphZ
 MK598dwePkZcrcymcrkmzUb+Sn0l/tr+KX7bs=; b=kSP4VXPU6UdFZWcU22gfli
 OtwY5WNLh0luwa/v1A9+l0aVwohq5sxq99NtJfSWXYoLCQ2ow7BojNcZJfG9Gf15
 Afl/DT72bP1ol5TQH64GPbKKBxqP4x2U7vc8pAJP3YJ4AwqjKma2it0l4NWlzIg/
 rER9AxRhMVNsStA4F3AVCheNiatzIEh/uy07QVo2b0kOITNjDiVMzQMnxHf2fzKN
 9UjqrT85HDTD80L4UZ/3TMlbDbyewjILjZIH9GBAPnsaQSXG8jRTJZxIyyr2k+Na
 YcnZsU+46IK8MlnCMmK/WVs44EJ7Z5mi/BlajOEnVny0OVr5vJjy2XGEDqxqX48w
 ==
X-ME-Sender: <xms:vwyQX4vVroALbSaovBe2TZu775MiLeExmuXhvA5LN9_O_enQZytY1Q>
 <xme:vwyQX1fqZYz9DBBBEkHPny6gDFUKUjYof6JE6ix70iBTjxA1uVn4bC9N3Wr4dJ21K
 b6MOHbCyYMjMFi_ZuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeehgddvkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:vwyQXzxJg8lGVGEN8lmmBLtN8-D0ld3NQuE4oW_Z9-sB4vEvQ6nq2w>
 <xmx:vwyQX7OC5ZBEOXRF8xkM-7Hm4hnHkQzV9gAnWxrUxMgLp9h9A3i5zQ>
 <xmx:vwyQX488bdhtaYdDpDPt114f3OMrNQ1jHh6WnnwBRMn4GKHnOz9OYQ>
 <xmx:wAyQXzUpdpkFgjPIrM33LlZNsuQWDV68icerh9JMbZZyJWtrELNVOplRM6w>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 020A0328005E;
 Wed, 21 Oct 2020 06:26:05 -0400 (EDT)
Date: Wed, 21 Oct 2020 12:26:04 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v7 05/11] hw/block/nvme: Support Zoned Namespace Command
 Set
Message-ID: <20201021102604.GA276644@apples.localdomain>
References: <20201019021726.12048-1-dmitry.fomichev@wdc.com>
 <20201019021726.12048-6-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <20201019021726.12048-6-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=64.147.123.27; envelope-from=its@irrelevant.dk;
 helo=wnew2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 06:26:10
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


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Oct 19 11:17, Dmitry Fomichev wrote:
> +/*
> + * Close or finish all the zones that are currently open.
> + */
> +static void nvme_zoned_clear_ns(NvmeNamespace *ns)
> +{
> +    NvmeZone *zone;
> +    uint32_t set_state;
> +    int i;
> +
> +    zone = ns->zone_array;
> +    for (i = 0; i < ns->num_zones; i++, zone++) {
> +        switch (nvme_get_zone_state(zone)) {
> +        case NVME_ZONE_STATE_IMPLICITLY_OPEN:
> +            QTAILQ_REMOVE(&ns->imp_open_zones, zone, entry);
> +            break;
> +        case NVME_ZONE_STATE_EXPLICITLY_OPEN:
> +            QTAILQ_REMOVE(&ns->exp_open_zones, zone, entry);
> +            break;
> +        case NVME_ZONE_STATE_CLOSED:
> +            /* fall through */
> +        default:
> +            continue;
> +        }
> +
> +        if (zone->d.wp == zone->d.zslba) {
> +            set_state = NVME_ZONE_STATE_EMPTY;
> +        } else {
> +            set_state = NVME_ZONE_STATE_CLOSED;
> +        }
> +
> +        switch (set_state) {
> +        case NVME_ZONE_STATE_CLOSED:
> +            trace_pci_nvme_clear_ns_close(nvme_get_zone_state(zone),
> +                                          zone->d.zslba);
> +            QTAILQ_INSERT_TAIL(&ns->closed_zones, zone, entry);
> +            break;
> +        case NVME_ZONE_STATE_EMPTY:
> +            trace_pci_nvme_clear_ns_reset(nvme_get_zone_state(zone),
> +                                          zone->d.zslba);
> +            break;
> +        case NVME_ZONE_STATE_FULL:
> +            trace_pci_nvme_clear_ns_full(nvme_get_zone_state(zone),
> +                                         zone->d.zslba);
> +            zone->d.wp = nvme_zone_wr_boundary(zone);
> +            QTAILQ_INSERT_TAIL(&ns->full_zones, zone, entry);
> +        }

No need for the switch here - just add to the closed list in the
conditional.

The NVME_ZONE_STATE_FULL case is unreachable.

> +
> +        zone->w_ptr = zone->d.wp;
> +        nvme_set_zone_state(zone, set_state);
> +    }
> +}

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+QDLcACgkQTeGvMW1P
Del75QgAvdRyQVxzniwDB8J3f3lTfIcIcW2uD+4aGADg8GWv+aOosrvdQRP8FMgo
mA2018m7S6qDh1t+sXNVrnesWQL8aOqVFKuACL5H0lk51FM0zTzhQlAxp63D7I+U
gnRdfxt//G/swuvs4lzYfjVb0LFwbDzmr4kx21VdoMZ4iiqJjLPRj2lF7abjx4Ev
bGIt3KbcMMfKz0EX3C9bj+ykUbrn1waV8bk+8kzpXUWghqflVgLbSc7pxe0c/xCi
OmWjLnjykkJ5NXj1XbSHynkaDsKpAokAkROHwwBPQOks9cKuENJY199SFhZsi7M8
85WcHJmC/qavmfN6cEXqWTe38wnKEg==
=aPK3
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--


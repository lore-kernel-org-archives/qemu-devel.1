Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEB7C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 07:25:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5A5B22384
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 07:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A5B22384
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaDAv-0000Nk-M9
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 02:25:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kaD7G-00080t-GQ; Wed, 04 Nov 2020 02:21:58 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:37445)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kaD7D-0004lD-QF; Wed, 04 Nov 2020 02:21:57 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 4BB20FBF;
 Wed,  4 Nov 2020 02:21:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Wed, 04 Nov 2020 02:21:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=2gZGyCThFEaQgEd/BV5XItWsqap
 4T0WcUktpCiFyGE4=; b=Tb2BG/TgsGHCVIj4rFf4jeZe6D6EFiYoAjqf+Pt84yK
 brL1Y6bM3xwT6Qd5x14EAvQsz1RwfYRGaInq1IkniwPdulUaCogVcByC+vzTvX9x
 0nk6f/0UanU3TWqsNFHrEszWqu4uVJA4tVHNBg+9ZwQfUM8P9fAe5cBg6ct8L8W5
 5WEbfIvR+UEzoUeJAa0y3UE0M9VWR/oIZMLRSf2rDAtXIiY+xwTahtFwX7nlcipk
 mKddAFgWQqfyFq3fGcgpkQnoNvAMcOWsZVuThDjwl9j1GWw0eYOm+EsFJM0sad6F
 yxh+RcsugonSjI665De5s8DwgBRlp1KRkHvtD3yK2SQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=2gZGyC
 ThFEaQgEd/BV5XItWsqap4T0WcUktpCiFyGE4=; b=dwwbaokYIYq/h9z9MsAVnW
 8yh9GWOgxX7yZm9W+R6KijaLZ3GWpMrUfLjLV8BealLlFdvg/C2DV7l2oFX0LhCD
 Wh1/VQ3wAw8jOx0jVGFZXC8bjmwFozKyGkD6WfyG9uuI0ywTTDsnpEkMRfQvVtxM
 PPjZfHWYlAMRTkX0onqNTo0e1UxV6ryIarq7ft+eAxcBj9V8LnpYJUcZZMwsK6Kd
 FCOD3RYGWyiiRX0RT8aFeZ2LLvrvM3ETF028FX0x6bc01PLyiAPvXW0TjDEH+EEJ
 +ycX93KQ4PQHhXO6bbXxbE/JHz7diMJe6Sg2/Wl1LpFcR7bF8G6mLigim+ErTn0g
 ==
X-ME-Sender: <xms:jVaiX71ufpf1UELLmh4aTBj9rRrtknGzw66RTsnQoXz_6rGHeQcyfA>
 <xme:jVaiX6EQhVyeuJyZa20U9vOtmsgsCRRZkQ6VK9dLMVkoMA1GBZux0uYp8ndWEdnIL
 59JFFhW3etrdaiswI0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtgedguddtgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvddu
 ffeknecukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:jVaiX74SZdvh5k6CDUrzObKZ69X9UWtRg1Re927JgzEVhbfOYYBxuA>
 <xmx:jVaiXw0b64gYPIsOJbwulKzxfgWhJlR2gRVGFQiy02_u51PyYqKohQ>
 <xmx:jVaiX-H2p_g7d5BArUFmEzrp1wtbFaKY2s1rdSs1UXnX0VZQvvh8eA>
 <xmx:jlaiX584Px13Bh7tz27mqXK1jG2782x2Lgu-OWi-yM3aoQp5Y8xXH8JvTaY>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 8B329328037B;
 Wed,  4 Nov 2020 02:21:47 -0500 (EST)
Date: Wed, 4 Nov 2020 08:21:45 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v8 07/11] hw/block/nvme: Support Zoned Namespace Command
 Set
Message-ID: <20201104072145.GA166505@apples.localdomain>
References: <20201030023242.5204-1-dmitry.fomichev@wdc.com>
 <20201030023242.5204-8-dmitry.fomichev@wdc.com>
 <bcdfd825-980d-ea3d-30a5-b85c0dccd01d@redhat.com>
 <MN2PR04MB59511341E3622276A993FE7CE1110@MN2PR04MB5951.namprd04.prod.outlook.com>
 <b8d2a80b-4f7f-56eb-39dd-1e40f73c5a9b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <b8d2a80b-4f7f-56eb-39dd-1e40f73c5a9b@redhat.com>
Received-SPF: pass client-ip=64.147.123.27; envelope-from=its@irrelevant.dk;
 helo=wnew2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 02:21:52
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
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Niklas Cassel <Niklas.Cassel@wdc.com>,
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov  3 21:37, Philippe Mathieu-Daud=C3=A9 wrote:
> On 11/3/20 8:48 PM, Dmitry Fomichev wrote:
> >> -----Original Message-----
> >> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ...
> >>>  typedef struct QEMU_PACKED NvmeCqe {
> >>> -    uint32_t    result;
> >>> -    uint32_t    rsvd;
> >>> +    union {
> >>> +        uint64_t     result64;
> >>> +        uint32_t     result32;
> >>> +    };
> >>
> >> When using packed structure you want to define all fields to
> >> avoid alignment confusion (and I'm surprised the compiler doesn't
> >> complain...). So this would be:
> >>
> >>        union {
> >>            uint64_t     result64;
> >>            struct {
> >>                uint32_t    result32;
> >>                uint32_t    rsvd32;
> >>            };
> >>        };
> >>

I align (hehe...) towards this. The amount of bit-juggling we need for
commands justify the need for separate NvmeCmd's, but in this case I
think an NvmeCqeZA is just unnecessary clutter. If the result value is
complex, the approach used by AERs is better I think:

   typedef struct QEMU_PACKED NvmeAerResult {
       uint8_t event_type;
       uint8_t event_info;
       uint8_t log_page;
       uint8_t resv;
   } NvmeAerResult;

   NvmeAerResult *result =3D (NvmeAerResult *)&req->cqe.result32;

Since storing the Zone Append ALBA in the result64 isn't really a
complex operation, let's just assign it into that member directly.

(Addendum) That DW1 is command specific and no longer reserved is
defined by TP 4056 (Namespace Types) - not v1.4 or any of its revisions.

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+iVoUACgkQTeGvMW1P
DenyzQgApuiwrvPSNMQ9TzxTDBkTy6DGOWG83tUAOZupX3YHtLzXmAASXqiZtFlP
6DeBQHOaiJE1WfD09js1lxi3o7qZm6rjLM7jiaaFXxEB1mEc8t5T7xewy8Kn3mzM
VmkU8tUNhKWzNG2zgCPo+8d34KMH1XmKnlxzsFh2x41yFDVEwf6XGH4RgSlmkVaF
c9DEUGURGKg/iRrgqyiWxWwy9BMH3L5QcI61XOA7ilemV7NAWq24I1TkzsagpHHY
ejHhFOF2oZyk15Jx9PnIwEMU5MRgVnjiPjr7frpzF8IETwE6H/3fjSD+VpEXNwTt
a6qD4ZNqrZ/ijbi3J6CWhXUBu/DVHw==
=lXvt
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--


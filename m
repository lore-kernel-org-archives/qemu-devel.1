Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B1BC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 12:40:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B39F721D81
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 12:40:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B39F721D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUUSH-0001hq-5u
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 08:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kUUMH-0005H7-1z; Mon, 19 Oct 2020 08:33:49 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:50651)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kUUME-0006jN-KK; Mon, 19 Oct 2020 08:33:48 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id C83309E4;
 Mon, 19 Oct 2020 08:33:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Mon, 19 Oct 2020 08:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=mU0U1njhL4CdptzmDzMrZ15kevm
 lkekKNUFYmKr0kdQ=; b=sFAA2370EVgylrBZuaOHL0RFHk0+bPozV5DPzG3YSJr
 vMxMDjR50bNRIxuUZc63GpM6unJ+UlIJULDkXYHrZzneoey7e2o1MuV/ObEHhOnF
 4BBq3qVfyFllsvCQwqkfi+X6WXPqHVjFdb5+wEjyexrhO8Z+kQH56wcss/Wl9hpG
 brJt9T7//uodyEu4+vv4bu32aWyJbnXZPeNWJZ/1Snj+P40K0lAC77alClbVYQK9
 sg/v9CD/TLPJx61aKk/kKUqQrid89jL+ElVYJJ7fLyyfFd0mnyyFM7xZ0wJ5gbQV
 5MtIdg9J9u6YAsMEzoAtouxUMIkbk0HIL0+/sh4Od6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=mU0U1n
 jhL4CdptzmDzMrZ15kevmlkekKNUFYmKr0kdQ=; b=Zv2+Q1AKfKy7CnssGkmg5f
 lgReFLBtKeytUzS8QzBaXV/oNeb0hnSVodNPvKrvmLO7cSJ3wWOzVdFrUhjOLsAl
 vFw42KCWSLXZVglRoVvHXFGyA2G8VkD1I6USIECS14FLXBRbIJXnUyhpt/MYB1EL
 +1kh2gEXowRyjas9WOJl0kMMZ/eUCT6bmV91U+b8ZVUJFzX2l+qQeWxz/QcGLMyq
 hsjUKn9LajuGC7Tdq9rENR6vPfGjsSHYEPiUpyCZXygAPNmSrvrrHAIvDnvW/W7c
 F6GIjbLFMfe0xim9f8k9zAl/2zZwYxfMuvq1pISNr+VYJds114q6onmMIt97PVaw
 ==
X-ME-Sender: <xms:pIeNXxh7-XSirKNOp9Gj7mJs-0El8iMnepB-dSi3X8xZnn5B6HCyJg>
 <xme:pIeNX2AV54R2iQ7XIx5MjtqAAE0bam1DcdWCkV99gSJcowg0-m_HVSbtzPAMkGEAf
 Bp1D2MlL7_AiaTDUvk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjedugdehgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:pIeNXxGyeB8sHXwlqQnkjyX4CC8wT9q_t8L-ou_cpd7Vxu3nXN-2ZA>
 <xmx:pIeNX2SD7gAKPev1SBnipdz2hLP6FdZ0DAbynHqRyVkIRhMZ8b4txQ>
 <xmx:pIeNX-yNDcSIzC3vGd5VgMtu5UNlZ_iEgeX4qegokIgrI3qeY2Ryxg>
 <xmx:poeNXw40VCGExWtV-TAabr8PVZG1GGdNE9A4_8r6IofHnDCfCP9kwl8BRjPsE8Pj>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 00AA2328005E;
 Mon, 19 Oct 2020 08:33:38 -0400 (EDT)
Date: Mon, 19 Oct 2020 14:33:37 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v7 05/11] hw/block/nvme: Support Zoned Namespace Command
 Set
Message-ID: <20201019123337.GC10549@apples.localdomain>
References: <20201019021726.12048-1-dmitry.fomichev@wdc.com>
 <20201019021726.12048-6-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="da4uJneut+ArUgXk"
Content-Disposition: inline
In-Reply-To: <20201019021726.12048-6-dmitry.fomichev@wdc.com>
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


--da4uJneut+ArUgXk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 19 11:17, Dmitry Fomichev wrote:
> diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
> index d6b2808b97..170cbb8cdc 100644
> --- a/hw/block/nvme-ns.h
> +++ b/hw/block/nvme-ns.h
> @@ -34,6 +45,18 @@ typedef struct NvmeNamespace {
>      const uint32_t *iocs;
>      uint8_t      csi;
> =20
> +    NvmeIdNsZoned   *id_ns_zoned;
> +    NvmeZone        *zone_array;
> +    QTAILQ_HEAD(, NvmeZone) exp_open_zones;
> +    QTAILQ_HEAD(, NvmeZone) imp_open_zones;
> +    QTAILQ_HEAD(, NvmeZone) closed_zones;
> +    QTAILQ_HEAD(, NvmeZone) full_zones;

Apart from the imp_open_zones list that is being used in a later patch
to support Implicitly Opened to Closed transitions, these lists seem
rather pointless. As far as I can tell the only use they have is being
inserted into, removed from and checking if a zone is in one of those
four states?

The Zone Management Receive (and Send with Select All) is just iterating
on all zones and matching on state.

--da4uJneut+ArUgXk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+Nh5wACgkQTeGvMW1P
DelQDAgApGZONt96xzTQiW1/fwegdEv4l17dgHxEMhz4ddq68/tkDhxU5FYxljP2
cVlDSsI9fXXZv8dZkZwk40wlCIocb+MmeIUVK5trdMN2Ra7qECV0jXTL+gMbhbdQ
Ih3f0JA1nI2AJlv/n9j6Cp1T9bZFyTNknvwmwAtq8QT4yqvzmafbflUjJuSxB6Ht
k6SzLXpbe3XUi1KM8cR5l3D7uF6BqwV8zDBMAbKu2Ge7qSlknBkAXsBUPo8qx8Sm
jgA6q7fJ2Lk7FRz4y6dUtRXjA0BTVFJMPu4lCTkgBjct7Uslw5Kyrbu4hk/a3D6z
j/RJN0ZNH46tyWwE98Mm52cTADESFQ==
=FCrS
-----END PGP SIGNATURE-----

--da4uJneut+ArUgXk--


Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC252C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 08:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 557FF206B7
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 08:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557FF206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOG6Y-0000rQ-Vf
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 04:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kOG0a-0004Ua-0t; Fri, 02 Oct 2020 04:01:40 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:45375)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kOG0W-0007NR-ES; Fri, 02 Oct 2020 04:01:39 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id 5C8CA58019B;
 Fri,  2 Oct 2020 04:01:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Fri, 02 Oct 2020 04:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=ts/HeDudNEBQGzRxTWxnzTiHTUn
 4cm1JsEXaqZ3izGE=; b=ynNP3RI2XJFU69fhhvu5JdUn6jGzDhGanj7KKxwUiAC
 UAN7g2NgJOmhyKTlvZrN89HJ0Lj0UY5EFouzBA04s3ut+bfmtq3Tx4JKHar/d/qj
 n6oXcr2+TCfF1SdiFXz+CFx3uSQAeE4TmvMoVz8YEnNmqSf2ZwwDbde4qVx+ntc7
 NxSjQr8pnVMO+AiC01+lcYqeQacBrXuDgmD8OFjhPjyxTQtIxYX7/+poSWz3e3Bs
 aSIFNg4fKCRvZvcQmUVAVDwCpGPAQdh4aSSvIynIkx9Y338WtShQmH71Jav6DGEL
 bB+9Fqwb+v+A9jgpPibc9HxHxLVs59RERD66IlLkvXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ts/HeD
 udNEBQGzRxTWxnzTiHTUn4cm1JsEXaqZ3izGE=; b=K+nK9o/EtNckoVMaGNbX2l
 BQpET46AJbEDGn8cavc224WDuY+mahCxJdYwlu7Aeei00j80MzVjhPK8AF66+0hs
 aeYWYSh77Qo8JbRfjIZgZCJacqA1igwV2IW3go3fYlmgRAA9aLw4836IHn0ak8N7
 fLqLlCPfLXU3zg6jVq/Be1LUujtZAcMxAcQxuErDAkt9+9wWsTkBMUaC47A9DAz4
 ei2FWkh3a8FSpSmkrrVIeesWJvID8ucc6yUIB/5PbDlvdNN+4poqiiHTEULoCVdA
 IKpWcfP1ik4Z5aV96UZt6QJBR8VEKfJSh5JO6mg3hspe23KtehA1R5WzVP5duopw
 ==
X-ME-Sender: <xms:Xd52X9Lzajuj6AHPpn8Sov908GiVhbnhsm_U0ciSROD3W0hzHfVdDA>
 <xme:Xd52X5KYJo3SCOmams4892EYudlKGVeGLMm0jwJptKwEfdw4KSVQKkMr--CBq_8xp
 UFEqbaD2lQsbhoOl4U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeeiucetufdoteggodetrfdotffvucfrrh
 hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 epfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhsucflvghn
 shgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtthgvrhhnpe
 ejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudffkeenucfk
 phepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
 grmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:Xd52X1t6egDkrvLsptm4jYj47vFIcXhzJVAJJ3w89bXoVrihFJ4plg>
 <xmx:Xd52X-ZG2zg1Kff_vrbvGcMehcLWonkbRVZHuYvwTBM-1LyTmHeZzA>
 <xmx:Xd52X0aYW0OqfIli9JLCQJ5LXz9_T06fw00Eg8lQfEn6KTAXRZUNlQ>
 <xmx:Xd52XzzjetdAfs2e6PmGsFFiND7YqtM7Fp1JxJTFkhRf0TuIIkDjqw>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id B9F3E3064684;
 Fri,  2 Oct 2020 04:01:31 -0400 (EDT)
Date: Fri, 2 Oct 2020 10:01:29 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] hw/block/nvme: Simplify timestamp sum
Message-ID: <20201002080129.GA877411@apples.localdomain>
References: <20201002075716.1657849-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20201002075716.1657849-1-philmd@redhat.com>
Received-SPF: pass client-ip=66.111.4.221; envelope-from=its@irrelevant.dk;
 helo=new1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 04:01:34
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct  2 09:57, Philippe Mathieu-Daud=C3=A9 wrote:
> As the 'timestamp' variable is declared as a 48-bit bitfield,
> we do not need to wrap the sum result.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

> ---
>  hw/block/nvme.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 63078f6009..44fa5b9076 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1280,12 +1280,7 @@ static inline uint64_t nvme_get_timestamp(const Nv=
meCtrl *n)
> =20
>      union nvme_timestamp ts;
>      ts.all =3D 0;
> -
> -    /*
> -     * If the sum of the Timestamp value set by the host and the elapsed
> -     * time exceeds 2^48, the value returned should be reduced modulo 2^=
48.
> -     */
> -    ts.timestamp =3D (n->host_timestamp + elapsed_time) & 0xffffffffffff;
> +    ts.timestamp =3D n->host_timestamp + elapsed_time;
> =20
>      /* If the host timestamp is non-zero, set the timestamp origin */
>      ts.origin =3D n->host_timestamp ? 0x01 : 0x00;
> --=20
> 2.26.2
>=20
>=20

--=20
One of us - No more doubt, silence or taboo about mental illness.

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl923lQACgkQTeGvMW1P
DekPtQf/bbwonD3gH43JRl64udrY31xcysQbMQ5D32zUjUUmYLSLBYxv2y5wfqV0
cKs7qhwhA4WnZcrHiLdHVPPCHYJu9yUs/mt7QtxLt5Mu+CpYMr+FhLft7Ynoga08
bmTF8fhO8cX1AE99cKeTqpez371nm+ikL8gYb8zriXgu7CrDrWGbUhh6gCmpYI4x
wWyxFRqHSJrwjNayc93dZrD3ngubew0gtgKreXaAmbsb/7dxe1gTmXnyuseyp0dP
7U0nNtgHdUN9SLOWI+NLsmlNiun76IamICaXyMVl+w6sTU5aa75UfiCSoQMJjwsP
7pkzw2KTLl7t8hvajMexOJCCAFU6+A==
=EMB+
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--


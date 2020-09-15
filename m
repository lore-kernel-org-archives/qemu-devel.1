Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD15BC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 07:47:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AFBD21974
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 07:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AFBD21974
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI5gY-0004Tz-Jj
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 03:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kI5d9-00039f-JU; Tue, 15 Sep 2020 03:43:59 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:41521)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kI5d7-0006NV-LF; Tue, 15 Sep 2020 03:43:59 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id A5C395802B4;
 Tue, 15 Sep 2020 03:43:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Tue, 15 Sep 2020 03:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=MpM4zmPEpirQJ1kAYKRF8CSNbbw
 Vo4Bc0/8x7WJwgKo=; b=aR+UOQYIQnKR4wr5l+zB2Qw4vcPMPDuUJma7xnfkszt
 nbpwF64uvspbNieo/ccOTU3il8F0lKiV6e51RfSwc9cxkXfUFXrGrbB/cTbYcO3i
 Y93sS7nU+yQeYOqYMOYLl3O5wahfUOXRTf+n177hfIVSmNMEZ84RH+TKvXplCWVe
 dL9/TF4F6amorJMMW4kL4jRtvDY1u7a3DsaekFK8ud1nIahBkNvcg2Se8HxlItey
 rHyY5aI7lXtK6f8AYhrRoEJKRq3lbP1hq2R2x7DiN0WCA/tVKZhYKlzWEvFmx1/L
 a9jeSr45ToOJ9eeKezSGksF1PlvVe2EIXMjlZgTJSSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=MpM4zm
 PEpirQJ1kAYKRF8CSNbbwVo4Bc0/8x7WJwgKo=; b=SQDivlTzYWNpDwFZILUw9c
 /VMpQowhBrCi9KvzRmEsr3KW9PGDLM6Tk13hrjDNm3eM7YLszjoRCcXrwANZWQ/n
 hykuyVZWo01OYsqpNEpan9PnY8x3yWVubdZgVS+jcDjtyLtn4lE/vHHHLu/T6jCS
 sDpzLblZeefsG4qGOuu5TpWInZtTJvhmk7WIN9J/y6WAwAXoTFrTTspUuLls+iTm
 gVfJigIvENqGIg3nNk0ZD2KK7IPIPF9s1nvzN4RkHMvZ2cx/e4v8L4/iLijq200+
 xbuZR0eCc8KCTUtyBHLSVYFn9kjWEtyw/2oUj3jJReeNQPkgF65m6qVQo9Pf3mCQ
 ==
X-ME-Sender: <xms:unBgX9ArlRYE8KooUVrS6MrXbWU8lvTw5aQg6gXGM_66j6_Vw_qdFg>
 <xme:unBgX7ijlq40JvRNqYlZpNbjY_qrhoPF2fifdog7yV3xLfco9gJvubsyFRkO_DjF1
 Snhuen-F8aTL9mhW5s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudeijedguddulecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvddu
 ffeknecukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:unBgX4ldOyIMc553ft68IZv3Vmr5TKEhxiFbPE7ZwbMfvWV1rHuqNA>
 <xmx:unBgX3xVfza9XgwtIscnOTuQGN10zetIcnMgQ0cOZgYTXtaNWTH1UA>
 <xmx:unBgXySSmC2NNYke1fTJjjj-L9IJFvA9qNVGiTuqcGITNYieGjy7WA>
 <xmx:u3BgX-b1zaW1IZ4vfySpyIIX90WSNu39JXGZyrQ59LQ2GLQ3gVnLh87t_og>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id E6801328005D;
 Tue, 15 Sep 2020 03:43:52 -0400 (EDT)
Date: Tue, 15 Sep 2020 09:43:51 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v2 00/15] hw/block/nvme: Support Namespace Types and
 Zoned Namespace Command Set
Message-ID: <20200915074351.GC499689@apples.localdomain>
References: <20200912225430.1772-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
Content-Disposition: inline
In-Reply-To: <20200912225430.1772-1-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=66.111.4.224; envelope-from=its@irrelevant.dk;
 helo=new2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 03:34:26
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
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Keith Busch <kbusch@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 13 07:54, Dmitry Fomichev wrote:
> v1 -> v2:
>=20
>  - Incorporated feedback from Klaus and Alistair.

Since it's been a while since I reviewed this, it would have been nice
if you had listed what feedback you incorporated ;)


--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9gcLAACgkQTeGvMW1P
DenWHgf+IEsIs7pwEOQBompWsNRqeOhhjRDI1txUH3GntMI2xjZpXSe7Mu62NAre
mGOcBRO9Hprflk8QM6IO7sAkfxX/qH6UCAkPRyBPSas0Y8OnhKy97ZuV1s0BuEUW
ObCDam4Yuy4wkZxu4ZJGNdnCDES2CVkjLxP6jFCvICoPxaYtcaNh1I8QJcHQT16c
T5RE8PCfNvjTrB5BVzi4KbqgAgANYfNe/88eOBN88BVi3bMtOcwE/BXw1T8kV3NM
1msi3FDZ3BpOixkbSFzHu915kSIzjtjA8xcVNVqchryZ3iYDtDrH/pT5mpxa6Nap
HZvMchGw2cfueJI0UYc5CpQuLwIXbw==
=qBEf
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--


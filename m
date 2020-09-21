Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D37AC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 18:01:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D02DE2071A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 18:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D02DE2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKQ8A-0005QU-IQ
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 14:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKQ3I-0000aQ-Bb; Mon, 21 Sep 2020 13:56:36 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:34823)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKQ3G-00021s-4n; Mon, 21 Sep 2020 13:56:36 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 73DB45804AC;
 Mon, 21 Sep 2020 13:56:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Mon, 21 Sep 2020 13:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=9nDOZLFxC+NN56ZABKF+HP1WngG
 WrS3dVOWPmF7uP40=; b=h44GNJDHHjG2jt0brvqgsMbGz08CGpCmeVyVolGJgaP
 r71TDuMeyXE75y2e7tmVAC/vSZOCMcZYbHwY7EbvZ3+1jj1QGM/UV5u2loyvlBRB
 jtY5mnKHP5KpmbbLQbFJdLFccCXCUxbFqRTgO30lG1BAM1RNdXCt8SzpT0vnKPjS
 9N3Svg/XpS9d+5v5x8ujQT1/5VDUTG+uU6x1svtBOhiOa1a409yuV6k/Lej4SLPA
 ahzF005Ns6yKnEf3nJtD23tqQaVAZzx7uKLsBi9YUMl7w43W7WFFrs17PD/Oy67y
 VAtsN/YqovZzBXPLfXUuzLHEFgVuoiMktxTKJY9DExQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=9nDOZL
 FxC+NN56ZABKF+HP1WngGWrS3dVOWPmF7uP40=; b=rcSP76t6c9oN5KAKZ92otB
 dkhXHC0LWmmaXniMjyGqjXwcOgTKBCIHH10ie3iAtoNB0fkdb5v2M98q5nsiZ4mB
 gw02Te+1LAzxEjR3qN4E9kTQAhuHlRXWl2quCv1NMjOqXwEcFrZMJKRqyABvlhZ3
 CfqIXcJsqmdk3F5HwdpxpoqwYBhRkPkF2biyYmo2D2gQ5xSM3v8Fp8cH5GdKMTAf
 I8aTrXX7j+Lbn96dN9W8hear3QnS8s3uZS72sLZgQLuvB1w4QTQQ6yORikwIugqb
 8hHh3oG9B8UbIPo2LJcz7DfDUlT9043/JtMPZybEPmxr+hv5LDBdVsJmZS05fjwA
 ==
X-ME-Sender: <xms:TuloX0P8vtXm-r_7cSnzhaaCf0Rj0krVxah0tLM1ZWEr3fC4gTGA0g>
 <xme:TuloX6-2r4ggEnC0-ilmvnCwOqp3kKcBCs-6dFbKbIW63AqCzdt-aRVwfK3VCeqK3
 kx9sCJhuMkztBOLAXI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvgdduvdduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:TuloX7RapjN-1qpmS3y5STjNDBsGagv0QN7ChAIcPvkcYsS3dXP9fA>
 <xmx:TuloX8vCJW5kdgYgVIGpNq0Dsse4I4qJdNt6sn9tIOtVQImBvu7s_A>
 <xmx:TuloX8cWfqz0fsZeEOiuRhLO4fbwRq02nggMjQG47yVTQIukjjrxjw>
 <xmx:T-loX6tKwG1COIQ5ySLQs8S9O2tURGUe4WoG7drXpCXVtl5A7HwZ5A>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id E88713064683;
 Mon, 21 Sep 2020 13:56:28 -0400 (EDT)
Date: Mon, 21 Sep 2020 19:56:27 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v2 09/17] hw/block/nvme: refactor aio submission
Message-ID: <20200921175627.GA999349@apples.localdomain>
References: <20200918203621.602915-1-its@irrelevant.dk>
 <20200918203621.602915-10-its@irrelevant.dk>
 <20200921152015.GB4034182@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20200921152015.GB4034182@dhcp-10-100-145-180.wdl.wdc.com>
Received-SPF: pass client-ip=66.111.4.224; envelope-from=its@irrelevant.dk;
 helo=new2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 13:56:31
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 21 08:20, Keith Busch wrote:
> On Fri, Sep 18, 2020 at 10:36:13PM +0200, Klaus Jensen wrote:
> > +static inline bool nvme_req_is_write(NvmeRequest *req)
> > +{
> > +    switch (req->cmd.opcode) {
> > +    case NVME_CMD_WRITE:
> > +    case NVME_CMD_WRITE_ZEROES:
> > +        return true;
> > +    default:
> > +        return false;
> > +    }
> > +}
>=20
> It doesn't look like this is called for WRITE_ZEROES anywhere. It also
> looks like this helper is a bit unnecessary. We can reorganize some of
> the flow so that we're not checking the opcode twice:
>=20

Ooops. Yes, that is a leftover from when I had a patch that combined
nvme_rw and nvme_write_zeroes in the series.

I'll remove it.

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9o6UcACgkQTeGvMW1P
Dek9Lgf/Su4fHhA07v2L66niggUfk/qRRiCxaQOkdTrx/lDIj7O9CfQXs5JTVPQZ
evx7k6UJadR5LsdnPrWqm0K3ALOKeWcRTgTwa7spPHDRuluW2pFgvYSW7Xmmn493
tTG9nJvIMD7861ilCcGjeYetgh7qjqBFLI9jZLHhY/d6F+a0E7x6BdhgynDueood
T4hZ202xiciWylYC6Gglz9Gq/JpkSiE4u3nD2BY4fs+ci+r0PlXwPYCV7Lm04Rah
AutGbTH9BsCrqXLA1MWCQhPns9YqPs2hdpcPtCONGndHPuDqlMo38LLL8AV9N7Ht
bu20jfvw9/MuurjhQG+aDSDGz4hCnA==
=2Cdz
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--


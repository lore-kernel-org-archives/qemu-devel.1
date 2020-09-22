Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A87C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:26:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C02F12075E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02F12075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKeYg-00056U-Ce
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 05:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKeE1-000220-03; Tue, 22 Sep 2020 05:04:37 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:33939)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKeDv-000300-7T; Tue, 22 Sep 2020 05:04:36 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 146DE5803F7;
 Tue, 22 Sep 2020 05:04:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Tue, 22 Sep 2020 05:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=TqSENd0b6/MDWDuKtmOg1LK7A+P
 AOD11PQRiUIxmVoo=; b=aBSlszBGYLoIwb771bhABUePMLO7vpISUuSysmdAUXK
 U1IB8lThZKvWsoEACCZl2A7FjhBuKN2dcksClKoJPhgeTGIWhPQX0mD7zbjvWwoR
 lGslcYSP/ijDp9y60/1gSzbWQyVHjasPCvmOKYtahJZzDdMCALWlMWBRxW3XnWsp
 oghAb0I4PrxGwVLAUbDO63k1GdKPU3bOKaluN0PRnAw7Q0x5CuKXafDlxu1ahPN0
 i1ZKqRVEvKYSfl07N46xfBEr4cURsO9V+2IJ/K+UQTDWGfWWiZ/3cR/MIaJO+cxl
 Nxd1tsNAhvpyGAk8LJ3PlwhGcFAdWP03NsNaN5gBN3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=TqSENd
 0b6/MDWDuKtmOg1LK7A+PAOD11PQRiUIxmVoo=; b=FF+wrlxBlxRxKJ/g8wr60y
 iTVO2SOskrognpSFa3tEd2rnLB3CSjT8ESTQDIMBj/Wn/rqp/XVFELC3jpqZy2zT
 1327/iJGsQlWC9G7RHkT1YPbuVzugfdZi9RP15YwIiTJOj1FDtJe9EUWiDoeRe/Y
 ZtsS76MPGoz1r3f4B9j2E0X5d+KN1FYSDJgi8LQ82ZAOlUdxC+gKrtF3J43bU3wC
 WAGUJXSFx2QUMcslar/CGv7vOck8cAEQfI0ommDsNEZJeF8Ep91p4ifW2/Yh6ZyN
 1my5BKKYkQ+z2OB4CwrpUGNKz0QMxbYoEw5sxtrL/TYiJv/Gxfxb60hzg2pIYMKg
 ==
X-ME-Sender: <xms:HL5pX0KkuwEpkYhlcp-EsCNm5NxzTFCqWWna_cwKKKIW0PGSnER_sw>
 <xme:HL5pX0JYRkOg_Key7bxXN16If0MwMqPuiZeMfTdvul1A9I6MZkumyIPyRy4ah60bI
 cksCJ40cwEb6XcI--4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeggdduvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:HL5pX0s4d2haSNNK__y4umMtXjA50FwSnQUvtUYqG2bRF31zHhShEQ>
 <xmx:HL5pXxbGXcsaG0B5uhCHrD9GpxC1vFrAxP41fWL5AChY9axdcD9Q6g>
 <xmx:HL5pX7bfcMN0txrf504M8Co8AgsqswEBhw5ON6ItQV047VWiM1fHZw>
 <xmx:Hb5pX6Ul-Wz0b2LT4oMm5IJSlVmujYhtE02QvyhYkbWFpc3gTExQTw>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 277F4328005E;
 Tue, 22 Sep 2020 05:04:27 -0400 (EDT)
Date: Tue, 22 Sep 2020 11:04:25 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Subject: Re: [PATCH v6 2/2] nvme: allow cmb and pmr to be enabled on same
 device
Message-ID: <20200922090425.GA1236186@apples.localdomain>
References: <20200729220107.37758-1-andrzej.jakowski@linux.intel.com>
 <20200729220107.37758-3-andrzej.jakowski@linux.intel.com>
 <20200729225019.GA346228@apples.localdomain>
 <20200817062911.GA7412@apples.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <20200817062911.GA7412@apples.localdomain>
Received-SPF: pass client-ip=66.111.4.230; envelope-from=its@irrelevant.dk;
 helo=new4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 04:45:36
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
Cc: kbusch@kernel.org, kwolf@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 17 08:29, Klaus Jensen wrote:
> On Jul 30 00:50, Klaus Jensen wrote:
> > On Jul 29 15:01, Andrzej Jakowski wrote:
> > > So far it was not possible to have CMB and PMR emulated on the same
> > > device, because BAR2 was used exclusively either of PMR or CMB. This
> > > patch places CMB at BAR4 offset so it not conflicts with MSI-X vector=
s.
> > >=20
> > > Signed-off-by: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
> > > ---
> >=20
> > Well, I'm certainly happy now. LGTM!
> >=20
> > Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
> >=20
>=20
> Are anyone willing to chip in with another review on this?
>=20

I think this patch is ready (and have been for some time) for inclusion,
but would really like an additional review on this; preferably from
Keith, since he is the one that originally mentioned that we could do
something like this.

I've mentioned it before, but I would prefer that the MSI-X stuff was in
BAR0 instead of mixing it with the CMB, but that's bikeshedding and my
R-b still holds of course.

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9pvhQACgkQTeGvMW1P
Dek+OQf+JwP1ZNjVQp3z7ZoBpUmbja0bGHLX4/yKaZvJ6oGK9p0LMXaCAMyqgAIy
od32BeIBzZJ1lyqspio2gkrQ1Lji4iC2jyA0neVJdS6ye/cvWAoFqkg/FXSSvDO5
OpCq2WvEndImQkR7r24/HioeqfvY5TmlYPrtiO1JpomVDZWPlDMzb0Mxn2mkR+oW
cxLVv3ouQE82XflKX/drnCrR8udIMmnM044IU3qf2n4PgeaS22IIsQaKO1A4FzF7
sd3ZDkOIpi9SgIOef+d415RkrWY4FgNvIdsggGYLap+W9UmNox9JTCJJ2QX5+3bm
6LX5NcAuMdBJaRcHVr97mfOUpaEcwA==
=swfn
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--


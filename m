Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B75C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 18:48:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AF0224630
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 18:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF0224630
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVfdQ-00056c-KF
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 14:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kVfYo-0003Th-Ap; Thu, 22 Oct 2020 14:43:39 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:34515)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kVfYk-0005mY-L6; Thu, 22 Oct 2020 14:43:37 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id CCCA75C00C6;
 Thu, 22 Oct 2020 14:43:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Thu, 22 Oct 2020 14:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=nbVA8FVxi7D+ac6Isya3SbmKAus
 O2gAtCXx7x5hslD4=; b=RwjjNDTuFbzmI/gzOnf4oIa/KBoPysPHbizPexlHbSV
 qMpXY2G+/6OYNlZcdUgqwlhHZB9j3msla8w0OfeQ2gi2efO+v0tshslzEbePEGDu
 5U3NwqyZ6iSWjCOxC3x/NWI+xufGJcKmvIAygrjYUSNVuXliUYrKZf2epSFpoGMk
 qGMJ9yrJ/ltuXpnSflNfW2zqKI8PXU4qABMC741hFpzq6KH/KdaKqmW5zjbBYpyx
 HKajnD0WmUabiQEjYzJMbhQni8l5zMfIQDGwDw1AZrYSgd1O0G1x4Xbk9z79GWJ4
 eaSLhlAgNKMxz0GwU0WI6Cvaz4s4eZ994xH7mn95P6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=nbVA8F
 Vxi7D+ac6Isya3SbmKAusO2gAtCXx7x5hslD4=; b=j2TFUdBp4ni6rFm7xDVeSn
 Bmm88WBMAIO0qWA0/B8LapBNMAxHAUxLqxPsZmf5pP6JRxUPOJpeFtlhSo0loScZ
 2EKNioqp46yl2fen8OsnJgUJ950uaU+gkmYMy08Ee7h3u2X2/RW+nbfuK50ADdd5
 ZWat/scl+2pz/Hfx/ILFtVShLl0/6QVC9A1t1MzeAlGdPeTP+3fP2z6wW6qW0XCY
 yu0hDKcefKnR10bG9otwJ+dFIsTu+E7Uf/nOTy8N6Mi5byudWgFYCNqsmco5xt86
 bCL6uO0z8btKt4KWWAoJigo+7GeHllktXjqXCj4tNCICU85nAgwNh11jnNU7obRw
 ==
X-ME-Sender: <xms:0tKRX2oIlAf-TWsn8NcFNPwO_sLl76K3FQx_Zk2xl_Uy2ch0gFUmiw>
 <xme:0tKRX0rtRC-ek-5BZNS99-7AAnul5Kf7ULKAu4ibkt0ewA3ZVW-lS5U8d5U3zlzb4
 9OdQQryrOfNdvVBHDE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeekgdegjecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:0tKRX7PcIfFwZdx3mUnjBbUS-00mjSZcVCGghPILdaJS5wyInfVKhw>
 <xmx:0tKRX142mwv_HYIn8CUMn_57WIn7_emJ2bBZp-nrKwHqCgSGMFHtzA>
 <xmx:0tKRX15e2kINaia1G7GCZZqd4YAUdNZcUiHMNLsoYqBPYXn5uqYaeQ>
 <xmx:09KRX40d9_HJcr04YdFBivqvoHui7JesnsdVqY_Rgjq2KWy5AGH9sA>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id E0BD6328005D;
 Thu, 22 Oct 2020 14:43:29 -0400 (EDT)
Date: Thu, 22 Oct 2020 20:43:28 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v4 2/2] hw/block/nvme: add the dataset management command
Message-ID: <20201022184328.GC209677@apples.localdomain>
References: <20201022073313.143794-1-its@irrelevant.dk>
 <20201022073313.143794-3-its@irrelevant.dk>
 <20201022150103.GA1665151@dhcp-10-100-145-180.wdc.com>
 <20201022174333.GA209677@apples.localdomain>
 <20201022175023.GA1694294@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Content-Disposition: inline
In-Reply-To: <20201022175023.GA1694294@dhcp-10-100-145-180.wdc.com>
Received-SPF: pass client-ip=66.111.4.29; envelope-from=its@irrelevant.dk;
 helo=out5-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 13:43:37
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
Cc: Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 22 10:50, Keith Busch wrote:
> On Thu, Oct 22, 2020 at 07:43:33PM +0200, Klaus Jensen wrote:
> > On Oct 22 08:01, Keith Busch wrote:
> > > On Thu, Oct 22, 2020 at 09:33:13AM +0200, Klaus Jensen wrote:
> > > > +        if (--(*discards)) {
> > > > +            status =3D NVME_NO_COMPLETE;
> > > > +        } else {
> > > > +            g_free(discards);
> > > > +            req->opaque =3D NULL;
> > >=20
> > > This case needs a
> > >=20
> > >             status =3D req->status;
> > >=20
> > > So that we get the error set in the callback.
> > >=20
> >=20
> > There are no cases that result in a non-zero status code here.
>=20
> Your callback has a case that sets NVME_INTERNAL_DEV_ERROR status. That
> would get ignored if the final discard reference is dropped from the
> submission side.
>=20

Oh. Crap. You are right. Nice catch!

> +static void nvme_aio_discard_cb(void *opaque, int ret)
> +{
> +    NvmeRequest *req =3D opaque;
> +    int *discards =3D req->opaque;
> +
> +    trace_pci_nvme_aio_discard_cb(nvme_cid(req));
> +
> +    if (ret) {
> +        req->status =3D NVME_INTERNAL_DEV_ERROR;
> +        trace_pci_nvme_err_aio(nvme_cid(req), strerror(ret),
> +                               req->status);
> +    }

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+R0s4ACgkQTeGvMW1P
DenAWwgArVP/fMR8EKwOYJU633J4aGagglNF9VDj7o9cSf+dDTogysYYPGh98p4f
YuPc9qAn5lTkufHCbgMXFJIeJpdB+juwa7fNXO+NItU4Fs32DsScpHRC7CpSRwCs
RRvZeNUUbSdYvqD+FlLtvoZXxbSx4ea0R6RTaehPk2LGST0hob7I5WFJhisyHyf5
/+tuKJCW2nPfJ5F5NH5Eemk1Co2fZ0EP6Jg/WnqduTWbUyP1DAEQaXoxCGCXHEFL
ggTWqs5zfZG30OhAa4U37R9g9EVqjVeB4qNFDuehZ58sSXXVHjOoMX88odBtiy/E
v96iJMP1+/Hnkbk4z5bjkSVNlH5HDw==
=Wuuy
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--


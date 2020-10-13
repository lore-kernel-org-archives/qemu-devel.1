Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2615C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:32:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B028D2078A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B028D2078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSFjG-0005I0-DB
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 04:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kSFeI-0000tc-LJ; Tue, 13 Oct 2020 04:27:10 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:41355)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kSFeG-0003qQ-KB; Tue, 13 Oct 2020 04:27:10 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id 153AB5802DF;
 Tue, 13 Oct 2020 04:27:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Tue, 13 Oct 2020 04:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=a353oz923P8zk0/MTcuKtZB2Xp0
 rygr9BO7jiFQDXhQ=; b=R/u6L8ulHy7Hm40CBV4CzaM1HS/b5X/DlY844OSk+Hi
 9JNkOjOCowI2RxuPMrszKX+lJt84dfMHAu/baSiQ++NVYItfrh/QRG9AxzEalg+m
 YtaoIj274aYX7BpOW+RujbhvDX8M9Xj2hXNfW80S4X43MK90XNBs43nY4tIu5qcP
 /40vblwVoKxWOSdzYhqlQL2O3VvKYCpwl2Qa8wszjlhx9r+Fa6Qnc/tvhGt9Y6Rq
 DydJVQF9DEovOWAkOaNHHRl9ApibyagGg+N19NfcgMJ8vIOdTAcycPxarv+EfVNP
 ZNJjasGl+6O2fVQ9KOQzB5FA8H8Eo16w2/i78NKas4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=a353oz
 923P8zk0/MTcuKtZB2Xp0rygr9BO7jiFQDXhQ=; b=f7LCLXLOyKRLpfpJ1sT0Cs
 wEbmWrqmADsZobMlY/fFg78i/6cHMsUOxNpK/oekjCsfqdZJheoXwHdxJoGBSVh0
 tYRhAK8I1mGjstIT3LTbA15HwwSMYJDqoL67GEuZT8vlNzy1T2EiCnhlItNci124
 7dDynskFXWO2QWyqfuZODU6+czfj0EYiJJ6ccjo9Ok0cPpDeaa04MpMKREkhRwuD
 nnjLO/I4XVXR9o67MRasXoz08mSXGsLBJCLh3n6Nbq4LhBPr+aJjk6v1aXkwB2+V
 B0t0zEK3QW2Aky0WqXjAAPMafQpjYqx9WTFW2oJL1IU9fccsMbEWm+XYoADLlt7g
 ==
X-ME-Sender: <xms:2GSFX7a1wOfaESxrWAW8j-ex_q47VbwQGN7rdEfpHgGs1O1scjyxVg>
 <xme:2GSFX6b-DHA37mfwLEHWM_MIT2faiJFreVB_Cx0wdfDn4UvbZv76ytbTrIeVHujpZ
 Qf30Wh-JDrbeYg-zn8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrheelgddtgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:2GSFX9_ouQ4E8cAyR-ig_ij4ZY2JzgCP9Cv5y6dgYhYC7P0OR0zXWQ>
 <xmx:2GSFXxrt16BQNVmndaV7xAVEv4A3LNRzn9AtIq6NM4ybUGz452euzA>
 <xmx:2GSFX2oUMdcSIU2wuIbRM3FStt47hlHdVXDexZw_eF-_AUrnWujN0g>
 <xmx:2WSFX_kxlW_ceMX9m-4Hu7W7RQhUbxm59k4m7TJbKMC01StYmmkEkg>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 48DB43064680;
 Tue, 13 Oct 2020 04:27:03 -0400 (EDT)
Date: Tue, 13 Oct 2020 10:27:01 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/block/nvme: update nsid when registered
Message-ID: <20201013082701.GB168093@apples.localdomain>
References: <20201001215059.866660-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Content-Disposition: inline
In-Reply-To: <20201001215059.866660-1-its@irrelevant.dk>
Received-SPF: pass client-ip=66.111.4.229; envelope-from=its@irrelevant.dk;
 helo=new3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 04:27:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Keith Busch <kbusch@kernel.org>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct  1 23:50, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> If the user does not specify an nsid parameter on the nvme-ns device,
> nvme_register_namespace will find the first free namespace id and assign
> that.
>=20
> This fix makes sure the assigned id is saved.
>=20
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index da8344f196a8..bb1ee009cd31 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -2583,7 +2583,7 @@ int nvme_register_namespace(NvmeCtrl *n, NvmeNamesp=
ace *ns, Error **errp)
>          for (int i =3D 1; i <=3D n->num_namespaces; i++) {
>              NvmeNamespace *ns =3D nvme_ns(n, i);
>              if (!ns) {
> -                nsid =3D i;
> +                nsid =3D ns->params.nsid =3D i;
>                  break;
>              }
>          }
> --=20
> 2.28.0
>=20
>=20

Applied to nvme-next.

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+FZNIACgkQTeGvMW1P
DelWrQf/RmQI1J2D8jXZCQn597mPh+VkZNxP/YBVyyYxAaWl653lSXyTexoXKWAJ
HMH9dTDjbGIEtYgcvdeKrEnQhAPhwe7Thca1Wpub6RBZVjdtTSxUe7DzEzr8/eHO
ro3EK60nlBn2ZmYBjBVVfErA7Ddn2Mf7HphBS2CvHEWH0/Xpa6yy5HXhHaGGaMU+
N2vVfVT35QcdcqEDpjX1DS7tlsxqq5DuPts3wMtHVWCh5re50dHP1NlO/tW3n8DC
VpJPvvnrfoT8TLntzkW+EjW1YzjQKjYuDnThkmvhwMddGgQ+pgR9ZkFgfJSR3cJH
3bgj/3rBf4f5Oyywi/jMXCTXRQYpjg==
=+QXq
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--


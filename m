Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2087C55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7532221527
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7532221527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXNlR-0005mu-8m
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMsQ-00057c-ES; Tue, 27 Oct 2020 07:10:54 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:59969)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMsO-00018m-DQ; Tue, 27 Oct 2020 07:10:54 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 147C15C010F;
 Tue, 27 Oct 2020 07:10:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 27 Oct 2020 07:10:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=O/60c2vjkei9vgixDLp04aezsvT
 mCUYPTTTMBNKRzwI=; b=gTrRgCoNkurPHatGR7yQ7JQvWQyJv4j75R9hU12ZBay
 UT8Qr4adEFa+/Cx/UFVM+qMc9aq5uQRVRu06djo/D8A5MugZWMdqF8o2ptxt6azI
 Zqb1hLu+BbM4N4vr3mv4sxsouDFS61AtORckyiUK4Z+OT1tKOw9C2WcqQp/FMXjr
 MZgq8x4PZ9WELsEGy8gGvMVSxovotC7OxMDFJMz08PmoffQCHhLWqyVrU+mEZzpN
 xGX7NIWKXeTYZJagAn77D66FKPYvk+Omk06/vbzDLfmvqa+WBS32Gi2KpiWw9TCH
 zxBHhQusxkPP5ZgWahcXNgy0gk0ECfkWiVD2b3TXieg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=O/60c2
 vjkei9vgixDLp04aezsvTmCUYPTTTMBNKRzwI=; b=ScdajlYm5jHQ3Ns/6w+IZP
 xaOyh/aciRSXQgYzGCsMwIN+B+6FSDAR2Wa8tk3djpZwX0i6krEkCV5st5UZ3YDb
 wI8rOsskGb6dPw/AtLJuNvUNbvxC524wV5fIWNy2mT6VFgWeww5ttnJoWReIFkVa
 1Kx908jsCB7RC+7XGCmtdGn3D6BHNiy+ofRl9F+LCNHGwQnC70gtiyZFGTZPiPFJ
 WyA8KAYtbqaPFhbD02yL/S9PqxAIJFAe2xIioIIY5rL4NFT/M8/AsMVOL3zif/g0
 huXp0Ku/WK2e6j8D68eEHU0h2skD0CrDDTtf+/LKhB2Pl2YreOrS9zrEENd3v18A
 ==
X-ME-Sender: <xms:NwCYX_S7lZOaJhteG_iebqBf-2-xm1KP4TxaXRMlOA2_tUXNU-PPpQ>
 <xme:NwCYXwxbhIKqMcFRGWSoZWHrwlaLFgiKnL4eO6-kgfp-DNLp-3byde1AvA-cqcbo6
 s6OT2sncV_9WGMd3MY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddvgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:NwCYX03kl8phn1oDMpD2Fkh-HG-JGGbCmtFKShctGJ_yz1yUy8kPwA>
 <xmx:NwCYX_DOqDvc6XfEgoMTdOsXN8FByyBe1aJy1Y5qx5IHuLsgFTTKAg>
 <xmx:NwCYX4iATzKkMUZSUFUJcC0W5GX131ibQLEtMSh8NTKn48YXfJeaQA>
 <xmx:OQCYXyYNilG_ADmDqBpJ1dl2D93alnTwnRIRbb1Q3VkACbkRquh2Qg>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 9862E3280060;
 Tue, 27 Oct 2020 07:10:46 -0400 (EDT)
Date: Tue, 27 Oct 2020 12:10:44 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PULL 02/30] pci: pass along the return value of dma_memory_rw
Message-ID: <20201027111044.GA548260@apples.localdomain>
References: <20201027104932.558087-1-its@irrelevant.dk>
 <20201027104932.558087-3-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <20201027104932.558087-3-its@irrelevant.dk>
Received-SPF: pass client-ip=66.111.4.26; envelope-from=its@irrelevant.dk;
 helo=out2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 06:49:36
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
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 27 11:49, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> Some devices might want to know the return value of dma_memory_rw, so
> pass it along instead of ignoring it.
>=20
> There are no existing users of the return value, so this patch should be
> safe.
>=20
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Keith Busch <kbusch@kernel.org>
> ---
>  include/hw/pci/pci.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 0a59a06b149d..f19ffe6b4fe8 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -783,8 +783,7 @@ static inline AddressSpace *pci_get_address_space(PCI=
Device *dev)
>  static inline int pci_dma_rw(PCIDevice *dev, dma_addr_t addr,
>                               void *buf, dma_addr_t len, DMADirection dir)
>  {
> -    dma_memory_rw(pci_get_address_space(dev), addr, buf, len, dir);
> -    return 0;
> +    return dma_memory_rw(pci_get_address_space(dev), addr, buf, len, dir=
);
>  }
> =20
>  static inline int pci_dma_read(PCIDevice *dev, dma_addr_t addr,
> --=20
> 2.29.1
>=20

Philippe posted a series where this patch is included as well (with a
couple of additional reviews I think). Merging that is probably
preferable, and I can respin this pull.

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+YADIACgkQTeGvMW1P
DemwmQf/RVLB3AGqeJWmNYtoDIllyfKwMSHMQCCwZshjCsDQmom4asuCUOtV9IEd
kH5OCcvlXdiPft0oGVTBvCOyS39BuYXGMxRGrRqVs0EtRonnjBetTFunjdX76KPO
Ac0hFudh0EM5ezhkL8wYG4q2JHgnJfYIy3fuQpv+1DQVlqlCoqtprDPn+/olgRr6
eIzQPniG35lY7Ss9M5Pse1dwruVOmCXMT8mfU0jyqgUrw2n4+DEJH5NdAn13PKqf
TB4XZCMsXXiZi1Bhc77um/yCgzgESUJyZPNpYRCui5owZJq90gpLnOsZNzlUjhE+
15n/bIAsRb0gO7jylJuEcdxepxLKLA==
=OHJZ
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--


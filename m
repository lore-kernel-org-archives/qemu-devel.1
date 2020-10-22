Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E333C56201
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 17:50:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47C20205CA
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 17:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C20205CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVej6-0002Uw-1I
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 13:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kVef1-0001Gm-6q; Thu, 22 Oct 2020 13:45:59 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:58957)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kVeez-00074W-N4; Thu, 22 Oct 2020 13:45:58 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 00E4E5C0089;
 Thu, 22 Oct 2020 13:45:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Thu, 22 Oct 2020 13:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=KMH/OmzFbouydXK92UI5SPdjII5
 jJiIBcyuPgPnV9t0=; b=mrsb2xdJaO8Eu8KBzz34FEMiRlw9D+kj2yosTtsg6Tc
 3qv6/TaW57Vco3ayxccBADxHc2PSHmUItOHz7yMVE6ZACdDTkaDcG4bTd0w60kuP
 cXwUbKrolMI+pp7tEtgQs6mOtDCSWy/RtKS+rsriIBpNQmICEaREBX79Ko467brV
 naFpd9KJecie09NHXH3+tqbX5EKEQer1BdLOYo3dWvdA+PwjqiUApiuXIIoKthfL
 HOu0ufeK/PvIWPPpfhIOHmkMRlJ7tx0TpayHnHbHIEYckKGF6CjJLNVP5i8bWH/5
 w0j8u4QF6qJLIYJaeR0IzL8uJRjQpxWmrxk15UxsLoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=KMH/Om
 zFbouydXK92UI5SPdjII5jJiIBcyuPgPnV9t0=; b=Qln4S0ZTyeXclWV9hrwTHD
 USNux1k8D7wlVVWnnEOmmDPBBxt3YNEc8g4Rt3kUjz0SJkld8XUMUHBtSq5TFF1+
 CjK1zO9pmU3cTaHiEGTFP6ne2ncywwRVaQleym/6YpUyUWSStWM1G7jGe+eWV8XM
 Xvlf426h04p3eUUyAYR0GkjjspoUxXG54u6m+2e6Pv2jO9xJ30KAxFSDZTEnHARD
 0Fp6dIaCSZQAwXSy8MnpW7OAyxNjw9rUCq+J53gcT2MDD0l+gP9nT7KCvxvFRri4
 0CotYkPTqURSfO5dFS+bxi+HBv4GsAvMC2g649/gZU/TQCyGWOKkao5Rb/b7xRRg
 ==
X-ME-Sender: <xms:U8WRX77x9mcnuTEC1fwJGPnyLRo_3gAE0m_sQxTibergyO1vUEdEkA>
 <xme:U8WRXw6-cwj6eXKV9VUYGCcLrDPIAfsmAC6kKZpUwKBHm9VobnaEDHkiUNqvj7aDc
 TmjaD_4NAdJHJCxM9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeekgdefgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgepudenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:U8WRXyfYUOYL5uPo7HDxuUMQFB2oblWjTJn6NBgv_dJFjKD0GB8mcQ>
 <xmx:U8WRX8J-dg3-jweAttLnUYrlZ_6q7GpZmQ7QKbgRJ-A8_AulNFG8ng>
 <xmx:U8WRX_IIcoSkYsSPC6VfNWRLxaaBcxJrqbvzu7IXXVav1gM5i8uqUg>
 <xmx:VMWRX8F-o21b8bDzSfEMjMKGUO_WtUA7fkBdezgdHJyG-p8ahBF5Kw>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id DD5E33064610;
 Thu, 22 Oct 2020 13:45:54 -0400 (EDT)
Date: Thu, 22 Oct 2020 19:45:53 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 0/2] hw/block/nvme: two fixes for create sq/cq
Message-ID: <20201022174553.GB209677@apples.localdomain>
References: <20201022132404.190695-1-its@irrelevant.dk>
 <20201022152031.GA1668364@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
In-Reply-To: <20201022152031.GA1668364@dhcp-10-100-145-180.wdc.com>
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


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 22 08:20, Keith Busch wrote:
> On Thu, Oct 22, 2020 at 03:24:02PM +0200, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> >=20
> > The first patch is a follow up to "hw/block/nvme: fix prp mapping status
> > codes" and fixes some status codes in the nvme_create_{sq,cq} functions.
> >=20
> > The second patch fixes a faulty check on the given queue identifier.
>=20
> Looks good.
>=20
> Reviewed-by: Keith Busch <kbusch@kernel.org>

Thanks! Applied to nvme-next.

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+RxU0ACgkQTeGvMW1P
DelbpAgAqcA3SG2e6vQsSe4hTD79+go+tK1Vy7npvKnNaXflmYPBABX/zSUUblXa
54rDeXFwYol8kXJjKUhq9xOSTLhPG5rAMiFWfdWuydclLGBYr0pa0pHPDmf6SRri
+Fl8LP0BRUzgalsWhBeKMvxbLERejQ3Y00xDQtHQZ/6EuB4dUFsRslnO1n6eJTFM
ElmiwAck4GlGiycgT57l/5c0L2bZNeKavRYs73OjbCg8MAj7WOYhelIy2FmjzNyD
DSHjONybYdaNLuz1e6h6OG1h2wUIJO1K4WC6culxpE192briBNpzVLgtucv7v4hG
JTk8Rv8KdJ9XWfRptOvB32PGANfvqg==
=sWuv
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--


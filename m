Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA25C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 04:18:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C0DD21D92
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 04:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C0DD21D92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNq3N-0000Nk-2i
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 00:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNpzP-0006rE-8c; Thu, 01 Oct 2020 00:14:43 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:41067)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNpzN-00061e-C6; Thu, 01 Oct 2020 00:14:42 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 4808C45C;
 Thu,  1 Oct 2020 00:14:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Thu, 01 Oct 2020 00:14:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=99CFNYEsNTIo920uZO/ihY/G10C
 XL/AFR4I7uPpiQBY=; b=YAnzOkAJZfNSjJykxr6b8/YJK4oplK1NmrZKeRAteww
 tWSuhBp2kimPXE6COcgZgye3cQyzoG953ok9O64qaGBPP7no1DF6XwnNoreS3Pps
 0Vd9M7jYJZ+URgSDLVt1aJVjkR3CFMGkfprvNAUDmU5yDe8kkOGKMtbecaFkmqfL
 0Q6CsscLEm5faKROCWM6BAQiALXHuFcEiDGJOjoppTlMTDPaJNggh/5UXnQKxghu
 f8X8cmYVGXy2BoiwAR+ddkD+nlKsFN6sxzCV0c8bYzjv9th/lGuEVkkFbaG1ZhA8
 YEp4YqrGU5znb2YI/tE2rACR3IRWgT13Evuxm+xWCvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=99CFNY
 EsNTIo920uZO/ihY/G10CXL/AFR4I7uPpiQBY=; b=MJLDkM0SfGliP1f9lv99C/
 4K99DIROmVq0JyUXaYbBrT5EualbH4NduO4MvPihkX6L8GeiqO7fJRMAurI2fbDw
 D11Zg/Q73sW0gHScFaKr1h5f+lfARjzqsZPyLdpioi1PPcqz7VuVXEAzo6qZ1KR5
 1oK2a9RsxWTRJ1FsQlvsVm2YSLU5x8yRjdp2nXnngPjyPX1fYIxkQfNvXAO0xG41
 xdAa3LebeiqU4TJKoBPN2TB1AwOxfxbx0hMwUtLNnnSaRgbOpNSQaJnUhg0xLDLW
 VbMnifqTTMuc2CC+gb5ZyvY00mkd4OMjyiHKqo+Gkfjn5deVsw6n15cesTTFYnug
 ==
X-ME-Sender: <xms:rVd1X0bSFsYb00RANnacoVpo53OEtTrGK4Sc4nH1OTAKJlnu3T3GKQ>
 <xme:rVd1X_aHIK0JcJFJ0eZ0x-neb6r22CBNMFFSJgicmx9h7GbTPWu-3OxwePN4zI5p8
 KBzMnuwvGBZNKKj5ls>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgdekfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:rVd1X-8_KZPraCB5wVpyuJO5bYITobbCQyZm4megzjHHqYiZ7XzY-A>
 <xmx:rVd1X-peOC-_P6Ww4BKlK8c4RgxjLZytO5DECXaObml0R_RV-H7BJw>
 <xmx:rVd1X_ppQmh3Yen9P1Bwidhve3HlDgvqkPowsAMW4j9Tgs_QhzNWGg>
 <xmx:rld1XwC8r8Pt2XLaBO3NSbOsrlXUGQwFhruKB_U6WeixPqrZTttXTGYPLRU>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 7AAA73064686;
 Thu,  1 Oct 2020 00:14:36 -0400 (EDT)
Date: Thu, 1 Oct 2020 06:14:34 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 4/9] hw/block/nvme: validate command set selected
Message-ID: <20201001041434.GD681387@apples.localdomain>
References: <20200930220414.562527-1-kbusch@kernel.org>
 <20200930220414.562527-5-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jL2BoiuKMElzg3CS"
Content-Disposition: inline
In-Reply-To: <20200930220414.562527-5-kbusch@kernel.org>
Received-SPF: pass client-ip=64.147.123.17; envelope-from=its@irrelevant.dk;
 helo=wnew3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 00:05:15
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
Cc: Kevin Wolf <kwolf@redhat.com>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 30 15:04, Keith Busch wrote:
> Fail to start the controller if the user requests a command set that the
> controller does not support.
>=20
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

> ---
>  hw/block/nvme.c       | 6 +++++-
>  hw/block/trace-events | 1 +
>  include/block/nvme.h  | 4 ++++
>  3 files changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 41389b2b09..6c582e6874 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -2049,6 +2049,10 @@ static int nvme_start_ctrl(NvmeCtrl *n)
>          trace_pci_nvme_err_startfail_acq_misaligned(n->bar.acq);
>          return -1;
>      }
> +    if (unlikely(!(NVME_CAP_CSS(n->bar.cap) & (1 << NVME_CC_CSS(n->bar.c=
c))))) {
> +        trace_pci_nvme_err_startfail_css(NVME_CC_CSS(n->bar.cc));
> +        return -1;
> +    }
>      if (unlikely(NVME_CC_MPS(n->bar.cc) <
>                   NVME_CAP_MPSMIN(n->bar.cap))) {
>          trace_pci_nvme_err_startfail_page_too_small(
> @@ -2750,7 +2754,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *=
pci_dev)
>      NVME_CAP_SET_MQES(n->bar.cap, 0x7ff);
>      NVME_CAP_SET_CQR(n->bar.cap, 1);
>      NVME_CAP_SET_TO(n->bar.cap, 0xf);
> -    NVME_CAP_SET_CSS(n->bar.cap, 1);
> +    NVME_CAP_SET_CSS(n->bar.cap, NVME_CAP_CSS_NVM);
>      NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
> =20
>      n->bar.vs =3D NVME_SPEC_VER;
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 446cca08e9..7720e1b4d9 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -133,6 +133,7 @@ pci_nvme_err_startfail_cqent_too_small(uint8_t log2ps=
, uint8_t maxlog2ps) "nvme_
>  pci_nvme_err_startfail_cqent_too_large(uint8_t log2ps, uint8_t maxlog2ps=
) "nvme_start_ctrl failed because the completion queue entry size is too la=
rge: log2size=3D%u, max=3D%u"
>  pci_nvme_err_startfail_sqent_too_small(uint8_t log2ps, uint8_t maxlog2ps=
) "nvme_start_ctrl failed because the submission queue entry size is too sm=
all: log2size=3D%u, min=3D%u"
>  pci_nvme_err_startfail_sqent_too_large(uint8_t log2ps, uint8_t maxlog2ps=
) "nvme_start_ctrl failed because the submission queue entry size is too la=
rge: log2size=3D%u, max=3D%u"
> +pci_nvme_err_startfail_css(uint8_t css) "nvme_start_ctrl failed because =
invalid command set selected:%u"
>  pci_nvme_err_startfail_asqent_sz_zero(void) "nvme_start_ctrl failed beca=
use the admin submission queue size is zero"
>  pci_nvme_err_startfail_acqent_sz_zero(void) "nvme_start_ctrl failed beca=
use the admin completion queue size is zero"
>  pci_nvme_err_startfail(void) "setting controller enable bit failed"
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 868cf53f0b..bc20a2ba5e 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -82,6 +82,10 @@ enum NvmeCapMask {
>  #define NVME_CAP_SET_PMRS(cap, val) (cap |=3D (uint64_t)(val & CAP_PMR_M=
ASK)\
>                                                              << CAP_PMR_S=
HIFT)
> =20
> +enum NvmeCapCss {
> +    NVME_CAP_CSS_NVM =3D 1 << 0,
> +};
> +
>  enum NvmeCcShift {
>      CC_EN_SHIFT     =3D 0,
>      CC_CSS_SHIFT    =3D 4,
> --=20
> 2.24.1
>=20
>=20

--=20
One of us - No more doubt, silence or taboo about mental illness.

--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl91V6gACgkQTeGvMW1P
Demu5Qf/VJZMDUf5heV+yzuAEntZJks0Mf+mUMYr/+29xaYg2yyEpIeJtYg6Hltg
AL3RGXlk5h8lO4GZH8cYXT5Q0R25JRJjdsjFfELwk3y5bLq2ozK16b3igetE+Gae
eicHyYCrceqMbrmGmHQH00A6nXYxEwJL3LenXU6VX5WD0TxvFxgxkRs4EmW5Lcln
AnHzQWr3yjQyEEfP+SsTZEDPWEkcGEpOAl+W794p7pOoY0Nd7g+6N3BBWOlhuXTC
8mxYptLtSxSaXFhvHgD+I5jkSNeEzlDNP24UNB6ZB18RB8FE7SX4S5RSZ5ThHRjW
LkKdWD1KoDzHC8dO1Hu0C5WI+I0eFg==
=XEtv
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--


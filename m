Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44A5C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 21:51:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29E522076D
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 21:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E522076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNNWq-0003ns-PI
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 17:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNNRt-000171-ED; Tue, 29 Sep 2020 17:46:13 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:60791)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNNRp-00061B-Ca; Tue, 29 Sep 2020 17:46:13 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id D5591D2D;
 Tue, 29 Sep 2020 17:46:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 29 Sep 2020 17:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=lA5XqT/37hyVUNJWUmCw3mMk5Yn
 x4eRaSz3tiJP8NwU=; b=wDs73sd5YE7PHBooQMugFgcjY/N4mUKm+Z8QQKyKXVD
 jv7ER6f438fTxJtKgtwjkQwh7SyVmtaEFSLax0ymViN8gtbpgKtsvdnbZj73LuSF
 QZZSva56qnKlDbbedoKrzFhbaN+rDXfuWKlSq8icguzNpUKZI78mFcp1ZdOPY8tU
 zlDjW2hlE0cSOuCWK6DVvGa7IthgWC9I89cTaWSANH0U/WanYm0Vz10B/fZLgIV3
 6UMWuDpqS1Gkv7h0ROWhd/LEy+ypWOMS3Fdr+PN52VYsDloZV6qrsRKrMFFPQskV
 fvYZWlTU3kePJ0AWpFTcF/CqluvsuWCO7HW2fwQEdpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=lA5XqT
 /37hyVUNJWUmCw3mMk5Ynx4eRaSz3tiJP8NwU=; b=g9/mPZo+ZPXyg1D/IfaC8d
 bbc02/2JyHTuBOeR4A8v59f5uwqNx34wtiSNbWo9uyVEC84AWdx79ect15nGDAQT
 xskUWlGv7D4ihTboMVrwq97DrZf7TpLbMrbHc7Efc8Ys91uZhbamKLoVq+wEQzZd
 gyZW0MYcbzlXCF6sURBhMmqKxk+6tH5mCC7wkOtT1Gg55THA2UHHbgI91S7NM5De
 kKYPnb4YYw2X87vTlxWXRQH7Jxrbu64WefbzJvH/MRPRlDZs5toJZYqTSkO62ksY
 auynnAlKnTXdn17us8Vm2SsXYHbasKXuN0H2qVLCplVSvRjd2Nd605XHVdNzWGLg
 ==
X-ME-Sender: <xms:G6tzXxTsc_Fx6fE5wEEc3o_0SyUqidDeJpMb2bovsdL9tHwAmio-2w>
 <xme:G6tzX6yY2zYgsFyotooqA-pyEdRO5DLYTNFfktJun1bozA7vijANNJfi2_SBiknFV
 PwOfj453DtVOsIVuq8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdekgdduieehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:G6tzX23hmoQbYepHGHuR1inzYIrUdpOQTA0GVqiToaXz10K2hW0C5A>
 <xmx:G6tzX5BV2TcJPrmByw_2T2OVG06Pgb0TY7CL6zIlUwsDMOrntCBShw>
 <xmx:G6tzX6iSbAc3tMJVXHDUkgKxJT9Pf12mFkyk-gbnWlgtIrgUiV_qUA>
 <xmx:HKtzX1P6LsOMpTZ9AjBIaIjKwoOHtOHlKaIqU93sB7TYBWouuJhERQPi9bYic_44>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 3B632328005E;
 Tue, 29 Sep 2020 17:46:02 -0400 (EDT)
Date: Tue, 29 Sep 2020 23:46:00 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 07/18] hw/block/nvme: add support for the get log page
 command
Message-ID: <20200929214600.GA377237@apples.localdomain>
References: <20200706061303.246057-1-its@irrelevant.dk>
 <20200706061303.246057-8-its@irrelevant.dk>
 <CAFEAcA8dqNBm1YqLPjoJ=79K=6z=SxYHvcvnZiY3MJMvv1n1BQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <CAFEAcA8dqNBm1YqLPjoJ=79K=6z=SxYHvcvnZiY3MJMvv1n1BQ@mail.gmail.com>
Received-SPF: pass client-ip=64.147.123.27; envelope-from=its@irrelevant.dk;
 helo=wnew2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 17:46:07
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
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 29 14:11, Peter Maydell wrote:
> On Mon, 6 Jul 2020 at 07:15, Klaus Jensen <its@irrelevant.dk> wrote:
> >
> > From: Klaus Jensen <k.jensen@samsung.com>
> >
> > Add support for the Get Log Page command and basic implementations of
> > the mandatory Error Information, SMART / Health Information and Firmware
> > Slot Information log pages.
> >
> > In violation of the specification, the SMART / Health Information log
> > page does not persist information over the lifetime of the controller
> > because the device has no place to store such persistent state.
> >
> > Note that the LPA field in the Identify Controller data structure
> > intentionally has bit 0 cleared because there is no namespace specific
> > information in the SMART / Health information log page.
> >
> > Required for compliance with NVMe revision 1.3d. See NVM Express 1.3d,
> > Section 5.14 ("Get Log Page command").
>=20
> Hi; Coverity reports a potential issue in this code
> (CID 1432413):
>=20
> > +static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t bu=
f_len,
> > +                                uint64_t off, NvmeRequest *req)
> > +{
> > +    uint64_t prp1 =3D le64_to_cpu(cmd->dptr.prp1);
> > +    uint64_t prp2 =3D le64_to_cpu(cmd->dptr.prp2);
> > +    uint32_t nsid =3D le32_to_cpu(cmd->nsid);
> > +
> > +    uint32_t trans_len;
> > +    time_t current_ms;
> > +    uint64_t units_read =3D 0, units_written =3D 0;
> > +    uint64_t read_commands =3D 0, write_commands =3D 0;
> > +    NvmeSmartLog smart;
> > +    BlockAcctStats *s;
> > +
> > +    if (nsid && nsid !=3D 0xffffffff) {
> > +        return NVME_INVALID_FIELD | NVME_DNR;
> > +    }
> > +
> > +    s =3D blk_get_stats(n->conf.blk);
> > +
> > +    units_read =3D s->nr_bytes[BLOCK_ACCT_READ] >> BDRV_SECTOR_BITS;
> > +    units_written =3D s->nr_bytes[BLOCK_ACCT_WRITE] >> BDRV_SECTOR_BIT=
S;
> > +    read_commands =3D s->nr_ops[BLOCK_ACCT_READ];
> > +    write_commands =3D s->nr_ops[BLOCK_ACCT_WRITE];
> > +
> > +    if (off > sizeof(smart)) {
> > +        return NVME_INVALID_FIELD | NVME_DNR;
> > +    }
>=20
> Here we check for off > sizeof(smart), which means that we allow
> off =3D=3D sizeof(smart)...
>=20
> > +
> > +    trans_len =3D MIN(sizeof(smart) - off, buf_len);
>=20
> > +    return nvme_dma_read_prp(n, (uint8_t *) &smart + off, trans_len, p=
rp1,
> > +                             prp2);
>=20
> ...in which case the pointer we pass to nvme_dma_read_prp() will
> be off the end of the 'smart' object.
>=20
> Now we are passing 0 as the trans_len, so I *think* this function
> will not actually read the buffer (Coverity is not smart
> enough to see this); so I could just close the Coverity issue as
> a false-positive. But maybe there is a clearer-to-humans as well
> as clearer-to-Coverity way to write this. What do you think ?
>=20
> > +static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t b=
uf_len,
> > +                                 uint64_t off, NvmeRequest *req)
> > +{
> > +    uint32_t trans_len;
> > +    uint64_t prp1 =3D le64_to_cpu(cmd->dptr.prp1);
> > +    uint64_t prp2 =3D le64_to_cpu(cmd->dptr.prp2);
> > +    NvmeFwSlotInfoLog fw_log =3D {
> > +        .afi =3D 0x1,
> > +    };
> > +
> > +    strpadcpy((char *)&fw_log.frs1, sizeof(fw_log.frs1), "1.0", ' ');
> > +
> > +    if (off > sizeof(fw_log)) {
> > +        return NVME_INVALID_FIELD | NVME_DNR;
> > +    }
> > +
> > +    trans_len =3D MIN(sizeof(fw_log) - off, buf_len);
> > +
> > +    return nvme_dma_read_prp(n, (uint8_t *) &fw_log + off, trans_len, =
prp1,
> > +                             prp2);
>=20
> Coverity warns about the same structure here (CID 1432411).
>=20
> thanks
> -- PMM

Hi Peter,

Thanks. This is somewhere in the middle of a bunch of patches I got
merged I think, commit 94a7897c41db? I just requested Coverity access.

What happens is that nvme_dma_read_prp will call into nvme_map_prp which
wont map anything because len is 0. This will cause the statically
allocated QEMUSGList and QEMUIOVector in the request to be
uninitialized. Returning from nvme_map_prp, nvme_dma_read_prp will
notice that req->qsg.nsg is zero so it will default to the iov and move
into qemu_iovec_{to,from}_buf(&req->iov, ...). In there we actually pass
the NULL struct iovec, but since there is a __builtin_constant_p(bytes)
condition at the end of it all, we never follow it.

Not "serious" I think, but definitely not good. We will of course fix
this up.

@keith, do you agree with my analysis?

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9zqxUACgkQTeGvMW1P
DemHNAf/WI8C19iRbSVbOYTVWG4ooRcB+ePLGgRYiEuc7ejmBzhKFRj3Z2jkm95Y
MpNxvZD5gwzT7H27fmsDjTzi8Hgf2VQ4RKvmP4gQpBH08OyiMMyhKkrwHBZq0KIO
MC9v9oBdd5XRiFWhx1jRFkleuZHvLJiXHmvBr6wb3VJvsE0CzTPW4gDvD4/NytTE
5a66st1d6ymO8Vs3NerHxLE7BqzYwqRQYud+0pNlnUPlLgzaJvMZAxjhd8Wl/9X/
4l9PSPYbgxJ7A55n4gc2NQfUcmKqCUdquUuFXonxnomQjTIfhFLy2LzfEn0m14nX
tOv++VLM43b1C/XcIDTnGRkrmQ1xBw==
=ryzi
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--


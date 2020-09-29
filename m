Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E824C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 22:46:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF71920756
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 22:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF71920756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNOOQ-00078t-K7
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 18:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNOKt-0004Qx-PY; Tue, 29 Sep 2020 18:43:03 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:43407)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNOKn-0004Rk-4a; Tue, 29 Sep 2020 18:43:01 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 03ADBE95;
 Tue, 29 Sep 2020 18:42:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 29 Sep 2020 18:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=yJy2qHVCJqwal7pE3dQcnTpWriP
 Q8Ee2PsuOqAqUNAk=; b=lR0AaOaYrAE9Q/wmBugoOWGu1ChcB6u2jhcfyRtB/uP
 5/1Pyhqe1y7dS1jhMQJClFs7ueBeIaQYMjPOSlcLh3f/hDkI8rVrkojs7bR9MPU5
 15Vb6UbEDrOrbXOn5KveAro8SWcU4gZ+RRkBo4V3F6XXJNVpuc+pQFMnH88Jshju
 +Se+AyTpp7tE8r6Aq5uEhSzMfccCrrbgQTlbqSJbEt82NGK+p4qWyG4zfDs56570
 Hp34uPMT1PCk8GKKHS6rX3PcX/FEerKpijbS2jJG2SWYHuSnZLEy3j5UYiXIKTN6
 UJdkrWwyAkqoqwc1XidHvA2QCIs/qo3hy5NCHNPM7EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=yJy2qH
 VCJqwal7pE3dQcnTpWriPQ8Ee2PsuOqAqUNAk=; b=uIPOsaf0xyc4lhKRepNqNt
 iWmsTQeJPVJ7cD/2KztWtp16yGLLA6gxjCcVrQkWNQA4NMvZil03mptBdI4sgP2e
 Ama39spcGcl5DzZ+CVVfbXySKF38A5/0fbXRxld2gawc5mNB+zT6NGFuXOiRRuP9
 jDzb3jxrTvWiCQWj2lp05Ru8l1wnzUukSzj27MH7N8APcxd5IVgoqk5yjwJMXndL
 AQ0k4AzDCXG9seCXPKPSlvTygs0niYgmM1ggy0bzS1slq/Af8BhF0I+IeUjSDKE5
 fimu46bTMhhaEdRhQnV4WdDIgSV4UE8VNrQlSpLGdo4j2DWWl2codQ88C4yHVpHg
 ==
X-ME-Sender: <xms:a7hzXzD7l5kAOCl4gs4HvuoADr-GCbdf0ghr1rgCUbmOgT6-PPrPrg>
 <xme:a7hzX5gvmWkMD-FPfb_9vnUHcOss1jRocJnU834h5oQW8kxxKFeocq2YQHeiHnH7d
 BO8D-6Ng79kY5m9nuU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfedtgddutdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:a7hzX-krfD5gdiJDUyzpA45W1p439SYphf4REUF5p5y6UWxs_0yNWw>
 <xmx:a7hzX1x0AfhWK-9DcQR0Q-Jvm5_9MDGDR4lJxk77-fPQUf4HNgEPbg>
 <xmx:a7hzX4T3PDCEjySnDj0YkN3Sjxk7EoM1hdpmZAyd_9cWNpRRPfAKtg>
 <xmx:bbhzXx9kDFIjaKdQ7lOvEEj58zSGKrQfB5ywfdzjbt1iqra9wFbPyZlS9Ibk9y3s>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 3C6603280059;
 Tue, 29 Sep 2020 18:42:50 -0400 (EDT)
Date: Wed, 30 Sep 2020 00:42:48 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v3 07/18] hw/block/nvme: add support for the get log page
 command
Message-ID: <20200929224248.GB377237@apples.localdomain>
References: <20200706061303.246057-1-its@irrelevant.dk>
 <20200706061303.246057-8-its@irrelevant.dk>
 <CAFEAcA8dqNBm1YqLPjoJ=79K=6z=SxYHvcvnZiY3MJMvv1n1BQ@mail.gmail.com>
 <20200929214600.GA377237@apples.localdomain>
 <20200929223420.GB508696@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline
In-Reply-To: <20200929223420.GB508696@dhcp-10-100-145-180.wdl.wdc.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Qemu-block <qemu-block@nongnu.org>, Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
 Klaus Jensen <k.jensen@samsung.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 29 15:34, Keith Busch wrote:
> On Tue, Sep 29, 2020 at 11:46:00PM +0200, Klaus Jensen wrote:
> > On Sep 29 14:11, Peter Maydell wrote:
> > > > +static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32=
_t buf_len,
> > > > +                                 uint64_t off, NvmeRequest *req)
> > > > +{
> > > > +    uint32_t trans_len;
> > > > +    uint64_t prp1 =3D le64_to_cpu(cmd->dptr.prp1);
> > > > +    uint64_t prp2 =3D le64_to_cpu(cmd->dptr.prp2);
> > > > +    NvmeFwSlotInfoLog fw_log =3D {
> > > > +        .afi =3D 0x1,
> > > > +    };
> > > > +
> > > > +    strpadcpy((char *)&fw_log.frs1, sizeof(fw_log.frs1), "1.0", ' =
');
> > > > +
> > > > +    if (off > sizeof(fw_log)) {
> > > > +        return NVME_INVALID_FIELD | NVME_DNR;
> > > > +    }
> > > > +
> > > > +    trans_len =3D MIN(sizeof(fw_log) - off, buf_len);
> > > > +
> > > > +    return nvme_dma_read_prp(n, (uint8_t *) &fw_log + off, trans_l=
en, prp1,
> > > > +                             prp2);
> > >=20
> > > Coverity warns about the same structure here (CID 1432411).
> > >=20
> > > thanks
> > > -- PMM
> >=20
> > Hi Peter,
> >=20
> > Thanks. This is somewhere in the middle of a bunch of patches I got
> > merged I think, commit 94a7897c41db? I just requested Coverity access.
> >=20
> > What happens is that nvme_dma_read_prp will call into nvme_map_prp which
> > wont map anything because len is 0. This will cause the statically
> > allocated QEMUSGList and QEMUIOVector in the request to be
> > uninitialized. Returning from nvme_map_prp, nvme_dma_read_prp will
> > notice that req->qsg.nsg is zero so it will default to the iov and move
> > into qemu_iovec_{to,from}_buf(&req->iov, ...). In there we actually pass
> > the NULL struct iovec, but since there is a __builtin_constant_p(bytes)
> > condition at the end of it all, we never follow it.
> >=20
> > Not "serious" I think, but definitely not good. We will of course fix
> > this up.
> >=20
> > @keith, do you agree with my analysis?
>=20
> Yeah, looks safe as-is, but we're missing out on returning the spec
> required 'Invalid Field'.

I can't see where it says that we should do that? Invalid Field in
Command if offset is *greater* than the size of the log page.

Some dynamic log pages have side-effects of being read, so while this is
a super wierd way of specifying that we want nothing returned, I think
it is valid?

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9zuGYACgkQTeGvMW1P
Denm1gf/XaZHL4LA8aPsGZoJlVoHxb4gL43ED4+jjNoQ5eskES2jZwJ2mwQSixxg
b8cVKhsQaCS2rz+rgb3qGGA6SrdXZSQMVLut5jKmnE6QQSR/mUQg60e/YwmPGfch
bgPTmDJ71hYFRuvcmieJxdls3i/x5JrFQoOcym2f4OCs9XkxBd4iD4Bn+wCbfEPV
gxDZgnocjCwajQytT3KGHFNtmUIf9HHPsocBsKdznWzgo39KM3MDTn5nf41fGgky
UJLxZUBR2vbfNAa+S5J7o4aM+v+z0xfpMqpbNpvr/oGj1keFWTSDgHDx1IP/t01K
gZmUqqxR7KzAn6oyJ8UeXtcNkhwkJQ==
=yoH9
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--


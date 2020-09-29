Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70427C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 18:43:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B02562075A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 18:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02562075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNKb8-00059J-CT
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 14:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNKX4-00030H-SC; Tue, 29 Sep 2020 14:39:22 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:34777)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNKX1-0006HB-0y; Tue, 29 Sep 2020 14:39:22 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 71C6EF69;
 Tue, 29 Sep 2020 14:39:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 29 Sep 2020 14:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=uIpIQp/X8Vc0FSR8L8xzzVWSOeq
 RQsZ3Whs6U2/QgK8=; b=Elfy1Wj6HUyk02PuBC7kcf2HZfFQDmqr24x14NUEIQG
 fX7Cp+QkKP5+/OM4xbXwfN+uMTm5Ru7VmXPChiO/KIfQAJzgflUp4OexwSVsNvZ4
 cm5CTblpDfu/7xBdFEbdEbK1UmD4qgf/KGV0pY1ClPUNqe9AJwBEBAmoGxMab9W5
 xiqOoEZU6Tec8He8MIMPM06qlc4Yi3qcZREifTnLI5UdlIG+MtpTLsrz40n67lRP
 gL7FpfmKuHW6hz+QJ5r+dA2cKoACghzx+zoMbTifQ0TjE0hcYys/laR96dNi7t5E
 KCb7JdxryORseOex8uQjFhoZwAjD0M07zT+GAQEVsNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=uIpIQp
 /X8Vc0FSR8L8xzzVWSOeqRQsZ3Whs6U2/QgK8=; b=iHC2UEnowxPmZA/zqBcFYE
 oMW2Q4tqSxCCs3jOsgg+kVBXRpqHO36dTQAqAR5swueuePsQonGqck4zURG5Wndg
 KW4LqtrbqGZQH6YBLZqsO7CyyUphX1Bq4k5wBC08r9xwCdTF4x7FE1/JFt/CPK0m
 HGvzN/AdfDh+GkzdDhVuOMiXPs12rCiUMSZ/OLuRNWGg0E5qamrO2jbq80iu96fX
 5IkPlLgZyBASSYF9a5jBkx9UolRY5I/4aGRO9iZ9bACfv4pqLdENy9iIPhj5GIjC
 +S56QaU6AnkICPKJbBOZf7KjLpLK4q9LK5cMem/fPb6enp6dsvy9CBrLNuP5vC+g
 ==
X-ME-Sender: <xms:Un9zX2GFZQWBxAvYNXS3Rc7JH-YntuFIdLvHTFdpMTVQSQ7kcyYLFg>
 <xme:Un9zX3UMcd3VhPWdybQwioaKczMbMer2zfsjq4puT9ONDIpT_IQ-2BQKeWtnIUSoD
 MFQA1jvUcKSJLeUl1k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdekgdduvdejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpedtleekfedtueejueehledtudeugfdutdeigeegieehhfdvtedtgeetfefggfdu
 keenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeektddrudeijedrleekrd
 duledtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
 ihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:Un9zXwLEj8OjrKVuZVhqEIhHz5uWiiuKldZwrnArRLedaE0metvhJw>
 <xmx:Un9zXwGtCyFfF2KKjjMFVS9axHgH0isANaMh1eneyAVfTnftblL5Hg>
 <xmx:Un9zX8VTlyb8jUwOQ0VBZc_6BF2dDSSgu9NpCQDLQ-ZDHS1axb0D1g>
 <xmx:U39zX1NhvmCvEiwvNlGzjPo9FHG7QDxNwljptA180JsGqdLFQ3HaTnaiwDHf-FHB>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 2D1FA3280065;
 Tue, 29 Sep 2020 14:39:13 -0400 (EDT)
Date: Tue, 29 Sep 2020 20:39:11 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
Subject: Re: [PATCH v4 00/14] hw/block/nvme: Support Namespace Types and
 Zoned Namespace Command Set
Message-ID: <20200929183911.GF286786@apples.localdomain>
References: <20200923182021.3724-1-dmitry.fomichev@wdc.com>
 <20200924210751.GD1738917@apples.localdomain>
 <MN2PR04MB59515B1EA1238861DFF3236AE1350@MN2PR04MB5951.namprd04.prod.outlook.com>
 <20200928063648.GA1967@apples.localdomain>
 <MN2PR04MB5951A1DAC6A607732A35B968E1320@MN2PR04MB5951.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9ADF8FXzFeE7X4jE"
Content-Disposition: inline
In-Reply-To: <MN2PR04MB5951A1DAC6A607732A35B968E1320@MN2PR04MB5951.namprd04.prod.outlook.com>
Received-SPF: pass client-ip=64.147.123.17; envelope-from=its@irrelevant.dk;
 helo=wnew3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 12:36:54
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Niklas Cassel <Niklas.Cassel@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--9ADF8FXzFeE7X4jE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 29 15:42, Dmitry Fomichev wrote:
> > -----Original Message-----
> > From: Klaus Jensen <its@irrelevant.dk>
> > Sent: Monday, September 28, 2020 2:37 AM
> > To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
> > Cc: Keith Busch <kbusch@kernel.org>; Damien Le Moal
> > <Damien.LeMoal@wdc.com>; Klaus Jensen <k.jensen@samsung.com>; Kevin
> > Wolf <kwolf@redhat.com>; Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
>;
> > Maxim Levitsky <mlevitsk@redhat.com>; Fam Zheng <fam@euphon.net>;
> > Niklas Cassel <Niklas.Cassel@wdc.com>; qemu-block@nongnu.org; qemu-
> > devel@nongnu.org; Alistair Francis <Alistair.Francis@wdc.com>; Matias
> > Bjorling <Matias.Bjorling@wdc.com>
> > Subject: Re: [PATCH v4 00/14] hw/block/nvme: Support Namespace Types
> > and Zoned Namespace Command Set
> >=20
> > On Sep 28 02:33, Dmitry Fomichev wrote:
> > > > -----Original Message-----
> > > > From: Klaus Jensen <its@irrelevant.dk>
> > > >
> > > > If it really needs to be memory mapped, then I think a hostmem-based
> > > > approach similar to what Andrzej did for PMR is needed (I think that
> > > > will get rid of the CONFIG_POSIX ifdef at least, but still leave it
> > > > slightly tricky to get it to work on all platforms AFAIK).
> > >
> > > Ok, it looks that using the HostMemoryBackendFile backend will be
> > > more appropriate. This will remove the need for conditional compile.
> > >
> > > The mmap() portability is pretty decent across software platforms.
> > > Any poor Windows user who is forced to emulate ZNS on mingw will be
> > > able to do so, just without having zone state persistency. Considering
> > > how specialized this stuff is in first place, I estimate the number o=
f users
> > > affected by this "limitation" to be exactly zero.
> > >
> >=20
> > QEMU is a cross platform project - we should strive for portability.
> >=20
> > Alienating developers that use a Windows platform and calling them out
> > as "poor" is not exactly good for the zoned ecosystem.
> >=20
>=20
> Wow. By bringing up political correctness here you are basically admitting
> the fact that you have no real technical argument here.

I prefer that we support all platforms if and when we can. That's a
technical argument, not a personal one like you those you start using
now.

> The whole Windows issue is red herring that you are using to attack
> the code that is absolutely legit, but comes from a competitor.

I can't even...

> Your initial complaint was that it doesn't compile in mingw and that
> it uses "wrong" API. You have even suggested the API to use. Now, the
> code uses that API and builds fine, but now it's still not good simply
> because you "do not like it". It's a disgrace.
>=20

I answered this in a previous reply.

> > > > But really,
> > > > since we do not require memory semantics for this, then I think the
> > > > abstraction is fundamentally wrong.
> > > >
> > >
> > > Seriously, what is wrong with using mmap :) ? It is used successfully=
 for
> > > similar applications, for example -
> > > https://github.com/open-iscsi/tcmu-runner/blob/master/file_zbc.c
> > >
> >=20
> > There is nothing fundamentally wrong with mmap. I just think it is the
> > wrong abstraction here (and it limits portability for no good reason).
> > For PMR there is a good reason - it requires memory semantics.
> >=20
>=20
> We are trying to emulate NVMEe controller NVRAM.  The best abstraction
> for emulating NVRAM would be... NVRAM!
>=20

You never brought that up before and sure it could be a fair argument,
except it is not true.

PMR is emulating NVRAM (and requires memory semantics). Persistent state
is not emulating anything. It is an implementation detail.

> > > > I am, of course, blowing my own horn, since my implementation uses a
> > > > portable blockdev for this.
> > > >
> > >
> > > You are making it sound like the entire WDC series relies on this app=
roach.
> > > Actually, the persistency is introduced in the second to last patch i=
n the
> > > series and it only adds a couple of lines of code in the i/o path to =
mark
> > > zones dirty. This is possible because of using mmap() and I find the =
way
> > > it is done to be quite elegant, not ugly :)
> > >
> >=20
> > No, I understand that your implementation works fine without
> > persistance, but persistance is key. That is why my series adds it in
> > the first patch. Without persistence it is just a toy. And the QEMU
> > device is not just an "NVMe-version" of null_blk.
> >=20
> > And I don't think I ever called the use of mmap ugly. I called out the
> > physical memory API shenanigans as a hack.
> >=20
> > > > Another issue is the complete lack of endian conversions. Does it
> > > > matter? It depends. Will anyone ever use this on a big endian host =
and
> > > > move the meta data backing file to a little endian host? Probably n=
ot.
> > > > So does it really matter? Probably not, but it is cutting corners.
> > > >
> >=20
> > After I had replied this, I considered a follow-up, because there are
> > probably QEMU developers that would call me out on this.
> >=20
> > This definitely DOES matter to QEMU.
> >=20
> > >
> > > Great point on endianness! Naturally, all file backed values are stor=
ed in
> > > their native endianness. This way, there is no extra overhead on big =
endian
> > > hardware architectures. Portability concerns can be easily addressed =
by
> > > storing metadata endianness as a byte flag in its header. Then, during
> > > initialization, the metadata validation code can detect the possible
> > > discrepancy in endianness and automatically convert the metadata to t=
he
> > > endianness of the host. This part is out of scope of this series, but=
 I would
> > > be able to contribute such a solution as an enhancement in the future.
> > >
> >=20
> > It is not out of scope. I don't see why we should merge something that
> > is arguably buggy.
>=20
> Again, wow! Now you turned around and arbitrarily elevated this issue from
> moderate ("Does it matter?, cutting corners") to severe ("buggy"). Likely
> because v5 of WDC patchset has been posted.

No, exactly as I wrote above, after I hit reply I considered a
follow-up. I guess I should have.

> This, again, just shows your lack of integrity as a maintainer.
>=20

I can't believe I just read that.

I will not put up with this. It is completely non-called for. I stand up
for my opinions and I will fight to make sure the best possible code
goes upstream. Yes, I am paid by Samsung. But I can compartmentalize. I
have been working on QEMU before Samsung and I know how to separate
corporate interest and open source. I have a proven record on this list
to show that. I really cannot believe that you brought it down to that
level. I have been putting forth technical arguments throughout this
entire review process and now you are getting personal.

Not. Cool. Please keep things professional from now.

> This "issue" is a real trivial one to fix as I described above and you are
> blowing it up way out of proportion, making it look like it is a fundamen=
tal
> problem that can not be resolved. It's not.
>=20

If it is so trival to fix, please fix it. I think I made it clear that I
won't be happy until it is portable.

And please note that I have *not* complained about other parts of your
series. I have complained ALOT about the persistence implementation -
and I continue to stand behind those complaints.

I'm getting super tired of this one-sided process. I have continuously
reviewed and commented your series, I have found multiple bugs, I have
suggested improvements. Maybe if just one or two of those 9 people who
signed off on your zoned implementation could look past their own nose
and look at my series - you might just realize that its decent, portable
and offers some niceties that yours do not have (at the cost of the same
amount of code mind you).

--9ADF8FXzFeE7X4jE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9zf0wACgkQTeGvMW1P
Dek8nwgAr38MIaq5+ERKapyZpglXp2O2VCNenb+547oRAGreHHA1a3PW6UZh/+Pt
KY/jpvAfUl1TASA6UspiSg+guXDxLuMRgz019+qt3lly0u7f8jgMCp3TlDW6Qq/W
SKqRoMI6q/Cs2DAC1YUv7C77CJFDNnbjINJoGTp1I74L9UuwCwS1bVPkwDbTMgym
/Y9SmvvTYEfBKnzdDfg1QSY7SR6if7RtfzYkxsgyUUHqloOy/GEXOznC5PJxyL+l
OsSy3tsqAREpiLsp/pB6KpjHxfIgOUq1ixGcA3ZsEusKqpCma5zCSI+GjvziavZa
95KkKecU+ncq9uHFvWFTynLhljprEw==
=lE9X
-----END PGP SIGNATURE-----

--9ADF8FXzFeE7X4jE--


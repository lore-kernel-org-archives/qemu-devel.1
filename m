Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB598C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 10:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DABC520773
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 10:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DABC520773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNDDm-0002Vc-Bu
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 06:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kND9k-0000rd-B1; Tue, 29 Sep 2020 06:46:52 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:38755)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kND9g-0000LE-AO; Tue, 29 Sep 2020 06:46:48 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailnew.nyi.internal (Postfix) with ESMTP id B22BB58082F;
 Tue, 29 Sep 2020 06:46:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Tue, 29 Sep 2020 06:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=KxATW4Ukxmag59jSi/FYL1zDTSj
 6I8Vz44Mxnen6mkU=; b=SFKW8mC9UQOAYz7eK85MzfR3RmP3MSNjrW2dYhjt3UJ
 yZMl/o8T3VPD6tpZBE76c9RA2mCY8avL81S+6Smxqhq1XkU+jDBdmusBZUekOhHU
 xfVw1chIq+P0u0u5UAgg2hHjNvMlfWRxfmpAkggaf0+qGDM0cG9b3c4J0HqkQRMQ
 zcou6pYVtDqiKv7g5JOX4HhfO8ZOAdvgUtsgQo89AN9xvy2Y/YG56xX8i43a2yRX
 9CnI5X9vYYmd586HR6+IbVpgXaeDDqcpCD9ZAQ28TV4HHvQYoYxqRHG30Tth0fWn
 DRmgUQ+1yWwa61JA7LYL6nNcKKwkGPX5KiYqUmZHB7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=KxATW4
 Ukxmag59jSi/FYL1zDTSj6I8Vz44Mxnen6mkU=; b=bPIqGocoqU4ACBzxoYc+wd
 7ztUjcMZs9wHERkmiOqDok3oZCbr/LhgB3NuFLgPVTsl+f+ta5BwlMT/8QOKGL0Z
 jtztt8zYsLLovkFatcMTBh+oLsIDA8beBxbAZiHLnMn7R6Ydy4XjIqAHwKUO3quE
 qZw/DFG6jGoDo6a+mNHCIUvWC99eU3vz+vXNYzFVnKq4m1Vsye7cQOoB3XYFCk1Q
 BwD6/0HhMP9zBbgupKt2j6ka8MO82v5+/CKfo1+4uKnzRYSMjrQOXcKZgVFkzzQ9
 x55RxE7as80KMLkQ42kQM/HcywpsPurmRgoI4YrBapCa58GAwS49kwzJGOBTIKMw
 ==
X-ME-Sender: <xms:jRBzX_05frbj4C9hDhDyzJDn-k28-dY9tgNcXqhM6ue-Qiw7fa_SHA>
 <xme:jRBzX-EaCj9bYA3q1nmm3fNC3KQlhsckWVMCZsR5KhFdMz0WP0DUegwbSvn2D7bSH
 VN18yu-LC-HFps1f9U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdekgdeffecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:jRBzX_7vP8ipI9BGp8MihgYAoTbmEenwpKhOyW35FwhXKDsyhtGaeg>
 <xmx:jRBzX03P4nsUSCKTPe7D7Ol9BjkcZfV6j8YT_v0bD89yJLTLlbOHhQ>
 <xmx:jRBzXyE2EaPt1pPz2BXhiMs270wPKNcQlROsChw34vIxI7kJ6wJg5Q>
 <xmx:jhBzX1BdLiY205YeCkOk8KZdGyjYOIn6NYyXgI_3sop8dcEncNg0YY8f9RM>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id BD189306467E;
 Tue, 29 Sep 2020 06:46:35 -0400 (EDT)
Date: Tue, 29 Sep 2020 12:46:33 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v4 00/14] hw/block/nvme: Support Namespace Types and
 Zoned Namespace Command Set
Message-ID: <20200929104633.GA179147@apples.localdomain>
References: <20200923182021.3724-1-dmitry.fomichev@wdc.com>
 <20200924210751.GD1738917@apples.localdomain>
 <MN2PR04MB59515B1EA1238861DFF3236AE1350@MN2PR04MB5951.namprd04.prod.outlook.com>
 <20200928063648.GA1967@apples.localdomain>
 <20200928212541.GC227320@dhcp-10-100-145-180.wdl.wdc.com>
 <CY4PR04MB3751997C2ED1D5EFB69E32ACE7350@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <CY4PR04MB3751997C2ED1D5EFB69E32ACE7350@CY4PR04MB3751.namprd04.prod.outlook.com>
Received-SPF: pass client-ip=66.111.4.224; envelope-from=its@irrelevant.dk;
 helo=new2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 06:46:38
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Niklas Cassel <Niklas.Cassel@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 28 22:54, Damien Le Moal wrote:
> On 2020/09/29 6:25, Keith Busch wrote:
> > On Mon, Sep 28, 2020 at 08:36:48AM +0200, Klaus Jensen wrote:
> >> On Sep 28 02:33, Dmitry Fomichev wrote:
> >>> You are making it sound like the entire WDC series relies on this app=
roach.
> >>> Actually, the persistency is introduced in the second to last patch i=
n the
> >>> series and it only adds a couple of lines of code in the i/o path to =
mark
> >>> zones dirty. This is possible because of using mmap() and I find the =
way
> >>> it is done to be quite elegant, not ugly :)
> >>>
> >>
> >> No, I understand that your implementation works fine without
> >> persistance, but persistance is key. That is why my series adds it in
> >> the first patch. Without persistence it is just a toy. And the QEMU
> >> device is not just an "NVMe-version" of null_blk.
> >=20
> > I really think we should be a bit more cautious of commiting to an
> > on-disk format for the persistent state. Both this and Klaus' persistent
> > state feels a bit ad-hoc, and with all the other knobs provided, it
> > looks too easy to have out-of-sync states, or just not being able to
> > boot at all if a qemu versions have different on-disk formats.
> >=20
> > Is anyone really considering zone emulation for production level stuff
> > anyway? I can't imagine a real scenario where you'd want put yourself
> > through that: you are just giving yourself all the downsides of a zoned
> > block device and none of the benefits. AFAIK, this is provided as a
> > development vehicle, closer to a "toy".
> >=20
> > I think we should consider trimming this down to a more minimal set that
> > we *do* agree on and commit for inclusion ASAP. We can iterate all the
> > bells & whistles and flush out the meta data's data marshalling scheme
> > for persistence later.
>=20
> +1 on this. Removing the persistence also removes the debate on endianess=
=2E With
> that out of the way, it should be straightforward to get agreement on a s=
eries
> that can be merged quickly to get developers started with testing ZNS sof=
tware
> with QEMU. That is the most important goal here. 5.9 is around the corner=
, we
> need something for people to get started with ZNS quickly.
>=20

Wait. What. No. Stop!

It is unmistakably clear that you are invalidating my arguments about
portability and endianness issues by suggesting that we just remove
persistent state and deal with it later, but persistence is the killer
feature that sets the QEMU emulated device apart from other emulation
options. It is not about using emulation in production (because yeah,
why would you?), but persistence is what makes it possible to develop
and test "zoned FTLs" or something that requires recovery at power up.
This is what allows testing of how your host software deals with opened
zones being transitioned to FULL on power up and the persistent tracking
of LBA allocation (in my series) can be used to properly test error
recovery if you lost state in the app.

Please, work with me on this instead of just removing such an essential
feature. Since persistence seems to be the only thing we are really
discussing, we should have plenty of time until the soft-freeze to come
up with a proper solution on that.

I agree that my version had a format that was pretty ad-hoc and that
won't fly - it needs magic and version capabilities like in Dmitry's
series, which incidentially looks a lot like what we did in the
OpenChannel implementation, so I agree with the strategy.

ZNS-wise, the only thing my implementation stores is the zone
descriptors (in spec-native little-endian format) and the zone
descriptor extensions. So there are no endian issues with those. The
allocation tracking bitmap is always stored in little endian, but
converted to big-endian if running on a big-endian host.

Let me just conjure something up.

    #define NVME_PSTATE_MAGIC ...
    #define NVME_PSTATE_V1    1

    typedef struct NvmePstateHeader {
        uint32_t magic;
        uint32_t version;

        uint64_t blk_len;

        uint8_t  lbads;
        uint8_t  iocs;

        uint8_t  rsvd18[3054];

        struct {
            uint64_t zsze;
            uint8_t  zdes;
        } QEMU_PACKED zns;

        uint8_t  rsvd3089[1007];
    } QEMU_PACKED NvmePstateHeader;

With such a header we have all we need. We can bail out if any
parameters do not match and similar to nvme data structures it contains
reserved areas for future use. I'll be posting a v2 with this. If this
still feels too ad-hoc, we can be inspired by QCOW2 and the "extension"
feature.

I can agree that we drop other optional features like zone excursions
and the reset/finish recommended limit simulation, but PLEASE DO NOT
remove persistence and upstream a half-baked version when we are so
close and have time to get it right.

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9zEIUACgkQTeGvMW1P
Den2iggAtA5Pp6+wOstKhrIztC3VHrQxkZEBDWw2N4ZhbzDCrII/NW5p2c5LRYFw
hUFdneQcEznvFYXF6LkowVrwi7LuxdhGE29MX9z06aFvKN15fYtUx65+uNVNagyr
GPzT/U9fjcRAVOGIaCyWDNliuEaNr/EX5kDcNmQAgoH1bhjLHDqajU2lqdSMxEnF
ZqstV5U0Mk2DiYs5f8iOI5y6J3hiF6bS0UAYB3XJdcoeQkpxCbfDk9bS1ZEVvh9L
CLX0ZZYpmSJIqZm1R+7lOCLcBrtTzxmYyy0T9hKt0j+shtA7aZzTYPK41wNoEc7B
Y9ekNvhchx30LRpQOxXinpzUEaLGeg==
=NgDk
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--


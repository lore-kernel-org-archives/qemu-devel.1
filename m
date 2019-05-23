Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CA6C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 11:15:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B68D221019
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 11:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68D221019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33943 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTlh2-0000Tb-Uz
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 07:15:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hTlfu-0008JH-69
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:14:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hTlfs-00085l-2c
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:14:18 -0400
Received: from 10.mo68.mail-out.ovh.net ([46.105.79.203]:54936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hTlfr-00080r-U6
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:14:16 -0400
Received: from player792.ha.ovh.net (unknown [10.109.143.238])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 6636B12EE1D
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 13:14:05 +0200 (CEST)
Received: from kaod.org (deibp9eh1--blueice1n0.emea.ibm.com [195.212.29.162])
	(Authenticated sender: clg@kaod.org)
	by player792.ha.ovh.net (Postfix) with ESMTPSA id 61E9762AB623;
	Thu, 23 May 2019 11:13:57 +0000 (UTC)
To: Wim Vervoorn <wvervoorn@eltan.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
	Peter Maydell <peter.maydell@linaro.org>
References: <d0fea426e8b245769f3022dad121c17e@Eltsrv03.Eltan.local>
	<3ee8eb5a-d38c-9570-3da5-a055e9f147e5@kaod.org>
	<fed595d26ce54222b42e005566b70308@Eltsrv03.Eltan.local>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9b49eb14-6dc8-29df-c617-8080551b4f6c@kaod.org>
Date: Thu, 23 May 2019 13:13:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <fed595d26ce54222b42e005566b70308@Eltsrv03.Eltan.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 9258274935155362577
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddruddugedgfeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.79.203
Subject: Re: [Qemu-devel] aspeed qemu question
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/23/19 12:05 PM, Wim Vervoorn wrote:
> Hello C=C3=A9dric,
>=20
> I have another question regarding the ASPEED Qemu support. This is rega=
rding the SPI support.
>=20
> I noticed that in general the fmc_model and the spi_model for the flash=
 device
> are different even though there is only one flash device connected.

The flash devices are created but not attached to a file backend=20
unless you define it on the command line with -drive options :

	-drive file=3D$flashfile,format=3Draw,if=3Dmtd

The first mtd drive corresponds to the flash chip attached to the=20
FMC controller (BMC Firmware), the second is the flash attached to=20
the SPI1 controller (Host Firmware)

> I would expect that in this case the models used would be identical.

The flash device models are defined at the machine level in
hw/arm/aspeed.c:

    }, {
        .name      =3D MACHINE_TYPE_NAME("witherspoon-bmc"),
        .desc      =3D "OpenPOWER Witherspoon BMC (ARM1176)",
        .soc_name  =3D "ast2500-a1",
        .hw_strap1 =3D WITHERSPOON_BMC_HW_STRAP1,
        .fmc_model =3D "mx25l25635e",
        .spi_model =3D "mx66l1g45g",
        .num_cs    =3D 2,
        .i2c_init  =3D witherspoon_bmc_i2c_init,
        .ram       =3D 512 * MiB,
    },

> Can you explain how this is works and how I select the correct model
> for the fmc and for the spi controller.

You need to define a new machine (board) if you want different flash mode=
ls.

C.=20


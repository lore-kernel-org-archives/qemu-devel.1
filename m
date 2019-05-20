Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC56C04AAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 07:48:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D79CF20815
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 07:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79CF20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59617 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSd2G-0008Ee-5e
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 03:48:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hSd0v-0007ic-18
	for qemu-devel@nongnu.org; Mon, 20 May 2019 03:47:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hSd0u-0000Yi-3Y
	for qemu-devel@nongnu.org; Mon, 20 May 2019 03:47:17 -0400
Received: from 4.mo6.mail-out.ovh.net ([87.98.184.159]:60357)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hSd0t-0000TC-UN
	for qemu-devel@nongnu.org; Mon, 20 May 2019 03:47:16 -0400
Received: from player693.ha.ovh.net (unknown [10.108.54.67])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 391D81C3582
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 09:47:11 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
	(Authenticated sender: clg@kaod.org)
	by player693.ha.ovh.net (Postfix) with ESMTPSA id 797675E77D5E;
	Mon, 20 May 2019 07:47:05 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190506142042.28096-1-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b12201c8-7d5f-2108-6666-75543c38f243@kaod.org>
Date: Mon, 20 May 2019 09:47:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506142042.28096-1-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 6592988382054943523
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddruddtjedguddvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.184.159
Subject: Re: [Qemu-devel] [PATCH v2 0/3] aspeed: cleanups and extensions
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On 5/6/19 4:20 PM, C=C3=A9dric Le Goater wrote:
> Hello,
>=20
> Here is a series adding a couple of cleanups to the Aspeed SoCs to
> prepare ground for extensions and new SoCs.
>=20
> Thanks,
>=20
> C.
>=20
> Changes since v1:
>=20
>  - moved enum defining the Aspeed controller names under aspeed_soc.h
>  - removed AspeedSoCInfo 'sdram_base' field
>  - fixed clang compilation
>=20
> C=C3=A9dric Le Goater (3):
>   aspeed: add a per SoC mapping for the interrupt space
>   aspeed: add a per SoC mapping for the memory space

I think these two patches are fine to go even if Philippe's comments=20
are not addressed. There are valid but not a blocker to me. =20

>   aspeed: use sysbus_init_child_obj() to initialize children

Philippe has taken over this patch in a larger series which will go=20
through Eduardo's tree, if I understood well the emails. When merged,=20
we can try to re-merge the RTC patchset from Joel. I think we made=20
things a little more complex than they should have been.=20

Thanks,

C.

>  include/hw/arm/aspeed_soc.h |  40 ++++++-
>  hw/arm/aspeed.c             |   8 +-
>  hw/arm/aspeed_soc.c         | 226 ++++++++++++++++++++++--------------
>  3 files changed, 184 insertions(+), 90 deletions(-)
>=20



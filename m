Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7DAC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:25:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64D4A2068F
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D4A2068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYDci-0002vS-3V
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 13:25:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iYDUd-0000Te-If
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:17:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iYDUc-00042N-2U
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:17:19 -0500
Received: from 3.mo5.mail-out.ovh.net ([46.105.40.108]:44578)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iYDUb-000406-RU
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:17:18 -0500
Received: from player729.ha.ovh.net (unknown [10.109.146.5])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id A223425BAD7
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 19:17:14 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player729.ha.ovh.net (Postfix) with ESMTPSA id 0F301C992A3F;
 Fri, 22 Nov 2019 18:17:09 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v5 00/23] ppc/pnv: add XIVE support for KVM guests
To: David Gibson <david@gibson.dropbear.id.au>
References: <20191115162436.30548-1-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3a76eea8-9009-8762-be89-c2c045db8721@kaod.org>
Date: Fri, 22 Nov 2019 19:17:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191115162436.30548-1-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 2750010522864225107
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudehgedguddutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejvdelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.40.108
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/11/2019 17:24, C=C3=A9dric Le Goater wrote:
> Hello,
>=20
> The QEMU PowerNV machine emulates a baremetal OpenPOWER system and
> acts as an hypervisor (L0). Supporting emulation of KVM to run guests
> (L1) requires a few more extensions, among which guest support for the
> XIVE interrupt controller on POWER9 processor.
>=20
> The following changes extend the XIVE models with the new XiveFabric
> and XivePresenter interfaces to provide support for XIVE escalations
> and interrupt resend. This mechanism is used by XIVE to notify the
> hypervisor that a vCPU is not dispatched on a HW thread. Tested on a
> QEMU PowerNV machine and a simple QEMU pseries guest doing network on
> a local bridge.
>=20
> The XIVE interrupt controller offers a way to increase the XIVE
> resources per chip by configuring multiple XIVE blocks on a chip. This
> is not currently supported by the model. However, some configurations,
> such as OPAL/skiboot, use one block-per-chip configuration with some
> optimizations. One of them is to override the hardwired chip ID by the
> block id in the PowerBUS operations and for CAM line compares. This
> patchset improves the support for this setup. Tested with 4 chips.
>=20
> A series from Suraj adding guest support in the Radix MMU model of the
> QEMU PowerNV machine is still required and will be send later. The
> whole patchset can be found under :
>=20
>   https://github.com/legoater/qemu/tree/powernv-4.2


 [ ... ]

> C=C3=A9dric Le Goater (23):
>   ppc/xive: Record the IPB in the associated NVT
>   ppc/xive: Introduce helpers for the NVT id
>   ppc/pnv: Remove pnv_xive_vst_size() routine
>   ppc/pnv: Dump the XIVE NVT table
>   ppc/pnv: Quiesce some XIVE errors
>   ppc/xive: Introduce OS CAM line helpers
>   ppc/xive: Check V bit in TM_PULL_POOL_CTX
>   ppc/xive: Introduce a XivePresenter interface
>   ppc/xive: Implement the XivePresenter interface

David,

I have reworked the following patches to address Greg's comments=20
and your comment on "ppc/pnv: Dump the XIVE NVT table".=20

Shall I wait for some feedback from you or just resend ?=20

Thanks,

C.

>   ppc/pnv: Loop on the threads of the chip to find a matching NVT
>   ppc/pnv: Introduce a pnv_xive_is_cpu_enabled() helper
>   ppc/xive: Introduce a XiveFabric interface
>   ppc/pnv: Implement the XiveFabric interface
>   ppc/spapr: Implement the XiveFabric interface
>   ppc/xive: Use the XiveFabric and XivePresenter interfaces
>   ppc/xive: Extend the TIMA operation with a XivePresenter parameter
>   ppc/pnv: Clarify how the TIMA is accessed on a multichip system
>   ppc/xive: Move the TIMA operations to the controller model
>   ppc/xive: Remove the get_tctx() XiveRouter handler
>   ppc/xive: Introduce a xive_tctx_ipb_update() helper
>   ppc/xive: Synthesize interrupt from the saved IPB in the NVT
>   ppc/pnv: Introduce a pnv_xive_block_id() helper
>   ppc/pnv: Extend XiveRouter with a get_block_id() handler
>=20
>  include/hw/ppc/pnv.h       |  15 ++
>  include/hw/ppc/pnv_xive.h  |   3 -
>  include/hw/ppc/xive.h      |  72 ++++++--
>  include/hw/ppc/xive_regs.h |  24 +++
>  hw/intc/pnv_xive.c         | 360 ++++++++++++++++++++++++-------------
>  hw/intc/spapr_xive.c       |  88 ++++++++-
>  hw/intc/xive.c             | 350 ++++++++++++++++++++----------------
>  hw/ppc/pnv.c               |  37 +++-
>  hw/ppc/spapr.c             |  36 ++++
>  9 files changed, 691 insertions(+), 294 deletions(-)
>=20



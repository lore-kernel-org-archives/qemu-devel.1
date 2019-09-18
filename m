Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F5AC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 08:54:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26BEE21897
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 08:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26BEE21897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAVjl-0004VQ-AA
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 04:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iAVj1-0003sE-45
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 04:54:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iAVj0-00009P-3w
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 04:54:11 -0400
Received: from 10.mo177.mail-out.ovh.net ([46.105.73.133]:60368)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iAViz-0008U9-V2
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 04:54:10 -0400
Received: from player758.ha.ovh.net (unknown [10.109.146.163])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id AE2DD108B60
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 10:54:00 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player758.ha.ovh.net (Postfix) with ESMTPSA id 1E6FE9F85F34;
 Wed, 18 Sep 2019 08:53:55 +0000 (UTC)
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190731141233.1340-1-clg@kaod.org>
 <1a52b8c6-b29a-d223-0dfb-8aa24bf1d5aa@kaod.org>
 <20190918054426.GI2440@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <5a4efa4c-cdf9-53fe-f49b-ac6146b9b4b6@kaod.org>
Date: Wed, 18 Sep 2019 10:53:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190918054426.GI2440@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 17341110369127140179
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudekgddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.73.133
Subject: Re: [Qemu-devel] [PATCH v3 00/18] ppc/pnv: add XIVE support for KVM
 guests
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

On 18/09/2019 07:44, David Gibson wrote:
> On Tue, Sep 17, 2019 at 01:54:24PM +0200, C=E9dric Le Goater wrote:
>> On 31/07/2019 16:12, C=E9dric Le Goater wrote:
>>> Hello,
>>>
>>> The QEMU PowerNV machine emulates a baremetal OpenPOWER system and
>>> acts as an hypervisor (L0). Supporting emulation of KVM to run guests
>>> (L1) requires a few more extensions, among which guest support for th=
e
>>> XIVE interrupt controller on POWER9 processor.
>>>
>>> The following changes add new per-CPU PowerNV machines and extend the
>>> XIVE models with the new XiveFabric and XivePresenter interfaces to
>>> provide support for XIVE escalations and interrupt resend. This
>>> mechanism is used by XIVE to notify the hypervisor that a vCPU is not
>>> dispatched on a HW thread. Tested on a QEMU PowerNV machine and a
>>> simple QEMU pseries guest doing network on a local bridge.
>>>
>>> The XIVE interrupt controller offers a way to increase the XIVE
>>> resources per chip by configuring multiple XIVE blocks on a chip. Thi=
s
>>> is not currently supported by the model. However, some configurations=
,
>>> such as OPAL/skiboot, use one block-per-chip configuration with some
>>> optimizations. One of them is to override the hardwired chip ID by th=
e
>>> block id in the PowerBUS operations and for CAM line compares. This
>>> patchset improves the support for this setup. Tested with 4 chips.
>>
>> David,
>>
>> Do you want me to resend this patchset ? or you just didn't have time
>> to look at it ? =20
>=20
> Mostly, I just haven't had time.  I'm also finding the patches pretty
> difficult to read and review.  I don't think that's an indication
> they're bad, just that what they're doing is necessarily complex, but
> it's still made it hard to tackle them.

I will try to split the initial patches on the presenter a little more.


>> Patch 16 has changed a little since. The get_block_id() handler has=20
>> moved to the XiveRouterClass.
>=20
> You, might as well repost, so I'm looking at the latest stuff.  I
> can't promise I'll be able to look at the new set terribly soon
> though.

ok.

thanks,

C.



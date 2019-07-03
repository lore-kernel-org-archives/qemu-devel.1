Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1ED1C5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 05:58:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9DBA21871
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 05:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9DBA21871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiYHK-00078A-37
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 01:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43005)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hiYGR-0006I3-Mg
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 01:57:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hiYGQ-0002vV-HM
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 01:57:07 -0400
Received: from 14.mo6.mail-out.ovh.net ([46.105.56.113]:42118)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hiYGQ-0002uP-Bw
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 01:57:06 -0400
Received: from player756.ha.ovh.net (unknown [10.108.35.197])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id EF2D81D469B
 for <qemu-devel@nongnu.org>; Wed,  3 Jul 2019 07:57:03 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player756.ha.ovh.net (Postfix) with ESMTPSA id AD6B36B03748;
 Wed,  3 Jul 2019 05:56:57 +0000 (UTC)
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190630204601.30574-1-clg@kaod.org>
 <20190703021009.GE9442@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b187c7e4-bdbe-3b20-bb8e-f66deffac462@kaod.org>
Date: Wed, 3 Jul 2019 07:56:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190703021009.GE9442@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 4877116922123684691
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrvdelgddutdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.56.113
Subject: Re: [Qemu-devel] [PATCH 00/10] ppc/pnv: add XIVE support for KVM
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/07/2019 04:10, David Gibson wrote:
> On Sun, Jun 30, 2019 at 10:45:51PM +0200, C=E9dric Le Goater wrote:
>> Hello,
>>
>> The QEMU PowerNV machine emulates a baremetal OpenPOWER system and
>> acts as an hypervisor (L0). Supporting emulation of KVM to run guests
>> (L1) requires a few more extensions, among which support for the XIVE
>> interrupt controller on POWER9 processor.=20
>>
>> The following changes fix some parts of the XIVE model and provide
>> support for escalations and resend. This mechanism is used by KVM to
>> kick a vCPU when it is not dispatched on a HW thread.
>>
>> A series from Suraj adding guest support in the Radix MMU model of the
>> QEMU PowerNV machine is still required and will be send later. The
>> whole patchset can be found under :
>>
>>   https://github.com/legoater/qemu/tree/powernv-4.1
>=20
> The rest of this series is essentially a new feature, and so will have
> to wait until 4.2 now we're in soft freeze.

Yes. That's fine. This is to let you know what is in preparation:
escalations, KVM under PowerNV, PowerNV POWER10. It's all in the=20
pipe.

Thanks,

C.



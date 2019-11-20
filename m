Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AFDC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 07:47:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E399D208A1
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 07:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E399D208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXKiM-0002Lb-3o
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 02:47:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iXKhK-0001rI-0s
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 02:46:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iXKhH-0000vb-Py
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 02:46:44 -0500
Received: from 3.mo68.mail-out.ovh.net ([46.105.58.60]:48938)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iXKhH-0000tA-1G
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 02:46:43 -0500
Received: from player756.ha.ovh.net (unknown [10.109.159.224])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 50F6F14D074
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 08:46:40 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player756.ha.ovh.net (Postfix) with ESMTPSA id 71B62B7E30E2;
 Wed, 20 Nov 2019 07:46:34 +0000 (UTC)
Subject: Re: [PATCH 0/5] ppc/pnv: fix Homer/Occ mappings on multichip systems
To: Balamuruhan S <bala24@linux.ibm.com>, qemu-devel@nongnu.org
References: <20191119175056.32518-1-bala24@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <779f2a3b-62d2-62e9-674c-b2b53bf26da0@kaod.org>
Date: Wed, 20 Nov 2019 08:46:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191119175056.32518-1-bala24@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 17248505098024029158
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegledgudduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeehiedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.58.60
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
Cc: qemu-ppc@nongnu.org, groug@kaod.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On 19/11/2019 18:50, Balamuruhan S wrote:
> Hi All,
> 
> PowerNV fails to boot in multichip systems due to some misinterpretation
> and mapping in Homer/Occ device models, this patchset fixes the
> following,
> 
>  - Homer size is 4MB per chip and Occ common area size is 8MB
>  - Bar masks are used to calculate sizes of Homer/Occ in skiboot so
>    return appropriate value
>  - Occ common area is in BAR 3 on Power8 but wrongly mapped to BAR 2
>    currently
>  - OCC common area is shared across chips and should be mapped only once
>    for multichip systems

The first thing to address is the HOMER XSCOM region. 

Introduce an empty skeleton for P8 and P9 with different mem ops handers
because the registers have a different layout. From there, add the support
for the different PBA* regs and move them out from the default XSCOM
handlers. That should fix most of the current problems and it will provide 
a nice framework for future extensions.

Why not add the associated HOMER MMIO region while we are it ? the PBA
registers have all the definitions we need and it will gives us access
to the pstate table.


Second is the OCC region. Do we need a XSCOM *or* a MMIO region ? This is 
not clear. Please check skiboot. I think a MMIO region should be enough
because this is how sensor data from the OCC is accessed. 

On that topic, we could define properties on the PnvOCC model for each 
sensor and tune the value from the QEMU monitor. It really shouldn't be
too complex.

Also the same address is used, we should only map it once but we need 
to invent something to know from which chip it is accessed. 


C.


> 
> Request for your review and suggestions to make it better. I would like to
> thank Cedric for his time and help to figure out the issues.
>
> Balamuruhan S (5):
>   hw/ppc/pnv: incorrect homer and occ common area size
>   hw/ppc/pnv_xscom: PBA bar mask values are incorrect with homer/occ
>     sizes
>   hw/ppc/pnv_xscom: Power8 occ common area is in PBA BAR 3
>   hw/ppc/pnv_xscom: occ common area to be mapped only once
>   hw/ppc/pnv_xscom: add PBA BARs for Power8 slw image
> 
>  hw/ppc/pnv_occ.c     |  2 +-
>  hw/ppc/pnv_xscom.c   | 37 +++++++++++++++++++++++++++----------
>  include/hw/ppc/pnv.h | 12 ++++++++----
>  3 files changed, 36 insertions(+), 15 deletions(-)
> 



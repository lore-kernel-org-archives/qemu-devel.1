Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B89ECDE20
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:56:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 722BD208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 722BD208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Lpe-0001NB-Cj
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 05:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1i8Lnv-0008Ev-WC
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:54:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1i8Lnu-0004vq-J3
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:54:19 -0400
Received: from 15.mo4.mail-out.ovh.net ([91.121.62.11]:60328)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1i8Lnu-0004tW-By
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:54:18 -0400
Received: from player157.ha.ovh.net (unknown [10.109.160.23])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 7CBB5206B83
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 11:54:16 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id 3007C9AA68E9;
 Thu, 12 Sep 2019 09:54:04 +0000 (UTC)
To: Balamuruhan S <bala24@linux.ibm.com>, qemu-devel@nongnu.org
References: <20190912093056.4516-1-bala24@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b27c56a5-1401-09f3-4d5d-9ff4843c8f26@kaod.org>
Date: Thu, 12 Sep 2019 11:54:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190912093056.4516-1-bala24@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 1569222997106199378
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrtdehgddvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.121.62.11
Subject: Re: [Qemu-devel] [PATCH v3 0/4] add Homer/OCC common area emulation
 for PowerNV
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
Cc: maddy@linux.vnet.ibm.com, groug@kaod.org, anju@linux.vnet.ibm.com,
 qemu-ppc@nongnu.org, hari@linux.vnet.ibm.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/09/2019 11:30, Balamuruhan S wrote:
> Hi All,
> 
> This is follow-up patch that implements HOMER and OCC SRAM device
> models to emulate homer memory and occ common area access for pstate
> table, occ sensors, runtime data and slw.

So, now, we can write directly to the OCC SRAM memory region from the
QEMU monitor. How will skiboot pick up the changes ?  


C.

> 
> Currently skiboot disables the homer/occ code path with `QUIRK_NO_PBA`,
> this quirk have to be removed in skiboot for it to use HOMER and OCC
> SRAM device models along with a bug fix,
> 
> https://github.com/balamuruhans/skiboot/commit/a655514d2a730e0372a2faee277d1cf01f71a524
> https://github.com/balamuruhans/skiboot/commit/fd3d93d92ec66a7494346d6d24ced7b48264c9a0
> 
> This version fixes a review comment from Cedric in previous version,
> 
> changes in v3:
>     * pass on PnvHomer *homer directly to core_max_array() function
>       from the caller.
> 
> v2 patchset:
> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg02231.html
> 
> changes in v2:
>     * change to PnvHomer/PnvHomerClass instead of PnvHOMER/PnvHOMERClass
>       for better code readabililty.
>     * fabric link to chip to use `nr_cores` from PnvChip struct for
>       core_max_array() as we need to consider active cores in chip and not
>       whole machine.
>     * declare variable well ahead instead in for() loop syntax to make
>       all compilers happy.
>     * change to shorter variable name to `hmrc` instead of `homer_class`.
>     * remove `homer_` prefix for regs as it is not useful.
>     * have separate commit for checkpatch.pl coding style warnings.
> 
> v1 patchset:
> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg01610.html
> 
> changes in v1:
>     * breaks it to have separate patch series for Homer and OCC
>       emulation.
>     * reuse PnvOCC device model to implement SRAM device.
>     * implement PnvHomer as separate device model.
>     * have core max base address as part of PnvHOMERClass.
>     * reuse PNV_CHIP_INDEX() instead of introducing new `chip_num`.
>     * define all the memory ops access address as macros.
>     * few coding style warnings given by checkpatch.pl.
> 
> rfc patchset:
> https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg00979.html
> 
> I request for review, comments and suggestions for the changes.
> 
> Balamuruhan S (4):
>   hw/ppc/pnv_xscom: retrieve homer/occ base address from PBA BARs
>   hw/ppc/pnv_occ: add sram device model for occ common area
>   hw/ppc/pnv_homer: add PowerNV homer device model
>   hw/ppc/pnv: fix checkpatch.pl coding style warnings
> 
>  hw/ppc/Makefile.objs       |   1 +
>  hw/ppc/pnv.c               |  87 ++++++++++++---
>  hw/ppc/pnv_homer.c         | 272 +++++++++++++++++++++++++++++++++++++++++++++
>  hw/ppc/pnv_occ.c           |  78 +++++++++++++
>  hw/ppc/pnv_xscom.c         |  34 +++++-
>  include/hw/ppc/pnv.h       |  21 ++++
>  include/hw/ppc/pnv_homer.h |  53 +++++++++
>  include/hw/ppc/pnv_occ.h   |   3 +
>  8 files changed, 528 insertions(+), 21 deletions(-)
>  create mode 100644 hw/ppc/pnv_homer.c
>  create mode 100644 include/hw/ppc/pnv_homer.h
> 



Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCFAC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 11:50:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3669021019
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 11:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3669021019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7eet-0003D2-S2
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 07:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1i7eb8-0001Ba-18
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 07:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1i7eb6-0000X2-Fn
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 07:46:13 -0400
Received: from 14.mo4.mail-out.ovh.net ([46.105.40.29]:40914)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1i7eb5-0000U6-0t
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 07:46:12 -0400
Received: from player729.ha.ovh.net (unknown [10.109.160.62])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 81353205246
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 13:46:07 +0200 (CEST)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player729.ha.ovh.net (Postfix) with ESMTPSA id 5205C9CBA716;
 Tue, 10 Sep 2019 11:45:56 +0000 (UTC)
To: Balamuruhan S <bala24@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20190910071019.16689-1-bala24@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <0a76efcd-127c-75a4-8fc8-92007ccec1a5@kaod.org>
Date: Tue, 10 Sep 2019 13:45:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910071019.16689-1-bala24@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 10159276337659808594
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrtddtgddvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.40.29
Subject: Re: [Qemu-devel] [PATCH v1 0/3] add Homer/OCC common area emulation
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
Cc: maddy@linux.vnet.ibm.com, anju@linux.vnet.ibm.com, groug@kaod.org,
 hari@linux.vnet.ibm.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/09/2019 09:10, Balamuruhan S wrote:
> Hi All,
> 
> This is follow-up patch that implements HOMER and OCC SRAM device
> models to emulate homer memory and occ common area access for pstate
> table, occ sensors, runtime data and slw.
> 
> This version addresses review comments in previous patchset and
> breaks it to have separate patch series for Homer and OCC emulation,
> 
> https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg00979.html
> 
> currently skiboot disables the homer/occ code path with `QUIRK_NO_PBA`,
> this quirk have to be removed in skiboot for it to use HOMER and OCC
> SRAM device models along with few bug fixes,
> 
> https://github.com/balamuruhans/skiboot/commit/a655514d2a730e0372a2faee277d1cf01f71a524
> https://github.com/balamuruhans/skiboot/commit/fd3d93d92ec66a7494346d6d24ced7b48264c9a0

Can't we generate the sensors in QEMU ? I am not sure what this
patch does. Is the Header Block invalid ? 

It would be good to generate properties to control their values 
on the monitor line, like Rashmica did for GPIO model in the 
Aspeed machine.

> https://github.com/balamuruhans/skiboot/commit/165b3829a93bc177c18133945a8cca3a2d701173

This one is weird .

C. 

> 
> changes from v1:
>     * reuse PnvOCC device model to implement SRAM device.
>     * implement PnvHomer as separate device model.
>     * have core max base address as part of PnvHOMERClass.
>     * reuse PNV_CHIP_INDEX() instead of introducing new `chip_num`.
>     * define all the memory ops access address as macros.
>     * few coding style warnings given by checkpatch.pl.
> 
> I request for review, comments and suggestions for the changes.
> 
> Balamuruhan S (3):
>   hw/ppc/pnv_xscom: retrieve homer/occ base address from PBA BARs
>   hw/ppc/pnv_occ: add sram device model for occ common area
>   hw/ppc/pnv_homer: add PowerNV homer device model
> 
>  hw/ppc/Makefile.objs       |   1 +
>  hw/ppc/pnv.c               |  87 ++++++++++++---
>  hw/ppc/pnv_homer.c         | 258 +++++++++++++++++++++++++++++++++++++++++++++
>  hw/ppc/pnv_occ.c           |  78 ++++++++++++++
>  hw/ppc/pnv_xscom.c         |  34 +++++-
>  include/hw/ppc/pnv.h       |  21 ++++
>  include/hw/ppc/pnv_homer.h |  52 +++++++++
>  include/hw/ppc/pnv_occ.h   |   3 +
>  8 files changed, 513 insertions(+), 21 deletions(-)
>  create mode 100644 hw/ppc/pnv_homer.c
>  create mode 100644 include/hw/ppc/pnv_homer.h
> 



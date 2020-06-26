Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8496EC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:22:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57EE72070A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57EE72070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jolVM-0002Bn-MH
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 06:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jolUh-0001eX-HU; Fri, 26 Jun 2020 06:22:03 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:61262)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jolUf-0000m8-2j; Fri, 26 Jun 2020 06:22:02 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id E0A4D7482CD;
 Fri, 26 Jun 2020 12:21:49 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C43367475FA; Fri, 26 Jun 2020 12:21:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C298E74633D;
 Fri, 26 Jun 2020 12:21:49 +0200 (CEST)
Date: Fri, 26 Jun 2020 12:21:49 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH v5 00/11] Mac Old World ROM experiment
In-Reply-To: <cover.1592315226.git.balaton@eik.bme.hu>
Message-ID: <alpine.BSF.2.22.395.2006261218180.94870@zero.eik.bme.hu>
References: <cover.1592315226.git.balaton@eik.bme.hu>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 06:21:50
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Mark,

On Tue, 16 Jun 2020, BALATON Zoltan wrote:
> v5: Rebased on master, added some more clean ups, CUDA i2c is still to
> be sorted out, help with that is welcome.

What about these patches? At least those that are finished (up to patch 9) 
could be merged. I've seen you sent a pull request but not including any 
of these. Will this need another rebase after your patches? If I rebase 
them will you consider merging them? (Otherwise I won't spend time with 
it.)

Thanks,
BALATON Zoltan

> BALATON Zoltan (11):
>  mac_oldworld: Allow loading binary ROM image
>  mac_newworld: Allow loading binary ROM image
>  mac_oldworld: Drop a variable, use get_system_memory() directly
>  mac_oldworld: Drop some variables
>  grackle: Set revision in PCI config to match hardware
>  mac_oldworld: Rename ppc_heathrow_reset to ppc_heathrow_cpu_reset
>  mac_oldworld: Map macio to expected address at reset
>  mac_oldworld: Add machine ID register
>  macio: Add dummy screamer register area
>  WIP macio/cuda: Attempt to add i2c support
>  mac_oldworld: Add SPD data to cover RAM
>
> hw/misc/macio/cuda.c         |  62 ++++++++++++++++-
> hw/misc/macio/macio.c        |  34 ++++++++++
> hw/pci-host/grackle.c        |   2 +-
> hw/ppc/mac.h                 |  15 ++++-
> hw/ppc/mac_newworld.c        |  22 +++---
> hw/ppc/mac_oldworld.c        | 127 ++++++++++++++++++++++++++---------
> include/hw/misc/macio/cuda.h |   1 +
> 7 files changed, 219 insertions(+), 44 deletions(-)
>
>


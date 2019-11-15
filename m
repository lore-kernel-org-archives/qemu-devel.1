Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAD4C43141
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 12:26:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9929E2084B
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 12:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9929E2084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVafs-0004gU-Md
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 07:26:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iVaeq-0003gb-Vp
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:25:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iVaep-0007m8-UH
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:25:00 -0500
Received: from 16.mo7.mail-out.ovh.net ([46.105.72.216]:60628)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iVaep-0007lV-OE
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:24:59 -0500
Received: from player691.ha.ovh.net (unknown [10.108.42.168])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 23CAE13EB8E
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 13:24:56 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player691.ha.ovh.net (Postfix) with ESMTPSA id 1011EC3DEE1C;
 Fri, 15 Nov 2019 12:24:52 +0000 (UTC)
Subject: Re: [PATCH for-5.0 7/8] ppc/pnv: Link "chip" property to
 PnvCore::chip pointer
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <157381880498.136087.3775284829737989585.stgit@bahia.lan>
 <157381884403.136087.1106071650789146002.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <35f82bf2-3557-2d0c-5915-7f2b4b977fbe@kaod.org>
Date: Fri, 15 Nov 2019 13:24:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157381884403.136087.1106071650789146002.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 11031567287851191123
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudefhedggedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheiledurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.72.216
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> index 55eee95104da..fce6d8d9b31b 100644
> --- a/include/hw/ppc/pnv_core.h
> +++ b/include/hw/ppc/pnv_core.h
> @@ -36,11 +36,11 @@ typedef struct PnvChip PnvChip;
>  typedef struct PnvCore {
>      /*< private >*/
>      CPUCore parent_obj;
> +    PnvChip *chip;
>  
>      /*< public >*/
>      PowerPCCPU **threads;
>      uint32_t pir;
> -    PnvChip *chip;
>  
>      MemoryRegion xscom_regs;
>  } PnvCore;
> 


Why this change ? 

C.


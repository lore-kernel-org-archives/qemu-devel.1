Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF21DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 15:44:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8282C20679
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 15:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8282C20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgVZ1-0002Fi-Of
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 11:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jgVYV-0001pd-M3
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 11:43:51 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:51061)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jgVYS-0004h6-De
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 11:43:50 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 48685746335;
 Wed,  3 Jun 2020 17:43:45 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2623274632C; Wed,  3 Jun 2020 17:43:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2495D74594E;
 Wed,  3 Jun 2020 17:43:45 +0200 (CEST)
Date: Wed, 3 Jun 2020 17:43:45 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH] ati-vga: increment mm_index in ati_mm_read/write
In-Reply-To: <alpine.BSF.2.22.395.2006031727180.57649@zero.eik.bme.hu>
Message-ID: <alpine.BSF.2.22.395.2006031740220.57649@zero.eik.bme.hu>
References: <20200603124732.1137892-1-ppandit@redhat.com>
 <20200603134404.xdb2koul7fatv4ez@sirius.home.kraxel.org>
 <nycvar.YSQ.7.77.849.2006031952260.62159@xnncv>
 <alpine.BSF.2.22.395.2006031727180.57649@zero.eik.bme.hu>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 09:56:49
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Ren Ding <rding@gatech.edu>, Yi Ren <c4tren@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Hanqing Zhao <hanqing@gatech.edu>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jun 2020, BALATON Zoltan wrote:
> On Wed, 3 Jun 2020, P J P wrote:
>> +-- On Wed, 3 Jun 2020, Gerd Hoffmann wrote --+
>> | Hmm, why modify mm_index?  Shouldn't we just check it is non-zero
>> | before calling ati_mm_read/ati_mm_write?
>>
>>  if (s->regs.mm_index & BIT(31)) {
>>     ...
>>  } else {
>>     ati_mm_write(s, s->regs.mm_index + addr - MM_DATA, data, size);
>>  }
>> 
>> Exit condition for recursion is to set (mm_index & BIT(31)), so recursion
>> would continue even with non-zero values I think.
>
> MM_INDEX and MM_DATA allows access to registers (or memory if BIT(31) is set) 
> via only these two registers. This is called indexed access in docs. So it 
> does not really make sense to allow access to these registers as well thus we 
> can avoid infinite recursion. It's not meant to recurse until BIT(31) is set. 
> I think you can do:
>
>  if (s->regs.mm_index & BIT(31)) {
>     ...
> -  } else {
> +  } else if (s->regs.mm_index >= BIOS_0_SCRATCH) {

Actually this should be

+  } else if (s->regs.mm_index >= CLOCK_CNTL_INDEX) {

or even > MM_DATA + 3 may be best as that only refers to defines used in 
that case. So maybe

+  } else if (s->regs.mm_index > MM_DATA + 3) {

>     ati_mm_write(s, s->regs.mm_index + addr - MM_DATA, data, size);
>  }
>
> and do the same in ati_mm_read() as well.
>
> Regards,
> BALATON Zoltan
>


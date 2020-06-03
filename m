Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73358C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 13:57:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E361207D5
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 13:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E361207D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgTtp-0007CA-Ga
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 09:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jgTt9-0006Gp-Pe
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 09:57:03 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:56510)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jgTt7-0004PU-4n
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 09:57:02 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id A5F84746335;
 Wed,  3 Jun 2020 15:56:48 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8BC8074632B; Wed,  3 Jun 2020 15:56:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8A32C74594E;
 Wed,  3 Jun 2020 15:56:48 +0200 (CEST)
Date: Wed, 3 Jun 2020 15:56:48 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] ati-vga: increment mm_index in ati_mm_read/write
In-Reply-To: <20200603134404.xdb2koul7fatv4ez@sirius.home.kraxel.org>
Message-ID: <alpine.BSF.2.22.395.2006031554560.9760@zero.eik.bme.hu>
References: <20200603124732.1137892-1-ppandit@redhat.com>
 <20200603134404.xdb2koul7fatv4ez@sirius.home.kraxel.org>
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
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>, Yi Ren <c4tren@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>,
 Ren Ding <rding@gatech.edu>, Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jun 2020, Gerd Hoffmann wrote:
> On Wed, Jun 03, 2020 at 06:17:32PM +0530, P J P wrote:
>> From: Prasad J Pandit <pjp@fedoraproject.org>
>>
>> While accessing VGA registers via ati_mm_read/write routines,
>> a guest may set 's->regs.mm_index' such that it leads to infinite
>> recursion.
>
> Lovely.
>
>> Increment the mm_index value to avoid it.
>
> Hmm, why modify mm_index?  Shouldn't we just check it is non-zero
> before calling ati_mm_read/ati_mm_write?

I haven't found any mention in any docs that say MM_INDEX should auto 
increment so unless this is proven to do that on real hardware I also 
think forbiding indexed access to index registers should be enough.

Regards,
BALATON Zoltan


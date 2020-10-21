Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1307C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 09:19:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5E2B21D6C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 09:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E2B21D6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVAGy-0002zs-Qu
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 05:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kVAG8-0002UZ-1M; Wed, 21 Oct 2020 05:18:16 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:39750
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kVAG6-0000qK-26; Wed, 21 Oct 2020 05:18:15 -0400
Received: from host86-148-246-80.range86-148.btcentralplus.com
 ([86.148.246.80] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kVAG4-0005en-0x; Wed, 21 Oct 2020 10:18:16 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: armbru@redhat.com, david@gibson.dropbear.id.au, atar4qemu@gmail.com,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20200926140216.7368-1-mark.cave-ayland@ilande.co.uk>
Message-ID: <bc9324ba-678a-c160-0c04-140697fe3fae@ilande.co.uk>
Date: Wed, 21 Oct 2020 10:18:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200926140216.7368-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 86.148.246.80
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 0/6] QOM minor fixes
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/09/2020 15:02, Mark Cave-Ayland wrote:

> This series started off as a fix for the nd_table misuse in the sparc32-ledma
> device as pointed out by Markus, and then I remembered there was similar
> issue around the use of serial_hd() in macio. The last patch is one I've had
> sitting in a local branch for a while and is a mistake I made during the
> original sabre.c split which seems appropriate to include here.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> v2:
> - Rebase onto master
> - Add R-B tags from Philippe
> - Remove user_creatable=true from patch 5 as pointed out by Zoltan
> 
> 
> Mark Cave-Ayland (6):
>    sparc32-dma: use object_initialize_child() for espdma and ledma child
>      objects
>    sparc32-ledma: use object_initialize_child() for lance child object
>    sparc32-espdma: use object_initialize_child() for esp child object
>    sparc32-ledma: don't reference nd_table directly within the device
>    macio: don't reference serial_hd() directly within the device
>    sabre: don't call sysbus_mmio_map() in sabre_realize()
> 
>   hw/dma/sparc32_dma.c           | 49 +++++++++++++++++-----------------
>   hw/misc/macio/macio.c          |  4 ---
>   hw/pci-host/sabre.c            |  8 ------
>   hw/ppc/mac_newworld.c          |  6 +++++
>   hw/ppc/mac_oldworld.c          |  6 +++++
>   hw/sparc/sun4m.c               | 21 +++++++++------
>   hw/sparc64/sun4u.c             |  7 +++++
>   include/hw/sparc/sparc32_dma.h |  8 +++---
>   8 files changed, 60 insertions(+), 49 deletions(-)

I've applied this series (minus patch 5 the macio change which has been merged 
separately via my qemu-macppc branch) to my qemu-sparc branch.


ATB,

Mark.


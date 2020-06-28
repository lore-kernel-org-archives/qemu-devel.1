Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07647C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 15:05:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D140B206F1
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 15:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D140B206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpYs9-0006Mq-4N
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 11:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jpYrF-0005kI-RE; Sun, 28 Jun 2020 11:04:38 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:58559)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jpYr5-0002eV-UY; Sun, 28 Jun 2020 11:04:35 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id DDBDA74594E;
 Sun, 28 Jun 2020 17:04:23 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6275C745712; Sun, 28 Jun 2020 17:04:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5F62B7456F8;
 Sun, 28 Jun 2020 17:04:23 +0200 (CEST)
Date: Sun, 28 Jun 2020 17:04:23 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v5 09/11] macio: Add dummy screamer register area
In-Reply-To: <alpine.BSF.2.22.395.2006281633240.21756@zero.eik.bme.hu>
Message-ID: <alpine.BSF.2.22.395.2006281658310.21756@zero.eik.bme.hu>
References: <cover.1592315226.git.balaton@eik.bme.hu>
 <ecaaee4ba802b7a53de03e401c4d68e94de554f5.1592315226.git.balaton@eik.bme.hu>
 <3012998c-8345-f654-1de1-dd623ef375e8@ilande.co.uk>
 <alpine.BSF.2.22.395.2006281406340.95193@zero.eik.bme.hu>
 <alpine.BSF.2.22.395.2006281555030.21756@zero.eik.bme.hu>
 <alpine.BSF.2.22.395.2006281627240.21756@zero.eik.bme.hu>
 <alpine.BSF.2.22.395.2006281633240.21756@zero.eik.bme.hu>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 28 Jun 2020, BALATON Zoltan wrote:
> SCREAMER: ########### AUDIO WRITE! 0 / 11104 - 11104
> Unassigned mem write 00000000f3011190 = 0x9000000
> Unassigned mem write 00000000f3011190 = 0xb000000
> Unassigned mem write 00000000f3011190 = 0x9000000
> Unassigned mem write 00000000f3011190 = 0x9000000
> Unassigned mem write 00000000f3011190 = 0xb000000
> Unassigned mem write 00000000f3011190 = 0x9000000
> Unassigned mem write 00000000f3011190 = 0x1000000
> Unassigned mem write 00000000f3011190 = 0x3000000
> Unassigned mem write 00000000f3011190 = 0x1000000
> Unassigned mem write 00000000f3011190 = 0x1000000
> Unassigned mem write 00000000f3011190 = 0x3000000
> Unassigned mem write 00000000f3011190 = 0x1000000
> Unassigned mem write 00000000f3011190 = 0x1000000
> Unassigned mem write 00000000f3011190 = 0x3000000
> Unassigned mem write 00000000f3011190 = 0x1000000
> Unassigned mem write 00000000f3011190 = 0x9000000
> Unassigned mem write 00000000f3011190 = 0xb000000
> Unassigned mem write 00000000f3011190 = 0x9000000
> Unassigned mem write 00000000f3011190 = 0x9000000
> Unassigned mem write 00000000f3011190 = 0xb000000
> Unassigned mem write 00000000f3011190 = 0x9000000
> Unassigned mem write 00000000f3011190 = 0x1000000
> Unassigned mem write 00000000f3011190 = 0x3000000
> Unassigned mem write 00000000f3011190 = 0x1000000
> Unassigned mem write 00000000f3011190 = 0x1000000
> Unassigned mem write 00000000f3011190 = 0x3000000
> Unassigned mem write 00000000f3011190 = 0x1000000
> Unassigned mem write 00000000f3011190 = 0x3000000
> Unassigned mem read 00000000f3011190
> Unassigned mem write 00000000f3011190 = 0x1000000
> Unassigned mem write 00000000f3011190 = 0x3000000
> Unassigned mem read 00000000f3011190
> Unassigned mem write 00000000f3011190 = 0x1000000
> Unassigned mem write 00000000f3011190 = 0x3000000
> Unassigned mem read 00000000f3011190
> Unassigned mem write 00000000f3011190 = 0x1000000
> Unassigned mem write 00000000f3011190 = 0x3000000
> Unassigned mem read 00000000f3011190
> Unassigned mem write 00000000f3011190 = 0x1000000
> Unassigned mem write 00000000f3011190 = 0x3000000
> Unassigned mem read 00000000f3011190
> [bunch of more accesses to this address...]
> Unassigned mem read 00000000f3011170
> Unassigned mem read 00000000f3011170

According to 
https://github.com/dingusdev/dingusppc/blob/master/devices/macio.h this is 
probably the ethernet port, may want to map some unimplemented device 
there to log access, otherwise it probably OK ans could do without it for 
now.

> Unassigned mem read 000000000fefe7b0
> Unassigned mem write 000000000feffffc = 0x0
> Unassigned mem write 000000000feffff8 = 0x0

Still not sure about this one I'd expect it to write to frame buffer at 
this point but probably it's accessing wrong area due to something 
nonsense returned by some earlier read of some register and it did not 
seem to talk to PCI devices to set up the BARs earlier so either we're 
missing some register writes that are silently discarded in some 
partially emulated device or it expects things to be already set up some 
way at startup.

Regards,
BALATON Zoltan


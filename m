Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A532BC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 13:05:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 121CE2074A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 13:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 121CE2074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTltb-00077O-VG
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 09:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kTlsQ-0006gC-PY; Sat, 17 Oct 2020 09:04:02 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:58822
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kTlsN-0005bz-LF; Sat, 17 Oct 2020 09:04:02 -0400
Received: from host86-148-246-80.range86-148.btcentralplus.com
 ([86.148.246.80] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kTlsP-0004tU-6c; Sat, 17 Oct 2020 14:04:01 +0100
To: BALATON Zoltan <balaton@eik.bme.hu>
References: <20201013114922.2946-1-mark.cave-ayland@ilande.co.uk>
 <20201013114922.2946-3-mark.cave-ayland@ilande.co.uk>
 <c882279b-a561-2c3a-a6b5-b27446fddb02@amsat.org>
 <79df54b3-d9e5-145e-e277-24468b121ba0@ilande.co.uk>
 <91a24667-5f72-d3d9-8e47-6453268d2b78@eik.bme.hu>
 <4b25afd1-0ce5-0832-a3f0-1b58b3aa7b32@ilande.co.uk>
 <a5bf7f6-ace0-72e9-52df-e5b421b4e1c5@eik.bme.hu>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <7ef60d94-9065-7de4-c1b4-9172d46188e4@ilande.co.uk>
Date: Sat, 17 Oct 2020 14:03:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <a5bf7f6-ace0-72e9-52df-e5b421b4e1c5@eik.bme.hu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.148.246.80
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 2/3] grackle: use qdev gpios for PCI IRQs
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.247,
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/10/2020 01:26, BALATON Zoltan via wrote:

> As said in previous message the i2c and SPD patches are not quite ready yet so I've 
> omitted those from this series, I may rework them later once this part is merged and 
> can rebase the rest on top of that. We would also need your screamer patches to get 
> the Mac ROM working, what is still missing for those?

The 2 main reasons for not merging the screamer patches so far are:

1) Hangs in MacOS 9.0 and 9.1 on startup

Probably related to DBDMA interrupts, but I haven't had time to dig into this in much 
detail.

2) Reduced OS X emulation speed

When OS X detects the sound hardware it enables its internal sound engine which does 
2 things: firstly it constantly runs DBDMA requests which execute in the bottom-half 
even if no sound is being generated, so you end up reducing the raw emulation speed 
and secondly the OS X sound engine is floating point based so you end up running a 
lot more background floating point arithmetic in the OS.

I'm open to further ideas as to how this can be improved. The DBDMA overhead could be 
reduced by running DBDMA in the iothread if that is possible but that would be a fair 
bit of work.


ATB,

Mark.


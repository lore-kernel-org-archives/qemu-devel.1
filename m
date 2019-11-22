Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFAAC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 05:34:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D5FA20707
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 05:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D5FA20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY1aT-00081m-Ad
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 00:34:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54763)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1iY1Zr-0007Tp-NC
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 00:33:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1iY1Zq-0006N6-FQ
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 00:33:55 -0500
Received: from mail.ispras.ru ([83.149.199.45]:40578)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1iY1Zq-0006J8-7T
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 00:33:54 -0500
Received: from PASHAISP (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id B0FBF540082;
 Fri, 22 Nov 2019 08:33:30 +0300 (MSK)
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
To: "'Aleksandar Markovic'" <aleksandar.m.mail@gmail.com>,
 =?utf-8?Q?'Philippe_Mathieu-Daud=C3=A9'?= <philmd@redhat.com>
References: <20191029212430.20617-1-mrolnik@gmail.com>
 <20191029212430.20617-2-mrolnik@gmail.com>
 <750745b9-e51c-3757-3eb6-ffce51042d9c@redhat.com>
 <CAL1e-=gHukqViBf8hXMnCJDPB36yzanrWPF6cz26W3ebwXGkLA@mail.gmail.com>
In-Reply-To: <CAL1e-=gHukqViBf8hXMnCJDPB36yzanrWPF6cz26W3ebwXGkLA@mail.gmail.com>
Subject: RE: [PATCH v35 01/13] target/avr: Add outward facing interfaces and
 core CPU logic
Date: Fri, 22 Nov 2019 08:33:32 +0300
Message-ID: <000701d5a0f6$60e1fe00$22a5fa00$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: ru
Thread-Index: AdWgrhqzuyvHIM7oSim5Yn4Ms6PKmwASAoAQ
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 83.149.199.45
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
Cc: 'Thomas Huth' <thuth@redhat.com>, 'Sarah Harris' <S.E.Harris@kent.ac.uk>,
 'Joaquin de Andres' <me@xcancerberox.com.ar>,
 'Richard Henderson' <richard.henderson@linaro.org>,
 'QEMU Developers' <qemu-devel@nongnu.org>,
 'Michael Rolnik' <mrolnik@gmail.com>, 'Igor Mammedov' <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Aleksandar Markovic [mailto:aleksandar.m.mail@gmail.com]
> > Why not implement the dump_ASM code? This is very useful...
> >
> 
> ... and time-consuming to implement, unless Michael have some
> ready off-shelf code.

We already did this by taking the disassembly code from binutils:
https://github.com/Dovgalyuk/qemu/blob/avr8/disas/avr.c

But I'm not sure about license compatibility.

> It is great that you have lots of ideas, Philippe, however I think
> that it is counterproductive to suggest Michael to work on this
> at this moment. Disassembler is just a debugging tool,
> non-essential to core functionality, and Michael should remain
> focused on completing core bits and pieces of AVR emulation.
> 
> My 2 cents,
> Aleksandar
> 
> > Richard what is your position on this? I'd rather enforce this as a
> > requirement for each ports.

Pavel Dovgalyuk



Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1569C282DA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 15:43:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F94B222C7
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 15:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="JxAFjXok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F94B222C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58073 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHVfR-000239-LQ
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 11:43:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hHVeQ-0001TT-3P
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 11:42:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hHVeP-0002KG-5r
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 11:42:06 -0400
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144]:52399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hHVeP-0002Jx-1B
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 11:42:05 -0400
Received: by mail-it1-x144.google.com with SMTP id x132so8796769itf.2
	for <qemu-devel@nongnu.org>; Fri, 19 Apr 2019 08:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=rXRhStdQCc3dQU4S4qg2Ze2crnUdsX7Qa2mruJ/qLHY=;
	b=JxAFjXokAg1r75PA0j1k346zQWF6+3JJgwj4wqDXY1Mx8osZZEPTj0TPXkU/82BkjW
	rLUkIHFP7CNEHcIjVadH6CNL5jsq3/Z1onEbnF5/FfX1R4u6isMzF6R4FIncn4QCWMJq
	aIfcZL7T4Hfduf2DVfX1lAdOHVchPt40Gr5jKdcY/af2uNVsckGdc7LMAQgZ8urAGLrP
	1r9+H2PEzLVi8Ch5iJ1b1Fz+U0lLnGmM6St4zxin3SwkeGZKgIHYVA7NqD9S6iTI/yDc
	715HW7gLFsjmITa9CnWkTJnI/pAEHiicrSjoFnmqX1KvivvNjEgNNSSj4pQoj/aNtz2d
	/vOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=rXRhStdQCc3dQU4S4qg2Ze2crnUdsX7Qa2mruJ/qLHY=;
	b=id9IS4uoWC1YRKtTSV3uZXA3GbF59mT3e3gi/O4syyOVhOQWXj1ctx/iGjwbtRleEm
	uRSmqvvSRenOLhAkAHYIz5wiB/K8n1tQv7V6vIWJX6AaHQl8yB1056qT3hhX4E7+fuGc
	/Crc2MSxZpGSdIv3MJYYmncJTYeJMCIzojqQKhP+OQaLvQjnlrjaefMKp/Sj4q8Nmam7
	JMlSe+yj5yud9HqZ6ZK2rn32K0iTOQs/YamTGFTdL42pnIAs91EUWBlhPT7xEXhgaxS/
	rM+n5dwxBbEfUGpbWk+maJ4ZW/Gt7PJ71Aqbb0r8Zi1fsY9raXHEi7t346vLCQqw10CM
	IcnA==
X-Gm-Message-State: APjAAAXv/lC0Ws6a8z7AUU3+t2tCQf1s94PpmEBEF1A0PH20uvVM4cH1
	EJWABsyWI2K74+2bG2R7h/KeVw==
X-Google-Smtp-Source: APXvYqxi/hZCPGgSPaVvRYY4y8KHYZHHd5RsNTkPYEYg8nRTJsKiuWnZ9dmS3Ki8QOjxHXjFJE8pQA==
X-Received: by 2002:a24:e14b:: with SMTP id n72mr3183599ith.34.1555688524303; 
	Fri, 19 Apr 2019 08:42:04 -0700 (PDT)
Received: from ip-70-93.wireless.oberlin.edu (ip-70-93.wireless.oberlin.edu.
	[132.162.70.93]) by smtp.gmail.com with ESMTPSA id
	v126sm2429234itb.30.2019.04.19.08.42.03
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 19 Apr 2019 08:42:03 -0700 (PDT)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
In-Reply-To: <aaa450c5-0446-b4b3-40ac-ef87b5522545@redhat.com>
Date: Fri, 19 Apr 2019 11:42:02 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <05AF5CE1-3A71-4D78-B35B-C443BE310985@oberlin.edu>
References: <20190417005053.885-1-stephen.checkoway@oberlin.edu>
	<aaa450c5-0446-b4b3-40ac-ef87b5522545@redhat.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::144
Subject: Re: [Qemu-devel] [PATCH v2] hw/char/escc: Lower irq when transmit
 buffer is filled
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Laurent Vivier <laurent@vivier.eu>,
	=?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190419154202.k1rTvO8u-0ri5eouz_jjNL4LOKMXRO-5OcLof-lXfBg@z>



> On Apr 18, 2019, at 08:13, Philippe Mathieu-Daud=C3=A9 =
<philmd@redhat.com> wrote:
>=20
> On 4/17/19 2:50 AM, Stephen Checkoway wrote:
>> The SCC/ESCC will briefly stop asserting an interrupt when the
>> transmit FIFO is filled.
>>=20
>> This code doesn't model the transmit FIFO/shift register so the
>> pending transmit interrupt is never deasserted which means that an
>> edge-triggered interrupt controller will never see the low-to-high
>> transition it needs to raise another interrupt. The practical
>> consequence of this is that guest firmware with an interrupt service
>> routine for the ESCC that does not send all of the data it has
>> immediately will stop sending data if the following sequence of
>> events occurs:
>> 1. Disable processor interrupts
>> 2. Write a character to the ESCC
>> 3. Add additional characters to a buffer which is drained by the ISR
>> 4. Enable processor interrupts
>>=20
>> In this case, the first character will be sent, the interrupt will
>> fire and the ISR will output the second character. Since the pending
>> transmit interrupt remains asserted, no additional interrupts will
>> ever fire.
>=20
> You might want to add a line expliciting the chipset model which =
forced
> you to do that patch (Z85C30).

Done.

Thanks for looking at this.

--=20
Stephen Checkoway







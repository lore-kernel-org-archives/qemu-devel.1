Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB130C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 20:47:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55BF0206BE
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 20:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="DP1TRmgd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55BF0206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=walle.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsuUV-0002gC-7V
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 16:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@walle.cc>) id 1jsu7T-0003vF-SL
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 16:23:11 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:38893)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@walle.cc>) id 1jsu7P-00057G-22
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 16:23:11 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ssl.serverraum.org (Postfix) with ESMTPSA id AC4C323068;
 Tue,  7 Jul 2020 22:22:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2016061301; t=1594153379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tzjoJ2PIvRUP1j04WyWX2d7qzs5MUPGHOVmmpDLQVo0=;
 b=DP1TRmgdNCISSXyl/cQPKrAm7sMHUeFJyR06rkLg+PUef9gkcjypurckKPYE8pWh6bcVjI
 1GiAcTKF4pkMXalqH74Xos5B0068GDrUduLcpQnx4vLUesUsAcaD9t8BjRkaqO+STf74vd
 a4vgbgineFA2UA03R0mKeZJ1FA7EVcg=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Tue, 07 Jul 2020 22:22:59 +0200
From: Michael Walle <michael@walle.cc>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/4] hw/lm32/milkymist: Comment to remember some IRQs
 lines are left unwired
In-Reply-To: <CAFEAcA-oXwam0QmJaPnUnFLWsv62tKOcoCbqqj5W+Bn=yybLzg@mail.gmail.com>
References: <20200705211016.15241-1-f4bug@amsat.org>
 <20200705211016.15241-3-f4bug@amsat.org>
 <CAFEAcA-oXwam0QmJaPnUnFLWsv62tKOcoCbqqj5W+Bn=yybLzg@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.6
Message-ID: <57b75c41a564361350b4c871775d086e@walle.cc>
X-Sender: michael@walle.cc
Received-SPF: pass client-ip=176.9.125.105; envelope-from=michael@walle.cc;
 helo=ssl.serverraum.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 16:23:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 07 Jul 2020 16:43:45 -0400
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
Cc: Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 2020-07-07 18:30, schrieb Peter Maydell:
> On Sun, 5 Jul 2020 at 22:10, Philippe Mathieu-Daudé <f4bug@amsat.org> 
> wrote:
>> 
>> The 'card is readonly' and 'card inserted' IRQs are not wired.
>> Add a comment in case someone know where to wire them.
>> 
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/lm32/milkymist.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
>> index 469e3c4322..117973c967 100644
>> --- a/hw/lm32/milkymist.c
>> +++ b/hw/lm32/milkymist.c
>> @@ -87,6 +87,7 @@ static DeviceState *milkymist_memcard_create(hwaddr 
>> base)
>>      dev = qdev_new("milkymist-memcard");
>>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
>> +    /* FIXME wire 'card is readonly' and 'card inserted' IRQs? */
> 
> It's possible that these lines are correctly not wired up
> (ie that the hardware does not provide any kind of indication
> of the r/o or insertion events). The milkymist mmc device is a
> very simple one. AIUI the RTL for the board is on github if
> anybody wants to go check.

That is correct, there are not indications nor are there any
interrupts.

-michael


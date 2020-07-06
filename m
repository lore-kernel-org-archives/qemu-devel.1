Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A2EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:37:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D453206CD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="PpMqwGfn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D453206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsU7f-0005X4-CS
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 12:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.de>) id 1jsU6T-0003lt-MG
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:36:25 -0400
Received: from mout01.posteo.de ([185.67.36.65]:60246)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.de>) id 1jsU6R-00024f-Cw
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:36:25 -0400
Received: from submission (posteo.de [89.146.220.130]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 9896216005F
 for <qemu-devel@nongnu.org>; Mon,  6 Jul 2020 18:36:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
 t=1594053379; bh=s7Rg5HQ8oSF9KLtnOC2CgU2rXrXgIf3IGIs3WnXIoyw=;
 h=Subject:To:Cc:From:Date:From;
 b=PpMqwGfnS2xpBbgXKNo/gWHIahem5lSbxsKOjXq4zw2/AE/Q6ogsXYhS/c/W0+b9t
 j3R3wys55dGLiX6UHUGBaz8ciu2X9t+/Qno5XvSlqHkTmM7qN6ZnR9Vi99tE052/jo
 WeqrbDCckP/1D4mQfik0w/ml2GnZP8vTsmt2oU+AiKM246onlSYbjyM/wpg6MrYfSm
 4hDOMzeXsylOQJAaXeAN1R8MYbSl0fAuwhLiL56YHFfoANtB3T38l7CYyhdeAzP4ws
 Z3aZ93oxhAECRvDatqNfOzUewzY9PWwvZmQPFLHRwlQNTsmDUuLLiEJ5S8XwidFjSb
 Q+6rrExkeQlIg==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4B0rmb52hzz6tmG;
 Mon,  6 Jul 2020 18:36:15 +0200 (CEST)
Subject: Re: [PATCH rc6 22/30] target/avr: Register AVR support with the rest
 of QEMU
To: Eric Blake <eblake@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 qemu-devel@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
References: <20200705140315.260514-1-huth@tuxfamily.org>
 <20200705140315.260514-23-huth@tuxfamily.org>
 <257c315e-687f-0c29-9f6a-eeb0702e64a1@redhat.com>
From: Thomas Huth <th.huth@posteo.de>
Message-ID: <8b9c8b19-b162-ed79-f795-e7d702b7f860@posteo.de>
Date: Mon, 6 Jul 2020 18:36:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <257c315e-687f-0c29-9f6a-eeb0702e64a1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.65; envelope-from=th.huth@posteo.de;
 helo=mout01.posteo.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 12:36:20
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/07/2020 16.56, Eric Blake wrote:
> On 7/5/20 9:03 AM, Thomas Huth wrote:
>> From: Michael Rolnik <mrolnik@gmail.com>
>>
>> Add AVR related definitions into QEMU.
>>
>> [AM: Remove word 'Atmel' from filenames and all elements of code]
>> Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>> Signed-off-by: Thomas Huth <huth@tuxfamily.org>
>> ---
> 
>> +++ b/qapi/machine.json
>> @@ -25,7 +25,7 @@
>>   # Since: 3.0
>>   ##
> 
> Missing a line that resembles:
> 
> # @avr since 5.1

I thought that we stopped doing that ... but apparently, my memory was
wrong and this was only about the "dropped" statements (see commit id
bb5ccf225e81d2).

Ok, I can add that again (though it's somewhat strange that we removed
the "dropped" statements but still keep the "since" statements...?)

 Thomas


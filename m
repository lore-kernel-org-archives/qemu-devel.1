Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111DBCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:24:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D815420684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D815420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNhmK-0005QJ-Fq
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 14:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNhKR-0003ou-54
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:55:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNhKO-0008GH-JQ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:55:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53562)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNhKN-0008FK-PR
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:55:16 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 90C8E4E919
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 17:55:14 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id a15so13327678wrr.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 10:55:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6v+fctnKVl/6fYka3XIVf9fH1YaHhqzuYR56MyK9A60=;
 b=VbqaBTluSizzxDR6/MGZiDgXMi3qJ2/FO+HvH2qDNEdPrCXo5s3lC2CXLWGpLjNGIW
 NmwC/aHC2QNyi9Pux2QJUhjNgt9HMn46s7Aw2/2crJS9zPDojFcUqkYUNZMxgkXeSqqE
 khPg+QfwKz8NewemDElOfvI6F5I6iMtKBaNy4f9D6+kAKjxKxLTPdKp/TWytWHAOwtPr
 pppT7vNlOEabqWr2GtGubht3Pq8Y47W05HTBABCtSTxpESebn0Sl9LmmvctD1HxdeLCB
 omwfqVI0AX+foTeS9XOcNpAC03vKt7TMaTMAVhBLOf5VQVXdeMKqvNTGld459UKaNxRt
 3Qug==
X-Gm-Message-State: APjAAAWKGz3ab8nBD+GkW5CFSaVjbHUeWW1mHgJI3aVMjI442r9cSlVL
 T9yz1APtygAHsmQyatZyWgbKESzxWWgjCITm1/s5oM1fK5nLqpRuWXVBdbbItwx3HLzGSDTtICe
 mUe4N+txMpaU7o7A=
X-Received: by 2002:adf:8481:: with SMTP id 1mr5363898wrg.189.1571939713299;
 Thu, 24 Oct 2019 10:55:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyDJCsx9Qw7zYvfGHFEcryNWgFO6HIFZ5JybJTxQFAMpUNVQYdTFqK3xVFCKCJaBYCPY3voAA==
X-Received: by 2002:adf:8481:: with SMTP id 1mr5363848wrg.189.1571939712934;
 Thu, 24 Oct 2019 10:55:12 -0700 (PDT)
Received: from [192.168.1.115] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id s13sm2892518wmc.28.2019.10.24.10.55.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2019 10:55:12 -0700 (PDT)
Subject: Re: [PATCH v2 00/14] hw: Split RTC devices from hw/timer/ to hw/rtc/
To: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20191003230404.19384-1-philmd@redhat.com>
 <CAFEAcA-rmPuKQyv8d-u-1UAMhy6yGAcF3csVDcvYVXMosZysYw@mail.gmail.com>
 <839e9cb5-6fc2-a2b2-df12-abf9dbf6dcdd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <04b0db79-dfb3-9f28-b649-459214728556@redhat.com>
Date: Thu, 24 Oct 2019 19:55:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <839e9cb5-6fc2-a2b2-df12-abf9dbf6dcdd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goat?= =?UTF-8?Q?er?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Andrew Jeffery <andrew@aj.id.au>, QEMU Trivial <qemu-trivial@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/24/19 7:36 PM, Laurent Vivier wrote:
> On 24/10/2019 17:51, Peter Maydell wrote:
>> On Fri, 4 Oct 2019 at 00:04, Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com> wrote:
>>>
>>> Since v1: https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg03=
334.html
>>> - addressed review comments (described in patches 3 and 4)
>>> - added R-b/A-b tags
>>>
>>> Whole series now reviewed.
>>
>> for the arm parts:
>> Acked-by: Peter Maydell <peter.maydell@linaro.org>
>>
>=20
> I'm going to queue this series in qemu-trivial queue, so I guess your
> Acked-by is for patches 2, 10 and 11?

ARM: 2, 7-11, 13-14:

   hw: Move PL031 device from hw/timer/ to hw/rtc/ subdirectory
   hw: Move TWL92230 device from hw/timer/ to hw/rtc/ subdirectory
   hw: Move DS1338 device from hw/timer/ to hw/rtc/ subdirectory
   hw: Move Xilinx ZynqMP RTC from hw/timer/ to hw/rtc/ subdirectory
   hw: Move Exynos4210 RTC from hw/timer/ to hw/rtc/ subdirectory
   hw: Move Aspeed RTC from hw/timer/ to hw/rtc/ subdirectory
   hw/rtc/xlnx-zynqmp-rtc: Remove unused "ptimer.h" include
   hw/rtc/aspeed_rtc: Remove unused includes

PPC: 3-5

   hw: Move MC146818 device from hw/timer/ to hw/rtc/ subdirectory
   hw: Move M48T59 device from hw/timer/ to hw/rtc/ subdirectory
   hw: Move M41T80 device from hw/timer/ to hw/rtc/ subdirectory

SPARC: 6

   hw: Move sun4v hypervisor RTC from hw/timer/ to hw/rtc/ subdirectory


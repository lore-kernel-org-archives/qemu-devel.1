Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8039BC48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 21:09:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D3B32085A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 21:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3B32085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgFAv-00035l-LX
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 17:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47847)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hgF89-0001Ol-TT
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 17:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hgF86-0007uN-Tk
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 17:07:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33144)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hgF85-0007cI-A4
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 17:06:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so4380185wru.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 14:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GVSjoyqSgLXUC/6vX9U1sObPbGwez2+uAdBBOepJzH0=;
 b=kY4TIqQvBxN24/jWkop14ieUDnQnAiz3SyUP0Pthw9X63OBNNp7Sin/jKoii8YkmTy
 vtf57jUGQKmPUC/N/drg0H+Y1IwOiAtexsaiFe1L1Y8WmFFb1wLr/AHchiTcaeBBR2i3
 LRDtRnLGin1O7M2TTVqIzr3IH+sDBjENFJrFul61t+XFP7WKyf7dpvm6qj2xah9TgioF
 Sg+L0PRka26pdTTlGXtLgx/YIPE8LCwTdrGtZ/TaIywa5HUeb8Wbyl0jh90AN20IEWrD
 oNwiYrgQyU1VA+bHtk0G0C83oQcEBFrFqgqu3JysXcv4T/30iGqpAVhobeu0i2Cu6adj
 qaMw==
X-Gm-Message-State: APjAAAU5MUL9StsBXzwj4EIQjH16sGhz5G4gclsrRMYmcOMimdhJL7Tl
 Sgp1yNqcwRGXNhMJIszImrD/NQ==
X-Google-Smtp-Source: APXvYqyNt/8Z+gMZPgIPj3IR+Yy5GKZPz4YUchO3R4hDKPLAL0IHQG0vhmowxraTf588ho0izFNVjw==
X-Received: by 2002:adf:f84f:: with SMTP id d15mr5031902wrq.53.1561583191095; 
 Wed, 26 Jun 2019 14:06:31 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id f12sm51855wrg.5.2019.06.26.14.06.29
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jun 2019 14:06:30 -0700 (PDT)
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Stephen Checkoway <stephen.checkoway@oberlin.edu>
References: <20190505221544.31568-1-philmd@redhat.com>
 <10a0c45b-f58f-cb04-0404-0f5c2f3c4568@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7c05edec-b323-c91f-ab7f-bd2189337726@redhat.com>
Date: Wed, 26 Jun 2019 23:06:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <10a0c45b-f58f-cb04-0404-0f5c2f3c4568@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 00/13] hw/block/pflash_cfi02:
 Clean-up and fixes
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi John,

On 6/26/19 10:33 PM, John Snow wrote:
> I don't think this series ever made it upstream, and it's now well past
> 30 days, so I might encourage a resend when you can if this is still
> important to pursue.

I should have sent a 'ping' indeed.
I keep rebasing because I have it in my pflash-next queue, and I added
more patches from Stephen. I am still running tests, and it is a pain to
test things that have never been tested.
Anyway, my plan is to send a "current status of pflash-next" series.

Thanks for worrying :)

Phil.

> --js
> 
> On 5/5/19 6:15 PM, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> While reviewing Stephen Checkoway's v4 "Implement missing AMD
>> pflash functionality" [*] I found it hard (for me) to digest,
>> so I took step by step notes. This series is the result of
>> those notes.
>> Regarding Stephen's series, this series only contains the
>> generic code movement and trivial cleanup. The other patches
>> are rather dense and I need more time to study the specs.
>>
>> Stephen: If you take out the patch #2 ("Use the GLib API"),
>> you can rebase your series on top of this.
>> I'd appreciate if you can adapt your tests to use the GLib
>> functions, else I plan to do it later.

PD: Oh, Stephen, if you read it, forget about this comment!


>> [*] https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg04595.html
>>
>> Philippe Mathieu-Daudé (10):
>>   tests/pflash-cfi02: Use the GLib API
>>   tests/pflash-cfi02: Use IEC binary prefixes for size constants
>>   hw/block/pflash_cfi02: Fix debug format string
>>   hw/block/pflash_cfi02: Add an enum to define the write cycles
>>   hw/block/pflash_cfi02: Add helpers to manipulate the status bits
>>   hw/block/pflash_cfi02: Simplify a statement using fall through
>>   hw/block/pflash_cfi02: Use the ldst API in pflash_write()
>>   hw/block/pflash_cfi02: Use the ldst API in pflash_read()
>>   hw/block/pflash_cfi02: Extract the pflash_data_read() function
>>   hw/block/pflash_cfi02: Unify the MemoryRegionOps
>>
>> Stephen Checkoway (3):
>>   tests/pflash-cfi02: Add test for supported CFI commands
>>   hw/block/pflash_cfi02: Fix command address comparison
>>   hw/block/pflash_cfi02: Use the chip erase time specified in the CFI
>>     table
>>
>>  hw/block/pflash_cfi02.c   | 234 +++++++++++++++++---------------------
>>  tests/Makefile.include    |   2 +
>>  tests/pflash-cfi02-test.c | 232 +++++++++++++++++++++++++++++++++++++
>>  3 files changed, 339 insertions(+), 129 deletions(-)
>>  create mode 100644 tests/pflash-cfi02-test.c
>>


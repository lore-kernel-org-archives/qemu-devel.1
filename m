Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD188C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 16:50:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86E6B20989
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 16:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E6B20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiLzK-0000ds-JH
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 12:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41948)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hiL87-0003wg-Ij
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:55:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hiL85-00044x-0H
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:55:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38189)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hiL80-0003vP-R7
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:55:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id p11so7240009wro.5
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 08:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SEBw9BeVdtoobf5EiaV/9mIfZ46latCf3fEv7KSGJEk=;
 b=AYwxM2a2VhSJP1wMkezN3sep5jrpVN8dC298K9HF8fZ2nzEUOp3aa0c0JbA14OjJQQ
 1Ckp/s7Iex6WURjLYF909v0uVByLcpRz0Ewa7zHG8kxNrqKeTgbBJkVEykhB6DmItxWZ
 mdZxEcMBHLZAc4zLejEJw7jB16ERXDAhacLTSvvW7XmbFrDP+U0LPxWx/BmrW1/hnJWE
 G4zejZxU0vC0UDOyAuz64yp4qA+OGOkKbws45p9UwKkGkZbfSI8Eur+4vJaK5CZIocll
 YjyRQHKQuPd7FfX1DEA+mKvCBnsqmKn1RzneWN0dgxxCgIvwAzZ6X1iHe3HAYRE32f3M
 fYGg==
X-Gm-Message-State: APjAAAVOO+Mc8FCSF6rey3b/IyMuyXRivmac1XOJTP0OCahwdgQ5TZk6
 ofg4oVwpJ5Fs1j5AusKl1QEH+w==
X-Google-Smtp-Source: APXvYqw83TU/NGdcH4U34RRwIIvF2Nkw1gX+EMj+J1BLomRfji/Y5bhYQAoVD7GoOzOgd3XfFrNlWQ==
X-Received: by 2002:adf:eecf:: with SMTP id a15mr1250454wrp.264.1562082916428; 
 Tue, 02 Jul 2019 08:55:16 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id d9sm18395107wrb.71.2019.07.02.08.55.15
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Jul 2019 08:55:15 -0700 (PDT)
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>
References: <20190628120118.78920-1-mrolnik@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7213c712-5405-5fa8-bb2b-858f4d48ac54@redhat.com>
Date: Tue, 2 Jul 2019 17:55:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190628120118.78920-1-mrolnik@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v24 0/7] QEMU AVR 8 bit cores
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
Cc: imammedo@redhat.com, Thomas Huth <thuth@redhat.com>,
 richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Michael,

On 6/28/19 2:01 PM, Michael Rolnik wrote:
> This series of patches adds 8bit AVR cores to QEMU.
> All instruction, except BREAK/DES/SPM/SPMX, are implemented. Not fully tested yet.
> However I was able to execute simple code with functions. e.g fibonacci calculation.
> This series of patches include a non real, sample board.
> No fuses support yet. PC is set to 0 at reset.

I see in this thread you test some binary:
https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg02291.html

https://github.com/seharris/qemu-avr-tests/blob/master/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf

Can you add a test that uses your binary and check it does something?
That would help maintaining your work over time.

Avocado tests can be quite simple, i.e.:
https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg06515.html

Since you added support for the USART, you can also add some
assembler instructions to use it to this test:

https://git.qemu.org/?p=qemu.git;a=blob;f=tests/boot-serial-test.c;h=24852d4c7d0b3fc08fb0dab35f32372a0b2c46db;hb=HEAD

Thanks!

Phil.


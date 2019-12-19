Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89C3C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:34:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD47920716
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD47920716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43673 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihxpI-00051Y-PY
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 10:34:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <a13xp0p0v88@gmail.com>) id 1ihxns-0003bv-A4
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:33:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <a13xp0p0v88@gmail.com>) id 1ihxnq-0007pK-NZ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:33:28 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38325)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <a13xp0p0v88@gmail.com>)
 id 1ihxnm-0007RR-VE; Thu, 19 Dec 2019 10:33:23 -0500
Received: by mail-lj1-f193.google.com with SMTP id k8so6704964ljh.5;
 Thu, 19 Dec 2019 07:33:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ppuO1JL85G+HzuHduNnlGec+XG0sV8etIhIJ+8329dM=;
 b=iL7Pl1F0qLAJO19IyGqguLIntMfJkJb2vHDS7XSBAPVPqQ6jLuifLnoOEQ+B96Zoco
 rCEmowwDHlKujAWTzTXsb2Um6JvKCAQM69IEqldwTWIikahe2xT3aldEP6iLinJo8Kgn
 PIzkgWf/VTEhysPn3Y5OY8kQUSZ6Wzd7OadvonXOojYOh2S7zNc8jm2JDi0Laq4y44uR
 Bx14HDmVSPNYGuAFmQtz0zZpHT6HijqxRCXCUa4TVN8gInsO1M93xrOcTabcFPhAFARE
 tZQVJVVIEPj+t2OfzAtiPApxpQeT0QVlqNUr6HOr2EROTUhGnwElL54q4rYRQRhl/bz0
 HKOQ==
X-Gm-Message-State: APjAAAWGtZeBBSEBD+gbfYxDW+uluao0bPrae4Dx1U1qLXj6OMn+n0yN
 lXb9/cA3My+m4EldR63H64c=
X-Google-Smtp-Source: APXvYqxOxYAoCMHym05zVrxtjMWhAaXQMe9x0JVNmByOlNuUyXWKssTdOCC7x4f5BvSIcwQYbSD8NA==
X-Received: by 2002:a05:651c:112d:: with SMTP id
 e13mr5704007ljo.99.1576769601364; 
 Thu, 19 Dec 2019 07:33:21 -0800 (PST)
Received: from [192.168.42.234] ([213.87.152.106])
 by smtp.gmail.com with ESMTPSA id t2sm2963617ljj.11.2019.12.19.07.33.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2019 07:33:20 -0800 (PST)
Subject: Re: [PATCH v2 1/2] tests/ide-test: Create a single unit-test covering
 more PRDT cases
To: Kevin Wolf <kwolf@redhat.com>
References: <20191216181405.462292-1-alex.popov@linux.com>
 <20191219151203.GM5230@linux.fritz.box>
From: Alexander Popov <alex.popov@linux.com>
Autocrypt: addr=alex.popov@linux.com; prefer-encrypt=mutual; keydata=
 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
 j3lCqPk=
Message-ID: <dd64e9c8-c720-6569-c629-3d0c58ee7b43@linux.com>
Date: Thu, 19 Dec 2019 18:33:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191219151203.GM5230@linux.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.193
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
Reply-To: alex.popov@linux.com
Cc: Andrea Arcangeli <aarcange@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, sstabellini@kernel.org,
 pmatouse@redhat.com, mdroth@linux.vnet.ibm.com, qemu-block@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Kashyap Chamarthy <kashyap.cv@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, pjp@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Kevin,

Thanks for your review!

On 19.12.2019 18:12, Kevin Wolf wrote:
> Am 16.12.2019 um 19:14 hat Alexander Popov geschrieben:
>> Fuzzing the Linux kernel with syzkaller allowed to find how to crash qemu
>> using a special SCSI_IOCTL_SEND_COMMAND. It hits the assertion in
>> ide_dma_cb() introduced in the commit a718978ed58a in July 2015.
>> Currently this bug is not reproduced by the unit tests.
>>
>> Let's improve the ide-test to cover more PRDT cases including one
>> that causes this particular qemu crash.
>>
>> The test is developed according to the Programming Interface for
>> Bus Master IDE Controller (Revision 1.0 5/16/94).
>>
>> Signed-off-by: Alexander Popov <alex.popov@linux.com>
> 
> Looks mostly good to me, but I have a few comments.
> 
> First of all, the patch order needs to be reversed to keep the tree
> bisectable (first fix the bug, then test that it's fixed).

Ok, I'll do that.

>> +/*
>> + * This test is developed according to the Programming Interface for
>> + * Bus Master IDE Controller (Revision 1.0 5/16/94)
>> + */
>> +static void test_bmdma_various_prdts(void)
>>  {
>> -    QTestState *qts;
>> -    QPCIDevice *dev;
>> -    QPCIBar bmdma_bar, ide_bar;
>> -    uint8_t status;
>> -
>> -    PrdtEntry prdt[] = {
>> -        {
>> -            .addr = 0,
>> -            .size = cpu_to_le32(0x1000 | PRDT_EOT),
>> -        },
>> -    };
>> -
>> -    qts = test_bmdma_setup();
>> -
>> -    dev = get_pci_device(qts, &bmdma_bar, &ide_bar);
>> -
>> -    /* Normal request */
>> -    status = send_dma_request(qts, CMD_READ_DMA, 0, 1,
>> -                              prdt, ARRAY_SIZE(prdt), NULL);
>> -    g_assert_cmphex(status, ==, BM_STS_ACTIVE | BM_STS_INTR);
>> -    assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
>> +    uint32_t size = 0;
>> +    uint32_t prd_size = 0;
>> +    int req_sectors = 0;
>> +    uint32_t req_size = 0;
>> +    uint8_t s1 = 0, s2 = 0;
>> +
>> +    for (size = 0; size < 65536; size += 256) {
> 
> We're testing 64 * 4 = 256 cases here, each of them starting a new qemu
> process. Do we actually test anything new after the first couple of
> requests or does this just make the test slower than it needs to be?
> 
> This test case really takes a long time for me (minutes), whereas all
> other cases in ide-test combined run in like a second.
> 
> I would either test much less different sizes or at least run them in
> the same qemu process. Or both, of course.

Yes, it takes 3 minutes to run this test on my laptop.

Thanks for the idea. I'll try to run all the requests in a single qemu process.

>> +        /*
>> +         * Two bytes specify the count of the region in bytes.
>> +         * The bit 0 is always set to 0.
>> +         * A value of zero in these two bytes indicates 64K.
>> +         */
>> +        prd_size = size & 0xfffe;
>> +        if (prd_size == 0) {
>> +            prd_size = 65536;
>> +        }
>>  
>> -    /* Abort the request before it completes */
>> -    status = send_dma_request(qts, CMD_READ_DMA | CMDF_ABORT, 0, 1,
>> -                              prdt, ARRAY_SIZE(prdt), NULL);
>> -    g_assert_cmphex(status, ==, BM_STS_INTR);
>> -    assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
>> -    free_pci_device(dev);
>> -    test_bmdma_teardown(qts);
>> +        for (req_sectors = 1; req_sectors <= 256; req_sectors *= 2) {
>> +            req_size = req_sectors * 512;
>> +
>> +            /*
>> +             * 1. If PRDs specified a smaller size than the IDE transfer
>> +             * size, then the Interrupt and Active bits in the Controller
>> +             * status register are not set (Error Condition).
>> +             *
>> +             * 2. If the size of the physical memory regions was equal to
>> +             * the IDE device transfer size, the Interrupt bit in the
>> +             * Controller status register is set to 1, Active bit is set to 0.
>> +             *
>> +             * 3. If PRDs specified a larger size than the IDE transfer size,
>> +             * the Interrupt and Active bits in the Controller status register
>> +             * are both set to 1.
>> +             */
>> +            if (prd_size < req_size) {
>> +                s1 = 0;
>> +                s2 = 0;
>> +            } else if (prd_size == req_size) {
>> +                s1 = BM_STS_INTR;
>> +                s2 = BM_STS_INTR;
>> +            } else {
>> +                s1 = BM_STS_ACTIVE | BM_STS_INTR;
>> +                s2 = BM_STS_INTR;
>> +            }
>> +            test_bmdma_prdt(size, req_sectors, s1, s2);
>> +        }
>> +    }
>>  }
> 
> And finally, as mentioned in the reply for patch 2, I wonder if we
> should add a case with an empty PRDT (passing 0 as the PRDT size). This
> would be a separate patch, though.

Do you mean zero PRD size here?

The specification says that a value of zero in PRD size indicates 64K.
That's why we have the following code in bmdma_prepare_buf():
    len = prd.size & 0xfffe;
    if (len == 0)
        len = 0x10000;

That case is already tested in my version. Let me quote the code above:
>> +    for (size = 0; size < 65536; size += 256) {

Best regards,
Alexander


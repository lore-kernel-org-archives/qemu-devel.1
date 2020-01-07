Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA17C282DD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 22:40:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CEE72075A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 22:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CEE72075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioxWh-0007hd-At
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 17:40:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <a13xp0p0v88@gmail.com>) id 1ioxVm-0006jf-T2
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 17:39:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <a13xp0p0v88@gmail.com>) id 1ioxVl-0001je-Jv
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 17:39:42 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34941)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <a13xp0p0v88@gmail.com>)
 id 1ioxVi-0001h5-Hf; Tue, 07 Jan 2020 17:39:38 -0500
Received: by mail-lf1-f65.google.com with SMTP id 15so961443lfr.2;
 Tue, 07 Jan 2020 14:39:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=89e00cK2H9V1hgjkcHhlZTpuD6BrtTsROR/41x8PYhw=;
 b=iGNnDatZjbxr64pNr7UBIrPbTIkXN1CjmO4Q+gmmql8XqbvmGGDWrtQBgNP9RMvLYv
 FcoMoMl/u6sGHLkEi92pbLNAKiRnlOQzSdiacTxTEIrEy8H/0iDWXxxHTKOuGW77zBy0
 7WLxbbt2sijXiLyDR3ifG2HN6A08vqbPM5Qt3s0+r3D4qo4sxWFE9ddf8XxM4tcZH2H/
 SHzpQ3BvkGE+e1VWr9qA7z/czYoIYzPPwJFCr7dfp6wiCwiyeWW5OnlEJOEfrI0KEDC1
 LM4XDy1c/rZbhYlqfGqXTv034WWYrmSA0VuVj4cldY15VcK5YmOVwB4Sz5QQ9CP/aCBc
 KsMw==
X-Gm-Message-State: APjAAAXghV9sZrKz6bCXeNX2HKJVhhnVlNiJbvcvKJ6SuGlEG15rLkjc
 gmtOUTITdjMnrst5s7vMSOU=
X-Google-Smtp-Source: APXvYqwlueEfXihNkmZpjaPhERywINXn6LwkkjmfqP+iB1M5cp6qng6XqnD9MUhNThnZyNC1Kll8Vg==
X-Received: by 2002:ac2:5a09:: with SMTP id q9mr975422lfn.71.1578436776930;
 Tue, 07 Jan 2020 14:39:36 -0800 (PST)
Received: from [192.168.1.184] (128-68-70-109.broadband.corbina.ru.
 [128.68.70.109])
 by smtp.gmail.com with ESMTPSA id w17sm441684lfn.22.2020.01.07.14.39.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 14:39:35 -0800 (PST)
Subject: Re: [PATCH v3 2/2] tests/ide-test: Create a single unit-test covering
 more PRDT cases
To: Kevin Wolf <kwolf@redhat.com>
References: <20191223175117.508990-1-alex.popov@linux.com>
 <20191223175117.508990-3-alex.popov@linux.com>
 <20200107074444.GE4076@linux.fritz.box>
From: Alexander Popov <alex.popov@linux.com>
Autocrypt: addr=alex.popov@linux.com; prefer-encrypt=mutual; keydata=
 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
 j3lCqPk=
Message-ID: <79b3fccf-f289-245c-429e-517215249ce9@linux.com>
Date: Wed, 8 Jan 2020 01:39:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200107074444.GE4076@linux.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.65
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

On 07.01.2020 10:44, Kevin Wolf wrote:
> Am 23.12.2019 um 18:51 hat Alexander Popov geschrieben:
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
> The time this test takes is much better now (~5s for me).
> 
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
>> +    int sectors = 0;
>> +    uint32_t size = 0;
>> +
>> +    for (sectors = 1; sectors <= 256; sectors *= 2) {
>> +        QTestState *qts = NULL;
>> +        QPCIDevice *dev = NULL;
>> +        QPCIBar bmdma_bar, ide_bar;
>> +
>> +        qts = test_bmdma_setup();
>> +        dev = get_pci_device(qts, &bmdma_bar, &ide_bar);
> 
> I'm wondering why the initialisation has to be inside the outer for
> loop. I expected that moving it outside would further improve the speed.
> But sure enough, doing that makes the test fail.

Yes, that's why I came to the current solution.

> Did you have a look why this happens? I suppose we might be running out
> of some resources in the qtest framework becasue each send_dma_request()
> calls get_pci_device() again?

I've spent some time on investigating, but didn't succeed.

1. After several hundreds of send_dma_request() calls the following assertion in
that function fails:
    assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), BSY | DRQ);

2. If I comment out this assertion, the test system proceeds but eventually stalls.

3. I tried to send the CMD_FLUSH_CACHE command to the device, it didn't help.

4. That behavior is not influenced by ide_dma_cb() code that I changed.

I guess it would be better if that effect is examined by somebody with more
knowledge about DMA and qtest.

> 5 seconds isn't that bad, so this shouldn't block this series, but it's
> still by far the slowest test in ide-test, so any improvement certainly
> wouldn't hurt.

Thanks for not making that mandatory. It would take me much more time.

>> +        for (size = 0; size < 65536; size += 256) {
>> +            uint32_t req_size = sectors * 512;
>> +            uint32_t prd_size = size & 0xfffe; /* bit 0 is always set to 0 */
>> +            uint8_t ret = 0;
>> +            uint8_t req_status = 0;
> 
> If you end up sending another version for some reason, I would also
> consider renaming req_status, because reg_status already exists, which
> looks almost the same. This confused me for a moment when reading the
> code below.

Heh! Ok, let's wait for more reviews.

Best regards,
Alexander


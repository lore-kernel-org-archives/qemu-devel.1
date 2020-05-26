Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F20C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:52:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0311206F1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stHv/wAx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0311206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdbss-0003V7-Vu
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 11:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdbsJ-00032t-JG
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:52:19 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:35788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdbsI-0002Ni-PU
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:52:19 -0400
Received: by mail-ed1-x541.google.com with SMTP id be9so18079250edb.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 08:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=oqnXK7qHjN64emUW8LEJkWjGOu9n6iHpxaqpBT+64wU=;
 b=stHv/wAxuqI6+ioiWXtOO3vytxQoca8bZUDckUTYgw2COoHrDnVcoMf37bjVuUPh4X
 JeliHvlXGHYNNezM1x1Q66UTkxr+W4sd7RNNL3n1ZIfSlYHeiDxP55A6lTF0VGQiMAYo
 vdtBxxLq3m/hi3vmNBAQsF5bM3pX6mTP9vNtj0+DotKikeQtXJptUNkRw4ssRbhKRtnB
 zzoJaJWGEiKhagc4rDahgwNVQKHaDz7VKDpcOmTYcdcF1oUoSGeNJ0aDEQeyPZjrPJRi
 kKfBFv4tzrHqDTyQRyZKZjbsHlDuHjR4YSMWrU784HfSsbUWbPHstbA45f3HyRY49Pjd
 JrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oqnXK7qHjN64emUW8LEJkWjGOu9n6iHpxaqpBT+64wU=;
 b=VX7Ne7pBVhZvFC4ZY5gqNvb08glvFqsgq8Vqw6gmQ/R2qYPSfhHN6OhN8GLkJabbv1
 cRIru35Jvbd+2fuEF74jebVvhiCUjqykCvJp6hcP57PTeVftFRQz1NDW0Cob1Ysjh5jM
 WlkZWmwCw9kqdI8w0XGK2xwaN00fCXuiqWHnZ7SL+pTqWj1SVTcyIs77Cr7p6WJYKxmN
 oowsAzVox2o6wlZOquEiyI6kqg8XEnsryQM4KZF35C3e8sgooIlist//gR3GnXjOG6DZ
 1YG2Phe+NDWq2DkstUc1wOgOTqBzf9x2SNrbXIqJzkBkPSj7LFG1x8fi7ZrJ7Z7WDsq/
 51/Q==
X-Gm-Message-State: AOAM530yVuc9MhGcIsNxOF5IL5BItMp5kJrlo9tMRr9a3q2tZcuKjBnx
 UU9B17jaH9kL/FxxFSFMayw=
X-Google-Smtp-Source: ABdhPJwBLjB21XGZjW2qi1QZjDOSI0pDtNnaI8j3v49mXdudHgZNxgg8h+m21XFGRvVMERW5+sLHPw==
X-Received: by 2002:a05:6402:22a6:: with SMTP id
 cx6mr20571163edb.76.1590508336754; 
 Tue, 26 May 2020 08:52:16 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id s2sm234216ejm.50.2020.05.26.08.52.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 08:52:16 -0700 (PDT)
Subject: Re: [PATCH 0/2] tests/qtest/fuzz: Avoid QTest serialization
To: Alexander Bulekov <alxndr@bu.edu>
References: <20200526055820.12999-1-f4bug@amsat.org>
 <20200526085609.GA766304@stefanha-x1.localdomain>
 <0e3f6528-b26e-6b5b-be23-f7cf79c216f5@amsat.org>
 <20200526145632.65uxxj7qk2lrwxsv@mozz.bu.edu>
 <1e9429d6-7309-4f1e-4a72-6d4d28eea956@amsat.org>
 <20200526154146.of5jbenq7gduimx6@mozz.bu.edu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <90302b66-8512-3b3c-58db-9cdcd0049ed6@amsat.org>
Date: Tue, 26 May 2020 17:52:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200526154146.of5jbenq7gduimx6@mozz.bu.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/26/20 5:41 PM, Alexander Bulekov wrote:
> On 200526 1725, Philippe Mathieu-Daudé wrote:
>> On 5/26/20 4:56 PM, Alexander Bulekov wrote:
>>> On 200526 1105, Philippe Mathieu-Daudé wrote:
>>>> On 5/26/20 10:56 AM, Stefan Hajnoczi wrote:
>>>>> On Tue, May 26, 2020 at 07:58:18AM +0200, Philippe Mathieu-Daudé wrote:
>>>>>> Hi Alexander,
>>>>>>
>>>>>> I forgot to share these 2 patches wrote before
>>>>>> the direct MemoryRegion fuzzer sent yesterday.
>>>>>>
>>>>>> Regards,
>>>>>>
>>>>>> Phil.
>>>>>>
>>>>>> Philippe Mathieu-Daudé (2):
>>>>>>   tests/qtest/fuzz: Avoid QTest ioport serialization
>>>>>>   tests/qtest/fuzz: Avoid QTest mmio serialization
>>>>>>
>>>>>>  tests/qtest/fuzz/i440fx_fuzz.c      | 19 +++++++++++++------
>>>>>>  tests/qtest/fuzz/virtio_net_fuzz.c  |  6 ++++--
>>>>>>  tests/qtest/fuzz/virtio_scsi_fuzz.c |  6 +++++-
>>>>>>  3 files changed, 22 insertions(+), 9 deletions(-)
>>>>>
>>>>> Will it still be possible to print qtest reproducer commands when a
>>>>> crash is found?
>>>>
>>>> Yes, there is no change in the corpus format.
>>>
>>> Yes, though with these patches, the qtest-based code will be gone.
>>> Should there be some option to switch between the two modes?
>>
>> How so?
>>
>> How do you generate your reproducers?
> 
> Right now basically with this:
> 
> --- a/qtest.c
> +++ b/qtest.c
> @@ -808,6 +808,8 @@ bool qtest_driver(void)
> 
>  void qtest_server_inproc_recv(void *dummy, const char *buf)
>  {
> +    // It would be nice to add support for qtest's built in qtest_log_fp.
> +    printf(">>> %s\n", buf);

Uh =) I suppose you restart a single job with the offending corpus file?

>      static GString *gstr;
>      if (!gstr) {
>          gstr = g_string_new(NULL);
> --
> 
> It would be nice to add support for qtest's built in qtest_log_fp.
> Unless I'm missing something, these address_space_writes completely
> bypass qtest, so there has to be some additional step to build
> reproducers(eg running against the QTest-based version, or adding some
> way to spit out corresponding qtest commands for the
> address_space_writes).

I am using this hacky script, not committed yet because not ready but
still you can get the idea:

-- >8 --
import sys
import struct

# Tune to MemoryRegion properties
IOBASE = 0xa0002000
IOSIZE =     0x1000

action = { #           ASM        ADDR         VAL
    0x00: {'opcode': 'writeb', 'size': 8,  'fmt': 'B'},
    0x01: {'opcode': 'writew', 'size': 8,  'fmt': 'H'},
    0x02: {'opcode': 'writel', 'size': 8,  'fmt': 'I'},
    0x03: {'opcode': 'writeq', 'size': 8,  'fmt': 'L'},

    0x04: {'opcode': 'writeb', 'size': 16,  'fmt': 'B'},
    0x05: {'opcode': 'writew', 'size': 16,  'fmt': 'H'},
    0x06: {'opcode': 'writel', 'size': 16,  'fmt': 'I'},
    0x07: {'opcode': 'writeq', 'size': 16,  'fmt': 'L'},

    0x08: {'opcode': 'writeb', 'size': 32,  'fmt': 'B'},
    0x09: {'opcode': 'writew', 'size': 32,  'fmt': 'H'},
    0x0a: {'opcode': 'writel', 'size': 32,  'fmt': 'I'},
    0x0b: {'opcode': 'writeq', 'size': 32,  'fmt': 'L'},

    0x10: {'opcode': 'readb',  'size': 8,  'fmt': 'B'},
    0x11: {'opcode': 'readw',  'size': 8,  'fmt': 'H'},
    0x12: {'opcode': 'readl',  'size': 8,  'fmt': 'I'},
    0x13: {'opcode': 'readq',  'size': 8,  'fmt': 'L'},

    0x14: {'opcode': 'readb',  'size': 16,  'fmt': 'B'},
    0x15: {'opcode': 'readw',  'size': 16,  'fmt': 'H'},
    0x16: {'opcode': 'readl',  'size': 16,  'fmt': 'I'},
    0x17: {'opcode': 'readq',  'size': 16,  'fmt': 'L'},

    0x18: {'opcode': 'readb',  'size': 32,  'fmt': 'B'},
    0x19: {'opcode': 'readw',  'size': 32,  'fmt': 'H'},
    0x1a: {'opcode': 'readl',  'size': 32,  'fmt': 'I'},
    0x1b: {'opcode': 'readq',  'size': 32,  'fmt': 'L'},
}
AMASK = 0x1f
ADDR = {8: 'B', 16: 'H', 32: 'I', 64: 'L'}

def fuzz_parse_corpus_data(fn):
    fd = open(fn, 'rb')
    while True:
        buf = fd.read(1)
        if len(buf) < 1:
            break
        op, = struct.unpack("B", buf)
        op &= AMASK
        if op not in action:
            break
        a = action[op]
        fmt = "<" + ADDR[a['size']] + a['fmt']
        fmtsz = struct.calcsize(fmt)
        buf = fd.read(fmtsz)
        if len(buf) < fmtsz:
            break
        if a['fmt'] == 'x':
            addr, = struct.unpack(fmt, buf)
            val = 0
        else:
            addr, val = struct.unpack(fmt, buf)
        addr &= IOSIZE - 1
        print("%s 0x%02x 0x%x" % (a['opcode'], IOBASE + addr, val))

fuzz_parse_corpus_data(sys.argv[1])
---

$ python tests/qtest/fuzz/corpus2qtest.py \
  ./crash-12e481ba7c2a7a625152dc701821d5e184cddee8
writel 0xa0002000 0x20010000
writeb 0xa0002020 0x20
readl 0xa0002100 0x204204ff
writeb 0xa0002042 0x36
readl 0xa0002436 0xf4760024
writel 0xa0002020 0x4363636
writeb 0xa0002600 0xf4
writew 0xa0002001 0x2020
writeb 0xa0002020 0x4
writel 0xa0002020 0x4363636
writeb 0xa0002600 0xf4
writel 0xa0002020 0x36363a01
readl 0xa0002404 0x1f47600
writew 0xa0002020 0x2020
writeb 0xa0002004 0x42
writeb 0xa0002036 0x36
readl 0xa0002404 0x42f47600
writeb 0xa0002036 0x36
readl 0xa0002404 0x1f47600
writew 0xa0002020 0x420

> 
>>>
>>>>>
>>>>> Other than this concern, higher fuzzing rates would be great.
>>>>
>>>> Thanks,
>>>>
>>>> Phil.
>>>
> 


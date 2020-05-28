Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41409C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 13:37:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0FCF206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 13:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3QR8SAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0FCF206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeIig-0007ha-PU
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 09:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jeIfD-0003oY-Bm
 for qemu-devel@nongnu.org; Thu, 28 May 2020 09:33:39 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42906)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jeIfC-00031R-2z
 for qemu-devel@nongnu.org; Thu, 28 May 2020 09:33:39 -0400
Received: by mail-wr1-x444.google.com with SMTP id s8so27871032wrt.9
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 06:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6d95n3QDtsj9iokqwrlqAk79zoyR3jriRKU3RhPDs6I=;
 b=I3QR8SATKBACnBrgXbn+M+WJwJON2cbeMDXBN/pR0S9A8gVgwfOoGdswLxl1TtIEuE
 ASMA0Y6fHsnXrinp/3bpD6lKjQHLFyet3KVsorSY1CsXlKQYBwD1G7dpbMxK0ot7eTXJ
 qxluIglrDY/IW2PhY0UU2aKw13+3ZyvZ7isPZlEhYZfvEQtFfP68cV5oQHmxe/5kiTGT
 yDLfPXRGEpKRQec1YdQy1NRAGpFbh6SbIJfPL3xeomN+8K0topE0mvWcrSl4vAeZoh4+
 ywhPa1hv11uhWQXeyb8m3FNIFbi7zwVBrl+Yh/qs2JOYLAuvrJhvD2UUBzMcu/s1kYvN
 ouSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=6d95n3QDtsj9iokqwrlqAk79zoyR3jriRKU3RhPDs6I=;
 b=V2M2DzQBLHqMXRFrxXYfSsvWV5W1OcwVlIN0hDewVBHDm9F2buwYO2uFikdO9ZM1Qd
 HpZGzoWvxXX1C/f0GOvb/1FaHKpSmb2hQr0dQRNAmN/8Xa2YQ2G/GBYhaDuepz2lPqSY
 5nMz2TFc4wqTbENkpWAXc7OiodYLQr6FZ6rwoM9G5MsHc2KCphL6sqpMVmIDuVR1GprZ
 Lj8zltY5TVwklBTR4McrpHxf64M2yuEza8wP2Vytyy27kD/Skhg2scP1usecU4Xgas8j
 Iedt6etuZMXvL1tDqi8FDe/aGw0ty3x1NwKxNNLZsBHqfisQ+XLbZGaaOFb+e0KdluHW
 VpSw==
X-Gm-Message-State: AOAM532wcjsooFp7hTdieBDHtuvpAo4Q5i/oVbkZJhhf/2Mh2mIa2ptj
 g919JRightZqgikhU/niS68=
X-Google-Smtp-Source: ABdhPJwkWKAps0ihLj4sm3MlVYWkLG7LDOTGl1Kt/8q8LRSf2tGyaQU3dMYkZAGBh7yvpgUGPb9wpg==
X-Received: by 2002:adf:db47:: with SMTP id f7mr3722984wrj.101.1590672816197; 
 Thu, 28 May 2020 06:33:36 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id l17sm6182792wmi.3.2020.05.28.06.33.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2020 06:33:35 -0700 (PDT)
Subject: Re: [PATCH 0/2] tests/qtest/fuzz: Avoid QTest serialization
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Alexander Bulekov <alxndr@bu.edu>
References: <20200526055820.12999-1-f4bug@amsat.org>
 <20200526085609.GA766304@stefanha-x1.localdomain>
 <0e3f6528-b26e-6b5b-be23-f7cf79c216f5@amsat.org>
 <20200526145632.65uxxj7qk2lrwxsv@mozz.bu.edu>
 <1e9429d6-7309-4f1e-4a72-6d4d28eea956@amsat.org>
 <20200526154146.of5jbenq7gduimx6@mozz.bu.edu>
 <90302b66-8512-3b3c-58db-9cdcd0049ed6@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <bd0090dd-0a86-979d-9f43-2fe199fb9d28@amsat.org>
Date: Thu, 28 May 2020 15:33:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <90302b66-8512-3b3c-58db-9cdcd0049ed6@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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

On 5/26/20 5:52 PM, Philippe Mathieu-Daudé wrote:
> On 5/26/20 5:41 PM, Alexander Bulekov wrote:
>> On 200526 1725, Philippe Mathieu-Daudé wrote:
>>> On 5/26/20 4:56 PM, Alexander Bulekov wrote:
>>>> On 200526 1105, Philippe Mathieu-Daudé wrote:
>>>>> On 5/26/20 10:56 AM, Stefan Hajnoczi wrote:
>>>>>> On Tue, May 26, 2020 at 07:58:18AM +0200, Philippe Mathieu-Daudé wrote:
>>>>>>> Hi Alexander,
>>>>>>>
>>>>>>> I forgot to share these 2 patches wrote before
>>>>>>> the direct MemoryRegion fuzzer sent yesterday.
>>>>>>>
>>>>>>> Regards,
>>>>>>>
>>>>>>> Phil.
>>>>>>>
>>>>>>> Philippe Mathieu-Daudé (2):
>>>>>>>   tests/qtest/fuzz: Avoid QTest ioport serialization
>>>>>>>   tests/qtest/fuzz: Avoid QTest mmio serialization
>>>>>>>
>>>>>>>  tests/qtest/fuzz/i440fx_fuzz.c      | 19 +++++++++++++------
>>>>>>>  tests/qtest/fuzz/virtio_net_fuzz.c  |  6 ++++--
>>>>>>>  tests/qtest/fuzz/virtio_scsi_fuzz.c |  6 +++++-
>>>>>>>  3 files changed, 22 insertions(+), 9 deletions(-)
>>>>>>
>>>>>> Will it still be possible to print qtest reproducer commands when a
>>>>>> crash is found?
>>>>>
>>>>> Yes, there is no change in the corpus format.
>>>>
>>>> Yes, though with these patches, the qtest-based code will be gone.
>>>> Should there be some option to switch between the two modes?
>>>
>>> How so?
>>>
>>> How do you generate your reproducers?
>>
>> Right now basically with this:
>>
>> --- a/qtest.c
>> +++ b/qtest.c
>> @@ -808,6 +808,8 @@ bool qtest_driver(void)
>>
>>  void qtest_server_inproc_recv(void *dummy, const char *buf)
>>  {
>> +    // It would be nice to add support for qtest's built in qtest_log_fp.
>> +    printf(">>> %s\n", buf);
> 
> Uh =) I suppose you restart a single job with the offending corpus file?
> 
>>      static GString *gstr;
>>      if (!gstr) {
>>          gstr = g_string_new(NULL);
>> --
>>
>> It would be nice to add support for qtest's built in qtest_log_fp.
>> Unless I'm missing something, these address_space_writes completely
>> bypass qtest, so there has to be some additional step to build
>> reproducers(eg running against the QTest-based version, or adding some
>> way to spit out corresponding qtest commands for the
>> address_space_writes).
> 
> I am using this hacky script, not committed yet because not ready but
> still you can get the idea:
> 
> -- >8 --
> import sys
> import struct
> 
> # Tune to MemoryRegion properties
> IOBASE = 0xa0002000
> IOSIZE =     0x1000
> 
> action = { #           ASM        ADDR         VAL
>     0x00: {'opcode': 'writeb', 'size': 8,  'fmt': 'B'},
>     0x01: {'opcode': 'writew', 'size': 8,  'fmt': 'H'},
>     0x02: {'opcode': 'writel', 'size': 8,  'fmt': 'I'},
>     0x03: {'opcode': 'writeq', 'size': 8,  'fmt': 'L'},
> 
>     0x04: {'opcode': 'writeb', 'size': 16,  'fmt': 'B'},
>     0x05: {'opcode': 'writew', 'size': 16,  'fmt': 'H'},
>     0x06: {'opcode': 'writel', 'size': 16,  'fmt': 'I'},
>     0x07: {'opcode': 'writeq', 'size': 16,  'fmt': 'L'},
> 
>     0x08: {'opcode': 'writeb', 'size': 32,  'fmt': 'B'},
>     0x09: {'opcode': 'writew', 'size': 32,  'fmt': 'H'},
>     0x0a: {'opcode': 'writel', 'size': 32,  'fmt': 'I'},
>     0x0b: {'opcode': 'writeq', 'size': 32,  'fmt': 'L'},
> 
>     0x10: {'opcode': 'readb',  'size': 8,  'fmt': 'B'},
>     0x11: {'opcode': 'readw',  'size': 8,  'fmt': 'H'},
>     0x12: {'opcode': 'readl',  'size': 8,  'fmt': 'I'},
>     0x13: {'opcode': 'readq',  'size': 8,  'fmt': 'L'},
> 
>     0x14: {'opcode': 'readb',  'size': 16,  'fmt': 'B'},
>     0x15: {'opcode': 'readw',  'size': 16,  'fmt': 'H'},
>     0x16: {'opcode': 'readl',  'size': 16,  'fmt': 'I'},
>     0x17: {'opcode': 'readq',  'size': 16,  'fmt': 'L'},
> 
>     0x18: {'opcode': 'readb',  'size': 32,  'fmt': 'B'},
>     0x19: {'opcode': 'readw',  'size': 32,  'fmt': 'H'},
>     0x1a: {'opcode': 'readl',  'size': 32,  'fmt': 'I'},
>     0x1b: {'opcode': 'readq',  'size': 32,  'fmt': 'L'},
> }
> AMASK = 0x1f
> ADDR = {8: 'B', 16: 'H', 32: 'I', 64: 'L'}
> 
> def fuzz_parse_corpus_data(fn):
>     fd = open(fn, 'rb')
>     while True:
>         buf = fd.read(1)
>         if len(buf) < 1:
>             break
>         op, = struct.unpack("B", buf)
>         op &= AMASK
>         if op not in action:
>             break
>         a = action[op]
>         fmt = "<" + ADDR[a['size']] + a['fmt']
>         fmtsz = struct.calcsize(fmt)
>         buf = fd.read(fmtsz)
>         if len(buf) < fmtsz:
>             break
>         if a['fmt'] == 'x':
>             addr, = struct.unpack(fmt, buf)
>             val = 0
>         else:
>             addr, val = struct.unpack(fmt, buf)
>         addr &= IOSIZE - 1
>         print("%s 0x%02x 0x%x" % (a['opcode'], IOBASE + addr, val))
> 
> fuzz_parse_corpus_data(sys.argv[1])
> ---
> 
> $ python tests/qtest/fuzz/corpus2qtest.py \
>   ./crash-12e481ba7c2a7a625152dc701821d5e184cddee8
> writel 0xa0002000 0x20010000
> writeb 0xa0002020 0x20
> readl 0xa0002100 0x204204ff
> writeb 0xa0002042 0x36
> readl 0xa0002436 0xf4760024
> writel 0xa0002020 0x4363636
> writeb 0xa0002600 0xf4
> writew 0xa0002001 0x2020
> writeb 0xa0002020 0x4
> writel 0xa0002020 0x4363636
> writeb 0xa0002600 0xf4
> writel 0xa0002020 0x36363a01
> readl 0xa0002404 0x1f47600
> writew 0xa0002020 0x2020
> writeb 0xa0002004 0x42
> writeb 0xa0002036 0x36
> readl 0xa0002404 0x42f47600
> writeb 0xa0002036 0x36
> readl 0xa0002404 0x1f47600
> writew 0xa0002020 0x420

FYI talking with Stefan he kinda suggested it is cleaner to use a
'-replay corpus_data.bin' mode that enables the printf output from
qtest_*read/write (without reaching the device) rather than maintaining
a Python script.

> 
>>
>>>>
>>>>>>
>>>>>> Other than this concern, higher fuzzing rates would be great.
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Phil.
>>>>
>>
> 


Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1C3C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 14:48:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 261652089E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 14:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 261652089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35710 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heKpy-0004sh-Ol
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 10:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45910)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1heKnn-0003ID-Op
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 10:46:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1heKmg-0005WP-Pz
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 10:45:00 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35897)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1heKmg-0005WL-Ja
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 10:44:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id u8so6894694wmm.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 07:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HNfwa9Z1m00gZgcXZz0SAwJCt6xsZguaiHCg+EvN2Jg=;
 b=j015kKH3Rhame4fcsfsA3s5pcF4vUzKO2ToZICTKC2pcy0Sv1sluV8Bv10QYqpG6rG
 Ezc9L3JAbcH9sCbnaPWrN8am4/+rIjDbVaQRnqGVulg158fSAvnYsOgs96x/gBWtwsaN
 jBpeyCM6BrO0CqanK4lRBI89TrElL59sSG0xVTA5IrPJ0vXCh9mSy2sZmSFZcMCnVLlk
 OPNPw6ndsfWj5yTOeHsrByeX0osrBRuru+U3NY9hRWpTAp3xGT3udnH+rCB8IPvuuljR
 n39SZ25R7e6aZTrbfjVg8WV5ustUECRDQswfPCOQ8/4CnShr4asgnfFBteVdx4O8g2b5
 27FQ==
X-Gm-Message-State: APjAAAVZk1NmlJ0AdhduRTeaEKp3ZGRUiaW9Y4+WB0Loiv+YMcFJKPyQ
 m47ddvS3DIbrb3/SN7VyEmzg5g==
X-Google-Smtp-Source: APXvYqxaB9rOL9R+4t5yWJcrjcqijvd7z5nvhd8kR3Y6/hWhKO9nNHyKuzXxQCl2YzFLuI+JGVvAzw==
X-Received: by 2002:a1c:3b45:: with SMTP id i66mr4588910wma.48.1561128297514; 
 Fri, 21 Jun 2019 07:44:57 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id 17sm1981542wmx.47.2019.06.21.07.44.56
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Jun 2019 07:44:56 -0700 (PDT)
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20190613143446.23937-1-philmd@redhat.com>
 <20190613143446.23937-2-philmd@redhat.com>
 <20190620112729-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <791936b7-bd8d-d7fe-531e-f6e850448272@redhat.com>
Date: Fri, 21 Jun 2019 16:44:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190620112729-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v2 01/20] hw/i386/pc: Use unsigned type to
 index arrays
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
Cc: Yang Zhong <yang.zhong@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, qemu-devel@nongnu.org,
 Rob Bradford <robert.bradford@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Samuel Ortiz <sameo@linux.intel.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/20/19 5:27 PM, Michael S. Tsirkin wrote:
> On Thu, Jun 13, 2019 at 04:34:27PM +0200, Philippe Mathieu-Daudé wrote:
>> Reviewed-by: Li Qiang <liq3ea@gmail.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Motivation?  Is this a bugfix?

Apparently I started to work on this series after "chardev: Convert
qemu_chr_write() to take a size_t argument" [*] for which I had these
extra warnings:

  --extra-cflags=-Wtype-limits\
                 -Wsign-compare\
                 -Wno-error=sign-compare

[*] https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg05229.html

>> ---
>>  hw/i386/pc.c         | 5 +++--
>>  include/hw/i386/pc.h | 2 +-
>>  2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 2c5446b095..bb3c74f4ca 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -874,7 +874,7 @@ static void handle_a20_line_change(void *opaque, int irq, int level)
>>  
>>  int e820_add_entry(uint64_t address, uint64_t length, uint32_t type)
>>  {
>> -    int index = le32_to_cpu(e820_reserve.count);
>> +    unsigned int index = le32_to_cpu(e820_reserve.count);
>>      struct e820_entry *entry;
>>  
>>      if (type != E820_RAM) {
>> @@ -906,7 +906,8 @@ int e820_get_num_entries(void)
>>      return e820_entries;
>>  }
>>  
>> -bool e820_get_entry(int idx, uint32_t type, uint64_t *address, uint64_t *length)
>> +bool e820_get_entry(unsigned int idx, uint32_t type,
>> +                    uint64_t *address, uint64_t *length)
>>  {
>>      if (idx < e820_entries && e820_table[idx].type == cpu_to_le32(type)) {
>>          *address = le64_to_cpu(e820_table[idx].address);

And here I wanted to fix:

hw/i386/pc.c:911:13: warning: comparison of integers of different signs:
'int' and 'unsigned int' [-Wsign-compare]
    if (idx < e820_entries && e820_table[idx].type == cpu_to_le32(type)) {
        ~~~ ^ ~~~~~~~~~~~~
hw/i386/pc.c:972:36: warning: comparison of integers of different signs:
'unsigned int' and 'int' [-Wsign-compare]
    for (i = 0, array_count = 0; i < e820_get_num_entries(); i++) {
                                 ~ ^ ~~~~~~~~~~~~~~~~~~~~~~
Is it worthwhile?

>> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>> index a7d0b87166..3b3a0d6e59 100644
>> --- a/include/hw/i386/pc.h
>> +++ b/include/hw/i386/pc.h
>> @@ -291,7 +291,7 @@ void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
>>  
>>  int e820_add_entry(uint64_t, uint64_t, uint32_t);
>>  int e820_get_num_entries(void);
>> -bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
>> +bool e820_get_entry(unsigned int, uint32_t, uint64_t *, uint64_t *);
>>  
>>  extern GlobalProperty pc_compat_4_0_1[];
>>  extern const size_t pc_compat_4_0_1_len;
>> -- 
>> 2.20.1


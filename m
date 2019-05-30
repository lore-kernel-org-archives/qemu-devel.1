Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06340C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 16:35:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDD1825DBB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 16:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD1825DBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56546 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWO1F-00050H-W9
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 12:35:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hWO0K-0004gh-56
	for qemu-devel@nongnu.org; Thu, 30 May 2019 12:34:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hWO0I-0000m1-VT
	for qemu-devel@nongnu.org; Thu, 30 May 2019 12:34:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hWO0I-0000lD-OW
	for qemu-devel@nongnu.org; Thu, 30 May 2019 12:34:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id c2so4622482wrm.8
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 09:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=1AgZoy454L+s0PduOvRU73bcQAh4Zk736l+VO1SADmI=;
	b=YPCx1mbWWBQNZxeTnWfp5Lk0J0XjnxPs8LK6mT2fJHpQ0PidF2k2LPK4Fo2VDk9RyB
	qvqkh9h1wczlEv/4zS77uGYMeB47X/R78NgRcKZt7Sms9N+bHJQwHQD8K1Djqhwp9IdC
	3uMSSowzChuM6JNOn2/5oNY+5cspWZninJzR71N1eqacz/nrkzCo5E3viRfLTzJEGL4h
	aXdrqINkBjKGEj04BbcHYdU3eiA+iYFjeaeTrHKLKmyixfZHtiTvncD7bB0nY5pz9P0S
	DmUaXIS109aVCXyXjE4/m+lpZY6hPuZuxuW1H6o7+Rgm2eYNcI7gJFus6UM69ZIC2VjX
	ioNg==
X-Gm-Message-State: APjAAAVsmRFqF/Jcy1pbn+5WkjNFPE6DaE0/XB5IWYCbHOlpPbpgHBKS
	CpHlkK653qCEL3yA7RnYjJluzQ==
X-Google-Smtp-Source: APXvYqwO/QY1kHCI3URCGJOxJxkPGj/e19HoGEuKAZbJadezxZqf1G0tPinz6VVXBOpjS1t08+bk9A==
X-Received: by 2002:a5d:4886:: with SMTP id g6mr3132151wrq.108.1559234049348; 
	Thu, 30 May 2019 09:34:09 -0700 (PDT)
Received: from [192.168.1.38] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	b10sm8476912wrh.59.2019.05.30.09.34.07
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 30 May 2019 09:34:07 -0700 (PDT)
To: Li Qiang <liq3ea@gmail.com>
References: <20190524063553.5339-1-philmd@redhat.com>
	<20190524063553.5339-5-philmd@redhat.com>
	<CAKXe6SJaLz5Hmyi-0ZhZvqcZ=HhP78ad_Z5RcBysp70dXxZ4=g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f1c033b6-780e-0849-41cf-e8c776bacefd@redhat.com>
Date: Thu, 30 May 2019 18:34:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAKXe6SJaLz5Hmyi-0ZhZvqcZ=HhP78ad_Z5RcBysp70dXxZ4=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH 04/20] hw/i386/pc: Add the E820Type enum
 type
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Yang Zhong <yang.zhong@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
	Rob Bradford <robert.bradford@intel.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Qemu Developers <qemu-devel@nongnu.org>,
	Samuel Ortiz <sameo@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Li,

On 5/24/19 2:33 PM, Li Qiang wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com <mailto:philmd@redhat.com>> 于
> 2019年5月24日周五 下午2:45写道：
> 
>     This ensure we won't use an incorrect value.
> 
>     Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com
>     <mailto:philmd@redhat.com>>
>     ---
>      hw/i386/pc.c         | 12 +++++++-----
>      include/hw/i386/pc.h | 16 ++++++++++------
>      2 files changed, 17 insertions(+), 11 deletions(-)
> 
>     diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>     index 1245028dd6..ac8343c728 100644
>     --- a/hw/i386/pc.c
>     +++ b/hw/i386/pc.c
>     @@ -868,9 +868,10 @@ static void handle_a20_line_change(void
>     *opaque, int irq, int level)
>          x86_cpu_set_a20(cpu, level);
>      }
> 
>     -ssize_t e820_add_entry(uint64_t address, uint64_t length, uint32_t
>     type)
>     +ssize_t e820_add_entry(uint64_t address, uint64_t length, E820Type
>     type)
>      {
>          unsigned int index = le32_to_cpu(e820_reserve.count);
>     +    uint32_t utype = (uint32_t)type;
> 
> 
> I don't have strong opinion for this, as I don't like add an explicit
> conversion.

Usually I try to not over-cast, but I guess remember I added that
because some Clang build was failing, but I started a build on Travis-CI
and all passed, so I might have been trying in a local build directory
with stricter CPPFLAGS.
I'll clean that out.

Thanks for your review of this series!

Phil.

>          struct e820_entry *entry;
> 
>          if (type != E820_RAM) {
>     @@ -882,7 +883,7 @@ ssize_t e820_add_entry(uint64_t address,
>     uint64_t length, uint32_t type)
> 
>              entry->address = cpu_to_le64(address);
>              entry->length = cpu_to_le64(length);
>     -        entry->type = cpu_to_le32(type);
>     +        entry->type = cpu_to_le32(utype);
> 
>              e820_reserve.count = cpu_to_le32(index);
>          }
>     @@ -891,7 +892,7 @@ ssize_t e820_add_entry(uint64_t address,
>     uint64_t length, uint32_t type)
>          e820_table = g_renew(struct e820_entry, e820_table,
>     e820_entries + 1);
>          e820_table[e820_entries].address = cpu_to_le64(address);
>          e820_table[e820_entries].length = cpu_to_le64(length);
>     -    e820_table[e820_entries].type = cpu_to_le32(type);
>     +    e820_table[e820_entries].type = cpu_to_le32(utype);
>          e820_entries++;
> 
>          return e820_entries;
>     @@ -902,10 +903,11 @@ size_t e820_get_num_entries(void)
>          return e820_entries;
>      }
> 
>     -bool e820_get_entry(unsigned int idx, uint32_t type,
>     +bool e820_get_entry(unsigned int idx, E820Type type,
>                          uint64_t *address, uint64_t *length)
>      {
>     -    if (idx < e820_entries && e820_table[idx].type ==
>     cpu_to_le32(type)) {
>     +    uint32_t utype = (uint32_t)type;
>     +    if (idx < e820_entries && e820_table[idx].type ==
>     cpu_to_le32(utype)) {
>              *address = le64_to_cpu(e820_table[idx].address);
>              *length = le64_to_cpu(e820_table[idx].length);
>              return true;
>     diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>     index 2bc48c03c6..10e77a40ce 100644
>     --- a/include/hw/i386/pc.h
>     +++ b/include/hw/i386/pc.h
>     @@ -282,12 +282,16 @@ void pc_system_firmware_init(PCMachineState
>     *pcms, MemoryRegion *rom_memory);
>      void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
>                             const CPUArchIdList *apic_ids, GArray *entry);
> 
>     -/* e820 types */
>     -#define E820_RAM        1
>     -#define E820_RESERVED   2
>     -#define E820_ACPI       3
>     -#define E820_NVS        4
>     -#define E820_UNUSABLE   5
>     +/**
>     + * E820Type: Type of the e820 address range.
>     + */
>     +typedef enum {
>     +    E820_RAM        = 1,
>     +    E820_RESERVED   = 2,
>     +    E820_ACPI       = 3,
>     +    E820_NVS        = 4,
>     +    E820_UNUSABLE   = 5
>     +} E820Type;
> 
>      ssize_t e820_add_entry(uint64_t, uint64_t, uint32_t);
>      size_t e820_get_num_entries(void);
>     -- 
>     2.20.1
> 
> 


Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D695C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 11:03:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3FA221994
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 11:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3FA221994
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqy0c-0007nQ-5U
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 07:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47878)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hqy0M-00079W-09
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 07:03:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hqy0G-0002SA-BO
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 07:03:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42320)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hqy0F-0002DP-L9
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 07:03:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id x1so4080761wrr.9
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 04:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6umawaz58VrZjodVPQ7Rd283rV9fK/tEWuXuksm8zU8=;
 b=kyo5PGeYdwzX4nME7ozF/cHS89szeB4xa8Rj/kQxx4kvjFAIUsopSqohKhRgXqURCW
 KX2tl4Y2iUduVm2GCUE/ZVt/HFmzk/SAuTxL/KZSN/mgdYpqB0y8zkQLblzHn+DYDINV
 +eQI8A6ZTaoARnRzTJ9NR43OK29azmKEZeayEALrLheySe+qg4nvqi9q9Rub/9Z/DdTP
 5uplUy9FtQV8RT2HotOFPj1Vy3Rd/tl7W3S+TwKqWJ5aYCNGDMYlV5sUgFT+dnknnX3E
 RU96AOXpnQhbhgUqjw2Am45oqCireF2v6oyUaq7QAl9sQhLbDaUoz96UIE9Vop++QIvm
 ysPA==
X-Gm-Message-State: APjAAAU2Fd7nv+0x8adRDx4UpFNeIbopHzqjHEuB7k1+tZ7GkrVRmCD+
 Q7TbY3RwoaI5wwvRNIv3m3rC+A==
X-Google-Smtp-Source: APXvYqxkqUOJWOcynd+1+S70iqmP/Wr/QF26dNPpGaEs1Rs5UShaE///+ydFQsS1q5RBLN3ixN3xcg==
X-Received: by 2002:adf:f1d1:: with SMTP id z17mr29267913wro.190.1564138986653; 
 Fri, 26 Jul 2019 04:03:06 -0700 (PDT)
Received: from [192.168.50.36] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id t15sm45627206wrx.84.2019.07.26.04.03.04
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jul 2019 04:03:05 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <3106a3c959c4498fad13a5799c89ba7b@tpw09926dag18e.domain1.systemhost.net>
 <1564123618147.19868@bt.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <55d4c7f3-633b-0005-f74c-53578dd1bee1@redhat.com>
Date: Fri, 26 Jul 2019 13:03:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1564123618147.19868@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v5 09/15] cputlb: Access MemoryRegion with
 MemOp
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
Cc: peter.maydell@linaro.org, walling@linux.ibm.com, sagark@eecs.berkeley.edu,
 mst@redhat.com, palmer@sifive.com, mark.cave-ayland@ilande.co.uk,
 Alistair.Francis@wdc.com, edgar.iglesias@gmail.com, alex.williamson@redhat.com,
 arikalo@wavecomp.com, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, rth@twiddle.net, atar4qemu@gmail.com,
 ehabkost@redhat.com, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 stefanha@redhat.com, shorne@gmail.com, david@gibson.dropbear.id.au,
 qemu-riscv@nongnu.org, kbastian@mail.uni-paderborn.de, cohuck@redhat.com,
 laurent@vivier.eu, qemu-ppc@nongnu.org, amarkovic@wavecomp.com,
 pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/26/19 8:46 AM, tony.nguyen@bt.com wrote:
> No-op MEMOP_SIZE and SIZE_MEMOP macros allows us to later easily
> convert memory_region_dispatch_{read|write} paramter "unsigned size"
> into a size+sign+endianness encoded "MemOp op".
> 
> Being a no-op macro, this patch does not introduce any logical change.
> 
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> ---
>  accel/tcg/cputlb.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 523be4c..5d88cec 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -881,7 +881,7 @@ static void tlb_fill(CPUState *cpu, target_ulong addr, int size,
> 
>  static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
>                           int mmu_idx, target_ulong addr, uintptr_t retaddr,
> -                         MMUAccessType access_type, int size)
> +                         MMUAccessType access_type, MemOp op)
>  {
>      CPUState *cpu = env_cpu(env);
>      hwaddr mr_offset;
> @@ -906,14 +906,13 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
>          qemu_mutex_lock_iothread();
>          locked = true;
>      }
> -    r = memory_region_dispatch_read(mr, mr_offset,
> -                                    &val, size, iotlbentry->attrs);
> +    r = memory_region_dispatch_read(mr, mr_offset, &val, op, iotlbentry->attrs);
>      if (r != MEMTX_OK) {
>          hwaddr physaddr = mr_offset +
>              section->offset_within_address_space -
>              section->offset_within_region;
> 
> -        cpu_transaction_failed(cpu, physaddr, addr, size, access_type,
> +        cpu_transaction_failed(cpu, physaddr, addr, MEMOP_SIZE(op), access_type,
>                                 mmu_idx, iotlbentry->attrs, r, retaddr);
>      }
>      if (locked) {
> @@ -925,7 +924,7 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
> 
>  static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
>                        int mmu_idx, uint64_t val, target_ulong addr,
> -                      uintptr_t retaddr, int size)
> +                      uintptr_t retaddr, MemOp op)
>  {
>      CPUState *cpu = env_cpu(env);
>      hwaddr mr_offset;
> @@ -947,15 +946,15 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
>          qemu_mutex_lock_iothread();
>          locked = true;
>      }
> -    r = memory_region_dispatch_write(mr, mr_offset,
> -                                     val, size, iotlbentry->attrs);
> +    r = memory_region_dispatch_write(mr, mr_offset, val, op, iotlbentry->attrs);
>      if (r != MEMTX_OK) {
>          hwaddr physaddr = mr_offset +
>              section->offset_within_address_space -
>              section->offset_within_region;
> 
> -        cpu_transaction_failed(cpu, physaddr, addr, size, MMU_DATA_STORE,
> -                               mmu_idx, iotlbentry->attrs, r, retaddr);
> +        cpu_transaction_failed(cpu, physaddr, addr, MEMOP_SIZE(op),
> +                               MMU_DATA_STORE, mmu_idx, iotlbentry->attrs, r,
> +                               retaddr);
>      }
>      if (locked) {
>          qemu_mutex_unlock_iothread();
> @@ -1306,7 +1305,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
>          }
> 
>          res = io_readx(env, &env_tlb(env)->d[mmu_idx].iotlb[index],
> -                       mmu_idx, addr, retaddr, access_type, size);
> +                       mmu_idx, addr, retaddr, access_type, SIZE_MEMOP(size));
>          return handle_bswap(res, size, big_endian);
>      }
> 
> @@ -1555,7 +1554,7 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
> 
>          io_writex(env, &env_tlb(env)->d[mmu_idx].iotlb[index], mmu_idx,
>                    handle_bswap(val, size, big_endian),
> -                  addr, retaddr, size);
> +                  addr, retaddr, SIZE_MEMOP(size));
>          return;
>      }
> 
> --
> 1.8.3.1
> 
> 
> 

Cleaner :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E0EC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:32:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98D022184B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D022184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqbzB-0005N1-QK
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 07:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50076)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hqbyx-0004cx-5f
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:32:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hqbyv-0007ii-Px
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:32:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32770)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hqbyv-0007i7-J0
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:32:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so50482388wru.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 04:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4Pv32FVpU5zV0ZEDRiftCp/cKWy6ZBt/RMwUu782exw=;
 b=bMQCqGi1ZqmCq2/WAbD4Y011KD9zIVkbp0/13EcDCn/Nh93ARXOmjmtPJajHmbtzcz
 YdscgE1H4/a8yAifR294f+TSHVY7J3Kjq1pe9xcGNlWNQBtqdmwJrs/cb+Yysl4oOc6s
 bCOUtybiPj/wXEOctEeY5QymTBy5UYJ1KCdRsOyZ+s7aoOdM9yW0BeMmV7yUAW0raV2P
 zzhFh/RjHm9nBkjDZiijOtbeFvNx0xYUqSGd4G9SnddmhROPIWper8tIRyG5MXDjMelo
 T9bULzDvzUbJYLkfj3E/xHeJI/DHAQJrUgbHrGBxy+U1xjNIT4tu3xLa5yoa8/xc3L6x
 n+kA==
X-Gm-Message-State: APjAAAWu7yC4JMp+wnrrB4XRyUG9hxnENmfFjV7v9v/OJoz5W75oq5P+
 8ieKfIHpugFtqpKunlYVQnit3A==
X-Google-Smtp-Source: APXvYqze6CP51ZgyCHFw2fG+vqun5rCwL8wRppYwNVomGzbn2Rc3y8yIeg5TYC5GTEYfHXR9d9fuyQ==
X-Received: by 2002:a05:6000:145:: with SMTP id
 r5mr14988733wrx.208.1564054340693; 
 Thu, 25 Jul 2019 04:32:20 -0700 (PDT)
Received: from [192.168.1.37] (190.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.190])
 by smtp.gmail.com with ESMTPSA id c4sm39050957wrt.86.2019.07.25.04.32.18
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jul 2019 04:32:20 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <45d1ebe4b2ed4c039c9da20a738652df@tpw09926dag18e.domain1.systemhost.net>
 <1564048510876.64711@bt.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <35669616-b61d-a76a-86d7-fbc3beb5050c@redhat.com>
Date: Thu, 25 Jul 2019 13:32:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1564048510876.64711@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v4 08/15] exec: Access MemoryRegion with
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
 david@redhat.com, palmer@sifive.com, mark.cave-ayland@ilande.co.uk,
 Alistair.Francis@wdc.com, edgar.iglesias@gmail.com, alex.williamson@redhat.com,
 arikalo@wavecomp.com, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 rth@twiddle.net, atar4qemu@gmail.com, ehabkost@redhat.com,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, stefanha@redhat.com,
 shorne@gmail.com, david@gibson.dropbear.id.au, qemu-riscv@nongnu.org,
 kbastian@mail.uni-paderborn.de, cohuck@redhat.com, laurent@vivier.eu,
 qemu-ppc@nongnu.org, amarkovic@wavecomp.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/25/19 11:55 AM, tony.nguyen@bt.com wrote:
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> ---
>  exec.c            |  6 ++++--
>  memory_ldst.inc.c | 18 +++++++++---------
>  2 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index 3e78de3..5013864 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3334,7 +3334,8 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
>              /* XXX: could force current_cpu to NULL to avoid
>                 potential bugs */
>              val = ldn_p(buf, l);
> -            result |= memory_region_dispatch_write(mr, addr1, val, l, attrs);
> +            result |= memory_region_dispatch_write(mr, addr1, val,
> +                                                   SIZE_MEMOP(l), attrs);
>          } else {
>              /* RAM case */
>              ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
> @@ -3395,7 +3396,8 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
>              /* I/O case */
>              release_lock |= prepare_mmio_access(mr);
>              l = memory_access_size(mr, l, addr1);
> -            result |= memory_region_dispatch_read(mr, addr1, &val, l, attrs);
> +            result |= memory_region_dispatch_read(mr, addr1, &val,
> +                                                  SIZE_MEMOP(l), attrs);
>              stn_p(buf, l, val);
>          } else {
>              /* RAM case */
> diff --git a/memory_ldst.inc.c b/memory_ldst.inc.c
> index acf865b..e073cf9 100644
> --- a/memory_ldst.inc.c
> +++ b/memory_ldst.inc.c
> @@ -38,7 +38,7 @@ static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
>          release_lock |= prepare_mmio_access(mr);
> 
>          /* I/O case */
> -        r = memory_region_dispatch_read(mr, addr1, &val, 4, attrs);
> +        r = memory_region_dispatch_read(mr, addr1, &val, SIZE_MEMOP(4), attrs);
>  #if defined(TARGET_WORDS_BIGENDIAN)
>          if (endian == DEVICE_LITTLE_ENDIAN) {
>              val = bswap32(val);
> @@ -114,7 +114,7 @@ static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
>          release_lock |= prepare_mmio_access(mr);
> 
>          /* I/O case */
> -        r = memory_region_dispatch_read(mr, addr1, &val, 8, attrs);
> +        r = memory_region_dispatch_read(mr, addr1, &val, SIZE_MEMOP(8), attrs);
>  #if defined(TARGET_WORDS_BIGENDIAN)
>          if (endian == DEVICE_LITTLE_ENDIAN) {
>              val = bswap64(val);
> @@ -188,7 +188,7 @@ uint32_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
>          release_lock |= prepare_mmio_access(mr);
> 
>          /* I/O case */
> -        r = memory_region_dispatch_read(mr, addr1, &val, 1, attrs);
> +        r = memory_region_dispatch_read(mr, addr1, &val, SIZE_MEMOP(1), attrs);
>      } else {
>          /* RAM case */
>          ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
> @@ -224,7 +224,7 @@ static inline uint32_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
>          release_lock |= prepare_mmio_access(mr);
> 
>          /* I/O case */
> -        r = memory_region_dispatch_read(mr, addr1, &val, 2, attrs);
> +        r = memory_region_dispatch_read(mr, addr1, &val, SIZE_MEMOP(2), attrs);
>  #if defined(TARGET_WORDS_BIGENDIAN)
>          if (endian == DEVICE_LITTLE_ENDIAN) {
>              val = bswap16(val);
> @@ -300,7 +300,7 @@ void glue(address_space_stl_notdirty, SUFFIX)(ARG1_DECL,
>      if (l < 4 || !memory_access_is_direct(mr, true)) {
>          release_lock |= prepare_mmio_access(mr);
> 
> -        r = memory_region_dispatch_write(mr, addr1, val, 4, attrs);
> +        r = memory_region_dispatch_write(mr, addr1, val, SIZE_MEMOP(4), attrs);
>      } else {
>          ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
>          stl_p(ptr, val);
> @@ -346,7 +346,7 @@ static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
>              val = bswap32(val);
>          }
>  #endif
> -        r = memory_region_dispatch_write(mr, addr1, val, 4, attrs);
> +        r = memory_region_dispatch_write(mr, addr1, val, SIZE_MEMOP(4), attrs);
>      } else {
>          /* RAM case */
>          ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
> @@ -408,7 +408,7 @@ void glue(address_space_stb, SUFFIX)(ARG1_DECL,
>      mr = TRANSLATE(addr, &addr1, &l, true, attrs);
>      if (!memory_access_is_direct(mr, true)) {
>          release_lock |= prepare_mmio_access(mr);
> -        r = memory_region_dispatch_write(mr, addr1, val, 1, attrs);
> +        r = memory_region_dispatch_write(mr, addr1, val, SIZE_MEMOP(1), attrs);
>      } else {
>          /* RAM case */
>          ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
> @@ -451,7 +451,7 @@ static inline void glue(address_space_stw_internal, SUFFIX)(ARG1_DECL,
>              val = bswap16(val);
>          }
>  #endif
> -        r = memory_region_dispatch_write(mr, addr1, val, 2, attrs);
> +        r = memory_region_dispatch_write(mr, addr1, val, SIZE_MEMOP(2), attrs);
>      } else {
>          /* RAM case */
>          ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
> @@ -524,7 +524,7 @@ static void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
>              val = bswap64(val);
>          }
>  #endif
> -        r = memory_region_dispatch_write(mr, addr1, val, 8, attrs);
> +        r = memory_region_dispatch_write(mr, addr1, val, SIZE_MEMOP(8), attrs);
>      } else {
>          /* RAM case */
>          ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
> --
> 1.8.3.1
> 
> 
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


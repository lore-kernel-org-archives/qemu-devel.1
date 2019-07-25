Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB86EC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:45:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F93D229F9
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F93D229F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqcBx-0004cO-SB
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 07:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53758)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hqcBj-0003zr-Tf
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hqcBi-0000FH-IH
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:45:35 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38835)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hqcBi-0000Ev-AW
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:45:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id s15so23091039wmj.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 04:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Hjpm8Rf7RyjQH3MjUQFnmhQY9vXYn0vLazK73zwsPIc=;
 b=U0J1CKFT3q0AQ3QHv4ToygNd5bJxz9gfLp9NKVAKOAXhsNHdTreQb66imTuzCe/viY
 D9EQBQcYrW6PD3QXaoNbJKG402NV4AkQP2takKlFHsw7ybK9ARuHylziEKLVE0F/1vNN
 e2t9HY07fQKMZP6zrSpk6MF8NRajmzogSIetbs3t94rNt8nE/HKh6p7OAHTyESfraAqX
 n/P6Q0SmpOeAQ/hnf0TBahd07+aHL/e6sZWKFlOzfqNoxKrR0YBODbm80jGNZYfvyo2i
 RgzvCsbheG65MrzAcTelBozOpw9dguM8Xuhvt7hSNb+rE4tecYm0BYRJNQ7w42DOe2zm
 tPPg==
X-Gm-Message-State: APjAAAXGUkHW7zaZd7PoUhAsy3dO7ikQDGOSn1nt8YnwXhYg6JH7/PHQ
 sQB/9wwH72NvuaZhziynthr8Nw==
X-Google-Smtp-Source: APXvYqwpl3EpuV09Ri0BJiGZu4JiT5BzuRYMTdyHcrfp3RPkEm8pki7QP2yVsl0/uQLSYJnLgJBK1Q==
X-Received: by 2002:a7b:c4d0:: with SMTP id g16mr81340762wmk.88.1564055133344; 
 Thu, 25 Jul 2019 04:45:33 -0700 (PDT)
Received: from [192.168.1.37] (190.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.190])
 by smtp.gmail.com with ESMTPSA id a8sm38174833wma.31.2019.07.25.04.45.30
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jul 2019 04:45:32 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <45d1ebe4b2ed4c039c9da20a738652df@tpw09926dag18e.domain1.systemhost.net>
 <1564048354001.54262@bt.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <ee5949da-4457-0560-4525-40e4d4aaef4a@redhat.com>
Date: Thu, 25 Jul 2019 13:45:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1564048354001.54262@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v4 02/15] memory: Access MemoryRegion with
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

On 7/25/19 11:52 AM, tony.nguyen@bt.com wrote:
> Replacing size with size+sign+endianness (MemOp) will enable us to
> collapse the two byte swaps, adjust_endianness and handle_bswap, along
> the I/O path.
> 
> While interfaces are converted, callers will have existing unsigned
> size coerced into a MemOp, and the callee will use this MemOp as an
> unsigned size.
> 
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> ---
>  include/exec/memop.h  | 4 ++++
>  include/exec/memory.h | 9 +++++----
>  memory.c              | 7 +++++--
>  3 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/include/exec/memop.h b/include/exec/memop.h
> index ac58066..09c8d20 100644
> --- a/include/exec/memop.h
> +++ b/include/exec/memop.h
> @@ -106,4 +106,8 @@ typedef enum MemOp {
>      MO_SSIZE = MO_SIZE | MO_SIGN,
>  } MemOp;
> 
> +/* No-op while memory_region_dispatch_[read|write] is converted to MemOp */
> +#define MEMOP_SIZE(op)  (op)    /* MemOp to size.  */
> +#define SIZE_MEMOP(ul)  (ul)    /* Size to MemOp.  */

SIZE_MEMOP() is never used until patch #10 "memory: Access MemoryRegion
with MemOp semantics", it would be clearer to only introduce the
MEMOP_SIZE() no-op here, and directly introduce the correct SIZE_MEMOP()
macro in patch #10.

> +
>  #endif
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index bb0961d..30b1c58 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -19,6 +19,7 @@
>  #include "exec/cpu-common.h"
>  #include "exec/hwaddr.h"
>  #include "exec/memattrs.h"
> +#include "exec/memop.h"
>  #include "exec/ramlist.h"
>  #include "qemu/queue.h"
>  #include "qemu/int128.h"
> @@ -1731,13 +1732,13 @@ void mtree_info(bool flatview, bool dispatch_tree, bool owner);
>   * @mr: #MemoryRegion to access
>   * @addr: address within that region
>   * @pval: pointer to uint64_t which the data is written to
> - * @size: size of the access in bytes
> + * @op: encodes size of the access in bytes
>   * @attrs: memory transaction attributes to use for the access
>   */
>  MemTxResult memory_region_dispatch_read(MemoryRegion *mr,
>                                          hwaddr addr,
>                                          uint64_t *pval,
> -                                        unsigned size,
> +                                        MemOp op,
>                                          MemTxAttrs attrs);
>  /**
>   * memory_region_dispatch_write: perform a write directly to the specified
> @@ -1746,13 +1747,13 @@ MemTxResult memory_region_dispatch_read(MemoryRegion *mr,
>   * @mr: #MemoryRegion to access
>   * @addr: address within that region
>   * @data: data to write
> - * @size: size of the access in bytes
> + * @op: encodes size of the access in bytes
>   * @attrs: memory transaction attributes to use for the access
>   */
>  MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
>                                           hwaddr addr,
>                                           uint64_t data,
> -                                         unsigned size,
> +                                         MemOp op,
>                                           MemTxAttrs attrs);
> 
>  /**
> diff --git a/memory.c b/memory.c
> index 5d8c9a9..6982e19 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1439,10 +1439,11 @@ static MemTxResult memory_region_dispatch_read1(MemoryRegion *mr,
>  MemTxResult memory_region_dispatch_read(MemoryRegion *mr,
>                                          hwaddr addr,
>                                          uint64_t *pval,
> -                                        unsigned size,
> +                                        MemOp op,
>                                          MemTxAttrs attrs)
>  {
>      MemTxResult r;
> +    unsigned size = MEMOP_SIZE(op);
> 
>      if (!memory_region_access_valid(mr, addr, size, false, attrs)) {
>          *pval = unassigned_mem_read(mr, addr, size);
> @@ -1483,9 +1484,11 @@ static bool memory_region_dispatch_write_eventfds(MemoryRegion *mr,
>  MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
>                                           hwaddr addr,
>                                           uint64_t data,
> -                                         unsigned size,
> +                                         MemOp op,
>                                           MemTxAttrs attrs)
>  {
> +    unsigned size = MEMOP_SIZE(op);
> +
>      if (!memory_region_access_valid(mr, addr, size, true, attrs)) {
>          unassigned_mem_write(mr, addr, data, size);
>          return MEMTX_DECODE_ERROR;
> --
> 1.8.3.1
> 
> 
> 


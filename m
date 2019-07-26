Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979D6C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 09:40:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D3B4206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 09:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D3B4206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqwi5-0008PC-Ke
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 05:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58005)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hqwhr-0007wB-GA
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:40:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hqwhf-0004CF-O6
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:40:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36546)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hqwhf-0003w3-HL
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:39:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id g67so43012139wme.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 02:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fSfrGrRhjJEug1iM2o0JkpzkU95zBrleqMeDoDm1YlU=;
 b=sdLu0VMxg1fD1xQazTf3hWj27PvjFQCfAjttm0ANuVluGv+ZworMoj0Jb+oeRz7jQO
 YHJPhhIuqjQu44GHfPTYmq4Hc7JC2GIVzxtvPypwsnvXY2IIOa/HLhsSNN53GTGn6nkW
 8qzS6wox/45IyIiatQLtFwzI2nTbwO0Va2u0hUj7AOOu3muXo7LxqkCAN0MvDsEzDikN
 m3uS+sYe8EAJveQuUh7G0Ev4Px7qJ8yAxOq+cQ3C+RtwPmV+MbHdDNMYWjQlH7vev7c7
 971JNeqO1Edv9Z8hByuXHK2dGxQDlUKzvfyIituvOdSkYWVqNTpAs/VLbHt7WZR5OY6p
 I1GA==
X-Gm-Message-State: APjAAAXCEkVeyEiyNXP5atfM65lXLIRLY1IYRGOJN5XHXQqoXbQ3rVnJ
 HNN5qihad7/keIRLJXkMsO2abw==
X-Google-Smtp-Source: APXvYqzlV/1DKFivxacazGTydJt0YU/GPPbguaon/bVKYgHKpFk955pWjIYP5RnuPKMYMUaSrzjLgg==
X-Received: by 2002:a1c:228b:: with SMTP id
 i133mr84279148wmi.140.1564133991298; 
 Fri, 26 Jul 2019 02:39:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cc23:f353:392:d2ee?
 ([2001:b07:6468:f312:cc23:f353:392:d2ee])
 by smtp.gmail.com with ESMTPSA id b5sm43505459wru.69.2019.07.26.02.39.49
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jul 2019 02:39:50 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <3106a3c959c4498fad13a5799c89ba7b@tpw09926dag18e.domain1.systemhost.net>
 <1564123667210.66446@bt.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2159ad69-4c4c-24dc-6759-039e39f952d3@redhat.com>
Date: Fri, 26 Jul 2019 11:39:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564123667210.66446@bt.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v5 11/15] memory: Single byte swap along
 the I/O path
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
 laurent@vivier.eu, Alistair.Francis@wdc.com, edgar.iglesias@gmail.com,
 arikalo@wavecomp.com, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, rth@twiddle.net, atar4qemu@gmail.com,
 ehabkost@redhat.com, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 stefanha@redhat.com, shorne@gmail.com, david@gibson.dropbear.id.au,
 qemu-riscv@nongnu.org, kbastian@mail.uni-paderborn.de, cohuck@redhat.com,
 alex.williamson@redhat.com, qemu-ppc@nongnu.org, amarkovic@wavecomp.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/07/19 08:47, tony.nguyen@bt.com wrote:
> +static bool memory_region_endianness_inverted(MemoryRegion *mr)
>  {
>  #ifdef TARGET_WORDS_BIGENDIAN
>      return mr->ops->endianness == DEVICE_LITTLE_ENDIAN;
> @@ -361,23 +361,27 @@ static bool
> memory_region_wrong_endianness(MemoryRegion *mr)
>  #endif
>  }
>  
> -static void adjust_endianness(MemoryRegion *mr, uint64_t *data,
> unsigned size)
> +static void adjust_endianness(MemoryRegion *mr, uint64_t *data, MemOp op)
>  {
> -    if (memory_region_wrong_endianness(mr)) {
> -        switch (size) {
> -        case 1:
> +    if (memory_region_endianness_inverted(mr)) {
> +        op ^= MO_BSWAP;
> +    }

Here it should not matter: the caller of memory_region_dispatch_read
should includes one of MO_TE/MO_LE/MO_BE in the op (or nothing for host
endianness).  Then memory_region_endianness_inverted can be:

  if (mr->ops->endianness == DEVICE_NATIVE_ENDIAN)
    return (op & MO_BSWAP) != MO_TE;
  else if (mr->ops->endianness == DEVICE_BIG_ENDIAN)
    return (op & MO_BSWAP) != MO_BE;
  else if (mr->ops->endianness == DEVICE_LITTLE_ENDIAN)
    return (op & MO_BSWAP) != MO_LE;

and adjust_endianness does

  if (memory_region_endianness_inverted(mr, op)) {
    switch (op & MO_SIZE) {
      ...
    }
  }

I think the changes should be split in two parts.  Before this patch,
you modify all callers of memory_region_dispatch_* so that they already
pass the right endianness op; however, you leave the existing swap in
place.  So for example in load_helper you'd have in a previous patch

+        /* FIXME: io_readx ignores MO_BSWAP.  */
+        op = SIZE_MEMOP(size) | (big_endian ? MO_BE : MO_LE);
         res = io_readx(env, &env_tlb(env)->d[mmu_idx].iotlb[index],
-                       mmu_idx, addr, retaddr, access_type,
SIZE_MEMOP(size));
+                       mmu_idx, addr, retaddr, access_type, op);
         return handle_bswap(res, size, big_endian);

Then, in this patch, you remove the handle_bswap call as well as the
FIXME comment.

Paolo


Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E81C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:45:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 422CC20651
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QleSDlFD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422CC20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40703 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr1Tj-0006VB-Ue
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 10:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46209)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr1TA-0004qs-Er
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:45:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr1T9-0000Zq-6q
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:45:16 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42789)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr1T8-0000Xj-R3
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:45:15 -0400
Received: by mail-pl1-x642.google.com with SMTP id ay6so24889787plb.9
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 07:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=09dyhl6G3S8lsTRL7xnnyHEtd3ZZs9GS0a/kT0/mLtU=;
 b=QleSDlFDDiYzT+oyVC55dvfV+ZtmPEGOVZ7D3MljjMdjR32IVE/zEdl9NPw0mDwDwd
 6XSJQobRZDeTqjaNpXqwEPoY8yKvmb3vZ1tKYNEmhxfWPfbhVr42lBLKzF3/eMoBB/L8
 lzR5ZgfYRGNKemIYzaSeLcLHOMhxhVYoKcmpUdzJnVJdiRyF8Es5+mV3yfQXO1np/l0c
 93Hqn3rvpMXgH10Gk0QrPrwb3dVIAdn7nND6FIhNC6oxSw7TK0hk37y16pCjtF6nUUdt
 s/sZauVim1mqwXaKxGkQZnRJ0eGOYZExFeT6p8j15j4fPlJ+8WzUB+8DoMc2y+k/E59T
 MrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=09dyhl6G3S8lsTRL7xnnyHEtd3ZZs9GS0a/kT0/mLtU=;
 b=lM4jRSD/72G/QQSrGqAgyhMuCP2s8kZeX/pWG8OI2ygFpV0xxt+lTw9Rm0yMZDVpQT
 vLGonCVkXjVWUfxCCxZ0Xt7eYU5pfMPnP5RTn6f2A0f/nUS9VnwNtC8zz18C2IRth2Yq
 mpJH16zFYIFKI1xEHBHGahIP3Mu7R3P+MxCTU6yjBWHhEzgYCVS4GpEEgovry+oUqFhj
 z+Ge+hLMzbnG7QGhG46dEQ01QQWaZMv+OWlbLD0246+zKUxw2BwJGsTcLqeJDHOClaCi
 p9yUGzaNsKical+gMR6o7QzLccwYq19A8vfb9ZjnxjW76LJt8M3Ncui7Fhk2xsFuykhV
 4Q6Q==
X-Gm-Message-State: APjAAAVOP5hJ00hR3Au5c+0rHGsy5l64vSADK59TqPu2k2PBgoS9c2En
 PfrvgVe9zsjGPH5nQEGHvKNr6w==
X-Google-Smtp-Source: APXvYqzcZ+tk3moJfUmceuVRb3y5u7IOWS4gwoY1zJ/fy05qZbf074AXJ7u7DIztQZwta2ZoA1eQ4g==
X-Received: by 2002:a17:902:8c98:: with SMTP id
 t24mr99056689plo.320.1564152313581; 
 Fri, 26 Jul 2019 07:45:13 -0700 (PDT)
Received: from [192.168.1.11] (97-126-117-207.tukw.qwest.net. [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id f8sm11113172pgd.58.2019.07.26.07.45.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jul 2019 07:45:12 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>, tony.nguyen@bt.com,
 qemu-devel@nongnu.org
References: <3106a3c959c4498fad13a5799c89ba7b@tpw09926dag18e.domain1.systemhost.net>
 <1564123667210.66446@bt.com>
 <2159ad69-4c4c-24dc-6759-039e39f952d3@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <5b7df6eb-2ccc-f921-3a94-00d0f55b6d4d@linaro.org>
Date: Fri, 26 Jul 2019 07:45:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2159ad69-4c4c-24dc-6759-039e39f952d3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
 Alistair.Francis@wdc.com, edgar.iglesias@gmail.com, alex.williamson@redhat.com,
 arikalo@wavecomp.com, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, rth@twiddle.net, atar4qemu@gmail.com,
 ehabkost@redhat.com, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 stefanha@redhat.com, shorne@gmail.com, david@gibson.dropbear.id.au,
 qemu-riscv@nongnu.org, kbastian@mail.uni-paderborn.de, cohuck@redhat.com,
 laurent@vivier.eu, qemu-ppc@nongnu.org, amarkovic@wavecomp.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/26/19 2:39 AM, Paolo Bonzini wrote:
> Then memory_region_endianness_inverted can be:
> 
>   if (mr->ops->endianness == DEVICE_NATIVE_ENDIAN)
>     return (op & MO_BSWAP) != MO_TE;
>   else if (mr->ops->endianness == DEVICE_BIG_ENDIAN)
>     return (op & MO_BSWAP) != MO_BE;
>   else if (mr->ops->endianness == DEVICE_LITTLE_ENDIAN)
>     return (op & MO_BSWAP) != MO_LE;

Possibly outside the scope of this patch set, I'd like to replace enum
device_endian with MemOp, with exactly the above enumerator replacement.

In the meantime, perhaps a conversion function

static MemOp devendian_memop(enum device_endian d)
{
    switch (d) {
    case DEVICE_NATIVE_ENDIAN:
        return MO_TE;
    case DEVICE_BIG_ENDIAN:
        return MO_BE;
    case DEVICE_LITTLE_ENDIAN:
        return MO_LE;
    default:
        g_assert_not_reached();
    }
}

With that, this would simplify to

    return (op & MO_BSWAP) != devendian_memop(mr->ops->endianness);


> I think the changes should be split in two parts.  Before this patch,
> you modify all callers of memory_region_dispatch_* so that they already
> pass the right endianness op; however, you leave the existing swap in
> place.  So for example in load_helper you'd have in a previous patch
> 
> +        /* FIXME: io_readx ignores MO_BSWAP.  */
> +        op = SIZE_MEMOP(size) | (big_endian ? MO_BE : MO_LE);
>          res = io_readx(env, &env_tlb(env)->d[mmu_idx].iotlb[index],
> -                       mmu_idx, addr, retaddr, access_type,
> SIZE_MEMOP(size));
> +                       mmu_idx, addr, retaddr, access_type, op);
>          return handle_bswap(res, size, big_endian);
> 
> Then, in this patch, you remove the handle_bswap call as well as the
> FIXME comment.

Agreed.


r~


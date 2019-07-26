Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFBAC76190
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 13:28:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE8DA22BE8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 13:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dktL4Paf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE8DA22BE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr0GZ-00079f-4x
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 09:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34239)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr0GN-0006YM-3S
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:28:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr0GL-0000D6-Sy
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:27:58 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:38313)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr0GL-0000Aa-Fn
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:27:57 -0400
Received: by mail-pl1-x636.google.com with SMTP id az7so24762534plb.5
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 06:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AeYQ99I0ZNzvORClQ/VunoCYa+uAza8hxjARLVddn+g=;
 b=dktL4PafqHaYhKVS8jJxXCmbHP2YESh5KwEvAMb1/ZZommqyBc1vOsrbyTCSM2j9pw
 X/ca0xg5y+GQw8RrPABfFBhas+gWY3ovdSnUZPi09+tQvJRWPKoYNM23mQQ+hV/wvbDO
 gwtef88zaAe3hMfkuLv9hh3NJWTV6tP8OjGcOibDuFtdhv+rdjJBq7Ex3UD4kW1ssjdk
 FouDJEBBFixPrAArLBKBJk5T2IYQt0CSPj5KTpfYOxJ4DLJVahmNf7fJkjRQIaF0mHGx
 oTesPPOsPmlmYm0LLBFHw81H6Z4h3xWKakZWVBYoru3C28bLq2NZqGx1FNBYYHrTGr7m
 Dm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AeYQ99I0ZNzvORClQ/VunoCYa+uAza8hxjARLVddn+g=;
 b=FNzwYqXYiKYYwKtxn9x/cu2Xh+ff/IKQcfwXqbsxv7QMTHu1U2eZrNQvgZhmG/oV8e
 4W4N8ETqj2abTy30KaIozKGULTQTIa8Ht17CUi5iRtnzGiknPIkM+5t++o84PDVYuYOW
 WFPUV6ibwDd5fuMKOBVObsrBkwBA9oHABxcKNTB+YF439p1mLyESJ6PfXac5D55a6JeK
 P/X1HMXLiqUzVDr1psFIBcyBZn43hhEX4Sgo6n9FCHaRreUGBZ2BzkXeLwc9gw1oOeNy
 5u5iJr711nF1brcy0k0oSowK0x7aWBOFbqF1Dqp9ReLvgRMY+trnzLLpYAXZQeQnH0ik
 vPiw==
X-Gm-Message-State: APjAAAWZzHx/paodVhfreKPt0akoPUkuKbs78cwK/so19G6G6ydbszkT
 4HtQwaB4Q5fQyYCGm2tAESidDQ==
X-Google-Smtp-Source: APXvYqzMuiPdu0a1ET9u0yVXYjubdIm2B+x0TxdG8ctpS6rFLKtu2eTOYpwoJkSyarIir3DezWqGsQ==
X-Received: by 2002:a17:902:e20c:: with SMTP id
 ce12mr99544562plb.130.1564147676257; 
 Fri, 26 Jul 2019 06:27:56 -0700 (PDT)
Received: from [192.168.1.11] (97-126-117-207.tukw.qwest.net. [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id z4sm85049697pfg.166.2019.07.26.06.27.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jul 2019 06:27:55 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <3106a3c959c4498fad13a5799c89ba7b@tpw09926dag18e.domain1.systemhost.net>
 <1564123405954.22175@bt.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ae38e1f7-ee8c-8263-6e91-9a3dd1425ead@linaro.org>
Date: Fri, 26 Jul 2019 06:27:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564123405954.22175@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::636
Subject: Re: [Qemu-devel] [PATCH v5 01/15] tcg: TCGMemOp is now accelerator
 independent MemOp
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

On 7/25/19 11:43 PM, tony.nguyen@bt.com wrote:
> +#ifdef NEED_CPU_H
> +#ifdef ALIGNED_ONLY
> +    MO_ALIGN = 0,
> +    MO_UNALN = MO_AMASK,

You need the configure patch got TARGET_ALIGNED_ONLY that you posted separately
as patch 1 in order for this to work.

Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


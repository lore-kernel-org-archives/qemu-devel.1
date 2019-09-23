Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F17BC4CECF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 15:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DAA22089F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 15:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uTlxP+a/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DAA22089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCQez-0007FW-6o
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 11:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iCQe0-0006RC-Nd
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 11:52:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iCQdz-0008Qt-Ho
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 11:52:56 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40414)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iCQdz-0008Pr-9Y
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 11:52:55 -0400
Received: by mail-pg1-x541.google.com with SMTP id w10so8228258pgj.7
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 08:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=03cttwKmYV9Wkcz+WWxAoMZlIITVjELefQMbbuf4c0M=;
 b=uTlxP+a/fwAPEo3jvrATpHfKMjELcNnStsr+d2/PzY3NVnCenpgVutaAHFkorJ8o0F
 5PhwOT790m/I8z1wZ6j49boe2Z2ur8XxCf79ttUV7oFDYugrZ81lHEjdgXb+FuKhIBSo
 UH16Kg+MTsuUM0VaoNOBejYwxjbGHpIXMq2mgWLVMRPURXSjBArHI8g8uM5b5MAP75nd
 ml81XA5S6/XuPOZKNpgWrKepe3fpN4qeNLt3+RiT0tDYLk2vWFxm6VkojICXvSSwCApY
 iZM/wZ0/KdNFZ/bCO+oeowVY6R4+nyOkIenYoZKDcgtXNTjMuOT6XV1C7OD6spiBp8CM
 qqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=03cttwKmYV9Wkcz+WWxAoMZlIITVjELefQMbbuf4c0M=;
 b=JakKEm8XX6Rw5Qwvw9/aH5mTkhp1ZxT/CAzgH6OeM1n2g43va9Dm3PwknvrfbNaBW3
 ErHKO/WDPwWAjXF2290buCuy3LBsJfwAsV35ucWZFXxYsIB2XFnaK9wht4G6c0eWrj8u
 qu9wSNgkMGunqY/mxcWqKyZMk+AG4oqM0Fm37tSXLymGHtOQPhoEswaNZJZLm1O0ntab
 zN9q1okVRmTT2PIKlIsdQXNPBaPWaScfAE2vi8A5MSyshaBRPZIM8Ux6nJVl8/23hxZW
 Ne0bwfrDW8jrqmjSS0anCzE7yKEs1okuuiZdX0zSJ4jieQquqCuLNIChX5NBoeOiS2Ln
 dtfg==
X-Gm-Message-State: APjAAAV33WT6gqgGsooL/ssUJLjTWIPnynV/CMtvCN8S3iEbYLK6fnlN
 m7Cz+gUolozxr8B6yEKG4FhJLg==
X-Google-Smtp-Source: APXvYqwWligEzezIkHIU+LqjaM5VPsAbHW8pvndCXokSMRysjDzSnb3/UEx1ObduEWDMdZ91Kt5zzA==
X-Received: by 2002:a63:1720:: with SMTP id x32mr582560pgl.289.1569253973657; 
 Mon, 23 Sep 2019 08:52:53 -0700 (PDT)
Received: from [172.20.32.216] ([12.157.10.118])
 by smtp.gmail.com with ESMTPSA id f62sm17869542pfg.74.2019.09.23.08.52.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 23 Sep 2019 08:52:52 -0700 (PDT)
Subject: Re: [PATCH v3 09/20] cputlb: Replace switches in load/store_helper
 with callback
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand
 <david@redhat.com>, qemu-devel@nongnu.org
References: <20190922035458.14879-1-richard.henderson@linaro.org>
 <20190922035458.14879-10-richard.henderson@linaro.org>
 <f67383ec-9dc8-c040-8fd9-fb659b8cd2d4@redhat.com>
 <b9e498eb-6d63-11a6-01d8-1a32f5b14236@redhat.com>
 <9c254159-9b63-b66e-dca7-af3d30167f49@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <222d55d5-9378-e475-28f4-d527722d3dd6@linaro.org>
Date: Mon, 23 Sep 2019 08:52:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9c254159-9b63-b66e-dca7-af3d30167f49@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: alex.bennee@linaro.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/19 3:02 AM, Paolo Bonzini wrote:
> On 23/09/19 11:54, David Hildenbrand wrote:
>> On 23.09.19 11:51, Paolo Bonzini wrote:
>>> that includes the switches?  Everything should be inlined just the same
>>> if you do
>>>
>>>         if (unlikely(tlb_addr & TLB_BSWAP)) {
>>>             st_memop(haddr, op ^ MO_BSWAP, val);
>>>         } else {
>>>             st_memop(haddr, op, val);
>>>         }
>>
>> I asked the same question on v2 and Richard explained that - for
>> whatever reason -  the compiler will not properly propagate the constant
>> in the "op ^ MO_BSWAP" case.
> 
> Even if ld_memop and st_memop are __always_inline__?

I'm not sure I tried __always_inline__.  I can, if you like.


r~


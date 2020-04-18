Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31865C2BA19
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 03:13:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EED6721D93
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 03:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EB5X+PeX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED6721D93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPdvO-0002nw-NW
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 23:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jPdtV-00026j-Ca
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 23:11:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jPdtS-0002sC-Fp
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 23:11:48 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33023)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jPdtN-0002cm-19
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 23:11:43 -0400
Received: by mail-pg1-x541.google.com with SMTP id d17so2068660pgo.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 20:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LhHyVCgPfmdkG7ZBw218O16oDYMzcqMLZ1VwY44L4RQ=;
 b=EB5X+PeXzZjaIWd/EqIwHG6H+9UmOd/EV8unTpaxFD7M/Uo+fwvu2j6/sSedatkt5y
 RL7szB8fh4aoWViyZVxpYE8HCsyvJWSJniWXtIQsOAA80gljoZfl4D/+ogC7KHfCljKL
 46GnKLb9tSEXNGv8FXx1hVUvdez/as6IKn8csKA1x4b/5wm/kJx5bkkII3ZVLXwKWgqV
 FvYcXNUu1gliUtfuXTIDD09mw4p9YSBk7LWX/vbnuzsesnrqp9slRfB+4Iv3e7YrUwTe
 rUtSdqSjY8/Cf5NGzBCSvwL7HgXInikUqmsIGzLtbX8bmOa9N/QB4Ep/3gRUtlYlt5f0
 nnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LhHyVCgPfmdkG7ZBw218O16oDYMzcqMLZ1VwY44L4RQ=;
 b=lwm7N+RPPENXTsVjReS2/uACbVEr75uZk1v3Z97pBcTcE2gkbbRrtEj3VG+QXvtgAd
 FGP0zuG8Utkj1FNJmUYhwfKyqHqP4yHFCQIK0avU9VW1hh8Cf4GTL2dwz7zn+q8FV0ie
 VmjjDFmlUliwZQz0/j49KMAFltQ8qsWgvwWSxK8YJ6PifUjbq4tXBN7WoRafAOuItS8/
 zMNwifgF/ETY2wDapul1wuth/7OzXp8tpscdq080MKkpB7O7gYlLIjnmjW7Zrch1USrb
 ETTI2uREZU9+Q2r9ajsugQPqxJb720Ue5Nxf74iwDw6h+eRKIZprVEEIJJMa4cjSTmly
 HZlw==
X-Gm-Message-State: AGi0Pub8JxIWLhz1bBnPFNaJT611xU1lqhXK1q8WGX51YapSr0ZqPZX1
 L+JGZzk9o23YAVMhhdlhk6oU2g==
X-Google-Smtp-Source: APiQypIPg0lldPZiws2UjGLEyiHX1X6zc4gbcWa7cWoxj2zk/xMQqHvFfsyRtdv4HIU4Lw7LGhG8iQ==
X-Received: by 2002:a63:7d5d:: with SMTP id m29mr5937968pgn.65.1587179497777; 
 Fri, 17 Apr 2020 20:11:37 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id n17sm13135415pff.81.2020.04.17.20.11.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2020 20:11:37 -0700 (PDT)
Subject: Re: [PATCH 06/16] target/arm: Add sve infrastructure for page lookup
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200311064420.30606-1-richard.henderson@linaro.org>
 <20200311064420.30606-7-richard.henderson@linaro.org>
 <CAFEAcA8F2Qmdh=9RXFhN9_WPjhjhai9iO2Cn0dL5UAGV_r4AGw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2f954cef-763a-592d-28d8-750959f3a43e@linaro.org>
Date: Fri, 17 Apr 2020 20:11:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8F2Qmdh=9RXFhN9_WPjhjhai9iO2Cn0dL5UAGV_r4AGw@mail.gmail.com>
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/16/20 6:03 AM, Peter Maydell wrote:
>> +#ifdef CONFIG_USER_ONLY
>> +    memset(&info->attrs, 0, sizeof(info->attrs));
> 
> Could just write "info->attrs = {};" ?

Not quite.  Correct syntax would be attrs = (MemTxAttrs){ }.
I don't see that as an improvement over memset though.

>> +    int16_t mem_off_first[2];
>> +    int16_t reg_off_first[2];
>> +    int16_t reg_off_last[2];
> 
> It would be helpful to document what these actually are,
> and in particular what the behaviour is if the whole thing
> fits in a single page. (Judging by the code, the elements
> at index 1 for the 2nd page are set to -1 ?)

Yes, that's right.  I've added some more detail here.

>> +    intptr_t reg_off_first = -1, reg_off_last = -1, reg_off_split;
>> +    intptr_t mem_off_last, mem_off_split;
>> +    intptr_t page_split, elt_split;
>> +    intptr_t i;
> 
> intptr_t seems like a funny type to be using here, since these
> aren't actually related to pointers as far as I can tell.

They're used as array indexes.  If we use "int", the compiler keeps
re-extending the value.

>> +    memset(info, -1, offsetof(SVEContLdSt, page));
> 
> I guess this isn't conceptually much different from zeroing
> out integer struct fields, but it feels a bit less safe somehow.

It seems easier than setting 9 fields separately...

>> +    page_split = -(addr | TARGET_PAGE_MASK);
> 
> What is the negation for ?

Computation of remaining bytes in the page:

    -(x | TARGET_PAGE_MASK)
  = -(x | -TARGET_PAGE_SIZE)
  = TARGET_PAGE_SIZE - (x & -TARGET_PAGE_SIZE)

We use this all over qemu.


r~


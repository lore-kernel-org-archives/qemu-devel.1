Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65376C4646B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 06:10:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BF9D2085A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 06:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF9D2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg18n-0002ms-GH
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 02:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41819)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hg164-00009G-2q
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 02:07:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hg163-0002nO-4y
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 02:07:56 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36858)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hg162-0002mX-W7
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 02:07:55 -0400
Received: by mail-pf1-f194.google.com with SMTP id r7so750168pfl.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 23:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=gMkqqZE5Gc5VDmbZ8EedR3Q0d0rIRldtlW1sU8A/ZSU=;
 b=YBPCw7EBMF6aExhojv0zLlV6qxIt/yGWYXuUX+PvGNzDu/HpPt7IO7Rru8EDfMs7hE
 fNF75cxybQKMk8Q0Ds597awTdQYGznlDF03ZFUj8IRx7it8woJ6MJpaUVBcKNo6ywCUl
 8e5FbwEigP49OJYnqDZMClxtlk697zxImU9n9M4JUi6mcIoSoV5U9Kz+BZL2jitWsEup
 qvChJKjjloDJ7JjrDuD7tel8IbjqwV5/o5CZaH3jiGK9uJmwbe/6++nsJwtggTgiNzBn
 hVX60hcgm7gCm5zs5WJg5ItuG0n4nY8w45BAjMhdk/EI18PS4RmfJgRvQJKjDYo705uA
 ydsg==
X-Gm-Message-State: APjAAAVXSyaV4iuP5Seg3aGqpEhFq2+/fo9PomMMckDjNrHLm8KlQ1uZ
 7PLydcuxAVl4AaqMg6Mzmoi/vQ==
X-Google-Smtp-Source: APXvYqzyUEOF0KjqBeit16NPwVVDqK09I9VYSxQagN4SyN+WqLi+lMpjIJJxPshQLv7N8qc77DEKOg==
X-Received: by 2002:a63:78c3:: with SMTP id t186mr1243506pgc.340.1561529273724; 
 Tue, 25 Jun 2019 23:07:53 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id t26sm14694754pgu.43.2019.06.25.23.07.53
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 25 Jun 2019 23:07:53 -0700 (PDT)
Date: Tue, 25 Jun 2019 23:07:53 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Jun 2019 22:37:11 PDT (-0700)
In-Reply-To: <8ec410f8-d2a0-69ef-e3b7-925ef09717df@linaro.org>
From: Palmer Dabbelt <palmer@sifive.com>
To: richard.henderson@linaro.org
Message-ID: <mhng-cc180208-aea2-48b3-b008-2adf3d59f150@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.194
Subject: Re: [Qemu-devel] [PATCH] atomic failures on qemu-system-riscv64
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
Cc: me@carlosedp.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 joel@sing.id.au, Alistair Francis <Alistair.Francis@wdc.com>, marco@decred.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Jun 2019 08:39:21 PDT (-0700), richard.henderson@linaro.org wrote:
> On 6/24/19 8:08 PM, Joel Sing wrote:
>> From 8ef31a2ce8ef1cbeee92995a0b2994f480e9bb6d Mon Sep 17 00:00:00 2001
>> From: Joel Sing <joel@sing.id.au>
>> Date: Tue, 25 Jun 2019 02:44:24 +1000
>> Subject: [PATCH] Clear load reservations on qemu riscv target
>>
>> This prevents a load reservation from being placed in one context/process,
>> then being used in another, resulting in an SC succeeding incorrectly and
>> breaking atomics.
>>
>> Signed-off-by: Joel Sing <joel@sing.id.au>
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>> +    /* Clear the load reservation - otherwise a reservation placed in one
>
> Excepting this line, which will fail checkpatch.pl.
> Needs to be formatted as
>
>     /*
>      * Clear the load...

Thanks.  I fixed that one up as I pulled the patch in.

>
>
> r~


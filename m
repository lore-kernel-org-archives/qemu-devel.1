Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77302C48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 08:33:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5612A20659
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 08:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5612A20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg3N7-0006jP-ID
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 04:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46934)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hg3LQ-0005qe-7Z
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 04:31:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hg3LP-0008Ei-6M
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 04:31:56 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36703)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hg3LP-0008Db-0F
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 04:31:55 -0400
Received: by mail-pf1-f194.google.com with SMTP id r7so970128pfl.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 01:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=xpkB33jinwT4ATtBFOv4jybsidxDTYPFps6HY6FF87s=;
 b=ix7MbgHlGnugY0cLQZQl/nOnda63dzGkZpbMmafgUjQUMglohdOxH4xC/SScJt3mRx
 CA+7pGEA4BjxJmoJNSxrNxydvRqfUmfNYg1CJ5BQceoQ2UrS3n5NwYoJWynJRezz1fBs
 j1J3MVFOHCKyRHpLZ60seCutVXnaET3/Ij00Ci5nQzJfS5Gkzo2UIj76P4IYFKkXKIlN
 yXKKRl2TXlzVyv3tnnWwpFbioPyb07957kdx0k0dLQWpH+atkT30WA/e2uzMshFxkceh
 6ynetu6KSt8aI1DJGuZmesgPtvBfEhD30GREBIYYIyMxVLNSsiCJK56YDUgUgr6B9jrs
 sQQw==
X-Gm-Message-State: APjAAAVjcPo8+VQ/GzUWlaW9/CqaGuEzO/wZ3eHOgms/d5FeOmvuF1JI
 6oE7q7K1HTAO6xa1Sj/xf4PTLA==
X-Google-Smtp-Source: APXvYqxgGnZV+BTlb+7uwRMI2mgKZEB0znw2F4ZiRPu6mPhxsRIXoV7k9cMaZx6+1qSuR7x6/Zzztw==
X-Received: by 2002:a63:2310:: with SMTP id j16mr1863717pgj.238.1561537913693; 
 Wed, 26 Jun 2019 01:31:53 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id h18sm11451962pfr.75.2019.06.26.01.31.52
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 26 Jun 2019 01:31:53 -0700 (PDT)
Date: Wed, 26 Jun 2019 01:31:53 -0700 (PDT)
X-Google-Original-Date: Wed, 26 Jun 2019 01:31:49 PDT (-0700)
In-Reply-To: <77792d70-b438-df37-6fe4-b5723f7da99d@linaro.org>
From: Palmer Dabbelt <palmer@sifive.com>
To: richard.henderson@linaro.org
Message-ID: <mhng-5938add3-68fb-43bb-b0cb-60fd330a8866@palmer-si-x1e>
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

On Wed, 26 Jun 2019 01:30:35 PDT (-0700), richard.henderson@linaro.org wrote:
> On 6/26/19 10:25 AM, Palmer Dabbelt wrote:
>>> You misunderstand.  The code is exactly correct as-is.  The alignment check
>>> happens implicitly as a part of the softmmu tlb resolution.
>>
>> Sorry, I thought you said it wasn't happening for linux-user?  If it happens
>> for both then we're good.
>
> Oh, that.  No, there's no better way for linux-user.  Though honestly, if we're
> going to fix this, it should be done in tcg/* rather than adding hacks within
> target/riscv.

OK, I'm fine punting on it for now.  If I ever get time to fix it up then we'll
attempt to do so genericly.

Thanks!


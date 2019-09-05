Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3C6C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 19:17:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 872362070C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 19:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872362070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5xGY-0002YT-Lv
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 15:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i5xFZ-00020P-4c
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 15:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i5xFX-0003UY-9r
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 15:16:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38574)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i5xFX-0003TL-0j
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 15:16:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id h195so2432772pfe.5
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 12:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=iDHG0BDVBB8epY4Vv2q/BqiF9tL6/6irQjK8zuxQYWY=;
 b=EU2OSl6iXV3q/ttoVDBF2pI9gSo+G3GP6+vavB3WUidDUrqDjLkHqnwMARhZIcUB98
 NtUixWfEwe+aKAsZuX7qyZWMPmcT3CsFCX97dskxnFVG5n1bdRe0ZWURCg3igatTUX5r
 t9oNiB5z6oXmX+YqN8i5skEj2vwLg6H5sPWW9Hbg4i2+mEWrygZRDJWDmU8VRRZ+1BRX
 te98XP4bWv2VT/HUN//TLXgYfP8ikUDg2burxHzlRxKygOBUSzinywFh13wJ/DJLIyLB
 UxprMZsTIcmE+gPqJBzzD/QlJrc/yL6ndQNMi9cK/zb/LnkBxy1lJ3bwWudgWqWq5WpR
 hUyg==
X-Gm-Message-State: APjAAAXTx+4gU9sUwN3SMzKO4ggZXaQceBRjUId03C8Hr6QKG7FdnWxd
 oKirIWF2IqvaAJ+hxDsUC4iepxWS2OA=
X-Google-Smtp-Source: APXvYqzUIHNrQ3B+aRSQp3DHHG9RDU1Vl8NoiwOCCZ5uKwCSLUhIbYybptv7XR4BSmFUQL50ytrk/A==
X-Received: by 2002:a62:ee0a:: with SMTP id e10mr5918604pfi.197.1567711013322; 
 Thu, 05 Sep 2019 12:16:53 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id k5sm2534680pjs.1.2019.09.05.12.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2019 12:16:52 -0700 (PDT)
Date: Thu, 05 Sep 2019 12:16:52 -0700 (PDT)
X-Google-Original-Date: Thu, 05 Sep 2019 12:16:43 PDT (-0700)
In-Reply-To: <CAEUhbmX-czUP9e9CcN69kjkw2VZJaRcEc+F0SVbRXYkaecv9MQ@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: bmeng.cn@gmail.com
Message-ID: <mhng-0cc8e543-568d-44a0-8408-1d2e439939e2@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.196
Subject: Re: [Qemu-devel] [PATCH v2] riscv: sifive_test: Add reset
 functionality
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 05 Sep 2019 08:57:44 PDT (-0700), bmeng.cn@gmail.com wrote:
> Hi Palmer,
>
> On Thu, Sep 5, 2019 at 11:55 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>>
>> This adds a reset opcode for sifive_test device to trigger a system
>> reset for testing purpose.
>>
>> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
>>
>> ---
>>
>> Changes in v2:
>> - fix build error in the "for-master" branch of Palmer's RISC-V repo
>>   that was rebased on QEMU master
>>
>>  hw/riscv/sifive_test.c         | 4 ++++
>>  include/hw/riscv/sifive_test.h | 3 ++-
>>  2 files changed, 6 insertions(+), 1 deletion(-)
>>
>
> Please drop the already applied v1 patch in your "for-master" branch
> and apply this v2.
>
> After you rebased the "for-master' branch, this patch no longer build
> any more due to changes in QEMU master.
>
> Regards,
> Bin

Thanks!


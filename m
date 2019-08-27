Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505C8C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 23:19:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26B24206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 23:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B24206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2kk9-00039d-98
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 19:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i2kjU-0002kH-Pu
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 19:18:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i2kjT-00009E-Jn
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 19:18:36 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45376)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i2kjT-00008r-EU
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 19:18:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id o13so284852pgp.12
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 16:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=+NdJXzop9xzMrXs45gCXpBCRNCnn/BP7yEKo856qVN8=;
 b=In9c1kdJMYEY3GLvO/CgNSvCVbvgK2kI02qJ3RgeQxV4t99N0yALgZebvjnfAfJWCI
 Ln7SUazZttwt4E4A13gK5Cj1iP8EJFJqUvRRlW84pLCCYSQU7C15nWfoRCCYkg307D/Z
 GW1E2Z5TNO/vpuSXhSJOKYgtqrC/RbWnUYvHCSUoZmTkJUo40cNz/SVLHEEnTolkrL9p
 IzsZgeXh6ItujE5SY2xyO07BUz0DgOaxMQgnlX/VRhqdEC+x3O6gjN5ujr91P4bUxIH0
 IboBl3KZP072ovdJ8zuR9JzhKr3MLUvTMKJLy9u6s/tcMUgLs1oHe3XlN9TOvrn1g4Kb
 L+mA==
X-Gm-Message-State: APjAAAWvMbJMUftv8joSQzSjdCyjuPRMeCOeED66H3eYSOcQWyuC+4aw
 P6JVlC9j+uEuWpWKr3+gMwSAog==
X-Google-Smtp-Source: APXvYqywcUq5YaCvD5t/iURf9viSeWS/h6sspDDjvgcBz8/6SQ5zT90k3b2unNnsps5xupgxbdrPyw==
X-Received: by 2002:a63:5048:: with SMTP id q8mr816030pgl.446.1566947913939;
 Tue, 27 Aug 2019 16:18:33 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id d2sm247111pjg.19.2019.08.27.16.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2019 16:18:33 -0700 (PDT)
Date: Tue, 27 Aug 2019 16:18:33 -0700 (PDT)
X-Google-Original-Date: Tue, 27 Aug 2019 16:18:25 PDT (-0700)
In-Reply-To: <CAEUhbmWacQtwTRYhCw6GwfGBabrWbe2Ss2JVCJ5XE7s3bVE-gA@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: bmeng.cn@gmail.com
Message-ID: <mhng-e6db993a-530d-4220-8345-59a8b642a5ac@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.193
Subject: Re: [Qemu-devel] [PATCH v4] riscv: hmp: Add a command to show
 virtual memory mappings
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
Cc: qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, dgilbert@redhat.com,
 qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 18 Aug 2019 22:59:54 PDT (-0700), bmeng.cn@gmail.com wrote:
> On Wed, Aug 14, 2019 at 11:33 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>>
>> This adds 'info mem' command for RISC-V, to show virtual memory
>> mappings that aids debugging.
>>
>> Rather than showing every valid PTE, the command compacts the
>> output by merging all contiguous physical address mappings into
>> one block and only shows the merged block mapping details.
>>
>> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
>>
>> ---
>>
>> Changes in v4:
>> - restore to v2, that does not print all harts's PTE, since we
>>   should switch to a cpu context via the 'cpu' command
>>
>> Changes in v3:
>> - print PTEs for all harts instead of just current hart
>>
>> Changes in v2:
>> - promote ppn to hwaddr when doing page table address calculation
>>
>>  hmp-commands-info.hx       |   2 +-
>>  target/riscv/Makefile.objs |   4 +
>>  target/riscv/monitor.c     | 229 +++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 234 insertions(+), 1 deletion(-)
>>  create mode 100644 target/riscv/monitor.c
>>
>
> Ping?
>
> What's the status of this patch?

This is in my patch queue (for-master on github).  I'm still a bit backed up on 
email, but when I get caught back up I'll send a PR.


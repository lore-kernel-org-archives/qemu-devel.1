Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF15EC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 18:47:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB4AF2168B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 18:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB4AF2168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Dq2-0000TA-Th
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 14:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33972)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i5Dp5-0008Tl-I8
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 14:46:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i5Dp4-0004Et-Ac
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 14:46:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36070)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i5Dp4-0004ED-5O
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 14:46:34 -0400
Received: by mail-pf1-f195.google.com with SMTP id y22so5688592pfr.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 11:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=lTBnmSOBqUKx2hxZLXlAr5Jk335lHE92K6mAhufuKb0=;
 b=T1DHM68qSFblDaPXngsCMFYIo1cJgyTsUg6zS3rZXo3kxGUuIdrgcgpaDXbrdS5XMz
 NZuSCZMdwEGNcMcURHdHbBko+bBIMtNeeK6AoIwdyb6cNBvKa9E/k/NG8YNfEYn7pMED
 TLAWwLzYro9iS+u57+LzI/54Sb+EVL3xc2G53BH20/mIztDYdcyZVgNwXNfnrtGDc0uz
 3w+NdYFh03gH4z+ESkqSIUBeu57CElT3LXchlayUmDMhPirRziQXpb2jEBQnNtDCkVXr
 1cZZnISVStuG1pwdf4l1AD4wMPUzeADiVX0Z8d6RSK005luUVWDISmivktqcbf3LNjao
 +xtg==
X-Gm-Message-State: APjAAAVGiwe3/6BWANSheeCs1dSeAlwoydy+hQQy93lGBPgznmlwuug8
 PZjTsc+siMXZSPM9djk0L+U40Q==
X-Google-Smtp-Source: APXvYqyCURPjGi+zSKb5TovgXT/uNBgY2uC1FxCLDolVYEDgiIujwtZjOMK3nvrGiePEoCtISw4miw==
X-Received: by 2002:a63:4a51:: with SMTP id j17mr31507143pgl.284.1567536392250; 
 Tue, 03 Sep 2019 11:46:32 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id r23sm272493pjo.22.2019.09.03.11.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 11:46:31 -0700 (PDT)
Date: Tue, 03 Sep 2019 11:46:31 -0700 (PDT)
X-Google-Original-Date: Tue, 03 Sep 2019 10:35:56 PDT (-0700)
In-Reply-To: <CAEUhbmV5fWqzPcdWW52n7DTczTtoLfbmE0HhLCz1jsgcNbLwRA@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: bmeng.cn@gmail.com
Message-ID: <mhng-255d26e8-02dd-4acb-8b8f-a5e35aabd6c4@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.195
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

On Tue, 27 Aug 2019 18:31:18 PDT (-0700), bmeng.cn@gmail.com wrote:
> Hi Palmer,
>
> On Wed, Aug 28, 2019 at 7:18 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> On Sun, 18 Aug 2019 22:59:54 PDT (-0700), bmeng.cn@gmail.com wrote:
>> > On Wed, Aug 14, 2019 at 11:33 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>> >>
>> >> This adds 'info mem' command for RISC-V, to show virtual memory
>> >> mappings that aids debugging.
>> >>
>> >> Rather than showing every valid PTE, the command compacts the
>> >> output by merging all contiguous physical address mappings into
>> >> one block and only shows the merged block mapping details.
>> >>
>> >> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>> >> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> >> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
>> >>
>> >> ---
>> >>
>> >> Changes in v4:
>> >> - restore to v2, that does not print all harts's PTE, since we
>> >>   should switch to a cpu context via the 'cpu' command
>> >>
>> >> Changes in v3:
>> >> - print PTEs for all harts instead of just current hart
>> >>
>> >> Changes in v2:
>> >> - promote ppn to hwaddr when doing page table address calculation
>> >>
>> >>  hmp-commands-info.hx       |   2 +-
>> >>  target/riscv/Makefile.objs |   4 +
>> >>  target/riscv/monitor.c     | 229 +++++++++++++++++++++++++++++++++++++++++++++
>> >>  3 files changed, 234 insertions(+), 1 deletion(-)
>> >>  create mode 100644 target/riscv/monitor.c
>> >>
>> >
>> > Ping?
>> >
>> > What's the status of this patch?
>>
>> This is in my patch queue (for-master on github).  I'm still a bit backed up on
>> email, but when I get caught back up I'll send a PR.
>
> I double checked your git repo, and found you applied an older version
> of this patch.
>
> Please drop that, and apply this v4 one.
> http://patchwork.ozlabs.org/patch/1147104/

Sorry about that, it should be fixed now.


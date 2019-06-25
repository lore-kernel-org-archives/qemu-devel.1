Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58FAC48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:22:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9128A214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9128A214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58376 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfiaS-0002Jt-RM
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 06:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35128)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hfiYc-0000JE-Aw
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:20:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hfiYa-00032y-F9
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:20:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33829)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hfiYa-00032F-9R
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:20:08 -0400
Received: by mail-pl1-f195.google.com with SMTP id i2so8598413plt.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 03:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=hVOzHgObz/WAB1ABY7SiVI5U/KHR8XjQBJa5AUD1T4Y=;
 b=YPIxqHZ+02k99E+ok8mFDqEORKQh/ok+xDnK0mmODvN8HqjX69o3CDRo5TVFGHAePv
 1fasKGe7gX7qq9Zw6N25WmTJUWbqBPEyxgWvor1k0Vfj3rxE2+Z2lIp5T382tt9yen5b
 YmcIDVXj12ZhwyQVjtR2s8GFWnFbk0MXwSPhmL/InWV9e5qTb21ZPA5Dkt0D48W6+Tew
 /tGFbFtugFqdniSXrCrIhXeq0+D5HltS/uym9FiUcXd0OEYEpHQZIsUOOjnGglTfhhIf
 WFcShOXPr9/4Qs+XGUiZ1WUzbE8PZ3OEJKAPWsDnaYH20EmoLB3G9bElCCfaeKyy4H+4
 GnlQ==
X-Gm-Message-State: APjAAAX3aJmUObl0v3XmaRC0jGMgCwIWMVyK51KVNbg/VLQFKZ/aRqlm
 mmbT0p48d3nIh+0JlBDYZ7zEdsT1KAp31avM
X-Google-Smtp-Source: APXvYqz8V1r0oOEQKqYQIzbdGpZOU9uM3zP2w9wQjM2BRxIZc9HO+u7rebMKWnjF9uUFlvIFgbqo3g==
X-Received: by 2002:a17:902:9307:: with SMTP id
 bc7mr11505212plb.183.1561458006876; 
 Tue, 25 Jun 2019 03:20:06 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id c9sm14972729pfn.3.2019.06.25.03.20.06
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 25 Jun 2019 03:20:06 -0700 (PDT)
Date: Tue, 25 Jun 2019 03:20:06 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Jun 2019 03:15:42 PDT (-0700)
In-Reply-To: <cover.1561419713.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-d7c50a12-d355-4c7a-8c97-3952fda6b355@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.195
Subject: Re: [Qemu-devel] [PATCH v2 0/4] Miscellaneous patches from the
 RISC-V fork
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 24 Jun 2019 16:42:27 PDT (-0700), Alistair Francis wrote:
> This should be the last series bringing the patches from the RISC-V fork
> into mainline QEMU.
>
> v2:
>  - Add Wladimir's SOB line, after talking to them
>  - Allow c.andi to have a 0 immediate
>
> Dayeol Lee (1):
>   target/riscv: Fix PMP range boundary address bug
>
> Michael Clark (3):
>   disas/riscv: Disassemble reserved compressed encodings as illegal
>   disas/riscv: Fix `rdinstreth` constraint
>   target/riscv: Implement riscv_cpu_unassigned_access
>
>  disas/riscv.c             | 51 ++++++++++++++++++++++++++-------------
>  target/riscv/cpu.c        |  1 +
>  target/riscv/cpu.h        |  2 ++
>  target/riscv/cpu_helper.c | 16 ++++++++++++
>  target/riscv/pmp.c        |  2 +-
>  5 files changed, 54 insertions(+), 18 deletions(-)

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

1 and 4 were already in, so I'm leaving them towards the front of the queue.
The others are in now.

Thanks!


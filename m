Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBF1C31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 10:00:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C59FA21773
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 10:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C59FA21773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49764 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbj0q-0008Rt-Rz
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 06:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43370)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hbimr-0005vH-Jn
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hbimp-0001Ka-Gq
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:46:21 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45133)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hbimn-0001IM-NQ
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:46:18 -0400
Received: by mail-yw1-f68.google.com with SMTP id m16so812613ywh.12
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 02:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=cK4IHru9NjtoK1j7sPnIwHPmoDOk1U9/R6+MGUtxwxM=;
 b=f/tTjHfpmPH+Yka6PIuaqVEmEe0psAYwlsJSP8bw1kJaNYkZE7XDLNQgh+jVspT1x5
 /VKW3aZvpL3IKhD/PVtaQYBkfxxO2/jH21DcD6uCT026APxmMM9PC1m5tVq6l0kYss4E
 ALt5laHnfU9pf8GKa/EGTHR6C3tJiXX7Bf+A5f6gG4T55hj5cMLpdDKMxoHMy0bDKDrS
 GFLVB9lcBLm5PlfIQClk/QZ6GsAqlC1rjUim2OxgYfEHxecgSX3OrVqIQtgnWZG7EPi/
 Vz4h1k6Sfr3uvBfjyf/iIZNwLWPK9MKwlvmvEcnywEJLmwc8fetVCwMDKREo/1Qq43DH
 7T6Q==
X-Gm-Message-State: APjAAAWAEjZB+NzzfpKP97LqABjQxymofOb6efZ7U2x4CwZgdpG2bpYs
 PbJojsNCGFbRVqV+duajejc4mBkYlw5YKw==
X-Google-Smtp-Source: APXvYqwSxlAaD/UdXNQxiqJIeb1XUQ3SEVwE8D0U2XrWpwLqMcImTpWEULlQXDxLPzTsXCJyVB1qxw==
X-Received: by 2002:a81:3250:: with SMTP id y77mr37829602ywy.437.1560505575907; 
 Fri, 14 Jun 2019 02:46:15 -0700 (PDT)
Received: from localhost ([83.137.6.186])
 by smtp.gmail.com with ESMTPSA id j127sm642757ywe.32.2019.06.14.02.46.14
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 02:46:15 -0700 (PDT)
Date: Fri, 14 Jun 2019 02:46:15 -0700 (PDT)
X-Google-Original-Date: Fri, 14 Jun 2019 02:45:46 PDT (-0700)
In-Reply-To: <cover.1558131003.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-0be72427-39c4-40d8-b88d-d050ec1591bb@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.161.68
Subject: Re: [Qemu-devel] [PATCH v1 0/4] Miscellaneous patches from the
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

On Fri, 17 May 2019 15:10:56 PDT (-0700), Alistair Francis wrote:
> This should be the last series bringing the patches from the RISC-V fork
> into mainline QEMU.
>
> Dayeol Lee (1):
>   target/riscv: Fix PMP range boundary address bug
>
> Michael Clark (3):
>   disas/riscv: Disassemble reserved compressed encodings as illegal
>   disas/riscv: Fix `rdinstreth` constraint
>   target/riscv: Implement riscv_cpu_unassigned_access
>
>  disas/riscv.c             | 53 ++++++++++++++++++++++++++-------------
>  target/riscv/cpu.c        |  1 +
>  target/riscv/cpu.h        |  2 ++
>  target/riscv/cpu_helper.c | 16 ++++++++++++
>  target/riscv/pmp.c        |  2 +-
>  5 files changed, 55 insertions(+), 19 deletions(-)

There's some minor issues with two of these, but since they're all independent
I'm going to take the other two right now.

Thanks!


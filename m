Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFA2C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 13:45:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F72820863
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 13:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F72820863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7gS9-0003lJ-3M
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 09:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i7gR8-0002qT-Gp
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 09:44:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i7gR7-0001rw-CB
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 09:44:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36348)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i7gR7-0001ro-6n
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 09:44:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id y19so20384041wrd.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 06:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=y9npP439xdxmCG7GzT6XJIeofQhv6EpyJUjkj0mjnbA=;
 b=KCVo0PAMkVJ1J8fldMRYh5iV/Z7orIpLgLCm+F2IG64HNX/KIxR46j569eNjoSlJkR
 qi/mkuRcWscBBO9MjONUPMH9Hw2FdcMsueFn1LrKkdzqKy3fHvlVZNWax9v4cYywSkLZ
 oofW8k4XPDwUuD0pr7sBDE1f5Jp+00SgXNtXTGN8BpJQmSyi5CH/1jSxfU5x9ciaxm3j
 oDzbWiZsQ+qracGRwIYv4Sh5LtdHa0YtuYn8uM++Odlx/DLMuj1D/K+9mjNJo2l3mWRs
 6CZcNwOR60zRDs1rFnvbqxMVRPPuzwvIFcQUIy3N33YNWAmy2+9Nd40mOQzP+9xNQCyL
 c+XA==
X-Gm-Message-State: APjAAAUWsYAYDp+JC5IIRebtFws7rVo8SmM3GffbWUPKd47aqpyxVEKh
 JjEo9xZZjzj6rXdkG3WfTfK1g7MHO2ecWw==
X-Google-Smtp-Source: APXvYqxBKLmqkhroW1nQHv5wadRS0PbQpwCW3MqBAFUPq4+dxBM4h4Eyt6a8dXcoV0yuwHuiag2Q6A==
X-Received: by 2002:adf:e704:: with SMTP id c4mr27654647wrm.283.1568123039721; 
 Tue, 10 Sep 2019 06:43:59 -0700 (PDT)
Received: from localhost ([148.69.85.38])
 by smtp.gmail.com with ESMTPSA id o8sm2717120wmc.30.2019.09.10.06.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 06:43:59 -0700 (PDT)
Date: Tue, 10 Sep 2019 06:43:59 -0700 (PDT)
X-Google-Original-Date: Tue, 10 Sep 2019 06:16:54 PDT (-0700)
In-Reply-To: <008eba3fe3b65cc5d37a1ced51d3631b23bef330.1566603412.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-1d14dd22-e463-4adb-ae6a-2f1623260659@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v1 01/28] target/riscv: Add the Hypervisor
 extension
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
Cc: qemu-riscv@nongnu.org, Anup Patel <Anup.Patel@wdc.com>,
 qemu-devel@nongnu.org, Atish Patra <Atish.Patra@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Aug 2019 16:37:52 PDT (-0700), Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 124ed33ee4..7f54fb8c87 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -67,6 +67,7 @@
>  #define RVC RV('C')
>  #define RVS RV('S')
>  #define RVU RV('U')
> +#define RVH RV('H')
>
>  /* S extension denotes that Supervisor mode exists, however it is possible
>     to have a core that support S mode but does not have an MMU and there

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>


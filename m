Return-Path: <SRS0=QAbx=Z6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21172C43603
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 22:39:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEF0420637
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 22:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJoEzkbG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF0420637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ie5Cd-0005tO-2W
	for qemu-devel@archiver.kernel.org; Sun, 08 Dec 2019 17:38:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1ie5Bz-0005Qo-0e
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 17:38:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1ie5Bx-0003MG-U3
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 17:38:18 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35222)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1ie5Bx-0003Ei-Km
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 17:38:17 -0500
Received: by mail-pl1-x641.google.com with SMTP id s10so4967148plp.2
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2019 14:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=MnvBbRT5iVZH0+Nzu+hGknTgiT+FwnkKwwLBbL9Zn4g=;
 b=oJoEzkbGwyMIJYmVqOV2vuz/nVqn5wdKUiDyDWQnIBOMICxwbI9aDzJfCuB9Y5iz7A
 cYjrttcvemVXPD6YhJnYemHbQ/Naq7G9isQY0oR6+07H8S2b4eBvagZc9RclbtVo5Oxt
 EEtgMLcfs3J/3c7VT8SDTP1NT7EG5oWzUt6oghdywy2GuZgCnU0DBs9lHL3YueZxCnll
 opyw7vdw3nGJ0w3W/tQsa3eFJx47fu5QCfnzoGRI1NK5i0R/BNV9XbBvqda9vMcGJmJV
 RUEUm6WbjWXlqrwxY6MUbY7tVH+4k0/AzXb47fspet8I73nnbz2lmJO3yvHxVkHo66SO
 GwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=MnvBbRT5iVZH0+Nzu+hGknTgiT+FwnkKwwLBbL9Zn4g=;
 b=GhGQpJ2CGYtZnVUBxLijBGwNs3MEBWFoWLfOcsb826STqojVHz4TV6ZVtS1C2rWKzQ
 3yrFBM3vOVA1ihJUusF63CSW6SApx1dPwz7BnqHup3BUA56mntin4ETTc8d7I3+Rkpd4
 /WALx+oADiC6x5s40aJ3YGZR/9OZSx2nQRMJqqVDxKA49Ay/RFl2qkWSxhLfCYM86j4t
 Ss6Ynhdjr3S+DsYbh8kfK/qmjwKUYfoduw1Cy4DiQqpAY8zjoc0cF66LXu5OBbW5i/yW
 9HjT/Fp3PjZCe8TsNlCK5+0p8aLagRhYazpUT6jPWohx5PcsxEzGfB0ELGrOMV6oVI/B
 UKmA==
X-Gm-Message-State: APjAAAVhFa9zwz7ZeHscy8TsO4YVFngp2ajIsU+zYygtbRlghxtfVqKY
 108FJ72cESbfeql7dNavgbA=
X-Google-Smtp-Source: APXvYqyTH+955DDw+6USZnKhGT30ibfdBdfKpDWuHsUCEHkmZ+v1u36m47xK1OHv9GIbrg7P55OpWA==
X-Received: by 2002:a17:902:c58e:: with SMTP id
 p14mr26026826plx.202.1575844696307; 
 Sun, 08 Dec 2019 14:38:16 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id u2sm22210820pgc.19.2019.12.08.14.38.14
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 08 Dec 2019 14:38:15 -0800 (PST)
Date: Sun, 8 Dec 2019 14:38:14 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Michael Tretter <m.tretter@pengutronix.de>
Subject: Re: [PATCH 1/5] arm64: zynqmp: Add firmware DT node
Message-ID: <20191208223814.GA21260@roeck-us.net>
References: <20191018160735.15658-1-m.tretter@pengutronix.de>
 <20191018160735.15658-2-m.tretter@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018160735.15658-2-m.tretter@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Rajan Vaja <rajan.vaja@xilinx.com>, michal.simek@xilinx.com,
 qemu-devel@nongnu.org, Rajan Vaja <rajanv@xilinx.com>, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 18, 2019 at 06:07:31PM +0200, Michael Tretter wrote:
> From: Rajan Vaja <rajan.vaja@xilinx.com>
> 
> Add firmware DT node in ZynqMP device tree. This node
> uses bindings as per new firmware interface driver.
> 
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>

With this patch applied in the mainline kernel, the qemu xlnx-zcu102
emulation crashes (see below). Any idea what it might take to get
qemu back to working ?

Thanks,
Guenter

---
[   30.719268] ------------[ cut here ]------------
[   30.719403] kernel BUG at arch/arm64/kernel/traps.c:406!
[   30.719971] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[   30.720358] Modules linked in:
[   30.720741] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.4.0-13331-g9455d25f4e3b #1
[   30.720852] Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
[   30.721157] pstate: 00000005 (nzcv daif -PAN -UAO)
[   30.721261] pc : do_undefinstr+0x2f4/0x318
[   30.721336] lr : do_undefinstr+0x1fc/0x318
[   30.721410] sp : ffff80001003b930
[   30.721486] x29: ffff80001003b930 x28: ffff00007d178040
[   30.721597] x27: 0000000000000000 x26: ffff8000117d0514
[   30.721683] x25: ffff8000118c90d0 x24: 0000000000000000
[   30.721769] x23: 0000000040000005 x22: 00000000d4000003
[   30.721854] x21: ffff800011e1c850 x20: ffff80001003b990
[   30.721940] x19: ffff800011e0fa08 x18: 0000000000000001
[   30.722025] x17: ffff800010c0f1d8 x16: ffff800010c11fb8
[   30.722111] x15: ffffffffffffffff x14: ffffffffffffffff
[   30.722196] x13: 0000000000000018 x12: 0101010101010101
[   30.722281] x11: 0000000000000000 x10: 00000000628e21fa
[   30.722384] x9 : ffff00007d178858 x8 : ffff00007d178880
[   30.722471] x7 : ffff80001003b8b0 x6 : 0000000000000001
[   30.722560] x5 : 0000000000000001 x4 : 0000000000000001
[   30.722646] x3 : 0000000000000000 x2 : 00000000000174b1
[   30.722730] x1 : ffff00007d178040 x0 : 0000000040000005
[   30.722913] Call trace:
[   30.722993]  do_undefinstr+0x2f4/0x318
[   30.723070]  el1_sync_handler+0xb0/0x108
[   30.723138]  el1_sync+0x7c/0x100
[   30.723201]  __arm_smccc_smc+0x0/0x2c
[   30.723272]  zynqmp_pm_get_api_version.part.1+0x40/0x68
[   30.723352]  zynqmp_firmware_probe+0xbc/0x298


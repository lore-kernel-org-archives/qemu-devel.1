Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B4FC4740C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 16:22:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69594207FC
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 16:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69594207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7MQS-0005PL-IP
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 12:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i7MPT-0004b7-9N
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 12:21:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i7MPR-0008VN-Vx
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 12:20:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56034)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i7MPR-0008Uz-QI
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 12:20:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id g207so236969wmg.5
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 09:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=k8mmStJgxO3xH5XM/EhqR2y7Ns9lt8r0g1sa9/rZBUg=;
 b=jlzjrfi3vyYDds3Qv4ot8VJOPLA//YOStR3RUvafF1OHXN+UPawt0eNuD6ozw8y6Lz
 HDP9anM5me2ZxvJI9Zos7zJKvVDmIZwp2DERY/HE7yFMJZjRECiGPG5sxLQCjMQVY4hK
 Y0BLjV5Lg4YRqTdA68hS8RNJmXPzSFcNBTijFz24ep5VGxaSWFjZcO+ldeEDF77XPPC6
 lQUJbdYhkYI18J/q2RfHo4h+wc0AvIdqOEml7Mc4kWbtIb4CnVT+gJQwqf7kMbFkNlLh
 pP8eYNnmEpl38CShjc4xJGkyUwaN0KVvRHvlNWgxIryrVY97lQoFg+djt5r1CjVrcoo7
 FM5g==
X-Gm-Message-State: APjAAAWGxWNJD8H/I3i0Ug4V/uF+uFpj+tsZ6yCKZOGVGcFNsIrAtY8n
 0PzmVq50oseS628KY5QfuCw3pg==
X-Google-Smtp-Source: APXvYqyifi14asoSzTSN6pXgMYqAaLVV5RvcSrD66Avro2MCWiq//8PwEdLO0+SKIJlrx5bUyneMgg==
X-Received: by 2002:a1c:a8d8:: with SMTP id r207mr48378wme.135.1568046055942; 
 Mon, 09 Sep 2019 09:20:55 -0700 (PDT)
Received: from localhost ([148.69.85.38])
 by smtp.gmail.com with ESMTPSA id z1sm24856457wre.40.2019.09.09.09.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2019 09:20:55 -0700 (PDT)
Date: Mon, 09 Sep 2019 09:20:55 -0700 (PDT)
X-Google-Original-Date: Mon, 09 Sep 2019 09:04:19 PDT (-0700)
In-Reply-To: <1567786819-22142-2-git-send-email-bmeng.cn@gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: bmeng.cn@gmail.com
Message-ID: <mhng-8a13e03d-e64a-46e3-bdb8-e2649b13cfb2@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v8 01/32] riscv: hw: Remove duplicated
 "hw/hw.h" inclusion
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
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 06 Sep 2019 09:19:48 PDT (-0700), bmeng.cn@gmail.com wrote:
> Commit a27bd6c779ba ("Include hw/qdev-properties.h less") wrongly
> added "hw/hw.h" to sifive_prci.c and sifive_test.c.
>
> Another inclusion of "hw/hw.h" was later added via
> commit 650d103d3ea9 ("Include hw/hw.h exactly where needed"), that
> resulted in duplicated inclusion of "hw/hw.h".
>
> Fixes: a27bd6c779ba ("Include hw/qdev-properties.h less")
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>
> ---
>
> Changes in v8:
> - newly included in v8 to ease patch inter dependencies
>
>  hw/riscv/sifive_prci.c | 1 -
>  hw/riscv/sifive_test.c | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/hw/riscv/sifive_prci.c b/hw/riscv/sifive_prci.c
> index 9837b61..562bc3d 100644
> --- a/hw/riscv/sifive_prci.c
> +++ b/hw/riscv/sifive_prci.c
> @@ -19,7 +19,6 @@
>   */
>
>  #include "qemu/osdep.h"
> -#include "hw/hw.h"
>  #include "hw/sysbus.h"
>  #include "qemu/module.h"
>  #include "target/riscv/cpu.h"
> diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
> index afbb3aa..3a14f9f 100644
> --- a/hw/riscv/sifive_test.c
> +++ b/hw/riscv/sifive_test.c
> @@ -19,7 +19,6 @@
>   */
>
>  #include "qemu/osdep.h"
> -#include "hw/hw.h"
>  #include "hw/sysbus.h"
>  #include "qemu/module.h"
>  #include "target/riscv/cpu.h"

Revieweb-by: Palmer Dabbelt <palmer@sifive.com>


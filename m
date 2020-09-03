Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C3AC2BB84
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 04:44:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04BA7207EA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 04:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agmbQmxq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04BA7207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDh70-0007vX-7F
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 00:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kDh60-0007Ty-MV
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 00:43:36 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a]:43607)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kDh5z-00086y-2z
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 00:43:36 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id p6so1229213ybk.10
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 21:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=2djIB4kDj7ywt7/Wqf/DNOjU6mViH+jHcBZSadgNrr0=;
 b=agmbQmxqSKZ2m5gDgZ7y7jAgs2sFHLekgV0kTUxbz8xk+IEEQ6jidO0qOPCVTLjO1f
 MRgrUIdZxymuVV1A4qjAilzlwVsx26eVWC5OEnaIa+cncGOlGMbOxzETj97sTu2eijuE
 DPCsOJ5ZtMiHJKYwsL7VWPmGR6Sft5gciX1sM684NIUgyKpV5xSrtXRUYp6mR/ixznXc
 M13lGwIGhJUKX7vQDqq84JxAgy6ZcJFCXIUjG1j57woCaCM68o/E9Lixd/4SEXc0Gem2
 WY/BLKLu8NhFxetknJvHQV76RUt2afFGeFACxSW1ZjtnyD8Z9zR2bIHlJRBaGLPPSxq5
 Qg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=2djIB4kDj7ywt7/Wqf/DNOjU6mViH+jHcBZSadgNrr0=;
 b=akWsjsqhIs0LoiGFhpDenuIZCuTE+jWWIf4MmEq5h5puTTKUbR1QHvtmGpVdaueLny
 t2w1OCK0+MiGJNdzVBoWDSJ9c5lv7Y1dpXOPjv2GAZtWFGnDMfk50B9zGfFr+tfcYwWX
 ur30SjFWiw4yZ6UQclYyaJWASCpjKbcNUGNGRrGo0h2IjtTsTy1G3E/wNACcecU0T3jH
 CPAbOY/rgyzJmfaMGXm3BwsxEXKbFECIQ+e54zlQ02VRmXBtk/1dpounDKH9o0WGiiOD
 vAiSO9FuAXCcJl87b26KLbqmZ25hiEQYwkj7hsGfUL2/O1KOvLjiweQThLCsPul1Q6zW
 2+9w==
X-Gm-Message-State: AOAM530b6phG58smgocI9v+okmbw6b1w/hSLAQlHi6vfIm0l9R19tvT9
 2WTcJZ+fHwrKfqM5Mwz/YJkojxwaKeAbD+XWq0k=
X-Google-Smtp-Source: ABdhPJyIvAN+Jq+z5pF3QACzd9Wnvk89UjRX3j+wed//822Bj/yqLkICf16NLWgBdvEB161bkof7MjqoLxoxxg1NK54=
X-Received: by 2002:a25:d946:: with SMTP id q67mr157861ybg.517.1599108213648; 
 Wed, 02 Sep 2020 21:43:33 -0700 (PDT)
MIME-Version: 1.0
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 3 Sep 2020 12:43:22 +0800
Message-ID: <CAEUhbmUOtjEsQzUQZsARBcr9jjpEAu6Br8zozV8f8fQBxznFdg@mail.gmail.com>
Subject: meson: how to determine which directory applies to the c_args during
 build?
To: Paolo Bonzini <pbonzini@redhat.com>, 
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb2a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I want to move a RISC-V model from hw/riscv directory to hw/uart
directory. The C file includes "target/riscv/cpu.h", but it fails to
compile:

include/exec/cpu-defs.h:23:2: error: #error cpu.h included from common code
 #error cpu.h included from common code
  ^
In file included from include/exec/cpu-defs.h:29:0,
                 from target/riscv/cpu.h:25,

...

tcg/i386/tcg-target.h:140:42: error: attempt to use poisoned "TARGET_LONG_BITS"
 #define TCG_TARGET_HAS_extrl_i64_i32    (TARGET_LONG_BITS == 32)
                                          ^
tcg/i386/tcg-target.h:141:42: error: attempt to use poisoned "TARGET_LONG_BITS"
 #define TCG_TARGET_HAS_extrh_i64_i32    (TARGET_LONG_BITS == 32)
                                          ^

It seems to me that when building hw/char directory NEED_CPU_H is not
defined. However when building hw/riscv and hw/intc NEED_CPU_H is
defined. I see NEED_CPU_H is defined in c_args in meson.build:

  c_args = ['-DNEED_CPU_H',
            '-DCONFIG_TARGET="@0@-config-target.h"'.format(target),
            '-DCONFIG_DEVICES="@0@-config-devices.h"'.format(target)]

Currently codes in hw/riscv and hw/intc have the "target/riscv/cpu.h"
inclusion but they do build fine. This seems to me that c_args applies
to hw/riscv and hw/intc directory but not hw/char. I also tried other
directories like hw/dma and it didn't work either.

I have no clue where to control c_args to build sub-directories. Any
suggestions?

Regards,
Bin


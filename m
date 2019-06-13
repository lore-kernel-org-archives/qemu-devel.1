Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240B2C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:26:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0097F20679
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0097F20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43458 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbUQX-0000uv-7x
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 14:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50709)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hbSeC-0004Gp-KU
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:32:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hbSYR-00022p-3c
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:26:24 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:56845)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hbSYP-0001om-3o
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:26:22 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MUGqT-1i1Tsf1xMh-00RFzG; Thu, 13 Jun 2019 18:26:18 +0200
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190519201953.20161-1-richard.henderson@linaro.org>
 <20190519201953.20161-4-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a70a685f-ba8d-77c9-8e93-25779bca9fa8@vivier.eu>
Date: Thu, 13 Jun 2019 18:26:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190519201953.20161-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JRcYZ/UGZGaJNMgaIsc7tOZwm5m+pRp6G1dJRGBzd1BB1zbul+l
 NBnOsEJLmDHQfIsFhk5eSUApXCOvfEKg1Pl9AtfrS5Q0zvHDI41z3jFVrEJN17HH3sJ1b0v
 KaA82AeCM7B04DLer9T8hzfw9zK3dqFrLxNCmXMDuXTwGCWU7IcceWqaKf5mSHLO1O4skfK
 q4s2pXTP/bmD/deBAd3+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0KDYBwClQqs=:H1ZfSeZHZozz2t6p3bpp+E
 z/Hsxj0BfsGyXAiY7Bii6NNXLm8BNKHAr4uvVCFH2H4PAYlV0gSGlmFv8WgVLhTTI17PUu8Wu
 Gek1IQpW0cPkdJ0Q0xcAXUh9TrTCBMoUMeyHIq3XJc6ibPUv4K6O9ImbatvoQ9RXWyMEvilFk
 etxTDQksN75VrioM5jxIgv4Pa0UI7S5WiUdsJb718bUhmLjJmYVlQqB34+QTKcCC4XT3l72Re
 I002LMwHLK0/g4/IuxxMZNhGYNStNCO/+ZIGRtRJ5QfAeJKUQ+EyrO4mM3XE6Kvm566NybEWg
 AeOuHqVpEUMJdk2ubhFTtoVh2jJdsfIYumgp0A+KiKKQKXWa8IQyNy7UZ2b5m13NIwpCKCSO6
 F6qJOw0h++jJbsd+tQOZVpHllrIITt3VW/iA9t4kxYy4ndGyrSL8ZV6F6aADzmoGCBbq3wDPH
 pCGKaFKf+AnlzrylqRoSCxlMK4h45XjR54f0NrXSJv4kkmmp/XbwAX9xWbNnEv0V2SDkZG6tD
 JTSqXJCTlJFycoWo8MgjsNXOKgkDF/N/z3LQjaVKDau6JWbZhKRlBbw635gpbQ8iFVwQhJ7D0
 6CVS0qBzbkY1ZXBM1froqaKX5tY3bhThST0rxgT/j5UDN1hmDgDiXSHZjKg5Cddet7TMeghmC
 5tXlgTVzkcR+qIrIIzhD7QSZfvbR27GabDHx6WVkQtQEPFSpSpqZI0u3YTSDpEq+ePnUXQLS1
 l2dkgn5uKergbz/RDMdi9n8wglMCzUjs9snbiTqx7YzFafRPSEqprKs/M3I=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: Re: [Qemu-devel] [PATCH 03/13] linux-user: Introduce
 cpu_clone_regs_parent
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 19/05/2019 à 22:19, Richard Henderson a écrit :
> Add an empty inline function for each target, and invoke it
> from the proper places.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/aarch64/target_cpu.h    | 4 ++++
>  linux-user/alpha/target_cpu.h      | 4 ++++
>  linux-user/arm/target_cpu.h        | 4 ++++
>  linux-user/cris/target_cpu.h       | 4 ++++
>  linux-user/hppa/target_cpu.h       | 4 ++++
>  linux-user/i386/target_cpu.h       | 4 ++++
>  linux-user/m68k/target_cpu.h       | 4 ++++
>  linux-user/microblaze/target_cpu.h | 4 ++++
>  linux-user/mips/target_cpu.h       | 4 ++++
>  linux-user/nios2/target_cpu.h      | 4 ++++
>  linux-user/openrisc/target_cpu.h   | 4 ++++
>  linux-user/ppc/target_cpu.h        | 4 ++++
>  linux-user/riscv/target_cpu.h      | 4 ++++
>  linux-user/s390x/target_cpu.h      | 4 ++++
>  linux-user/sh4/target_cpu.h        | 4 ++++
>  linux-user/sparc/target_cpu.h      | 4 ++++
>  linux-user/tilegx/target_cpu.h     | 4 ++++
>  linux-user/xtensa/target_cpu.h     | 4 ++++
>  linux-user/syscall.c               | 2 ++
>  19 files changed, 74 insertions(+)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


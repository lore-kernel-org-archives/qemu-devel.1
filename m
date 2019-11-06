Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12809C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:46:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D875D20663
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D875D20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSMZc-0004W5-0m
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 09:46:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iSMYc-0003ci-02
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:45:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iSMYa-0001bP-Ns
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:45:13 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:53611)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iSMYa-0001YH-Eg
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:45:12 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MiJEc-1hxxTv05lW-00fVtA; Wed, 06 Nov 2019 15:45:09 +0100
Subject: Re: [PATCH v3 00/12] linux-user sparc fixes
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191106113318.10226-1-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2b85d454-67ae-aa6d-091e-fbe68fdde26b@vivier.eu>
Date: Wed, 6 Nov 2019 15:45:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191106113318.10226-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ja+5qPJA0GMUX95IVOa9tEVV3jpFXI2AoPxzpmyecUKYS3RyXAt
 EgvtVIdhyQgeWjfyu7isj37aQw0/x+AIaYvZMxevzDigsUsMw+6P7t7nfZG+Q/s8UZGO3RT
 cuxW57bgD1h7Y3RSfLdk4S5f5pQhQtz5sPvfcRRqvig88NCWE639SRvYAHq9OiznL1w8JJa
 FOHMKkjNC8iP2U65Xz0gQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WpAxNRDqZCk=:nuVyRYfhcW24KJiB1HjxGb
 Vf/jcMDci5LXeQLJACmayG8P69UxoyNykcYmkqozI3updi40IHdj8JFNYMVC1Z5LyAQIv0Rzq
 L8gYWEQPrGm08MDZSj/c/brC51aWa+1H45rVw6iLhzIRGnFoCotD7lBeo+lcVoBWxQoCZR+eP
 R36HpnOeZ2VOaczwepSX9LoqQ6e5FqtQaNtCwir8DaskhW8ND0nPp6kuOsZxA1F+VsAjBz+H7
 HnW9I8frQSKC/5kQ5weEOAhJn2J0Vs1MlgaaEqVjHH0JMB2X8eO+x3CIkDil428WyC0Ler9U8
 n/wML+kCyDaIQQ3oH+xxZnRHmb2dyMPobSywYEdMypFIV1zT0cThrBSNGrgxFS9pQ5GrjjCVE
 DKIpzZCRfQkdtN8iBxPqEO5HA7gie5JrmXRIsEo9WAM2VXBebIg9RbDPIdlmrKt6uuD4hv013
 I50QOpeaC0p+EbED1fCYLuVNPxTNOcmZQUZvzmkKm9YXkBM+CFAgl143Mh6U0cME1hPPM91ZY
 ohDcItVXbI0+3zJu/Z/wq65GzeSxvkEFHkp0dnVfw6u09euT94sDb7eWcVl36K/NTsh5WG57a
 dpDuqUr1KUzadHfo/1iADecooBMZgG+26RqG+OJiagfFkSnEt0M05Syhi+S5D9f8Ek44moGo4
 fec+sJ0iedzGaIv4anf0rrOZhdaq5cdAYLrJdF2bHxI3lFRK+IR81DAYCxQxtqEzHrdrPL0SR
 eMhnxx1LJ/NkHsxvHkwgcg7/Wto116T9sCsvzAiNP2vpBpH99kfq/xyBLWtyvG8n5vJRPsnOX
 mLovNbS5TjI83zUaHzVA/i0hlesnF4boSaoL8LPP1YaF16MI6k3Tr68eRxTbjENmvd0p4wZi+
 26KTNFzU6T1Vx8wOfbIA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.187
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

Le 06/11/2019 à 12:33, Richard Henderson a écrit :
> Changes in v3:
>   * Fix checkpatch errors in patches 5 and 8.
>     There's lots more style errors left to clean up in
>     these files, but this is enough for now.

I've updated my pull request with this series in place of the previous one.

Thanks,
Laurent

> 
> r~
> 
> 
> Richard Henderson (12):
>   scripts/qemu-binfmt-conf: Update for sparc64
>   tests/tcg/multiarch/linux-test: Fix error check for shmat
>   target/sparc: Define an enumeration for accessing env->regwptr
>   linux-user/sparc: Use WREG constants in sparc/target_cpu.h
>   linux-user/sparc: Begin using WREG constants in sparc/signal.c
>   linux-user/sparc: Use WREG_SP constant in sparc/signal.c
>   linux-user/sparc: Fix WREG usage in setup_frame
>   linux-user/sparc64: Fix target_signal_frame
>   linux-user: Rename cpu_clone_regs to cpu_clone_regs_child
>   linux-user: Introduce cpu_clone_regs_parent
>   linux-user/sparc: Fix cpu_clone_regs_*
>   linux-user/alpha: Set r20 secondary return value
> 
>  linux-user/aarch64/target_cpu.h    |   7 +-
>  linux-user/alpha/target_cpu.h      |  16 ++++-
>  linux-user/arm/target_cpu.h        |   7 +-
>  linux-user/cris/target_cpu.h       |   7 +-
>  linux-user/hppa/target_cpu.h       |   7 +-
>  linux-user/i386/target_cpu.h       |   7 +-
>  linux-user/m68k/target_cpu.h       |   7 +-
>  linux-user/microblaze/target_cpu.h |   7 +-
>  linux-user/mips/target_cpu.h       |   7 +-
>  linux-user/nios2/target_cpu.h      |   7 +-
>  linux-user/openrisc/target_cpu.h   |   8 ++-
>  linux-user/ppc/target_cpu.h        |   7 +-
>  linux-user/riscv/target_cpu.h      |   7 +-
>  linux-user/s390x/target_cpu.h      |   7 +-
>  linux-user/sh4/target_cpu.h        |   7 +-
>  linux-user/sparc/target_cpu.h      |  64 ++++++++++++------
>  linux-user/tilegx/target_cpu.h     |   7 +-
>  linux-user/xtensa/target_cpu.h     |   8 ++-
>  target/sparc/cpu.h                 |  33 ++++++++++
>  linux-user/sparc/signal.c          | 100 ++++++++++-------------------
>  linux-user/syscall.c               |   6 +-
>  tests/tcg/multiarch/linux-test.c   |   3 +-
>  scripts/qemu-binfmt-conf.sh        |   8 ++-
>  23 files changed, 238 insertions(+), 106 deletions(-)
> 



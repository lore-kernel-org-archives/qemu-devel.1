Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E051C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 22:23:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 201A42087E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 22:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 201A42087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS7F0-00030F-8h
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 17:23:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iS76C-0003ze-Sx
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 17:14:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iS76A-0003T0-Gz
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 17:14:52 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:45061)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iS769-0003RT-Sc
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 17:14:50 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MryCb-1i6kSB36Rh-00nuiX; Tue, 05 Nov 2019 23:14:38 +0100
Subject: Re: [PULL 00/13] Linux user for 4.2 patches
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <157299160056.27285.4050632174467978305@37313f22b938>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <bb76453c-684f-eb7f-f774-f8a8029a58a1@vivier.eu>
Date: Tue, 5 Nov 2019 23:14:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157299160056.27285.4050632174467978305@37313f22b938>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jg19SZGzGwBMwAfuDFZAi90+ypGbr94H5HRKXQ76iunaGxrNwvZ
 Zg9mahbHkpQF/t73Pp7/OwOftOjT3WCok1Vq6P0XK8//Cb6Uf8mHXIucwUp1x3CDspCV5bt
 aye8YjilKMyYEA/eJDn5NFj0iYQgDupYal33yRs+WRruv72bVTQFiuRRvCNi/LfBLWA+/Lg
 VIEhmn2FMBtk/h/VBlX2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cEAB3XX5ois=:D/E6l0GrMoJI9xhNwj2MBc
 OiDVi3nyv+B1QefwLHC5EuZ90uSI/VRaXLvA2dzTXOjY0JoDcaqYdTbAOVaCbkoMm8777xMLk
 eIcbrMXrvdwHTzqB1xt/1RZGEXsmx/rOR+VBk0MJTjnjQtEZJJ7qr/Gt62J8vDlJEXR+SMIzR
 1J8xy+1b6aP6dAyhSzXrHsAY+RmJhQ8NJ3AOvMPmgLGFf3UW7WUWygPJjlYOcP/WEXg3+6RfN
 PPOXCzIogbJ3H3GpQMjzV4OlRemn94RxTam1dXRxMGH4sqJpDAR6htM5usZryMinA3RPSq056
 u5gCp6FOn/SmmDUMowKzRih9KhlYNq+r+z8ybh1eTerwjFF8McyXPCWOOSAuuWEFcqoZuylRb
 uo/XYzho1iyFHPEndMKlaA7sTzi4aAw81xgRQ7QROzcr88kASVjPza39C9hC/snv3ghKgN01k
 Go+8r8WgZbPxf7lrKgPkroDebIKnPae3ju58IZVBDivkrcHSiHcSwbo1r5KqXVh5jIYtEFE6X
 dPDYBOrhhU4vtsOnGkS+/uSu8e2WibZDgf+fb+oD8KJ1UFmL/SlQZCnw+zMtqsBs2dXc6LfUp
 PmJNqHYxKgF9yqszhySL8ZE0oSV1AwVEWxKJws7AHn/zc7yXfvHN0ViSczO5Bx34rfyic0nxi
 6T+a6/MJnkwY5enrfpWcmzRnXbcTYMU4fdQosY8pgTvRxc8XCddnRLbSYwIxfVUKsn1WiSZIj
 ylBC+Hfd+zCq/al31urBZYhwmeJkeb1nDcJotySasauC0sMsgCvSnfjximyJSVpQfOnv1fw+Q
 TgKrmSHP+Kj2kuPvLa7I4rGqEEjLvdU9TsAh5tGvjVpefajY4kCI2Sou2wIaSZWK7fragLVHh
 RdS6fbgG0uPDBsUbmb0A==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.131
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
Cc: mark.cave-ayland@ilande.co.uk, riku.voipio@iki.fi, alex.bennee@linaro.org,
 atar4qemu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Richard,

could you update your series?

If you prefer to wait next release I can drop your series from the pull
request.

Thanks,
Laurent

Le 05/11/2019 à 23:06, no-reply@patchew.org a écrit :
> Patchew URL: https://patchew.org/QEMU/20191105181119.26779-1-laurent@vivier.eu/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Subject: [PULL 00/13] Linux user for 4.2 patches
> Type: series
> Message-id: 20191105181119.26779-1-laurent@vivier.eu
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> === TEST SCRIPT END ===
> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>    36609b4..412fbef  master     -> master
> Switched to a new branch 'test'
> 965f842 linux-user/alpha: Set r20 secondary return value
> a59ca3b linux-user/sparc: Fix cpu_clone_regs_*
> 046ba0d linux-user: Introduce cpu_clone_regs_parent
> 1afe1bc linux-user: Rename cpu_clone_regs to cpu_clone_regs_child
> 748db1e linux-user/sparc64: Fix target_signal_frame
> 2e90cc8 linux-user/sparc: Fix WREG usage in setup_frame
> 608f997 linux-user/sparc: Use WREG_SP constant in sparc/signal.c
> 279530b linux-user/sparc: Begin using WREG constants in sparc/signal.c
> 3d27837 linux-user/sparc: Use WREG constants in sparc/target_cpu.h
> b30437c target/sparc: Define an enumeration for accessing env->regwptr
> 128b52d tests/tcg/multiarch/linux-test: Fix error check for shmat
> e78b5ec scripts/qemu-binfmt-conf: Update for sparc64
> 5a6b0f4 linux-user: Support for NETLINK socket options
> 
> === OUTPUT BEGIN ===
> 1/13 Checking commit 5a6b0f46c670 (linux-user: Support for NETLINK socket options)
> 2/13 Checking commit e78b5ec2867e (scripts/qemu-binfmt-conf: Update for sparc64)
> WARNING: line over 80 characters
> #36: FILE: scripts/qemu-binfmt-conf.sh:41:
> +sparc64_magic='\x7fELF\x02\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x2b'
> 
> ERROR: line over 90 characters
> #37: FILE: scripts/qemu-binfmt-conf.sh:42:
> +sparc64_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
> 
> total: 1 errors, 1 warnings, 20 lines checked
> 
> Patch 2/13 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 3/13 Checking commit 128b52d81645 (tests/tcg/multiarch/linux-test: Fix error check for shmat)
> 4/13 Checking commit b30437c1b51f (target/sparc: Define an enumeration for accessing env->regwptr)
> 5/13 Checking commit 3d27837139f0 (linux-user/sparc: Use WREG constants in sparc/target_cpu.h)
> 6/13 Checking commit 279530b9caeb (linux-user/sparc: Begin using WREG constants in sparc/signal.c)
> ERROR: spaces required around that '+' (ctx:VxV)
> #52: FILE: linux-user/sparc/signal.c:151:
> +        __put_user(env->regwptr[WREG_O0 + i], &si->si_regs.u_regs[i+8]);
>                                                                     ^
> 
> ERROR: spaces required around that '+' (ctx:VxV)
> #124: FILE: linux-user/sparc/signal.c:290:
> +        __get_user(env->regwptr[i + WREG_O0], &sf->info.si_regs.u_regs[i+8]);
>                                                                          ^
> 
> ERROR: spaces required around that '+' (ctx:VxV)
> #171: FILE: linux-user/sparc/signal.c:460:
> +    w_addr = TARGET_STACK_BIAS+env->regwptr[WREG_O6];
>                                ^
> 
> ERROR: spaces required around that '+' (ctx:VxV)
> #206: FILE: linux-user/sparc/signal.c:563:
> +    w_addr = TARGET_STACK_BIAS+env->regwptr[WREG_O6];
>                                ^
> 
> total: 4 errors, 0 warnings, 175 lines checked
> 
> Patch 6/13 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 7/13 Checking commit 608f99725ea6 (linux-user/sparc: Use WREG_SP constant in sparc/signal.c)
> 8/13 Checking commit 2e90cc889f5a (linux-user/sparc: Fix WREG usage in setup_frame)
> 9/13 Checking commit 748db1e8856b (linux-user/sparc64: Fix target_signal_frame)
> ERROR: space prohibited between function name and open parenthesis '('
> #24: FILE: linux-user/sparc/signal.c:90:
> +    uint32_t            insns[2] __attribute__ ((aligned (8)));
> 
> total: 1 errors, 0 warnings, 16 lines checked
> 
> Patch 9/13 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 10/13 Checking commit 1afe1bce0919 (linux-user: Rename cpu_clone_regs to cpu_clone_regs_child)
> 11/13 Checking commit 046ba0d62866 (linux-user: Introduce cpu_clone_regs_parent)
> 12/13 Checking commit a59ca3b85381 (linux-user/sparc: Fix cpu_clone_regs_*)
> 13/13 Checking commit 965f842f57f6 (linux-user/alpha: Set r20 secondary return value)
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> The full log is available at
> http://patchew.org/logs/20191105181119.26779-1-laurent@vivier.eu/testing.checkpatch/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 



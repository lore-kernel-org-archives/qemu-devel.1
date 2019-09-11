Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863D0ECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:52:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C2AE21928
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C2AE21928
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7wU2-0000Au-S5
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 02:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7wEm-0000D9-RD
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:36:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7wEl-0008Q7-Bb
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:36:20 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:40311)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7wEl-0008Ph-3F
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:36:19 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M7NaW-1i2QSA18Oq-007nXi; Wed, 11 Sep 2019 08:36:06 +0200
To: qemu-devel@nongnu.org
References: <156817660596.15929.7268040999872181435@5dec9699b7de>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <0c08a0c6-7ff0-477d-2451-fbfa5967462c@vivier.eu>
Date: Wed, 11 Sep 2019 08:36:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <156817660596.15929.7268040999872181435@5dec9699b7de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EHm9iHzsFhjSB9BKYQQ+0Q7pSJuQd63AKokDc/HgYmpxpvE9OI/
 V90sqcl4avxkBKDcfS5hIs6Aw8sAU57MKR1lnj1iXhabGAk9LUhOqJETq0iDXqLOOyCaJoV
 vv9oxLh0SGWuqD/p0IHl2P5M6MKYoii/5tqcQZe232qE+ZasW64O+uWVMEkPRb/GFV9WUPE
 iVNQBDfNh9T3eGRLfyaAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i1wMzCjJ9vQ=:tPDqTDKqYJaUj+B5lc2hQj
 1PzGPNkG5HNSDHdRRitNq4X/wSya1ybkcww0bdnq73L0M60aDEnKh3KfV9w7+G3sAL/+loySo
 bmI8bwxXQPyPl9PrtkTUkTfhcilhq0V3rZWyl2zR0GnMpUABsZSDmI2FGnqqttUI/Nm55e2DF
 gwLbCbfcflYSUH65CRLznStMFhwkRQ9PiCarwE2+iImo9psxkQz/6fbhK3mvPuy91ahbg3tlG
 lO9/p7Pi+0ZzBpHNOCcqhad8o/UdF9EuMDvatZD5YiGS27+ThrSJG4U99dCLMQkMTRewQV6ey
 aIhEadeqCvRs0grRDkPTGyx5lLMQ0qT9KNvpsEJIPotu5OQD3BRfUQMypXrKIFf48gnV3apvC
 pgolG7bbio08dLsJfNYoHOzQUfKsQMV2uae0Iu6HFfYpLQEhVeSa0+V3EVHwg0CHX01IY/rvl
 SCCvfM6TYVczVawWvZvOdk24bjNVE72Cl+cZGhjK1Rpv44g8x2hZOyAD7xZzMfHzRubw12GeJ
 B/eh7n12UiLHM4goH8/puxVyXrEX+VTSNLCHu2MeFxz6/27vqYf16bsJmj4mhk5rlupvrWkRK
 TS1k7eUN9ncj6ERE2LuyhM9k7IkC2d1IDRDugtSywyYvWyj8M5Unzqp4XFKN1CUF2CWebiLqa
 dBT97iUcAMhtUcT2q3ymm93U3rEuGIqVhT0F3m3cc6R+R5ybVsHiF+TIeeTTC0MwLiai2OpBP
 mY3bVdy6PqYj2DIxEYbtSfcBhoLDAUYIlgYR1jlvjcPPo5PSTzh7XkTvaZ0gzzboqzCCDAgPo
 don7hW0xgCBo29BgaDJjgkkQRttqRCKYdxJ4IuCReaehwdk6yk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
Subject: Re: [Qemu-devel] [PULL 00/15] Linux user for 4.2 patches
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
Cc: jcmvbkbc@gmail.com, riku.voipio@iki.fi
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I'm going to resend with fixed author email.

Thanks,
Laurent

Le 11/09/2019 à 06:36, no-reply@patchew.org a écrit :
> Patchew URL: https://patchew.org/QEMU/20190910163600.19971-1-laurent@vivier.eu/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Subject: [Qemu-devel] [PULL 00/15] Linux user for 4.2 patches
> Message-id: 20190910163600.19971-1-laurent@vivier.eu
> Type: series
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
> Switched to a new branch 'test'
> 0c6c9e5 linux-user: Add support for FDRESET, FDRAWCMD, FDTWADDLE, and FDEJECT ioctls
> ce3aecc linux-user: Add support for FDMSGON and FDMSGOFF ioctls
> 319e02f linux-user: Add support for FDFLUSH ioctl
> 8045de2 linux-user: Add support for FIOGETOWN and FIOSETOWN ioctls
> 118d115 linux-user: Add support for RNDRESEEDCRNG ioctl
> 82964b0 linux-user: drop redundant handling of environment variables
> 92f5fa9 target/xtensa: linux-user: add call0 ABI support
> 5104972 linux-user: Support gdb 'qOffsets' query for ELF
> 77a0cb8 linux-user/arm: Adjust MAX_RESERVED_VA for M-profile
> 02a9b81 linux-user: Pass CPUState to MAX_RESERVED_VA
> 0202b63 linux-user: add memfd_create
> 400e2fc linux-user: fail and report on bad dfilter specs
> 0dca0e6 linux-user: erroneous fd_trans_unregister call
> 956504f linux-user: Add AT_HWCAP2 for aarch64-linux-user
> 597e409 linux-user: remove useless variable
> 
> === OUTPUT BEGIN ===
> 1/15 Checking commit 597e40971702 (linux-user: remove useless variable)
> 2/15 Checking commit 956504f4a868 (linux-user: Add AT_HWCAP2 for aarch64-linux-user)
> 3/15 Checking commit 0dca0e61ffd2 (linux-user: erroneous fd_trans_unregister call)
> ERROR: Author email address is mangled by the mailing list
> #2: 
> Author: Shu-Chun Weng via Qemu-devel <qemu-devel@nongnu.org>
> 
> total: 1 errors, 0 warnings, 7 lines checked
> 
> Patch 3/15 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 4/15 Checking commit 400e2fc8d4a6 (linux-user: fail and report on bad dfilter specs)
> 5/15 Checking commit 0202b6345153 (linux-user: add memfd_create)
> ERROR: Author email address is mangled by the mailing list
> #2: 
> Author: Shu-Chun Weng via Qemu-devel <qemu-devel@nongnu.org>
> 
> total: 1 errors, 0 warnings, 42 lines checked
> 
> Patch 5/15 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 6/15 Checking commit 02a9b81ed9b4 (linux-user: Pass CPUState to MAX_RESERVED_VA)
> 7/15 Checking commit 77a0cb85f843 (linux-user/arm: Adjust MAX_RESERVED_VA for M-profile)
> 8/15 Checking commit 5104972e7cc1 (linux-user: Support gdb 'qOffsets' query for ELF)
> ERROR: Author email address is mangled by the mailing list
> #2: 
> Author: Josh Kunz via Qemu-devel <qemu-devel@nongnu.org>
> 
> total: 1 errors, 0 warnings, 8 lines checked
> 
> Patch 8/15 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 9/15 Checking commit 92f5fa9f7033 (target/xtensa: linux-user: add call0 ABI support)
> 10/15 Checking commit 82964b06260c (linux-user: drop redundant handling of environment variables)
> 11/15 Checking commit 118d1152ad9f (linux-user: Add support for RNDRESEEDCRNG ioctl)
> 12/15 Checking commit 8045de2e8ca9 (linux-user: Add support for FIOGETOWN and FIOSETOWN ioctls)
> 13/15 Checking commit 319e02f144c9 (linux-user: Add support for FDFLUSH ioctl)
> 14/15 Checking commit ce3aeccc52df (linux-user: Add support for FDMSGON and FDMSGOFF ioctls)
> 15/15 Checking commit 0c6c9e504819 (linux-user: Add support for FDRESET, FDRAWCMD, FDTWADDLE, and FDEJECT ioctls)
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> The full log is available at
> http://patchew.org/logs/20190910163600.19971-1-laurent@vivier.eu/testing.checkpatch/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 



Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEC2C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:44:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 527BC21848
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 527BC21848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSNTe-00052g-Cb
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 10:44:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48547)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iSNT0-0004Ch-6H
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:43:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iSNSy-0007KY-P7
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:43:29 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:34507)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iSNSy-0007Jm-G5
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:43:28 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1Mbies-1hvmnl3hGQ-00dDnx; Wed, 06 Nov 2019 16:43:24 +0100
Subject: Re: [PATCH v3 00/12] linux-user sparc fixes
To: qemu-devel@nongnu.org, no-reply@patchew.org, richard.henderson@linaro.org
References: <157305231198.21358.3677677989885907371@37313f22b938>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8e467370-0e87-474a-842e-e904005f3094@vivier.eu>
Date: Wed, 6 Nov 2019 16:43:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157305231198.21358.3677677989885907371@37313f22b938>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:T3d+THaMrufnLRCOvFXXIqb+zfCMx+BdoEE1JCVGVzEFeSeDHKO
 FpnViUpHdvQGaH8jBpx0y98m2E5IjvFKrW6m1RWe9rEsTPlSLrVCiEBeGhr762TFd8MjhNA
 o2hE54/7AjHXa6pjnjBcLu28YOMLV7hwfrFSnS3wlLb9nXulhS9umXkGnZ8+UMI8+wx+0xm
 EJjXLCnaE8BY+qADYaQ7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1GD15+ZIAJ0=:KSgz7UTCZ8lyWkLSdVBeH9
 DSUEFZ70LPhvDQ2cUKr8/BO4MmeQ2nfSfLjkX+eT0RpWf3xK8cwuk28XNzLRKvkKizuVfP6qe
 5o8OR66uCpyCEMPOtCSNJ2zvKcY7x28mLly/ENXQ5lQpqPzkrtxyvlDqzDL8mv68E0lut6toI
 rrjiQHecvIUDWaIAvHBpCCbwH89U6FDbnIyht8wSNuQ4iDgU32u950rBsAOc1IyEEt5Y+7D1K
 TMoZWS+WNU+aOW7hDL0yo7jVAYrRnqbPfcIrwMGpcOo/nGt3jHmjvEF1uJRgr6qhG6xaUA3oL
 VRoPuHohWBLvuHl7YJ1XxU5Sxc7l2qpAP9zgR1CwMvMdXb2K1cKGKXS9x2GY3XJAx+ZSZ7G+j
 41WrzLQZr2H5rQ8DlBt9EHZTUqkVuIdcf4wlcrUBSaZmAhPssDrR1zmFTT3wpFV0DxkOsAi3I
 ii6LLA4DhHYk+HsCVyHa9yZ6NW3viLVTUUVRgKkG4apmiJqqhGqeNNnmFvsjlYIEQxHAHTxYs
 UUIuKzvZYDIbSGrNMPlSdgGLV0dQx932yinAMoNi5U6c+IZBN+7GFI0YoiNiWl1hHYYNUfZia
 DtS/GeH4z7aqDtharUuUSTxf2uoarih/47PO8Azypj5yisY/uyWCyQUGUZk99kX9iDmltTDzM
 /Jub16G1Bh3o/ygiAS2QKJbh34j5qVcfi7wnfd/0E0YJ0pJQq4oVTGxXzKcm2v3Vd+nZE6z2W
 QQdYy9Q4PCmO1BjVlUH5YSgI7DA0YKyuAHzcdDjioeGM0CsKBjeXLEaw1540NJjOj3KXRv2kr
 M2yMTC+ZqRaWKwutJGD+LkkyK9Xa0TgwKlksfxltS0XOhc9kHhKs9XM1p97SEh5aIXJdgj3qd
 3CqcAgPMyQn/3j9EBYFP8SVvbGVI/PR8YhpceDNTw=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.135
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

Le 06/11/2019 à 15:58, no-reply@patchew.org a écrit :
> Patchew URL: https://patchew.org/QEMU/20191106113318.10226-1-richard.henderson@linaro.org/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Subject: [PATCH v3 00/12] linux-user sparc fixes
> Type: series
> Message-id: 20191106113318.10226-1-richard.henderson@linaro.org
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
>  - [tag update]      patchew/20191106130309.6737-1-jandryuk@gmail.com -> patchew/20191106130309.6737-1-jandryuk@gmail.com
>  - [tag update]      patchew/20191106141424.27244-1-edgar.iglesias@gmail.com -> patchew/20191106141424.27244-1-edgar.iglesias@gmail.com
>  * [new tag]         patchew/20191106145127.23700-1-marcel.apfelbaum@gmail.com -> patchew/20191106145127.23700-1-marcel.apfelbaum@gmail.com
> Switched to a new branch 'test'
> 33486ee linux-user/alpha: Set r20 secondary return value
> 4c5f970 linux-user/sparc: Fix cpu_clone_regs_*
> 38c0642 linux-user: Introduce cpu_clone_regs_parent
> 8fd10b2 linux-user: Rename cpu_clone_regs to cpu_clone_regs_child
> 1c6ebcb linux-user/sparc64: Fix target_signal_frame
> b1257ef linux-user/sparc: Fix WREG usage in setup_frame
> 5f40252 linux-user/sparc: Use WREG_SP constant in sparc/signal.c
> 2e7ffe6 linux-user/sparc: Begin using WREG constants in sparc/signal.c
> b87f31db linux-user/sparc: Use WREG constants in sparc/target_cpu.h
> 08fdb43 target/sparc: Define an enumeration for accessing env->regwptr
> 7e876dd tests/tcg/multiarch/linux-test: Fix error check for shmat
> 4dae54d scripts/qemu-binfmt-conf: Update for sparc64
> 
> === OUTPUT BEGIN ===
> 1/12 Checking commit 4dae54d6afb3 (scripts/qemu-binfmt-conf: Update for sparc64)
> WARNING: line over 80 characters
> #36: FILE: scripts/qemu-binfmt-conf.sh:41:
> +sparc64_magic='\x7fELF\x02\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x2b'
> 
> ERROR: line over 90 characters
> #37: FILE: scripts/qemu-binfmt-conf.sh:42:
> +sparc64_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
> 

All magic and mask are like this in scripts/qemu-binfmt-conf.sh, these
errors can be ignored.

Thanks,
Laurent



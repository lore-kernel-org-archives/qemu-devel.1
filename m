Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC221C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 07:22:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B54C2133F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 07:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B54C2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hglDO-0006zE-RH
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 03:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47477)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hglCi-0006FX-TX
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 03:21:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hglCh-0002ZR-CY
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 03:21:52 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:56389)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hglCg-0002Xx-Cs
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 03:21:51 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MzR0i-1iT4QN28eG-00vQXj; Fri, 28 Jun 2019 09:21:31 +0200
To: qemu-devel@nongnu.org, aleksandar.markovic@rt-rk.com
References: <156166365360.6332.12789669195894130027@c4a48874b076>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <735eb279-4f0f-b033-6ee9-eac0262a099d@vivier.eu>
Date: Fri, 28 Jun 2019 09:21:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156166365360.6332.12789669195894130027@c4a48874b076>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wSaEImG7kvbA1a/fM3OObZuJeLA5R6z6qomZs0+02eoSHOznxRt
 oNO1DMMrh9JE2JMMI9589kMQnBQ93etRTsFDc5TXi6uWpgsjwyKpgsRcenC+HbDLdO/sTtG
 fuRFxepfYVXfYeAzz0qsq2WtcMlQ8aPlwU2hQXPrxIYEr1Yb1BvtSVnO1wMBbBd/amWzpU/
 B3TX85DXdu3PJmDLc+i9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UjouDfk/Ho8=:a54yAQZ6W4uWMcqxTexTdB
 RN+fuNly1VeYzWi0Z9qh+Hoh6vi7506JjtzVg9jPWe2MySRX5+s9NSA+czwZIfNJOIEyxMata
 uXWdX/EAyuS2Iqk6bvy8PIWxRjxTteLdwlqhZmUqchReYRMFk0z0hJrWukRVRloZ7iwjgfjty
 drfLaiqGL79Atzp72t460E6NnDJBjpkr5UaXys7FscUaTfBH6UaOccwrBnBh+NlumzGGY3bKK
 sBsNc9TMsFuo0OnSM/XNSTS5fOBJ0mL2XXRcaBvcY5WOU/yUR0m+ybaTTgbpimUmlK6Fv5Htx
 QkzbLBx69Hv2zwWdf6nAq0JS0ZpgAIr3qraIOdcqebptOA3mZrhjWkuMxrpcdV5y9FXkfubwD
 4CDR9OIBShxsfbKg4rje+ZFeXdcadXMUuay4ftmZF8SucFasUyXcixNuHBFkUPy6L/1JEN+XE
 i2EdNCmFPVGrmDDFFX2saoB31CME9tzCAKwjuqcPBJS0CH2ctY5Y3MulXjpqS2DWJhuQ8qAlv
 Hodf3RJaZgDpALBu4TV48yuAn/8c+vSFb/Ooa8flAR6AZEJZk+xSEx8GGPPHn39VgXPMnSORS
 of3BhlqPIV9+KOT/ZgQfWO0eJ1EvK5DkS6B0YCDt+hpVIW/V3y5D1LRpyg5Mr9NZ3DDZbRzt7
 N/cCQT6Sqv6TPo7K23viv3o67Fc72s5/PCHfgGQ+hZrsFmGqo8HQIrOmm0COz019oIIi6Xspv
 qICo90XkLqvSNyTrN62oFCceBV4goVMYajY9vBQX4eQXZqetIMp/u8kWNHQ=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
Subject: Re: [Qemu-devel] [PATCH v13 0/5] linux-user: A set of miscellaneous
 patches
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
Cc: amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 27/06/2019 à 21:27, no-reply@patchew.org a écrit :
> Patchew URL: https://patchew.org/QEMU/1561648298-18100-1-git-send-email-aleksandar.markovic@rt-rk.com/
> 
> 
> 
> Hi,
> 
> This series failed build test on s390x host. Please find the details below.
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> # Testing script will be invoked under the git checkout with
> # HEAD pointing to a commit that has the patches applied on top of "base"
> # branch
> set -e
> CC=$HOME/bin/cc
> INSTALL=$PWD/install
> BUILD=$PWD/build
> mkdir -p $BUILD $INSTALL
> SRC=$PWD
> cd $BUILD
> $SRC/configure --cc=$CC --prefix=$INSTALL
> make -j4
> # XXX: we need reliable clean up
> # make check -j4 V=1
> make install
> 
> echo
> echo "=== ENV ==="
> env
> 
> echo
> echo "=== PACKAGES ==="
> rpm -qa
> === TEST SCRIPT END ===
> 
>   CC      i386-linux-user/linux-user/uname.o
>   CCAS    i386-linux-user/linux-user/safe-syscall.o
>   CC      i386-linux-user/linux-user/i386/signal.o
> /var/tmp/patchew-tester-tmp-zqhqa95y/src/linux-user/syscall.c:323:16: error: conflicting types for ‘statx’
>   323 | _syscall5(int, statx, int, dirfd, const char *, pathname, int, flags,
>       |                ^~~~~
> /var/tmp/patchew-tester-tmp-zqhqa95y/src/linux-user/syscall.c:214:13: note: in definition of macro ‘_syscall5’
> 

This is a real error. To avoid this you can rename it to "sys_statx"
(see sys_gettid() for instance).

Thanks,
Laurent



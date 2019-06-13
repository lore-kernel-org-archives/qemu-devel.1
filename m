Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFC5C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:05:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B876207E0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B876207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43236 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbU6M-0002pe-Cr
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 14:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50415)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hbSeG-000430-4g
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hbSXM-0005TI-PN
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:25:17 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:40875)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hbSXM-0005NE-G2
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:25:16 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MjjGX-1iLTij22iB-00lGaN; Thu, 13 Jun 2019 18:25:14 +0200
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190519201953.20161-1-richard.henderson@linaro.org>
 <20190519201953.20161-3-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e16ffcf1-465c-ca67-1bb4-a6da399c7617@vivier.eu>
Date: Thu, 13 Jun 2019 18:25:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190519201953.20161-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:r/rPSMmiBfFv/8RAPhbxpLz9NABEWDm6iWmhT9JnyUiAtQnaDjM
 0vCTfnC4REfTVF2YPxAw+tkhNyHDpiqyWtcSn+NwTpy0BiuqPKbeThDRK1NAbOJvmhmuevj
 Uj8vlYcdW6HmSeSmf3FXm7LlHX5KhuDOLNgckGIvHSxfkyDX0Py+qyAWAdem6CFugHJOyJ1
 BKXzYjpEip4+qJV8m1xqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+vxOTRehgZg=:G87J6g7yxaYlwE2ulH/fRM
 fZtOkn4Q/+rLNb9wrBLBkZufese50pSZMyVFY5Q6GnVNyYi1gs6h7njWXxUpXJySfZM0l1q/b
 D5Y+E64clc8gAZX8+7XV33oi1XrtR/KQ2lgL68jd7YznbyBHLVbuj9p62K9LPQ19PDFpDzybL
 dAsOhj0Sokb+3xi/orluYbA+53V3ZA+vuA6bUaPZnhewQKCktD6ewupnENoKZ0RiBmhF6F6o3
 WnxA/Sye6Mtphd0LTXJFeruVjzW2WKu+RWUJ7awaJeqVw/KWZfMoI1pukNoly/1b/Gw8mggJc
 +PLTRJXJHDp45b2bqUlsRDSqwMjgXvgaU8b+exeQ7R13GtWhYmXtrclNYpZD8kOMGqk7g6M9h
 hok0YIrCT/6VgNGWr88uS1niFovLaRw9QrJiXpc6/D7BOHYNtmOQUWmV81MhOmSEJiuv8vzr5
 CTDDSbq7biHnDY2Vy8b9JmhloaCRDaGVmAnvmxwMVa5URbfWYf06Bz0jzgHcCvN1ojdl+5avY
 ge7Ga3zAzMvwPDgbKVTvZsJ4f3fGqUdSPfzenUs60rWqq0D0ePoc064ahigEjhMPMxhPYA2vS
 OoZP20JmCubbqtA0miJZKTxx+7B6ALa6OEP6bSfuz2M0Uq0jIxwsRrSoeq8O1d5aWRBbhKAhQ
 WGFdBqslHTmDwS4msu4/V8f2/CjHae8vrQcO+2lIC88ya5v68bRx+/o7RuNomNkz2gGEX4mkR
 22rnhvc8o1nrQrcr3i//Ri9Zej95hum2+y6uSVVRsKHNkd+z1xtTXCf4wbs=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: Re: [Qemu-devel] [PATCH 02/13] linux-user: Rename cpu_clone_regs to
 cpu_clone_regs_child
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
> We will need a target-specific hook for adjusting registers
> in the parent during clone.  To avoid confusion, rename the
> one we have to make it clear it affects the child.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/aarch64/target_cpu.h    | 2 +-
>  linux-user/alpha/target_cpu.h      | 2 +-
>  linux-user/arm/target_cpu.h        | 2 +-
>  linux-user/cris/target_cpu.h       | 2 +-
>  linux-user/hppa/target_cpu.h       | 2 +-
>  linux-user/i386/target_cpu.h       | 2 +-
>  linux-user/m68k/target_cpu.h       | 2 +-
>  linux-user/microblaze/target_cpu.h | 2 +-
>  linux-user/mips/target_cpu.h       | 2 +-
>  linux-user/nios2/target_cpu.h      | 2 +-
>  linux-user/openrisc/target_cpu.h   | 3 ++-
>  linux-user/ppc/target_cpu.h        | 2 +-
>  linux-user/riscv/target_cpu.h      | 2 +-
>  linux-user/s390x/target_cpu.h      | 2 +-
>  linux-user/sh4/target_cpu.h        | 2 +-
>  linux-user/sparc/target_cpu.h      | 2 +-
>  linux-user/tilegx/target_cpu.h     | 2 +-
>  linux-user/xtensa/target_cpu.h     | 3 ++-
>  linux-user/syscall.c               | 4 ++--
>  19 files changed, 22 insertions(+), 20 deletions(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>



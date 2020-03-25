Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445ADC54FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 16:11:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2052320409
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 16:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2052320409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH8cg-0006gN-6H
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 12:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jH8aH-0005q6-3R
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 12:08:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jH8aG-0002Af-0d
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 12:08:48 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:40291)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jH8aF-00028E-O0
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 12:08:47 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M3DeV-1jFmCX44bd-003h1L; Wed, 25 Mar 2020 17:08:45 +0100
To: Richard Henderson <richard.henderson@linaro.org>
References: <20200325075757.1959961-1-laurent@vivier.eu>
 <f0f1e6bf-155b-f5af-de22-5798fe82766e@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH] linux-user, configure: fix (again) syscall_nr.h
 dependencies cleanup
Message-ID: <165d45d4-d601-67fa-207e-41bb4df08864@vivier.eu>
Date: Wed, 25 Mar 2020 17:08:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <f0f1e6bf-155b-f5af-de22-5798fe82766e@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EIxgrKSp4GNKtpaK4ObR3o0bjSpaZzAYZEUwQt3lvJa6vZbC05z
 GyDFh9qkt4YO8UJm3ClyzDSj8e5MyFu+bUhHy8+KaCrQJemteqduXNxetLxVtG7gmSIgFlo
 OIr0n4E2XG0Q6YGpwY+PxRc0gq/JGNiN9JcxIMMDpV6koRvDc6jQLK2WOHYAfGjzqMFNkfc
 9HmpBKlXFk+y9ZPwsjIDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U/svpShiQRI=:FxjDTBeC79TXC3hA6AGRV8
 ccVXjv6wAOW8ikgcrr7v98/ZF8ffFjJisR6e4GzlGxruAaVOqqlmTetfrYDzDCf5iPNsHl9U7
 t9Ts4hdoUHV5US246UMCt26E+ua5J8PHHCaK7HyId9GKdEpSkdkIJ9gt6N8Wt54GCAbHL2X/f
 65mWX0t5DJOzWx1mXoECcqbs0RbygYXfuWvO+Arg2JjUzjVeIpsaI8GCau5Ly3VwYsCg/iL2O
 8yqGNPCkCYPLbsy1CJnJ0ciGRXiYC5Nb1m0XaOQjdu5eox28w/vfGMeaI0X487BcqGsAzNQJ/
 yBwVgoO5avtqATmM4O06sUbIA8+qjnJMrTYt2GX9RwrPZ1fUxt9tB2NxLsksy7ES5oAHSdtAV
 ykAFYPLW9hM+ttZw42rSnrLg2J7SKsG925yaT5Zr8q1frHOAvCE9/s1zZ2leX34c96NtFhgvS
 c/YuYSyKiAStZK7IAh9bXYctdspNmMuY31JstRGkv/XM5V7l/JzEzVG1umUy1QGidl6AdFydc
 R2zYpkR89ZVw+z4Os7789Ga8/Z08mkZWyEo+/3K18gQEq+M+6H7f63KKISmvHGAZd5INwXTBL
 Fj4Z8VnRCnz76vwoMt5TWWD7p1YB35TS1UthT0dJV+0efBIJPwSeyqkURnQVwTkG9ZtvfbZAN
 Nb1LEbap1Es5WorAXgJ8MVLA9wMigsL68zI+ufiKqX5Pie6NjwZZWwXNH8z75xvp3mlNp6tIg
 E9cEyoH012CWj+h3mMyeUpx2auuQYzoAMnV8kHfha561o8bNUFPlkEjPDSLdf09x7vNoNDGen
 DeZncuWFc85buEk0I0Ai+6Z94VAUZoRQ/K2ETqIUpalQbAcGITQugYsoALEhgN+EkgpxUGF
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 25/03/2020 à 17:01, Richard Henderson a écrit :
> On 3/25/20 12:57 AM, Laurent Vivier wrote:
>> This patch fixes two problems:
>> - it cleanups linux-user variants (for instance ppc64-linux-user
>>   and ppc64le-linux-user)
>> - it removes the .o file when it removes the .d file, otherwise the .o
>>   file is never updated
>>
>> Fixes: 5f29856b852d ("linux-user, configure: improve syscall_nr.h dependencies checking")
>> Fixes: 4d6a835dea47 ("linux-user: introduce parameters to generate syscall_nr.h")
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>  configure | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> I haven't been able to reproduce the same failure from master, but this looks
> right.
> 

To reproduce the failure (either the one with the vsyscalls or the one
with missing TARGET_NR_XXX define reported by dgilbert/imammedo on the
IRC), I did:

git checkout -f v4.2.0 && \
./build.sh reset && \
git checkout master && \
./build.sh

and build.sh is:
------8<------------------------------------------------------------------
SRC=$PWD
OBJ=$SRC/build
DIR=test-linux-user
TEST=/backup/linux-user-test-0.3

set -x
if [ "$1" = "reset" ] ; then
    (cd $OBJ && \
     rm -fr $DIR && \
     mkdir $DIR && \
     cd $DIR && \
     "$SRC/configure" '--cc=ccache gcc' '--enable-debug' '--static'
'--disable-system' '--disable-gnutls' '--disable-tools')
fi

make --output-sync -C $OBJ/$DIR -j 17 && \
make --output-sync -C $OBJ/$DIR -j check V=1 && \
make --output-sync BUILDDIR=$OBJ/$DIR -C $TEST test
------8<------------------------------------------------------------------

Thanks,
Laurent


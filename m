Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9431C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 11:23:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F2A4206BF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 11:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F2A4206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54678 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNbiR-000673-ND
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 07:23:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hNbhI-0005Tg-00
	for qemu-devel@nongnu.org; Mon, 06 May 2019 07:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hNbhG-00021H-UE
	for qemu-devel@nongnu.org; Mon, 06 May 2019 07:22:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hNbhG-00020p-MY
	for qemu-devel@nongnu.org; Mon, 06 May 2019 07:22:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E3CDDC057F4B;
	Mon,  6 May 2019 11:22:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B175F60A9F;
	Mon,  6 May 2019 11:22:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 301911132B35; Mon,  6 May 2019 13:22:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190418203840.10528-1-armbru@redhat.com>
	<CAFEAcA9d5uMBiWx+OiLGuSs6qA5CRzG2dqhzsF8Q7tnOf_84Gg@mail.gmail.com>
Date: Mon, 06 May 2019 13:22:12 +0200
In-Reply-To: <CAFEAcA9d5uMBiWx+OiLGuSs6qA5CRzG2dqhzsF8Q7tnOf_84Gg@mail.gmail.com>
	(Peter Maydell's message of "Wed, 24 Apr 2019 11:55:25 +0100")
Message-ID: <874l67su8r.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Mon, 06 May 2019 11:22:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL for-4.1 0/9] Miscellaneous patches for
 2019-04-18
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 18 Apr 2019 at 21:40, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Early pull request because I'll be on vacation when 4.1 opens.  Hope
>> that's okay.
>>
>> The following changes since commit eeba63fc7fface36f438bcbc0d3b02e7dcb59983:
>>
>>   Update version for v4.0.0-rc4 release (2019-04-16 21:53:00 +0100)
>>
>> are available in the Git repository at:
>>
>>   git://repo.or.cz/qemu/armbru.git tags/pull-misc-2019-04-18
>>
>> for you to fetch changes up to 15136db27efaf0bdcf1131d41ad57832a2acadcc:
>>
>>   Clean up decorations and whitespace around header guards (2019-04-17 19:20:46 +0200)
>>
>> ----------------------------------------------------------------
>> Miscellaneous patches for 2019-04-18
>>
>> ----------------------------------------------------------------
>> Markus Armbruster (9):
>>       Clean up includes
>>       Use #include "..." for our own headers, <...> for others
>>       authz: Normalize #include "authz/trace.h" to "trace.h"
>>       linux-user/nios2 linux-user/riscv: Clean up header guards
>>       target/xtensa: Clean up core-isa.h header guards
>>       Clean up header guards that don't match their file name
>>       Clean up ill-advised or unusual header guards
>>       Normalize header guard symbol definition.
>>       Clean up decorations and whitespace around header guards
>
> Hi -- this fails 'make check' on ppc64 and s390, so likely
> a big-endian hosts issue:
>
> make[1]: Leaving directory `/home/pm215/qemu/build/all/tests/fp'
> cd /home/pm215/qemu/build/all/tests/fp && ./fp-test -s -l 1 -r all
> i32_to_f16 i64_to_f16 i32_to_f32 i64_to_f32 i32_to_f64 i64_to_f64
> i32_to_f128 i64_to_f128 >  int-to-float.out 2>&1 || (cat
> int-to-float.out && exit 1;)
>>> Testing i32_to_f16, rounding near_even
> ^M372 tests total.
> ^M372 tests performed.
> In 372 tests, no errors found in i32_to_f16, rounding near_even.
> [...]
>>> Testing i32_to_f128
> ^M372 tests total.
> ^MErrors found in i32_to_f128:
> 1006FFFF  => +0000.000000000000401B006FFFF00000 .....
>         expected +401B.006FFFF000000000000000000000 .....
> ^M0001DDEB  => +0000.000000000000400FDDEB00000000 .....
>         expected +400F.DDEB000000000000000000000000 .....
> ^MFFF6FFFC  => +0000.000000000000C012200080000000 .....
>         expected -4012.2000800000000000000000000000 .....
> [...]
> ^M00000020  => +0000.0000000000004004000000000000 .....
>         expected +4004.0000000000000000000000000000 .....
> ^M21 tests performed; 20 errors found.
> make: *** [check-softfloat-conv] Error 1

Awesome.

Luckily, Laurent included just PATCH 1/9 in his trivial pull request,
and had it fail the same:
Message-ID: <CAFEAcA9-hAU5dxUmSWtbvrPEXE-nCP1uLvLbOby-_EXZ27o+8g@mail.gmail.com>

See there for additional clues.


Received: from eggs.gnu.org ([209.51.188.92]:39002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gj9Sc-0000J0-BY
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 16:07:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gj9Sb-0006Zo-B7
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 16:07:54 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gj9Sa-0006Yu-4j
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 16:07:53 -0500
Received: by mail-pg1-x541.google.com with SMTP id t13so174892pgr.11
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 13:07:52 -0800 (PST)
References: <20190114011122.5995-1-richard.henderson@linaro.org>
	<20190114011122.5995-18-richard.henderson@linaro.org>
	<878sznpbd0.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <57ff8f98-95c9-734d-99dd-22d4ff350951@linaro.org>
Date: Tue, 15 Jan 2019 08:07:41 +1100
MIME-Version: 1.0
In-Reply-To: <878sznpbd0.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 17/17] tests/tcg/aarch64: Add mte smoke
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

On 1/15/19 1:22 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> ??? Requires a quite recent aarch64 assembler.  Use .inst instead?
> 
> How recent? Given buster is nearing release we could start using it as a
> basis for the ARM cross compiler images. That is shipping gcc 8.2.0 as
> of now.

Not yet released.  The patches adding the support include

commit 3a0f69be5589d351453afebd0974992cff3ee4d1
Author: Sudakshina Das <sudi.das@arm.com>
Date:   Mon Nov 12 13:29:38 2018 +0000

    [BINUTILS, AARCH64, 8/8] Add data cache instructions
    for Memory Tagging Extension

but the most recent binutils release branch (2.31) is from June.


r~

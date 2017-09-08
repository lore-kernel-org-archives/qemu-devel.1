Received: from eggs.gnu.org ([2001:4830:134:3::10]:57548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dqJ3m-0005cs-MF
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:11:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dqJ3j-0004N5-GA
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:11:02 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:34132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dqJ3j-0004LY-77
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:10:59 -0400
Received: by mail-wr0-x230.google.com with SMTP id v109so4643028wrc.1
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 06:10:59 -0700 (PDT)
References: <20170817230114.3655-1-richard.henderson@linaro.org>
	<20170817230114.3655-9-richard.henderson@linaro.org>
	<87377xijkt.fsf@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <87377xijkt.fsf@linaro.org>
Date: Fri, 08 Sep 2017 14:10:56 +0100
Message-ID: <871snhibdr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 8/8] tcg/i386: Add vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org


Alex Bennée <alex.bennee@linaro.org> writes:

> Richard Henderson <richard.henderson@linaro.org> writes:
>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
<snip>

Also this commit breaks RISU:

 qemu-aarch64 build/aarch64-linux-gnu/risu
    testcases.aarch64/insn_ANDSi_RES8_ANDS_RES_ANDv_ASRV__INC.risu.bin \
    -t testcases.aarch64/insn_ANDSi_RES8_ANDS_RES_ANDv_ASRV__INC.risu.bin.trace

Gives:

mismatch detail (master : apprentice):
  V29   : 000000000000000005388083c1444242 vs 00000000000000002a000e0416a30018

The insn is:

  37c:       6f56a29d        umull2  v29.4s, v20.8h, v6.h[1]

Which is odd because I didn't think we'd touched that.

You can find my bundle of testcases with trace files at:

  http://people.linaro.org/~alex.bennee/testcases/arm64.risu/aarch64-patterns-v8dot0.tar.xz

Which is used in our master RISU tracking job:

  https://validation.linaro.org/results/query/~alex.bennee/master-aarch64-risu-results

--
Alex Bennée

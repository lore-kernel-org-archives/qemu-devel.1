Received: from eggs.gnu.org ([2001:4830:134:3::10]:41529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dqsEI-0008MK-Ix
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 22:44:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dqsEF-0005g1-Ec
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 22:44:14 -0400
Received: from mail-pf0-x229.google.com ([2607:f8b0:400e:c00::229]:35149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dqsEF-0005fi-87
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 22:44:11 -0400
Received: by mail-pf0-x229.google.com with SMTP id g13so9523313pfm.2
	for <qemu-devel@nongnu.org>; Sat, 09 Sep 2017 19:44:11 -0700 (PDT)
References: <20170817230114.3655-1-richard.henderson@linaro.org>
	<20170817230114.3655-9-richard.henderson@linaro.org>
	<87377xijkt.fsf@linaro.org> <871snhibdr.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <889b3e05-64f6-8eb6-0c22-87b09b86b7b8@linaro.org>
Date: Sat, 9 Sep 2017 19:44:07 -0700
MIME-Version: 1.0
In-Reply-To: <871snhibdr.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org

On 09/08/2017 06:10 AM, Alex Bennée wrote:
> Also this commit breaks RISU:
> 
>  qemu-aarch64 build/aarch64-linux-gnu/risu
>     testcases.aarch64/insn_ANDSi_RES8_ANDS_RES_ANDv_ASRV__INC.risu.bin \
>     -t testcases.aarch64/insn_ANDSi_RES8_ANDS_RES_ANDv_ASRV__INC.risu.bin.trace
> 
> Gives:
> 
> mismatch detail (master : apprentice):
>   V29   : 000000000000000005388083c1444242 vs 00000000000000002a000e0416a30018
> 
> The insn is:
> 
>   37c:       6f56a29d        umull2  v29.4s, v20.8h, v6.h[1]
> 
> Which is odd because I didn't think we'd touched that.

Indeed we didn't.  Still, I'll check it out next week.


r~

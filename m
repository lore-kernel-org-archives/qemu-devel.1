Received: from eggs.gnu.org ([2001:4830:134:3::10]:39951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f4Qto-0001Cl-OF
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:55:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f4Qtn-0008Ei-Qx
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:55:24 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:40568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f4Qtn-0008EL-A6
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:55:23 -0400
Received: by mail-pl0-x241.google.com with SMTP id x4-v6so557319pln.7
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 05:55:23 -0700 (PDT)
References: <20180217203132.31780-1-richard.henderson@linaro.org>
	<20180217203132.31780-3-richard.henderson@linaro.org>
	<db140efc-6ba3-4609-1002-ab5e85424cb9@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <509a94c6-4d68-073d-882b-569e5aed8631@linaro.org>
Date: Fri, 6 Apr 2018 22:55:16 +1000
MIME-Version: 1.0
In-Reply-To: <db140efc-6ba3-4609-1002-ab5e85424cb9@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/19] target/hppa: Begin using
 scripts/decodetree.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org

On 04/06/2018 10:45 PM, Bastian Koppelmann wrote:
>> +break		000000 ----- ----- --- 00000000 -----
>>
> 
> Why are the im13 and im5 fields don't care? Is nobody using them?

The entire insn is placed in CR[IIR] for the kernel to use (distinguishing
different software breaks?), but the cpu does not use the field(s) at all.


r~

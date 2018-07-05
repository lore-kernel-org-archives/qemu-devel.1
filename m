Received: from eggs.gnu.org ([2001:4830:134:3::10]:39527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fb7Qe-0001Ly-7R
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:48:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fb7Qa-00073R-RH
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:48:24 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:43682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fb7Qa-000735-LM
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:48:20 -0400
Received: by mail-pl0-x241.google.com with SMTP id c41-v6so1521568plj.10
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 09:48:20 -0700 (PDT)
References: <20180703151732.29843-1-richard.henderson@linaro.org>
	<20180703151732.29843-8-richard.henderson@linaro.org>
	<B9095EFA-A3D5-4EEE-A5DA-E4284FD8881E@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <128b92a6-7b0e-5e27-2bad-63da14bb3a6a@linaro.org>
Date: Thu, 5 Jul 2018 09:48:17 -0700
MIME-Version: 1.0
In-Reply-To: <B9095EFA-A3D5-4EEE-A5DA-E4284FD8881E@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 7/7] target/ppc: Use non-arithmetic
 conversions for fp load/store
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, qemu-ppc@nongnu.org

On 07/05/2018 09:31 AM, Programmingkid wrote:
>> On Jul 3, 2018, at 11:17 AM, Richard Henderson <richard.henderson@linaro.org> wrote:
>>
>> Memory operations have no side effects on fp state.
>> The use of a "real" conversions between float64 and float32
>> would raise exceptions for SNaN and out-of-range inputs.
> 
> Would you have any documentation that tells us about converting
> between 64 bit and 32 bit floating points?

Spelled out right at the beginning of sections 4.6 (load) and 4.7 (store) of
Book 1 of the Power ISA manual (version 3.0B) [0].

I've double-checked vs RISU[1] testing of LFS and STFS, with master traces
generated on Power 8 ppc64le, so I don't see anything immediately wrong with
the patch.  But I haven't had time to look further than that.


r~


[0] https://openpowerfoundation.org/?resource_lib=power-isa-version-3-0
[1] https://git.linaro.org/people/peter.maydell/risu.git

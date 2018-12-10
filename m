Received: from eggs.gnu.org ([2001:4830:134:3::10]:44208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWSnh-0007Sc-0G
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 16:09:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWSnd-0004iK-63
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 16:09:12 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gWSnb-0004hb-7h
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 16:09:07 -0500
Received: by mail-ot1-x341.google.com with SMTP id i20so11906881otl.0
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 13:09:06 -0800 (PST)
References: <20181207085635.4291-1-mark.cave-ayland@ilande.co.uk>
	<alpine.BSF.2.21.9999.1812100112050.45639@zero.eik.bme.hu>
	<20181210025943.GE4261@umbus.fritz.box>
	<alpine.BSF.2.21.9999.1812102035360.24343@zero.eik.bme.hu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <763b8fce-daee-97ff-f1da-4f6dba6c5036@linaro.org>
Date: Mon, 10 Dec 2018 15:09:01 -0600
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.9999.1812102035360.24343@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH 0/6] target/ppc: convert VMX
 instructions to use TCG vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 12/10/18 2:54 PM, BALATON Zoltan wrote:
>> What was your host machine.  IIUC this change will only improve
>> performance if the host tcg backend is able to implement TCG vector
>> ops in terms of vector ops on the host.
> 
> Tried it on i5 650 which has: sse sse2 ssse3 sse4_1 sse4_2. I assume x86_64
> should be supported but not sure what are the CPU requirements.

Not quite.  I only support avx1 and later.

I thought about supporting sse4 and later (that's the minimum with all of the
instructions that do what we need), but there is only one cpu generation with
sse4 and without avx1, and avx1 is already 8 years old.


r~

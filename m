Received: from eggs.gnu.org ([2001:4830:134:3::10]:43003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gWnds-0004ki-0l
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 14:24:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gWndr-0002hQ-7c
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 14:24:27 -0500
References: <20181207085635.4291-1-mark.cave-ayland@ilande.co.uk>
	<20181207085635.4291-4-mark.cave-ayland@ilande.co.uk>
	<54550637-3a70-722f-a98f-6bd93958b644@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <88578f1a-d444-db88-b226-90ada4029e63@ilande.co.uk>
Date: Tue, 11 Dec 2018 19:24:14 +0000
MIME-Version: 1.0
In-Reply-To: <54550637-3a70-722f-a98f-6bd93958b644@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 3/6] target/ppc: introduce
 get_cpu_vsr{l, h}() and set_cpu_vsr{l, h}() helpers for VSR register access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 10/12/2018 19:16, Richard Henderson wrote:

> On 12/7/18 2:56 AM, Mark Cave-Ayland wrote:
>> +static inline void get_vsr(TCGv_i64 dst, int n)
>> +{
>> +    tcg_gen_ld_i64(dst, cpu_env, offsetof(CPUPPCState, vsr[n]));
>> +}
>> +
>> +static inline void set_vsr(int n, TCGv_i64 src)
>> +{
>> +    tcg_gen_st_i64(src, cpu_env, offsetof(CPUPPCState, vsr[n]));
>> +}
> 
> Why isn't this helper still using cpu_vsr[n]?

Gah this is just a mistake from squashing patches from my working branch to tidy them
up for submission. I'll fix this in the next iteration.


ATB,

Mark.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:33972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gXF53-0004up-MQ
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 19:42:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gXF51-0005S4-ED
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 19:42:21 -0500
References: <cover.1544643238.git.alistair.francis@wdc.com>
	<89a7db22-6744-0fb5-e543-847569e942c4@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Message-ID: <c799a3f8-9a49-e789-9cfd-ed5990bc7809@gmail.com>
Date: Wed, 12 Dec 2018 16:41:46 -0800
MIME-Version: 1.0
In-Reply-To: <89a7db22-6744-0fb5-e543-847569e942c4@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 00/23] Add RISC-V TCG backend support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>

On 12/12/2018 3:33 pm, Richard Henderson wrote:
> On 12/12/18 1:42 PM, Alistair Francis wrote:
>> As this is all new work (so can't cause regressions) I'm starting the
>> patch series process with what we have so far. That way others can help
>> contribute and test. If anyone has strong feelings for missing functionality
>> let me know and we can work on adding that before this is merged.
> 
> I'd be ok merging this immediately after the bswap patches currently queued on
> my tcg-next-2 branch.  Which for you just means defining
> TCG_TARGET_HAS_MEMORY_BSWAP to 0 and fixing the one MAINTAINERS entry.
> 
> Anything else can be fixed or improved via normal development.

Awesome!

I have fixed the maintainers file and defined 
TCG_TARGET_HAS_MEMORY_BSWAP to 0 (no effect yet) in my tree.

Unless anyone else has any comments I'm just going to sit on these 
patches until your branch is merged then I'll send a v2.

Alistair

> 
> 
> r~
> 

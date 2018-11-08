Received: from eggs.gnu.org ([2001:4830:134:3::10]:60131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gKo7k-00032D-DQ
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:29:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gKo7c-0001Dj-Qs
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:29:42 -0500
References: <20181108120628.29926-1-kbastian@mail.uni-paderborn.de>
	<97b143d6-5503-21ee-a836-cfa2597a5856@linaro.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <d6ec0bb8-1ea6-c032-5643-2248ce7647a6@mail.uni-paderborn.de>
Date: Thu, 8 Nov 2018 18:29:26 +0100
MIME-Version: 1.0
In-Reply-To: <97b143d6-5503-21ee-a836-cfa2597a5856@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH 0/2] target/riscv: Bugfixes found in
 decodetree conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, mjc@sifive.com, sagark@eecs.berkeley.edu, palmer@sifive.com, Alistair.Francis@wdc.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org


On 11/8/18 4:53 PM, Richard Henderson wrote:
> On 11/8/18 1:06 PM, Bastian Koppelmann wrote:
>> while going through the reviews of the riscv-decodetree patches, two bugs came
>> up that I fix here. There is one more problem [1] mentioned by Richard but
>> I don't have the time to investigate it further.
>>
>> [1] https://patchwork.kernel.org/patch/10650293/
> That one's not a bug, but an optimization.
>
> The other bug mentioned is shrw and shaw not sign-extending the result.


That was a bug I introduced during the conversion to decodetree.


Cheers,

Bastian

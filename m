Received: from eggs.gnu.org ([2001:4830:134:3::10]:34157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fgQTc-0002PW-EL
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 04:09:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fgQTZ-0005l0-8l
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 04:09:24 -0400
Received: from smtp59.i.mail.ru ([217.69.128.39]:36246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fgQTY-0005jc-Rv
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 04:09:21 -0400
References: <20180719121637.24576-1-jusual@mail.ru>
	<CAFEAcA8_2hM0J38w0h0jfVMvLMceHnxgKKYeMcY-SO_Ywk0QpA@mail.gmail.com>
From: Julia Suvorova <jusual@mail.ru>
Message-ID: <f6970c0f-d9d5-1d5d-7d6e-3e457f034bf2@mail.ru>
Date: Fri, 20 Jul 2018 11:09:10 +0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8_2hM0J38w0h0jfVMvLMceHnxgKKYeMcY-SO_Ywk0QpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] nvic: Change NVIC to support ARMv6-M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>

On 19.07.2018 19:25, Peter Maydell wrote:
> On 19 July 2018 at 13:16, Julia Suvorova <jusual@mail.ru> wrote:
>> The differences from ARMv7-M NVIC are:
>>    * ARMv6-M only supports up to 32 external interrupts
>>     (configurable feature already). The ICTR is reserved.
>>    * Active Bit Register is reserved.
>>    * ARMv6-M supports 4 priority levels against 256 in ARMv7-M.
>>
>> Signed-off-by: Julia Suvorova <jusual@mail.ru>
>> ---
>> v2:
>>      * Added num_prio_bits field
>>      * AIRCR.PRIGROUP is set as RAZ/WI for Baseline
> 
> Applied to target-arm.for-3.1, thanks.

It seems like you applied the first version of this patch.
Can you check this, please?

Best regards, Julia Suvorova.

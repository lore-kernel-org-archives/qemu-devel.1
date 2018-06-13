Received: from eggs.gnu.org ([2001:4830:134:3::10]:36174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fT9I2-0004Fn-8L
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 13:10:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fT9Hz-0008F0-0R
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 13:10:34 -0400
Received: from smtp55.i.mail.ru ([217.69.128.35]:39914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fT9Hy-00088p-GZ
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 13:10:30 -0400
References: <20180612204632.28780-1-jusual@mail.ru>
	<20180613140505.GS24528@stefanha-x1.localdomain>
From: Julia Suvorova <jusual@mail.ru>
Message-ID: <9047ab62-0bf7-d473-e4c3-562f33c68349@mail.ru>
Date: Wed, 13 Jun 2018 20:10:23 +0300
MIME-Version: 1.0
In-Reply-To: <20180613140505.GS24528@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/arm: Allow ARMv6-M Thumb2
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>

On 13.06.2018 17:05, Stefan Hajnoczi wrote:
> On Tue, Jun 12, 2018 at 11:46:32PM +0300, Julia Suvorova wrote:
>> ARMv6-M supports 6 Thumb2 instructions. This patch checks for these
>> instructions and allows their execution.
>> Like Thumb2 cores, ARMv6-M always interprets BL instruction as 32-bit.
>>
>> This patch is required for future Cortex-M0 support.
>>
>> Signed-off-by: Julia Suvorova <jusual@mail.ru>
>> ---
>>   target/arm/translate.c | 35 ++++++++++++++++++++++++++++++-----
>>   1 file changed, 30 insertions(+), 5 deletions(-)
> 
> Does make the undefined instruction test case that I recently posted
> pass (including all commented out instructions that weren't working
> yet)?
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> 

Yes, test with all instructions is passed.

Best regards, Julia Suvorova.

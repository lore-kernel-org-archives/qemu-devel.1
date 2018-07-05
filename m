Received: from eggs.gnu.org ([2001:4830:134:3::10]:42505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fb2Oa-0006rt-W0
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fb2OX-00010o-Sa
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:25:56 -0400
Received: from smtp62.i.mail.ru ([217.69.128.42]:52206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fb2OX-0000vo-H0
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:25:53 -0400
References: <20180704195812.28798-1-jusual@mail.ru>
	<20180704195812.28798-2-jusual@mail.ru>
	<CAFEAcA_ojVz=2Kbivr8b-VQQRCJUwnOf4w+pLAb4AoukMd8c_g@mail.gmail.com>
From: Julia Suvorova <jusual@mail.ru>
Message-ID: <d9228ff1-bdfa-506c-e32f-d0fbb69578be@mail.ru>
Date: Thu, 5 Jul 2018 14:25:47 +0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_ojVz=2Kbivr8b-VQQRCJUwnOf4w+pLAb4AoukMd8c_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] nvic: Handle ARMv6-M SCS reserved
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>

On 05.07.2018 13:54, Peter Maydell wrote:
> On 4 July 2018 at 20:58, Julia Suvorova <jusual@mail.ru> wrote:
>> Handle SCS reserved registers listed in ARMv6-M ARM D3.6.1.
>> All reserved registers are RAZ/WI.
>>
>> Signed-off-by: Julia Suvorova <jusual@mail.ru>
>> ---
>>   hw/intc/armv7m_nvic.c | 69 +++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 57 insertions(+), 12 deletions(-)
> 
> Hi; this patch is generally good, but I have a couple of comments
> below, and in most (but not all) of these cases we should be
> checking the ARM_FEATURE_M_MAIN bit rather than ARM_FEATURE_V7 --
> I've annotated which should be which.

Thank you for the review. I did not dare to set the ARM_FEATURE_M_MAIN,
because I was not completely sure about the v8M behavior in certain cases.
I'll update the code taking into account all the comments, and send v2.

Best regards, Julia Suvorova.

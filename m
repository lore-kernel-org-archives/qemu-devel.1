Received: from eggs.gnu.org ([2001:4830:134:3::10]:40002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fbCbp-00077F-3A
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 18:20:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fbCbj-0001D9-Vs
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 18:20:17 -0400
Received: from smtp62.i.mail.ru ([217.69.128.42]:48198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fbCbj-00019B-Kz
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 18:20:11 -0400
References: <20180705215052.8795-1-jusual@mail.ru>
From: Julia Suvorova <jusual@mail.ru>
Message-ID: <028d951c-38f4-7689-c43a-7e05c9952f16@mail.ru>
Date: Fri, 6 Jul 2018 01:20:01 +0300
MIME-Version: 1.0
In-Reply-To: <20180705215052.8795-1-jusual@mail.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/2] nvic: Handle ARMv6-M SCS reserved
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>

On 06.07.2018 00:50, Julia Suvorova wrote:
> v2:
>      * Use ARM_FEATURE_M_MAIN instead of ARM_FEATURE_V7 in most cases
>      * Remove CPUID registers check
>      * Use bad_offset instead of return
>      * Misc style fixes
> 
> Julia Suvorova (2):
>    nvic: Handle ARMv6-M SCS reserved registers
>    tests: Add ARMv6-M reserved register test
> 
>   hw/intc/armv7m_nvic.c             | 51 ++++++++++++++++++++++++--
>   tests/Makefile.include            |  2 ++
>   tests/tcg/arm/test-reserved-reg.c | 60 +++++++++++++++++++++++++++++++
>   3 files changed, 111 insertions(+), 2 deletions(-)
>   create mode 100644 tests/tcg/arm/test-reserved-reg.c

Sorry, bad indents. Please ignore this one, I'll send v3 soon.

Best regards, Julia Suvorova.

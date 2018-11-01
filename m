Received: from eggs.gnu.org ([2001:4830:134:3::10]:44282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gIAyH-0005IX-Nq
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 07:17:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gIAyH-0004CP-1U
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 07:17:05 -0400
References: <20181031002526.14262-1-contrib@steffen-goertz.de>
	<20181031002526.14262-3-contrib@steffen-goertz.de>
From: Julia Suvorova <jusual@mail.ru>
Message-ID: <93e1b8e1-c8f2-6a61-122a-8354b933782c@mail.ru>
Date: Thu, 1 Nov 2018 11:16:48 +0000
MIME-Version: 1.0
In-Reply-To: <20181031002526.14262-3-contrib@steffen-goertz.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 02/13] arm: Add header to host common
 definition for nRF51 SOC peripherals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Peter Maydell <peter.maydell@linaro.org>, "open list:NRF51" <qemu-arm@nongnu.org>

On 31.10.2018 00:25, Steffen Görtz wrote:
> Adds a header that provides definitions that are used
> across nRF51 peripherals
> 
> Signed-off-by: Steffen Görtz <contrib@steffen-goertz.de>
> ---
>   hw/arm/nrf51_soc.c           | 33 ++++++++++-----------------
>   include/hw/arm/nrf51.h       | 44 ++++++++++++++++++++++++++++++++++++
>   include/hw/char/nrf51_uart.h |  1 -
>   3 files changed, 56 insertions(+), 22 deletions(-)
>   create mode 100644 include/hw/arm/nrf51.h


Why do we need an extra file for this? nrf51_soc.h seemed like a good fit.
What's the purpose of renaming?

Best regards, Julia Suvorova.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:41926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1gIbY7-0005DX-QB
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:39:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1gIbY3-0001Hb-W6
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:39:49 -0400
References: <20181031002526.14262-1-contrib@steffen-goertz.de>
	<20181031002526.14262-3-contrib@steffen-goertz.de>
	<93e1b8e1-c8f2-6a61-122a-8354b933782c@mail.ru>
From: =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>
Message-ID: <a9a9af81-dbbd-0145-a245-e3c2f50e964c@steffen-goertz.de>
Date: Fri, 2 Nov 2018 11:39:09 -0400
MIME-Version: 1.0
In-Reply-To: <93e1b8e1-c8f2-6a61-122a-8354b933782c@mail.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Julia Suvorova <jusual@mail.ru>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Peter Maydell <peter.maydell@linaro.org>, "open list:NRF51" <qemu-arm@nongnu.org>

Hi Julia,

> Why do we need an extra file for this? nrf51_soc.h seemed like a good fit.

nrf51_soc.h is not included in the peripheral devices. It would be possible to put the definitions into nrf51_soc.h but i just did not want to mix up the dependency directions. 

> What's the purpose of renaming?

To avoid name conflicts down the road.

Cheers,
Steffen

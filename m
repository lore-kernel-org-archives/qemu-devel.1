Received: from eggs.gnu.org ([2001:4830:134:3::10]:58657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1gIcJz-0003wJ-KR
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 12:29:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1gIcJk-00056F-4J
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 12:29:17 -0400
Received: from steffen-goertz.de ([88.198.119.201]:33148)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1gIcJj-00053i-RB
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 12:29:04 -0400
References: <20181031002526.14262-1-contrib@steffen-goertz.de>
	<20181031002526.14262-9-contrib@steffen-goertz.de>
	<20181101123202.GQ24946@stefanha-x1.localdomain>
From: =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>
Message-ID: <cbbbd15a-311f-16f6-6efd-4699bd09c7bd@steffen-goertz.de>
Date: Fri, 2 Nov 2018 12:29:00 -0400
MIME-Version: 1.0
In-Reply-To: <20181101123202.GQ24946@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 08/13] hw/gpio/nrf51_gpio: Add nRF51
 GPIO peripheral
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>

Hi Stefan,

>
> gcc (GCC) 8.2.1 20181011 doesn't know that extract32(..., 3) can only
> result in values [0, 7] so it warns that state can be uninitialized.
>
> It might be simplest to include a default case that returns false (with
> a comment).
>

thank you for your remarks. Will be in the next version.

Steffen

Received: from eggs.gnu.org ([2001:4830:134:3::10]:35704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu.ml@steffen-goertz.de>) id 1gHqMM-0001cB-HI
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 09:16:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <qemu.ml@steffen-goertz.de>) id 1gHqMI-0007qr-NG
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 09:16:34 -0400
Received: from steffen-goertz.de ([88.198.119.201]:60644)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu.ml@steffen-goertz.de>) id 1gHqMI-0007q1-BI
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 09:16:30 -0400
References: <20181031002526.14262-1-contrib@steffen-goertz.de>
	<20181031002526.14262-2-contrib@steffen-goertz.de>
	<32aab4a3-7d7c-6361-43e0-913e68af906d@redhat.com>
From: =?UTF-8?Q?Steffen_G=c3=b6rtz?= <qemu.ml@steffen-goertz.de>
Message-ID: <0069f1dd-3971-37a8-d120-ff789272e39f@steffen-goertz.de>
Date: Wed, 31 Oct 2018 09:16:25 -0400
MIME-Version: 1.0
In-Reply-To: <32aab4a3-7d7c-6361-43e0-913e68af906d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 01/13] qtest: Add set_irq_in command to
 set IRQ/GPIO level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jim Mussared <jim@groklearning.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>, Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Julia Suvorova <jusual@mail.ru>

Hi Laurent,

thank you for your remarks! I have fixed the documentation (also added some explanation for the fields) and switched to int/qemu_strtoi with base=0.

Steffen

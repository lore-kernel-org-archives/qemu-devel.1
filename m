Received: from eggs.gnu.org ([209.51.188.92]:60088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmfIy-0000OQ-Dc
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:44:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmfIu-0000PR-3X
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:44:25 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:32859)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gmfIt-0000OJ-LW
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:44:23 -0500
Received: by mail-oi1-x243.google.com with SMTP id c206so4872333oib.0
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 05:44:22 -0800 (PST)
MIME-Version: 1.0
References: <20190123120759.7162-1-jusual@mail.ru>
In-Reply-To: <20190123120759.7162-1-jusual@mail.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Jan 2019 13:44:10 +0000
Message-ID: <CAFEAcA9CqxW+=fCi6Nkem_JS2t=esTpWHJWWhNz1FC+VU0y6bA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 0/3] tests/microbit-test: Add UART
 device test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>

On Wed, 23 Jan 2019 at 12:08, Julia Suvorova <jusual@mail.ru> wrote:
>
> v5:
>     * Replace g_assert with g_assert_* [Thomas, Alex]
>     * Increase the waiting time for an event [Thomas]
>     * Remove 'nowait' [Thomas]
>     * Rewrite uart_wait_for_event to use time difference instead of loop
> v4:
>     * Replace sprintf with g_strdup_printf [Peter]
>     * Move socket connection to qtest library [Peter]
>     * Use memcmp instead of strcmp [Stefan]
>     * Remove using global_qtest [Thomas]
> v3:
>     * Fix directory leak [Stefan]
>
> Based-on: <20190110094020.18354-1-stefanha@redhat.com>



Applied to target-arm.next, thanks.

-- PMM

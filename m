Received: from eggs.gnu.org ([209.51.188.92]:49101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggWhJ-0002Zw-RG
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 10:20:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggWhH-0000LD-2c
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 10:20:13 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggWhG-0000F2-Bx
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 10:20:10 -0500
Received: by mail-ot1-x343.google.com with SMTP id a11so585728otr.10
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 07:20:08 -0800 (PST)
MIME-Version: 1.0
References: <20190103091119.9367-1-stefanha@redhat.com>
In-Reply-To: <20190103091119.9367-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Jan 2019 15:19:56 +0000
Message-ID: <CAFEAcA-=fApDM-CGhJvXpv6BSp24K7a=fjfxOkUec0AoAMB7rw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 00/11] arm: Core nRF51 Devices and Microbit
 Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Julia Suvorova <jusual@mail.ru>, Paolo Bonzini <pbonzini@redhat.com>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>, Laurent Vivier <lvivier@redhat.com>

On Thu, 3 Jan 2019 at 09:12, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> Steffen has been busy so I picked up "[PATCH v5 00/14] arm: nRF51 Devices and
> Microbit Support".  This series includes the core devices needed to boot basic
> guest software on the "microbit" board.
>
> This series includes Steffen's random number generator, GPIO, timer, and a
> stubbed clock.  Also, this series adds the tests/microbit-test.c qtest.
>
> Changes from Steffen's series:
>  * Made timer tickless [Peter]
>  * Dropped non-volatile memory controller.  More work is needed there and I
>    don't want to hold back other devices in this series that are ready for
>    merge.
>  * Rebased and re-tested with make check and real micro:bit programs
>    (requires out-of-tree -kernel and stub TWI device patches)

Applied to target-arm.next, thanks.

-- PMM

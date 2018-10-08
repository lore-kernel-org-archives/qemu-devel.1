Received: from eggs.gnu.org ([2001:4830:134:3::10]:35886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9RWv-0006ii-JO
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 05:08:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9RWu-0001cQ-UL
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 05:08:45 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g9RWu-0001c1-Fj
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 05:08:44 -0400
Received: by mail-oi1-x241.google.com with SMTP id l197-v6so15186467oib.8
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 02:08:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1659f740-a536-eff8-c58e-a11fc0f9b9b1@redhat.com>
References: <1538732546-2284-1-git-send-email-thuth@redhat.com>
	<CAFEAcA_W9ioV5qDFV6jNY6t-W3MfEkuUXZeZCAST8_tOe=k9wg@mail.gmail.com>
	<1659f740-a536-eff8-c58e-a11fc0f9b9b1@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Oct 2018 10:08:23 +0100
Message-ID: <CAFEAcA9_E+YNPnx=00UJN-YUoeW81EsQwoq5bKup=46yq7Bh=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/core/generic-loader: Set a category for
 the generic-loader device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Alistair Francis <alistair@alistair23.me>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 8 October 2018 at 07:14, Thomas Huth <thuth@redhat.com> wrote:
> On 2018-10-05 18:32, Peter Maydell wrote:
>> On 5 October 2018 at 10:42, Thomas Huth <thuth@redhat.com> wrote:
>>> Each device that is instantiatable by the users should be marked with
>>> a category.
>>
>> Presumably we could assert() this somewhere (at which
>> point we'd find that we have dozens of devices that
>> fail to set a category bit, I imagine) ?
>
> You bet ... alone in qemu-system-aarch64, "-device help" shows more than
> 120 devices without a category...
>
> So if we'd want to enforce this, there is a lot of clean-up work needed
> first. Once we're in a good shape, I think a "make check" test would be
> the right thing to enforce that future devices are always provided with
> a category.

Asserting in something like the device base class realize seems
to me like a good approach -- that way it gets automatically
covered by the existing test that tries to create every
user creatable device (we do have one of those, right?), and
developers of new devices will spot their error immediately
even if they don't happen to run 'make check'.

thanks
-- PMM

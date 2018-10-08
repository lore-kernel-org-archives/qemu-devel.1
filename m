Received: from eggs.gnu.org ([2001:4830:134:3::10]:59345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g9OoR-0007dl-MP
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 02:14:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g9OoO-0007if-Es
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 02:14:39 -0400
References: <1538732546-2284-1-git-send-email-thuth@redhat.com>
	<CAFEAcA_W9ioV5qDFV6jNY6t-W3MfEkuUXZeZCAST8_tOe=k9wg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1659f740-a536-eff8-c58e-a11fc0f9b9b1@redhat.com>
Date: Mon, 8 Oct 2018 08:14:26 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_W9ioV5qDFV6jNY6t-W3MfEkuUXZeZCAST8_tOe=k9wg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Alistair Francis <alistair@alistair23.me>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 2018-10-05 18:32, Peter Maydell wrote:
> On 5 October 2018 at 10:42, Thomas Huth <thuth@redhat.com> wrote:
>> Each device that is instantiatable by the users should be marked with
>> a category.
> 
> Presumably we could assert() this somewhere (at which
> point we'd find that we have dozens of devices that
> fail to set a category bit, I imagine) ?

You bet ... alone in qemu-system-aarch64, "-device help" shows more than
120 devices without a category...

So if we'd want to enforce this, there is a lot of clean-up work needed
first. Once we're in a good shape, I think a "make check" test would be
the right thing to enforce that future devices are always provided with
a category.

 Thomas

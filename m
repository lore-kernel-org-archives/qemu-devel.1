Received: from eggs.gnu.org ([2001:4830:134:3::10]:32875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHoBa-0004ye-By
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 04:52:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHoBZ-0000W8-Nv
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 04:52:46 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:40808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eHoBZ-0000VZ-IX
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 04:52:45 -0500
Received: by mail-oi0-x243.google.com with SMTP id l138so12800062oib.7
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 01:52:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHQ1cqHm1MRWaxh7v4EWgRraS4Ezrx2QdbH43ao_FOX3P6MZQA@mail.gmail.com>
References: <20171106154813.19936-1-andrew.smirnov@gmail.com>
	<20171106154813.19936-12-andrew.smirnov@gmail.com>
	<CAFEAcA82Y3fWJyAUwOSxy6btutrS+FPa7sRm3AOKZM_GTcmBrA@mail.gmail.com>
	<CAHQ1cqHm1MRWaxh7v4EWgRraS4Ezrx2QdbH43ao_FOX3P6MZQA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Nov 2017 09:52:24 +0000
Message-ID: <CAFEAcA9FoRPWiXvtO2-mtc-Y2SgdmkH2habTcP+TY9RJZ02Bcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 11/30] sdhci: Add i.MX specific subtype
 of SDHCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On 22 November 2017 at 20:43, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> On Tue, Nov 21, 2017 at 10:02 AM, Peter Maydell
> <peter.maydell@linaro.org> wrote:
>> On 6 November 2017 at 15:47, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>>> +/* Controller does not provide transfer-complete interrupt when not busy */
>>> +#define SDHCI_QUIRK_NO_BUSY_IRQ    BIT(14)
>>
>> We only have one quirk, so why is it bit 14?
>>
>
> I took that code from Linux kernel, so I tried to keep it as is (same
> with unsigned long in quirks field).

That's fine, but if so we should have a comment that that's what we're
doing, so that subsequent additions by other contributors follow the
same convention.

thanks
-- PMM

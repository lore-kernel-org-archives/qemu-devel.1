Received: from eggs.gnu.org ([2001:4830:134:3::10]:32992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cT8m8-0002Ek-Jl
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 10:00:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cT8m2-0003ce-RP
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 10:00:48 -0500
Received: from mail-vk0-x229.google.com ([2607:f8b0:400c:c05::229]:36708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cT8m2-0003cX-ML
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 10:00:42 -0500
Received: by mail-vk0-x229.google.com with SMTP id t8so74457954vke.3
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 07:00:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170105043430.3176-4-alastair@au1.ibm.com>
References: <20170105043430.3176-1-alastair@au1.ibm.com>
	<20170105043430.3176-4-alastair@au1.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jan 2017 15:00:21 +0000
Message-ID: <CAFEAcA9SxUyT1_ztQ-wb4DwPAzmHcBkh8a=pQ76+7A0r5PHYFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v5 3/7] qtest: Support setting named GPIOs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alastair D'Silva <alastair@au1.ibm.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, Alastair D'Silva <alastair@d-silva.org>

On 5 January 2017 at 04:34, Alastair D'Silva <alastair@au1.ibm.com> wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
>
> Some devices change their behaviour based on the state of their input GPIO
> lines.
>
> This patch allows testing of the variable behaviour by providing facilities
> for the test to set the state of these GPIO lines.
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

I still think this is wrong, I'm afraid. The GPIO line is
already connected to something else in the simulation,
and injecting a value that didn't come from whatever else
it's connected to is likely to confuse things.

Tests should work by programming the device that is connected
to the other end of this GPIO to make it raise the line.

thanks
-- PMM

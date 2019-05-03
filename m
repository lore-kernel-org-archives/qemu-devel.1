Received: from eggs.gnu.org ([209.51.188.92]:34168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYKU-0001y5-BD
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:34:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYKR-0002TJ-M8
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:34:21 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMYKP-0002Ji-0E
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:34:17 -0400
Received: by mail-ot1-x342.google.com with SMTP id f23so5269560otl.9
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 06:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190430044036.1144-1-joel@jms.id.au>
	<20190430044036.1144-2-joel@jms.id.au>
In-Reply-To: <20190430044036.1144-2-joel@jms.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 14:34:02 +0100
Message-ID: <CAFEAcA-A-2RYAibPMRxKM6RPabxiOH-DLAzyRu8s5c3Vz+KFgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 1/2] hw: timer: Add ASPEED RTC device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, 30 Apr 2019 at 05:40, Joel Stanley <joel@jms.id.au> wrote:
>
> The RTC is modeled to provide time and date functionality. It is
> initialised at zero to match the hardware.
>
> There is no modelling of the alarm functionality, which includes the IRQ
> line. As there is no guest code to exercise this function that is
> acceptable for now.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

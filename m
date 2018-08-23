Received: from eggs.gnu.org ([2001:4830:134:3::10]:32979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fsthc-0007zz-OH
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fstha-0008HU-Oj
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:47:24 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:41963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fsthZ-0008Fb-4N
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:47:22 -0400
Received: by mail-oi0-x242.google.com with SMTP id k12-v6so10721637oiw.8
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 10:47:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-ZYqeWz9mVBvWNfvMThzJOzB7-HcQ=db3DzG9ZYrOi7g@mail.gmail.com>
References: <20180820141116.9118-1-peter.maydell@linaro.org>
	<20180820141116.9118-23-peter.maydell@linaro.org>
	<786e23f7-8492-477e-632b-10dc3ebd4576@linaro.org>
	<CAFEAcA-ZYqeWz9mVBvWNfvMThzJOzB7-HcQ=db3DzG9ZYrOi7g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Aug 2018 18:46:59 +0100
Message-ID: <CAFEAcA9G-wvjUp8UuxXyr-NvAmyRca-a8Pu5FfHqhL0oCVsG+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 22/22] hw/arm/mps2-tz: Fix MPS2 SCC config
 register values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, "patches@linaro.org" <patches@linaro.org>

On 23 August 2018 at 18:45, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 23 August 2018 at 18:42, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> On 08/20/2018 07:11 AM, Peter Maydell wrote:
>>> +    mmc->scc_id = 0x41040000 | (0x505 << 4);
>>
>> Is it any less clear to say 0x41045050?
>
> It makes it a bit clearer that that field is the number
> from the image name, I think. (Compare the an385
> and an511 init functions, which I notice I also need
> to update to fix the equivalent bug there.)

...though I guess that's less true now we're using a
hex constant rather than decimal. So yeah, we could just
say 0x41045050.

thanks
-- PMM

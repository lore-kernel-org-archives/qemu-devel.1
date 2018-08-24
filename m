Received: from eggs.gnu.org ([2001:4830:134:3::10]:47856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftDo7-0007FP-EO
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:15:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftDo6-0006bp-NB
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:15:27 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:33675)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ftDo6-0006aZ-AY
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:15:26 -0400
Received: by mail-oi0-x244.google.com with SMTP id 8-v6so15945621oip.0
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 08:15:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-nN4AD1m1w8Uv=wfvAYbVVrdPAxFKN75maVJe9wi=yDw@mail.gmail.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
	<1534870966-9287-4-git-send-email-pbonzini@redhat.com>
	<CAFEAcA-nN4AD1m1w8Uv=wfvAYbVVrdPAxFKN75maVJe9wi=yDw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 16:15:05 +0100
Message-ID: <CAFEAcA-M33nCAPVuGTFLWaiCiOXyXF3GrUWgDc9tbW5vARsjMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 03/74] es1370: simplify MemoryRegionOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 24 August 2018 at 16:04, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 21 August 2018 at 18:01, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> Use the automatic subregister extraction from the memory API, and avoid
>> that Coverity complains about missing fallthrough comments.
>
> Hi -- Coverity (CID 1395167) points out that these changes are wrong:

> because these values aren't contiguous:
>
> #define ES1370_REG_DAC1_FRAMEADR    0xc30
> #define ES1370_REG_DAC2_FRAMEADR    0xc38
> #define ES1370_REG_ADC_FRAMEADR     0xd30
>
> so you can't calculate the value of 'd' from the addr
> this way.
>
> (Similarly for the SCOUNT registers.)

...and also for the FRAMECNT registers, CID1395185.

thanks
-- PMM

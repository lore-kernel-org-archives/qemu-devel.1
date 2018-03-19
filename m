Received: from eggs.gnu.org ([2001:4830:134:3::10]:54351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1exsVc-0000My-S9
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 06:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1exsVb-0005OX-S0
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 06:59:20 -0400
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:45142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1exsVb-0005OA-MS
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 06:59:19 -0400
Received: by mail-ot0-x235.google.com with SMTP id q5-v6so6216112oth.12
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 03:59:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <837c5be7-a153-5a7e-8e2c-dccdb9945a4e@amsat.org>
References: <20180313153458.26822-1-peter.maydell@linaro.org>
	<20180313153458.26822-9-peter.maydell@linaro.org>
	<MWHPR21MB018983B74A652443B70680F19ED20@MWHPR21MB0189.namprd21.prod.outlook.com>
	<CAFEAcA8O7EEhoS83eRLH5bVmog_Qu1tAgUzR6NsE+GD2a7FsDw@mail.gmail.com>
	<837c5be7-a153-5a7e-8e2c-dccdb9945a4e@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Mar 2018 10:58:57 +0000
Message-ID: <CAFEAcA974GJpqTCit4wwcC0DESAGtga34pLNnrvZ6kDZ4zaUpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 8/9] hw/arm/bcm2836: Hardcode correct CPU
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Pekka Enberg <penberg@iki.fi>, "patches@linaro.org" <patches@linaro.org>

On 13 March 2018 at 23:16, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wr=
ote:
> On 03/13/2018 06:09 PM, Peter Maydell wrote:
>> On 13 March 2018 at 16:55, Andrew Baumann <Andrew.Baumann@microsoft.com>=
 wrote:
>>> At some point I remember seeing a patch to change this to cortex-a7. Is=
 there a reason we didn't make that change?
>>>
>>> (Background: the real Pi2 has an A7. When I first implemented the machi=
ne model there was no A7 emulation in QEMU, so I used the A15 which was the=
 closest equivalent.)
>>
>> Yeah, we should do that. I'd forgotten about that, I think
>> things just got lost in the shuffle of having several
>> patchsets that tried to change the same things at once.
>>
>> I guess the simplest thing is to add a patch at the end of
>> the series that fixes the cpu type for bcm2836.
>
> Peter, here is the patch Andrew remembered (maybe can be applied at the
> end):
> http://lists.nongnu.org/archive/html/qemu-devel/2018-02/msg04286.html

Thanks for finding that. It doesn't apply after this refactoring,
but I'll send out a patch which does the equivalent thing in the
new code. In the meantime I'm going to apply this patchset to
target-arm.next since I'm going to send out a pullreq with bugfixes
for rc0 today.

thanks
-- PMM

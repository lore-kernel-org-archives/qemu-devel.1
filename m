Received: from eggs.gnu.org ([2001:4830:134:3::10]:57835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dtwEA-00011h-36
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dtwE9-00059W-9R
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:36:46 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:43707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dtwE9-00058d-35
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:36:45 -0400
Received: by mail-wm0-x22f.google.com with SMTP id a137so13238492wma.0
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 06:36:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CALHRZurNLqH_6Xbh9SKtCA0fuk-CFEZeqBMwYXV=+UaZB4k1Bg@mail.gmail.com>
References: <1505494753-10837-1-git-send-email-sundeep.lkml@gmail.com>
	<1505494753-10837-3-git-send-email-sundeep.lkml@gmail.com>
	<2c6a4136-fb80-2000-940c-1df5e718cbf1@amsat.org>
	<CALHRZurRLysJCRwvm+SbJUn8YBAst_Q38RCzJkmT4z=mfnYuiQ@mail.gmail.com>
	<CALHRZurNLqH_6Xbh9SKtCA0fuk-CFEZeqBMwYXV=+UaZB4k1Bg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Sep 2017 14:36:23 +0100
Message-ID: <CAFEAcA-BQ=ognSsb3Kxx5ThJ5Q_GA_sFFFofpKY1=XnRS4-WTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu devel v9 PATCH 2/5] msf2: Microsemi
 Smartfusion2 System Register block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sundeep subbaraya <sundeep.lkml@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair23@gmail.com>

On 18 September 2017 at 14:27, sundeep subbaraya <sundeep.lkml@gmail.com> w=
rote:
> Hi Peter,
>
> On Mon, Sep 18, 2017 at 3:47 PM, sundeep subbaraya <sundeep.lkml@gmail.co=
m>
> wrote:
>>
>> Hi Philippe,
>>
>> On Mon, Sep 18, 2017 at 6:31 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsa=
t.org>
>> wrote:
>>>
>>> Hi Sundeep, Peter,
>>>
>>>
>>> On 09/15/2017 01:59 PM, Subbaraya Sundeep wrote:
>>>>
>>>> +static void msf2_sysreg_write(void *opaque, hwaddr offset,
>>>> +                          uint64_t val, unsigned size)
>>>> +{
>>>> +    MSF2SysregState *s =3D opaque;
>>>> +    uint32_t newval =3D val;
>>>> +
>>>> +    offset >>=3D 2;
>>>> +
>>>> +    switch (offset) {
>>>> +    case MSSDDR_PLL_STATUS:
>>>> +        trace_msf2_sysreg_write_pll_status();
>>>> +        break;
>>>> +
>>>> +    case ESRAM_CR:
>>>> +    case DDR_CR:
>>>> +    case ENVM_REMAP_BASE_CR:
>>>> +        if (newval !=3D s->regs[offset]) {
>>>> +            qemu_log_mask(LOG_UNIMP,
>>>> +                       TYPE_MSF2_SYSREG": remapping not supported\n")=
;
>>>
>>>
>>> I'd rather exit here than continue with inconsistent cpu, Peter what do
>>> you recommend?
>
>
> Could you please suggest.

We shouldn't exit QEMU for something the guest can provoke. If
the functionality isn't implemented then just LOG_UNIMP it.

thanks
-- PMM

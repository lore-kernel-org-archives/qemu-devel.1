Received: from eggs.gnu.org ([2001:4830:134:3::10]:53847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1d0YfE-0006SD-9H
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 15:19:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1d0YfD-0005BG-GC
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 15:19:48 -0400
Received: from mail-yb0-x241.google.com ([2607:f8b0:4002:c09::241]:35556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1d0YfD-0005BA-BU
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 15:19:47 -0400
Received: by mail-yb0-x241.google.com with SMTP id 19so98795ybl.2
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 12:19:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <507aa35d-83dc-2861-ab3f-1e185da8ca02@redhat.com>
References: <20170415192930.1443-1-bobby.prani@gmail.com>
	<CAFEAcA-JrBV6Vi21NRPk25u+NuiLG-untt7qbnqfdtd96f63TA@mail.gmail.com>
	<CAJhHMCBKQyOd8ZoDZWDV=NDu1PCx=6M8K1S0pfOr__H2TsR8sw@mail.gmail.com>
	<507aa35d-83dc-2861-ab3f-1e185da8ca02@redhat.com>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Tue, 18 Apr 2017 15:19:16 -0400
Message-ID: <CAJhHMCDyAwNC1NYnE_oq-XnJ41-OXXk42bEGbWoGAWdc2xKJxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] timer.h: Provide monotonic time for ARM
 guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Cao jin <caoj.fnst@cn.fujitsu.com>, Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>

On Tue, Apr 18, 2017 at 5:56 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 17/04/2017 20:55, Pranith Kumar wrote:
>>>> +/* ARM does not have a user-space readble cycle counter available.
>>>> + * This is a compromise to get monotonically increasing time.
>>>> + */
>>>> +static inline int64_t cpu_get_host_ticks(void)
>>>> +{
>>>> +    return get_clock();
>>>> +}
>>> This doesn't look like it should be ARM-specific. Is it
>>> better than the current default implementation? If so,
>>> why not make this the default implementation?
>>
>> I think we can do that...
>
> Yes, it is always better for emulation accuracy.  It may be much slower,
> depending on your OS (especially if get_clock requires a
> user->kernel->user transition), but the current code is quite broken.
>

OK, I sent an updated patch using get_clock() for all other cases.

--
Pranith

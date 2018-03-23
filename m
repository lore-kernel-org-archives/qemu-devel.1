Received: from eggs.gnu.org ([2001:4830:134:3::10]:47591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezJGZ-0006Nv-Sb
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 05:45:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezJGV-0004AV-Ru
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 05:45:43 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:45702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ezJGV-0004A8-MJ
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 05:45:39 -0400
Received: by mail-ot0-x242.google.com with SMTP id h26-v6so5138586otj.12
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 02:45:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <48f559bd-9f54-bcdd-1f3c-f6fafccfc54e@amsat.org>
References: <20180315133441.24149-1-peter.maydell@linaro.org>
	<20180322142343.jvc6pxxvl5zhfjgy@hawk.localdomain>
	<CAFEAcA8Vti8NnrQK4U4kLuk=nNMC5=KiKjc6wT7cLDnCHFj-8w@mail.gmail.com>
	<48f559bd-9f54-bcdd-1f3c-f6fafccfc54e@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Mar 2018 09:45:18 +0000
Message-ID: <CAFEAcA8fLGnPyM0R=O58BqYVYw6gbXtPcVQg0GFiM7n4=GWN8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-2.12] hw/intc/arm_gicv3: Fix
 secure-GIC NS ICC_PMR and ICC_RPR accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Andrew Jones <drjones@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 22 March 2018 at 20:42, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wr=
ote:
> Hi Peter,
>
> On 03/22/2018 03:29 PM, Peter Maydell wrote:
>> On 22 March 2018 at 14:23, Andrew Jones <drjones@redhat.com> wrote:
>>> On Thu, Mar 15, 2018 at 01:34:41PM +0000, Peter Maydell wrote:
>>>> If the GIC has the security extension support enabled, then a
>>>> non-secure access to ICC_PMR must take account of the non-secure
>>>> view of interrupt priorities, where real priorities 0..0x7f
>>>> are secure-only and not visible to the non-secure guest, and
>>>> priorities 0x80..0xff are shown to the guest as if they were
>>>> 0x00..0xff. We had the logic here wrong:
>>>
>>> 0x00..0x7f
>>
>> I think 0x00..0xff is correct.
>
> I guess Andrew only suggested to correct the hex prefix in your comment:
> - ... where real priorities 0..0x7f
> + ... where real priorities 0x00..0x7f

Oh, right. Yes, can do that. I was confused by the suggested correction
being directly under "0x00..0xff" in my commit message.

thanks
-- PMM

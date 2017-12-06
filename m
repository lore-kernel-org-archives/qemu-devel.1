Received: from eggs.gnu.org ([2001:4830:134:3::10]:33408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1eMXgH-00071f-PD
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 06:16:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1eMXgD-0004i7-SN
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 06:16:01 -0500
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:56316
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1eMXgD-0004ge-Lr
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 06:15:57 -0500
References: <CAGC02hTe8SijuwrM0ZGg04=To0GBnPUrC23iKuc-pao65vAAUQ@mail.gmail.com>
	<b36b0c95-4ddc-b818-522c-1bbec52138e8@adacore.com>
	<CAGC02hT7OvR1nbyD=AkOqPvxbNPz957=CPZsUxf1FJ73O8W52g@mail.gmail.com>
	<CAFEAcA8eDeKBnLW45=fPt3NeApMkvkiJzFEshvep_5qmwZKGXA@mail.gmail.com>
	<f79f9db0-20c0-aeee-6283-f912131dc551@adacore.com>
	<CAFEAcA_0-CczAFiFnKHVZWeoez6YLB6j0ffeoA=uK556U_NTOQ@mail.gmail.com>
	<9f64271d-7847-b44b-2bba-b0b49926bcfd@adacore.com>
	<7b448f9c-0ad2-aa5a-e76d-ce434abf57b9@redhat.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <a963af28-4a7f-6159-c18e-cfe8e861cebf@adacore.com>
Date: Wed, 6 Dec 2017 12:15:52 +0100
MIME-Version: 1.0
In-Reply-To: <7b448f9c-0ad2-aa5a-e76d-ce434abf57b9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 645662] x87 fpu emulation not accurate enough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, william lin <wlsaidhi@gmail.com>



On 11/29/2017 04:32 PM, Thomas Huth wrote:
> On 29.11.2017 16:20, KONRAD Frederic wrote:
>>
>>
>> On 11/29/2017 01:51 PM, Peter Maydell wrote:
>>> On 29 November 2017 at 12:47, KONRAD Frederic
>>> <frederic.konrad@adacore.com> wrote:
>>>> Maybe a little hack might work for x86 on x86 though.
>>>> Something like hardcoding the helper with an inline assembly
>>>> code?
>>>
>>> The set of people who want to emulate x86 on x86 is surely
>>> even smaller than the already tiny set of people who want to
>>> emulate x86 at all. I don't think it makes sense to add
>>> inline assembly hacks for that: QEMU should (as far as
>>> is reasonably possible) behave the same on all hosts.
>>>
>>
>> Sure it was a first step suggestion.
> 
> FYI, there is some code in WinUAE / Previous which might be usable, see
> e.g. WinUAE sources here:
> 
> https://github.com/tonioni/WinUAE/blob/master/softfloat/softfloat_fpsp.cpp
> 
> But the code is targetted for m68k only so far, so it likely needs some
> work, and we're currently discussing whether it's feasible to include it
> into QEMU at all, see this thread here:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg05342.html
> 
>   Thomas
> 

oops.

Hi Thomas sorry missed this mail.

I saw this thread, I'm not sure if m68k use the 80bits
arithmetic either.

BTW why don't we just use the long double cosl / sinl in the
helper?

It seems to me it can just fix the bug here (on linux host at
least, I think windows doesn't support them). We just lack the
long double <-> FloatX80 conversions here.

Fred

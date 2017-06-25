Received: from eggs.gnu.org ([2001:4830:134:3::10]:58309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dPBQv-0005YQ-LA
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 13:34:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dPBQr-0000VA-60
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 13:34:49 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:36398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dPBQq-0000UT-Ub
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 13:34:45 -0400
Received: by mail-wr0-x22b.google.com with SMTP id c11so124738026wrc.3
	for <qemu-devel@nongnu.org>; Sun, 25 Jun 2017 10:34:43 -0700 (PDT)
References: <CADR1n+V8R1LOGzbwdBDt5axeZ0mqh=WSCsfUo0Vr2nmE6BYqTQ@mail.gmail.com>
	<8760fqorbp.fsf@frigg.lan>
	<CAFEAcA-434=WhBxC=KB2HBhrPG9b+z1i3jqeFgiE=H8ceZJYzg@mail.gmail.com>
	<87mv91tn7d.fsf@linaro.org> <87r2y8gsy1.fsf@frigg.lan>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <87r2y8gsy1.fsf@frigg.lan>
Date: Sun, 25 Jun 2017 18:35:30 +0100
Message-ID: <87efu89di5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Tracing guest virtual addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jayanto Minocha <jayanto@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>


Lluís Vilanova <vilanova@ac.upc.edu> writes:

> Alex Bennée writes:
>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>
>>> On 20 June 2017 at 12:02, Lluís Vilanova <vilanova@ac.upc.edu> wrote:
>>>> Jayanto Minocha writes:
>>>>> But that is only used to instrument the cpu_ld/cpu_st macros, which is only
>>>>> called in the case of a tlb miss.
>>>>
>>>>> I've been going over the archives, and it looks like I need to instrument
>>>>> tcg_out_tlb_load. Am I on the right path ?
>>>>
>>>> That event should trace all guest memory accesses performed by the CPU. If you
>>>> found any case where this does not hold, it is likely a bug and I'd appreciate
>>>> it if you can point me to the smallest possible failing example.
>>>
>>> Does it catch memory accesses that are performed via helper functions,
>>> or only ones done by inline TCG code?
>
>> AFAICT it inserts a helper call on the TCG ld/st ops. I wonder why not
>> just ensure we always take the slow path and put the helpers in the
>> access functions there? You could even apply an address mask if you only
>> want to look at certain address ranges.
>
> It also catches accesses performed by helpers.

Don't helper accesses also pass through the SoftMMU? Or are we talking
about user-space access as well here?

>
>
> Cheers,
>   Lluis


--
Alex Bennée

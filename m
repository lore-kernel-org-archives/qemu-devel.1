Received: from eggs.gnu.org ([2001:4830:134:3::10]:36667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNgrE-0003mw-Pd
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNgrB-0003BH-N4
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:43:48 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:35968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dNgrB-0003Aw-Ey
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:43:45 -0400
Received: by mail-wr0-x22a.google.com with SMTP id c11so82539826wrc.3
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 07:43:45 -0700 (PDT)
References: <CADR1n+V8R1LOGzbwdBDt5axeZ0mqh=WSCsfUo0Vr2nmE6BYqTQ@mail.gmail.com>
	<8760fqorbp.fsf@frigg.lan>
	<CAFEAcA-434=WhBxC=KB2HBhrPG9b+z1i3jqeFgiE=H8ceZJYzg@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA-434=WhBxC=KB2HBhrPG9b+z1i3jqeFgiE=H8ceZJYzg@mail.gmail.com>
Date: Wed, 21 Jun 2017 15:44:22 +0100
Message-ID: <87mv91tn7d.fsf@linaro.org>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Jayanto Minocha <jayanto@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 20 June 2017 at 12:02, Lluís Vilanova <vilanova@ac.upc.edu> wrote:
>> Jayanto Minocha writes:
>>> But that is only used to instrument the cpu_ld/cpu_st macros, which is only
>>> called in the case of a tlb miss.
>>
>>> I've been going over the archives, and it looks like I need to instrument
>>> tcg_out_tlb_load. Am I on the right path ?
>>
>> That event should trace all guest memory accesses performed by the CPU. If you
>> found any case where this does not hold, it is likely a bug and I'd appreciate
>> it if you can point me to the smallest possible failing example.
>
> Does it catch memory accesses that are performed via helper functions,
> or only ones done by inline TCG code?

AFAICT it inserts a helper call on the TCG ld/st ops. I wonder why not
just ensure we always take the slow path and put the helpers in the
access functions there? You could even apply an address mask if you only
want to look at certain address ranges.

>
> thanks
> -- PMM


--
Alex Bennée

Received: from eggs.gnu.org ([2001:4830:134:3::10]:48332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ffAj0-000340-MU
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:08:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ffAix-0005mA-Gt
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:08:06 -0400
Date: Mon, 16 Jul 2018 23:08:01 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA-Lu=gZWQOROa+oEwaWP8FWSY__=jneDQZVK=mFXAcFMw@mail.gmail.com>
Message-ID: <alpine.BSF.2.21.1807162300430.15021@zero.eik.bme.hu>
References: <20180716195851.0FE177456B7@zero.eik.bme.hu>
	<CAFEAcA-Lu=gZWQOROa+oEwaWP8FWSY__=jneDQZVK=mFXAcFMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH] Do not enable QOM debugging by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 16 Jul 2018, Peter Maydell wrote:
> On 16 July 2018 at 20:47, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> Commit 3556c233d 5 years ago added an option to disable QOM debugging,
>> noting that it can have high performance cost but left the default to on.
>> Change the default to off and only enable it when debugging is requested
>> to avoid the performance penalty for those compiling without debug options.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>
> Looking at the code, doesn't this disable all the type checking
> on the QOM casts? That is not something I think we should drop,
> in the same way that we do not disable assert()s even in the
> non-debug build.
>
> Is this coming up as significant in profiling? In the past we've
> done some special casing if there are particular QOM casts in
> hot paths that use significant runtime.

My profiling results are not very accurate (could only gather sample based 
results with oprofile as --enable-gprof haven't worked for me) so I don't 
have numbers but I did see object_class_dynamic_cast_assert coming out 
among the top few without disabling this option but I don't know which 
call sites are responsible.

Are there any recommendations for profiling QEMU (especially TCG) 
somewhere that I should be aware of?

Regards,
BALATON Zoltan

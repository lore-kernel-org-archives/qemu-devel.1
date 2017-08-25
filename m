Received: from eggs.gnu.org ([2001:4830:134:3::10]:37789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dlAdK-00087A-5b
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:10:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dlAdJ-0005Ik-Al
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:10:30 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:37697)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dlAdJ-0005I5-4t
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:10:29 -0400
Received: by mail-wm0-x22d.google.com with SMTP id b189so7742341wmd.0
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 02:10:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1adde8d7-762f-8e89-7192-32d370b72af6@redhat.com>
References: <mailman.3749.1503600836.21955.qemu-devel@nongnu.org>
	<74846968-830E-4239-9DC7-B1252A5AC946@gmail.com>
	<60e13112-931d-a517-ddb1-20c2f2de736e@redhat.com>
	<9CE89958-B59C-4D3C-91C5-ECB4B153C43D@gmail.com>
	<89d8b7b1-fb0f-a967-927e-8795c7d2b324@redhat.com>
	<1adde8d7-762f-8e89-7192-32d370b72af6@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Aug 2017 10:10:07 +0100
Message-ID: <CAFEAcA-OiC_BxpK3_aBrkqie9B2AuefQRupJrnnfSq_asfQLNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Make test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>, Programmingkid <programmingkidx@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>

On 25 August 2017 at 06:49, Thomas Huth <thuth@redhat.com> wrote:
> On 25.08.2017 00:16, Cleber Rosa wrote:
>>
>> On 08/24/2017 05:50 PM, Programmingkid wrote:
>>>
>>> Thank you for the patches. I will test them. I was wondering what is the point to having both 'make check' and 'make test'. It looks like everyone is using 'make check'. Maybe we are better off removing the 'make test' target.
>>>
>>
>> I think the removing the `make test` target is a good thing, if its
>> tests are either absorbed by an existing `make check*` one.  Now that
>> depends on what people think the tcg tests (and others) deserve... TLC?
>> Total annihilation?
>
> Since we do not have very good test coverage for TCG yet, I'd like to
> see this rather fixed than removed! Could you please CC: me on future
> versions of your patch series (I missed v1)?

The problem is that we don't have a good framework for building
guest binaries to run under TCG. We should sort out one of those
so that it's easy for a new test to say "this is the .c file,
build it with an ARM gcc [eg using our docker stuff], then
run it with this QEMU command". When we have that it should
be straightforward to convert the 'make test' tests to use
that, and they can be run under 'make check'.

thanks
-- PMM

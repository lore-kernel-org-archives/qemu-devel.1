Received: from eggs.gnu.org ([2001:4830:134:3::10]:47087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eIAti-00041k-OJ
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 05:07:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eIAtc-0000I3-R4
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 05:07:50 -0500
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:38417)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eIAtc-0000HZ-Kq
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 05:07:44 -0500
Received: by mail-oi0-x229.google.com with SMTP id g139so4805158oic.5
	for <qemu-devel@nongnu.org>; Fri, 24 Nov 2017 02:07:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <d25e4d2f-2ca2-55fb-f314-8ed17da22b9b@redhat.com>
References: <20171122084157.11480-1-quintela@redhat.com>
	<4e926520-1b21-5aad-6a5c-3a8d11a8ea80@linaro.org>
	<CAFEAcA_i2rumOMHVa7t4nQhHoM6zWgD1mPC5QbcqGermiO3eeQ@mail.gmail.com>
	<e384f727-0cdd-9fcd-a50f-a9f89ae2272a@linaro.org>
	<CAFEAcA9zwnY5+=Em2gta7HVoKGv2EBS3UVH+zbwCzOCovyUVdg@mail.gmail.com>
	<d25e4d2f-2ca2-55fb-f314-8ed17da22b9b@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Nov 2017 10:07:23 +0000
Message-ID: <CAFEAcA_H2pF6qsW_pC9u6nRS7xwU5SHN8L6Eo6e==3Y-tqRv4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tcg: Fix complilation with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On 23 November 2017 at 22:08, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 22/11/2017 13:14, Peter Maydell wrote:
>>> We do this all of the time for more regular tests that are obviously
>>> compile-time.  I am a really big fan of this, because it makes sure that the
>>> (usually 32-bit) else branch continues to compile.
>> I'm happy with code that is "we assume the compiler is going to
>> be sensible here so we don't have to use #ifdefs in the name
>> of performance". I just don't think we should write code that
>> can't compile at all if the compiler happens to not identify
>> the codepath as dead. There's no guarantee by the compiler
>> that it's going to do that.
>
> There's plenty of cases where "if (kvm_enabled())" code would fail to
> link if the compiler didn't do that optimization.

I think that's a step less weird than "assert(kvm_enabled())",
but I tend to think of that kind of thing as "if the compiler
ever did decide not to link it we'd add missing stub functions".

thanks
-- PMM

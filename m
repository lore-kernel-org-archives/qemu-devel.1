Received: from eggs.gnu.org ([2001:4830:134:3::10]:49311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eIAvz-00054J-5i
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 05:10:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eIAvv-0002qK-Dx
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 05:10:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eIAvv-0002pV-6h
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 05:10:07 -0500
References: <20171122084157.11480-1-quintela@redhat.com>
	<4e926520-1b21-5aad-6a5c-3a8d11a8ea80@linaro.org>
	<CAFEAcA_i2rumOMHVa7t4nQhHoM6zWgD1mPC5QbcqGermiO3eeQ@mail.gmail.com>
	<e384f727-0cdd-9fcd-a50f-a9f89ae2272a@linaro.org>
	<CAFEAcA9zwnY5+=Em2gta7HVoKGv2EBS3UVH+zbwCzOCovyUVdg@mail.gmail.com>
	<d25e4d2f-2ca2-55fb-f314-8ed17da22b9b@redhat.com>
	<CAFEAcA_H2pF6qsW_pC9u6nRS7xwU5SHN8L6Eo6e==3Y-tqRv4w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b4ce1a99-9be7-c7eb-1867-5c873623d2a7@redhat.com>
Date: Fri, 24 Nov 2017 11:09:58 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_H2pF6qsW_pC9u6nRS7xwU5SHN8L6Eo6e==3Y-tqRv4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg: Fix complilation with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On 24/11/2017 11:07, Peter Maydell wrote:
> On 23 November 2017 at 22:08, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> On 22/11/2017 13:14, Peter Maydell wrote:
>>>> We do this all of the time for more regular tests that are obviously
>>>> compile-time.  I am a really big fan of this, because it makes sure that the
>>>> (usually 32-bit) else branch continues to compile.
>>> I'm happy with code that is "we assume the compiler is going to
>>> be sensible here so we don't have to use #ifdefs in the name
>>> of performance". I just don't think we should write code that
>>> can't compile at all if the compiler happens to not identify
>>> the codepath as dead. There's no guarantee by the compiler
>>> that it's going to do that.
>> There's plenty of cases where "if (kvm_enabled())" code would fail to
>> link if the compiler didn't do that optimization.
>
> I think that's a step less weird than "assert(kvm_enabled())",
> but I tend to think of that kind of thing as "if the compiler
> ever did decide not to link it we'd add missing stub functions".

I'll take a look at moving all the notdirty_* stuff under #ifdef
CONFIG_TCG then, for now we can proceed with Juan's patch.

Thanks,

Paolo

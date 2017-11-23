Received: from eggs.gnu.org ([2001:4830:134:3::10]:50684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHzfg-0003HT-0Z
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 17:08:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHzfc-0001H3-Rs
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 17:08:35 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eHzfc-0001GF-KF
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 17:08:32 -0500
Received: by mail-wm0-f41.google.com with SMTP id v186so19115542wma.2
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 14:08:32 -0800 (PST)
References: <20171122084157.11480-1-quintela@redhat.com>
	<4e926520-1b21-5aad-6a5c-3a8d11a8ea80@linaro.org>
	<CAFEAcA_i2rumOMHVa7t4nQhHoM6zWgD1mPC5QbcqGermiO3eeQ@mail.gmail.com>
	<e384f727-0cdd-9fcd-a50f-a9f89ae2272a@linaro.org>
	<CAFEAcA9zwnY5+=Em2gta7HVoKGv2EBS3UVH+zbwCzOCovyUVdg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d25e4d2f-2ca2-55fb-f314-8ed17da22b9b@redhat.com>
Date: Thu, 23 Nov 2017 23:08:27 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9zwnY5+=Em2gta7HVoKGv2EBS3UVH+zbwCzOCovyUVdg@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On 22/11/2017 13:14, Peter Maydell wrote:
>> We do this all of the time for more regular tests that are obviously
>> compile-time.  I am a really big fan of this, because it makes sure that the
>> (usually 32-bit) else branch continues to compile.
> I'm happy with code that is "we assume the compiler is going to
> be sensible here so we don't have to use #ifdefs in the name
> of performance". I just don't think we should write code that
> can't compile at all if the compiler happens to not identify
> the codepath as dead. There's no guarantee by the compiler
> that it's going to do that.

There's plenty of cases where "if (kvm_enabled())" code would fail to
link if the compiler didn't do that optimization.

(In fact, it's one of the very few optimizations that the compiler
performs at -O0, because it's extremely effective).

Paolo

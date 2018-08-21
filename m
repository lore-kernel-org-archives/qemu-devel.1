Received: from eggs.gnu.org ([2001:4830:134:3::10]:44167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fs7IS-0001pL-Rm
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:06:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fs7IO-0003fk-Jg
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:06:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fs7IO-0003ee-1o
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:06:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id 20-v6so10010407wrb.12
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 07:06:06 -0700 (PDT)
References: <20180817051853.23792-1-cota@braap.org>
	<20180817051853.23792-2-cota@braap.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d6414d6c-82d4-f76a-c8af-1ed3bab7229b@redhat.com>
Date: Tue, 21 Aug 2018 16:06:01 +0200
MIME-Version: 1.0
In-Reply-To: <20180817051853.23792-2-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/9] qsp: QEMU's Synchronization Profiler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Stefan Weil <sw@weilnetz.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>

On 17/08/2018 07:18, Emilio G. Cota wrote:
> +
> +#define qemu_rec_trymutex_lock(m) ({                            \
> +            QemuRecMutexTrylockFunc _f;                         \
> +            _f = atomic_read(&qemu_rec_mutex_trylock_func);     \
> +            _f(m, __FILE__, __LINE__);                          \
> +        })
> +

Obvious typo (found by clang's -Winfinite-recursion, how it detects it
is left as an exercise to the reader; it's not obvious and I like this
clang warning even though the first impression is "why would you need
it"), fixed while applying.

Paolo

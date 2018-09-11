Received: from eggs.gnu.org ([2001:4830:134:3::10]:60381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fzi1I-0006Cz-C9
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 08:43:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fzi1C-0008Pf-N2
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 08:43:51 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1fzi1A-0008D3-Pd
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 08:43:45 -0400
Received: by mail-pg1-x543.google.com with SMTP id 7-v6so12224094pgf.2
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 05:43:41 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180910232752.31565-1-cota@braap.org>
	<20180910232752.31565-3-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f6d7f508-eee6-cc53-248c-9553b68d15f5@twiddle.net>
Date: Tue, 11 Sep 2018 05:43:38 -0700
MIME-Version: 1.0
In-Reply-To: <20180910232752.31565-3-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/12] util: add atomic64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

On 09/10/2018 04:27 PM, Emilio G. Cota wrote:
> +#define GEN_READ(name, type)                    \
> +    type name(const type *ptr)                  \
> +    {                                           \
> +        QemuSpin *lock = addr_to_lock(ptr);     \
> +        type ret;                               \
> +                                                \
> +        qemu_spin_lock(lock);                   \
> +        ret = *ptr;                             \
> +        qemu_spin_unlock(lock);                 \
> +        return ret;                             \
> +    }
> +
> +GEN_READ(atomic_read_i64, int64_t)
> +GEN_READ(atomic_read_u64, uint64_t)

Is there really a good reason to have two external
functions instead of having one of them inline and
perform a cast?

Is this any better than using libatomic?


r~

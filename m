Received: from eggs.gnu.org ([2001:4830:134:3::10]:46171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dvKlE-0007qu-9G
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:00:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dvKl8-0000S9-On
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:00:40 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:45494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dvKl8-0000Ra-GP
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:00:34 -0400
Received: by mail-wm0-x22a.google.com with SMTP id q124so2382297wmb.0
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 03:00:34 -0700 (PDT)
References: <20170921162746.11761-1-pbonzini@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170921162746.11761-1-pbonzini@redhat.com>
Date: Fri, 22 Sep 2017 11:00:35 +0100
Message-ID: <87bmm3cat8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] atomic: update documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org


Paolo Bonzini <pbonzini@redhat.com> writes:

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  docs/devel/atomics.txt | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/docs/devel/atomics.txt b/docs/devel/atomics.txt
> index 3ef5d85b1b..048e5f23cb 100644
> --- a/docs/devel/atomics.txt
> +++ b/docs/devel/atomics.txt
> @@ -63,11 +63,22 @@ operations:
>      typeof(*ptr) atomic_fetch_sub(ptr, val)
>      typeof(*ptr) atomic_fetch_and(ptr, val)
>      typeof(*ptr) atomic_fetch_or(ptr, val)
> +    typeof(*ptr) atomic_fetch_xor(ptr, val)
>      typeof(*ptr) atomic_xchg(ptr, val)
>      typeof(*ptr) atomic_cmpxchg(ptr, old, new)
>
>  all of which return the old value of *ptr.  These operations are
> -polymorphic; they operate on any type that is as wide as an int.
> +polymorphic; they operate on any type that is as wide as a pointer.
> +
> +Similar operations return the new value of *ptr:
> +
> +    typeof(*ptr) atomic_inc_fetch(ptr)
> +    typeof(*ptr) atomic_dec_fetch(ptr)
> +    typeof(*ptr) atomic_add_fetch(ptr, val)
> +    typeof(*ptr) atomic_sub_fetch(ptr, val)
> +    typeof(*ptr) atomic_and_fetch(ptr, val)
> +    typeof(*ptr) atomic_or_fetch(ptr, val)
> +    typeof(*ptr) atomic_xor_fetch(ptr, val)
>
>  Sequentially consistent loads and stores can be done using:


--
Alex Bennée

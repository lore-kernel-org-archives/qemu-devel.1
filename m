Received: from eggs.gnu.org ([2001:4830:134:3::10]:60574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSgJU-0001oR-3l
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 05:46:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSgJQ-00060M-Qb
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 05:46:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:3687)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gSgJQ-00060D-Hh
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 05:46:20 -0500
References: <1543574620-17506-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <62eed37c-b39c-5afb-586f-0b3cd9741351@redhat.com>
Date: Fri, 30 Nov 2018 11:46:12 +0100
MIME-Version: 1.0
In-Reply-To: <1543574620-17506-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0] compiler.h: Add an explicit check
 for the compiler version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, berrange@redhat.com, peter.maydell@linaro.org

On 30/11/18 11:43, Thomas Huth wrote:
> The questions about our minimum compiler requirement pops up every
> couple of months, and we then have to recall the details each time.
> So let's document this in a proper way, by adding a comment and
> check for the right compiler version to our compiler.h header.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  include/qemu/compiler.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index ca9bc85..775446b 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -22,6 +22,14 @@
>  # define QEMU_GNUC_PREREQ(maj, min) 0
>  #endif
>  
> +/*
> + * We need at least GCC 4.1 for atomics support. Clang also supports these,
> + * and reports itself as GCC 4.2, so it passes this check, too.
> + */
> +#if !QEMU_GNUC_PREREQ(4, 1)
> +#error QEMU needs a compiler that is compatible with GCC v4.1 or newer
> +#endif
> +
>  #define QEMU_NORETURN __attribute__ ((__noreturn__))
>  
>  #define QEMU_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
> 

Queued, thanks.

Paolo

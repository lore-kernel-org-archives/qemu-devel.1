Received: from eggs.gnu.org ([2001:4830:134:3::10]:34716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gX6un-0005cw-7Q
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:59:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gX6uk-0004iB-1b
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:59:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:12717)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gX6uj-0004hJ-NZ
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:59:09 -0500
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
	<1544628195-37728-25-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3a3ae193-f083-f294-6b77-c31a07f6ea3e@redhat.com>
Date: Wed, 12 Dec 2018 16:59:06 +0100
MIME-Version: 1.0
In-Reply-To: <1544628195-37728-25-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 24/54] compiler.h: Add an explicit check for
 the compiler version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On 2018-12-12 16:22, Paolo Bonzini wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The questions about our minimum compiler requirement pops up every
> couple of months, and we then have to recall the details each time.
> So let's document this in a proper way, by adding a comment and
> check for the right compiler version to our compiler.h header.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <1543574620-17506-1-git-send-email-thuth@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qemu/compiler.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index 6b92710..6f32ec2 100644
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

You can drop this patch, it has been obsoleted by the configure check.

 Thomas

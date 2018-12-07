Received: from eggs.gnu.org ([2001:4830:134:3::10]:46276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVIyy-0003bE-DD
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:28:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVIyv-0007OI-97
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:28:04 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:34844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gVIyu-0007Fx-M5
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:28:00 -0500
Received: by mail-ot1-x32e.google.com with SMTP id 81so4329974otj.2
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 08:27:59 -0800 (PST)
References: <1543937577-28256-1-git-send-email-thuth@redhat.com>
	<1543937577-28256-2-git-send-email-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b5f4bb3b-5c07-f50a-b689-4ea98b73f0bc@linaro.org>
Date: Fri, 7 Dec 2018 10:27:55 -0600
MIME-Version: 1.0
In-Reply-To: <1543937577-28256-2-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2 1/7] configure: Add a test for
 the minimum compiler version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>

On 12/4/18 9:32 AM, Thomas Huth wrote:
> +# Check whether the compiler matches our minimum requirements:
> +cat > $TMPC << EOF
> +#if defined(__clang_major__) && defined(__clang_minor__)
> +# ifdef __apple_build_version__
> +#  if __clang_major__ < 5 || (__clang_major__ == 5 && __clang_minor__ < 1)
> +#   error You need at least XCode Clang v5.1 to compile QEMU
> +#  endif
> +# else
> +#  if __clang_major__ < 3 || (__clang_major__ == 3 && __clang_minor__ < 4)
> +#   error You need at least Clang v3.4 to compile QEMU
> +#  endif
> +# endif
> +#elif defined(__GNUC__) && defined(__GNUC_MINOR__)
> +# if __GNUC__ < 4 || (__GNUC__ == 4 && __GNUC_MINOR__ < 8)
> +#  error You need at least GCC v4.8 to compile QEMU
> +# endif
> +#else
> +# error You either need GCC or Clang to compiler QEMU
> +#endif
> +int main (void) { return 0; }
> +EOF
> +if ! compile_prog "" "" ; then
> +    error_exit "You need at least GCC v4.8 or Clang v3.4 (or XCode Clang v5.1)"
> +fi

I wonder if we could capture the actual error message that you used during the
test and feed that back to the user.  That said,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTqqw-0008HT-I0
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:13:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTqqt-0007TI-Dy
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:13:46 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gTqqt-0007Rj-8r
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:13:43 -0500
Received: by mail-ot1-x344.google.com with SMTP id 40so12099844oth.4
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 08:13:43 -0800 (PST)
References: <1543845937-300-1-git-send-email-thuth@redhat.com>
	<1543845937-300-6-git-send-email-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <649c046d-e3a0-e2b9-a6cb-9df5405834ab@linaro.org>
Date: Mon, 3 Dec 2018 10:13:38 -0600
MIME-Version: 1.0
In-Reply-To: <1543845937-300-6-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 5/7] tcg/tcg.h: Remove GCC check
 for tcg_debug_assert() macro
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

On 12/3/18 8:05 AM, Thomas Huth wrote:
> Both GCC v4.8 and Clang v3.4 support (our minimum versions) support
> __builtin_unreachable(), so we can remove the version check here now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tcg/tcg.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

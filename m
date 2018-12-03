Received: from eggs.gnu.org ([2001:4830:134:3::10]:39843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTqy1-0007sF-35
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:21:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTqxv-0006Nq-KM
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:21:05 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gTqxv-0006Ne-Fe
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:20:59 -0500
Received: by mail-oi1-x241.google.com with SMTP id x23so11416823oix.3
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 08:20:59 -0800 (PST)
References: <1543845937-300-1-git-send-email-thuth@redhat.com>
	<1543845937-300-8-git-send-email-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3759f21c-bd8e-d10b-0f85-38191c9533ad@linaro.org>
Date: Mon, 3 Dec 2018 10:20:55 -0600
MIME-Version: 1.0
In-Reply-To: <1543845937-300-8-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 7/7] includes: Replace
 QEMU_GNUC_PREREQ with "__has_builtin || !defined(__clang__)"
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
> Since we require GCC version 4.8 or newer now, we can be sure that
> the builtin functions are always available on GCC. And for Clang,
> we can check the availablility with __has_builtin instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  include/qemu/compiler.h   | 2 +-
>  include/qemu/host-utils.h | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

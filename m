Received: from eggs.gnu.org ([2001:4830:134:3::10]:36807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTqqN-0006uW-Bn
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:13:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTqqK-0006ls-8a
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:13:11 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gTqqK-0006le-3X
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:13:08 -0500
Received: by mail-ot1-x341.google.com with SMTP id u16so12089745otk.8
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 08:13:08 -0800 (PST)
References: <1543845937-300-1-git-send-email-thuth@redhat.com>
	<1543845937-300-5-git-send-email-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <82dae6b6-071f-be85-0982-80cedb3e0d9a@linaro.org>
Date: Mon, 3 Dec 2018 10:13:04 -0600
MIME-Version: 1.0
In-Reply-To: <1543845937-300-5-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 4/7] Remove QEMU_ARTIFICIAL macro
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
> The code that used it has already been removed a while ago with commit
> dc41aa7d34989b552ef ("tcg: Remove GET_TCGV_* and MAKE_TCGV_*").
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  include/qemu/compiler.h    | 6 ------
>  scripts/checkpatch.pl      | 1 -
>  scripts/cocci-macro-file.h | 1 -
>  3 files changed, 8 deletions(-)

Eh.  In theory this could be added to some of the other trivial interface
inline functions that we have, in order to ease the debugging experience.  But
since we're not actually doing that, removing this is also fine.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

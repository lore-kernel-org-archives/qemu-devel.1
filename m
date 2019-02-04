Received: from eggs.gnu.org ([209.51.188.92]:52070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqh5Y-0002de-TD
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 11:27:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqh5U-00035G-Kd
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 11:27:14 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:38388)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gqh5U-00032W-Ag
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 11:27:12 -0500
Received: by mail-wm1-x332.google.com with SMTP id m22so545196wml.3
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 08:27:06 -0800 (PST)
References: <1549294992-46543-1-git-send-email-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f826ac1d-ce19-c739-50ea-37762b88455a@linaro.org>
Date: Mon, 4 Feb 2019 16:27:02 +0000
MIME-Version: 1.0
In-Reply-To: <1549294992-46543-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] queue: fix QTAILQ_FOREACH_REVERSE_SAFE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com

On 2/4/19 3:43 PM, Paolo Bonzini wrote:
> The iteration was stopping as soon as prev_var was set to NULL, and
> therefore it skipped the first element.  Fortunately, or unfortunately,
> we have only one use of QTAILQ_FOREACH_REVERSE_SAFE.  Thus this only
> showed up as incorrect register preferences on the very first translation
> block that was compiled.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qemu/queue.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

Received: from eggs.gnu.org ([209.51.188.92]:47465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gj9yB-0003e9-Uq
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 16:40:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gj9y7-0007wl-9X
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 16:40:31 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:37007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gj9y4-0007mF-J6
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 16:40:25 -0500
Received: by mail-pl1-x62d.google.com with SMTP id b5so237044plr.4
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 13:40:18 -0800 (PST)
References: <1547467955-17245-1-git-send-email-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6fd5dadf-a0ff-ac50-b2a5-997c87f5aef4@linaro.org>
Date: Tue, 15 Jan 2019 08:40:10 +1100
MIME-Version: 1.0
In-Reply-To: <1547467955-17245-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] include/fpu/softfloat: Fix compilation
 with Clang on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org

On 1/14/19 11:12 PM, Thomas Huth wrote:
> Clang v7.0.1 does not like the __int128 variable type for inline
> assembly on s390x:
> 
> In file included from fpu/softfloat.c:97:
> include/fpu/softfloat-macros.h:647:9: error: inline asm error:
>  This value type register class is not natively supported!
>     asm("dlgr %0, %1" : "+r"(n) : "r"(d));
>         ^
> 
> Disable this code part there now when compiling with Clang, so that
> the generic code gets used instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  include/fpu/softfloat-macros.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Regardless of whatever follow-up we might do wrt CONFIG_INT128.


r~

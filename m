Received: from eggs.gnu.org ([209.51.188.92]:41122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ghLL6-00053l-9X
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 16:24:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ghLL5-0008Sy-3n
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 16:24:40 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:44035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ghLL4-0007ve-Ry
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 16:24:39 -0500
Received: by mail-pl1-x641.google.com with SMTP id e11so4149077plt.11
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 13:23:49 -0800 (PST)
References: <1547051976-13982-1-git-send-email-thuth@redhat.com>
	<1547051976-13982-3-git-send-email-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <badd808e-711c-b7e0-f669-c21b7d344850@linaro.org>
Date: Thu, 10 Jan 2019 08:23:41 +1100
MIME-Version: 1.0
In-Reply-To: <1547051976-13982-3-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/2] configure: Force the C standard to
 gnu99
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>

On 1/10/19 3:39 AM, Thomas Huth wrote:
> Different versions of GCC and Clang use different versions of the C standard.
> This repeatedly caused problems already, e.g. with duplicated typedefs:
> 
>  https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg05829.html
> 
> or with for-loop variable initializers:
> 
>  https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00237.html
> 
> To avoid these problems, we should enforce the C language version to the
> same level for all compilers. Since our minimum compiler versions is
> GCC v4.8, our best option is "gnu99" for C code right now ("gnu17" is not
> available there yet, and "gnu11" is marked as "experimental"), and "gnu++98"
> for the few C++ code that we have in the repository.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v3: Compile C++ code with -std=gnu++98

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

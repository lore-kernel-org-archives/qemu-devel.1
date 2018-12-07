Received: from eggs.gnu.org ([2001:4830:134:3::10]:46421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVIzU-0005Of-SE
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:28:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVIzR-000142-Hw
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:28:36 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:46584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gVIzR-00012b-9C
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:28:33 -0500
Received: by mail-ot1-x32e.google.com with SMTP id w25so4265943otm.13
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 08:28:33 -0800 (PST)
References: <1543937577-28256-1-git-send-email-thuth@redhat.com>
	<1543937577-28256-6-git-send-email-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1c526f15-7e97-bf9d-87ee-dc9cd7b77ec0@linaro.org>
Date: Fri, 7 Dec 2018 10:28:29 -0600
MIME-Version: 1.0
In-Reply-To: <1543937577-28256-6-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2 5/7] audio/alsaaudio: Remove
 compiler check around pragma
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
> Both GCC v4.8 and Clang v3.4 support the -Waddress option, so we do
> not need the compiler version check here anymore.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  audio/alsaaudio.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

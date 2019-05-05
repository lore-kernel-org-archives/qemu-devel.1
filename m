Received: from eggs.gnu.org ([209.51.188.92]:36843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNKjA-00029H-0W
	for qemu-devel@nongnu.org; Sun, 05 May 2019 13:15:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNKj9-0000Yp-80
	for qemu-devel@nongnu.org; Sun, 05 May 2019 13:15:03 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:43815)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNKj8-0000Xo-W3
	for qemu-devel@nongnu.org; Sun, 05 May 2019 13:15:03 -0400
Received: by mail-pl1-x641.google.com with SMTP id n8so5139984plp.10
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 10:15:02 -0700 (PDT)
References: <20190504120528.6389-1-pbonzini@redhat.com>
	<20190504120528.6389-9-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ce18b2de-9518-d94e-758d-8d79db5c2f8c@linaro.org>
Date: Sun, 5 May 2019 10:14:58 -0700
MIME-Version: 1.0
In-Reply-To: <20190504120528.6389-9-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 8/9] tcg/i386: add support for IBT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com

On 5/4/19 5:05 AM, Paolo Bonzini wrote:
> Add endbr annotations before indirect branch targets.  This lets QEMU enable
> IBT even for TCG-enabled builds.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Makefile.target           |  2 ++
>  configure                 |  9 +++++++++
>  include/qemu/cpuid.h      |  5 +++++
>  tcg/i386/tcg-target.inc.c | 19 +++++++++++++++++++
>  4 files changed, 35 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

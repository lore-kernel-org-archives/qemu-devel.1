Received: from eggs.gnu.org ([2001:4830:134:3::10]:57132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1voM-0000e3-HL
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:47:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1voI-0005I6-Sc
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:47:10 -0400
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231]:46440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e1voI-0005HX-MD
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:47:06 -0400
Received: by mail-pf0-x231.google.com with SMTP id p87so8401466pfj.3
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 07:47:06 -0700 (PDT)
References: <20171010102655.23322-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e53dac45-195e-88d2-fd50-083658cb6d4d@linaro.org>
Date: Tue, 10 Oct 2017 07:47:03 -0700
MIME-Version: 1.0
In-Reply-To: <20171010102655.23322-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] build: remove CONFIG_LIBDECNUMBER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org

On 10/10/2017 03:26 AM, Paolo Bonzini wrote:
> It is used only by PPC TCG, so just move it in target/ppc/Makefile.objs
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

FWIW, it *should* be used by target/s390x as well.

> diff --git a/target/ppc/Makefile.objs b/target/ppc/Makefile.objs
> index f92ba67ebd..ba61012bef 100644
> --- a/target/ppc/Makefile.objs
> +++ b/target/ppc/Makefile.objs
> @@ -15,5 +15,10 @@ obj-y += int_helper.o
>  obj-y += timebase_helper.o
>  obj-y += misc_helper.o
>  obj-y += mem_helper.o
> +obj-y += ../../libdecnumber/decContext.o
> +obj-y += ../../libdecnumber/decNumber.o
> +obj-y += ../../libdecnumber/dpd/decimal32.o
> +obj-y += ../../libdecnumber/dpd/decimal64.o
> +obj-y += ../../libdecnumber/dpd/decimal128.o
>  obj-$(CONFIG_USER_ONLY) += user_only_helper.o
>  obj-y += gdbstub.o

I suppose this isn't horrible, if it needed to be replicated.


r~

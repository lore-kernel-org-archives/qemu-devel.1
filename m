Received: from eggs.gnu.org ([209.51.188.92]:35928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNKeV-0000rU-Kj
	for qemu-devel@nongnu.org; Sun, 05 May 2019 13:10:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNKeR-0004eV-P5
	for qemu-devel@nongnu.org; Sun, 05 May 2019 13:10:13 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:43737)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNKeN-0004Zx-Qs
	for qemu-devel@nongnu.org; Sun, 05 May 2019 13:10:08 -0400
Received: by mail-pg1-x530.google.com with SMTP id t22so5232233pgi.10
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 10:10:07 -0700 (PDT)
References: <20190504120528.6389-1-pbonzini@redhat.com>
	<20190504120528.6389-6-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <21e07bbe-8b37-f2c7-8144-c303f41175d9@linaro.org>
Date: Sun, 5 May 2019 10:10:02 -0700
MIME-Version: 1.0
In-Reply-To: <20190504120528.6389-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/9] coroutine: add host specific coroutine
 backend for 64-bit s390
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
> +  "bras %%r3, 1f\n"                /* source PC will be after the BR */ \
> +  "1: aghi %%r3, 12\n"             /* 4 */                              \
> +  "stg %%r3, %[SCRATCH](%%r1)\n"   /* 6 save switch-back PC */          \
> +  "br %%r4\n"                      /* 2 jump to destination PC */       \

Better as

	larl	%r3, 2f
	stg	%r3, SCRATCH(%r1)
	br	%r4
2:


r~

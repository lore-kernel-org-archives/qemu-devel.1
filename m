Received: from eggs.gnu.org ([209.51.188.92]:48707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz9Xq-0001iJ-5E
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 19:27:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz9Xo-0008NW-7F
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 19:27:25 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:38518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gz9Xm-0007Ky-Vz
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 19:27:23 -0500
Received: by mail-pg1-x52d.google.com with SMTP id m2so8780652pgl.5
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 16:27:02 -0800 (PST)
References: <20190227111411.22890-1-david@redhat.com>
	<20190227111411.22890-2-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <57af4a2b-5d9f-6d5e-05bd-db84781feed0@linaro.org>
Date: Wed, 27 Feb 2019 16:26:57 -0800
MIME-Version: 1.0
In-Reply-To: <20190227111411.22890-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 1/2] tests/tcg: Allow targets to set
 the optimization level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-s390x@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

On 2/27/19 3:14 AM, David Hildenbrand wrote:
> Especially for inline asm with immediates;
> 
> static inline void some_instr(uint8_t imm)
> {
>     asm volatile("...", :: "i" (imm));
> }
> 
> static void test()
> {
>     some_instr(1);
> }

FWIW, __attribute__((always_inline)) should work even with -O0.


r~

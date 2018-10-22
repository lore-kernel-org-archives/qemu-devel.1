Received: from eggs.gnu.org ([2001:4830:134:3::10]:34970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEepk-0008QG-Fu
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:21:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEepf-0000xt-2q
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:21:44 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:51137)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEepe-0000wK-Lj
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:21:39 -0400
Received: by mail-wm1-x332.google.com with SMTP id i8-v6so11234652wmg.0
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 11:21:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
References: <20181022181623.8810-1-richard.henderson@linaro.org>
Message-ID: <1aa75fe6-f68a-bfba-1570-98e881f3d9e3@linaro.org>
Date: Mon, 22 Oct 2018 19:21:34 +0100
MIME-Version: 1.0
In-Reply-To: <20181022181623.8810-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH, build fix] osdep: Work around MinGW assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 10/22/18 7:16 PM, Richard Henderson wrote:
> + * not marked a noreturn, so the compiler cannot delete code following an

Bah.  Peter, if you apply this directly, can you please fix the grammar around
"marked a return" (either s/a/as/ or s/a// sound equally plausible for me).


r~

Received: from eggs.gnu.org ([209.51.188.92]:59044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hL88h-0004oi-RM
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:24:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hL88h-0005Qy-2V
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:24:19 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:40676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hL88g-0005Q3-RC
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:24:19 -0400
Received: by mail-pg1-x52c.google.com with SMTP id d31so5309104pgl.7
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 08:24:18 -0700 (PDT)
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-32-richard.henderson@linaro.org>
	<CAFEAcA9nWq44C=m3exNJBO-YpheGRdzzAL529uCaFtUNGCWGkQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ad201251-ce90-3680-74be-259189579c0e@linaro.org>
Date: Mon, 29 Apr 2019 08:23:58 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9nWq44C=m3exNJBO-YpheGRdzzAL529uCaFtUNGCWGkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 31/36] cpu: Introduce
 CPUNegativeOffsetState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 4/29/19 7:43 AM, Peter Maydell wrote:
> It would be nice if we could do a compile-time assert that
>  offsetof(CPUArchState, neg) + sizeof(CPUNegativeOffsetState)
>   == offsetof(CPUArchState, env)
> 
> but I guess the possibility of within-struct padding
> between the two structs makes that dubious. Or does our
> generated code rely on there being no padding between neg
> and env anyway ?

It would be nice, but there *is* padding for some targets.


r~

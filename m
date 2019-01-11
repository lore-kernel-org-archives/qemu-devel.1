Received: from eggs.gnu.org ([209.51.188.92]:48875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gi3tm-0003P5-Ld
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 15:59:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gi3tl-0000Td-5W
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 15:59:26 -0500
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:42202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gi3tl-0000TS-1O
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 15:59:25 -0500
Received: by mail-yb1-xb41.google.com with SMTP id q145so6358144ybq.9
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 12:59:24 -0800 (PST)
MIME-Version: 1.0
References: <20190111114918.27893-1-jcmvbkbc@gmail.com>
	<c75e59c4-7602-a737-16bb-8e5c4d0a6085@linaro.org>
In-Reply-To: <c75e59c4-7602-a737-16bb-8e5c4d0a6085@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 11 Jan 2019 12:59:12 -0800
Message-ID: <CAMo8Bf+U7PAikAbu-1ON81a2dYdA+tUQ-zuCzOLPm98MLZWPqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/xtensa: rework zero overhead loops
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Fri, Jan 11, 2019 at 12:53 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 1/11/19 10:49 PM, Max Filippov wrote:
> > +#define LINKABLE_BITS 12
> > +#define LINKABLE_SIZE (1u << LINKABLE_BITS)
> > +#define LINKABLE_MASK (-LINKABLE_SIZE)
>
> What is this for?  It seems to be replicating TARGET_PAGE_BITS.

I used it to play with different sizes of regions where direct TB chaining
is allowed. In linux-user it is possible to have it bigger than the page size.
It looks like the optimum is somewhere in the range 10..12.
I left it there because it looks logically independent from the page size,
but I sure can drop it.

-- 
Thanks.
-- Max

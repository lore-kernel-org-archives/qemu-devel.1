Received: from eggs.gnu.org ([209.51.188.92]:40725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gi5Gy-0004sL-PO
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 17:27:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gi5Gw-000814-40
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 17:27:28 -0500
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:35830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gi5Gv-00080j-PA
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 17:27:25 -0500
Received: by mail-yb1-xb44.google.com with SMTP id f187so6457270ybb.2
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 14:27:24 -0800 (PST)
MIME-Version: 1.0
References: <20190111220131.27153-1-jcmvbkbc@gmail.com>
	<2064503c-ed12-de29-59a9-46fa24d22f60@linaro.org>
	<CAMo8BfJaTbO0LSBWk7+WeFw7Oc6Sy2ykxaQcWTBeVGCdN9+aOg@mail.gmail.com>
	<cdaaa0bc-8282-6a92-886a-7dd5f2adfa46@linaro.org>
	<CAMo8Bf+FJUO46mv8bg7Rd2vH+noTsDHBrcfY=mbchaJoDd5eng@mail.gmail.com>
In-Reply-To: <CAMo8Bf+FJUO46mv8bg7Rd2vH+noTsDHBrcfY=mbchaJoDd5eng@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 11 Jan 2019 14:27:12 -0800
Message-ID: <CAMo8Bf+oiqDn9+RSiUXKwXfzWemJNrc6AQMRLMEbNSA3tfMavw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] target/xtensa: rework zero overhead
 loops implementation
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

On Fri, Jan 11, 2019 at 2:23 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> On Fri, Jan 11, 2019 at 2:17 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > On 1/12/19 9:14 AM, Max Filippov wrote:
> > >>> +        /*
> > >>> +         * 0 in the csbase_lend field means that there may not be a loopback
> > >>> +         * for any instruction that starts inside this page. Any other value
> > >>> +         * means that an instruction that ends at this offset from the page
> > >>> +         * start may loop back.
> > >>
> > >> Nit: s/may/will/g
> > >>
> > >> Using "may" makes it seem like we may have missed a case that should have
> > >> looped back.
> > >
> > > Using "will" makes it seem like it always loops back, but it doesn't do it
> > > when LCOUNT is 0.
> >
> > Err, no, you covered that in the first sentence, where 0 means that it will not
> > loop back.
>
> What I'm saying is that "Any other value means that an instruction that ends
> at this offset from the page start will loop back." sounds like that instruction
> will loop back unconditionally. LCOUNT = 0 is the condition when this doesn't
> happen, and it's not encoded in the TB flags. It's checked in the generated
> loopback code.

Maybe "Any other value means that an instruction that ends at this offset
from the page start may loop back and will need loopback code to be generated"?


-- 
Thanks.
-- Max

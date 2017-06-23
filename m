Received: from eggs.gnu.org ([2001:4830:134:3::10]:37617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dOQAx-0002Sr-Ik
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 11:07:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dOQAw-0000Y8-PX
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 11:07:11 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:33241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dOQAw-0000Xw-JE
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 11:07:10 -0400
Received: by mail-wr0-x231.google.com with SMTP id r103so69729791wrb.0
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 08:07:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGKXQydodgWiEUstZ4pvPD5g9E92nA5jxWWThCJCfNaoEuGiwg@mail.gmail.com>
References: <CAGKXQydF6Y6xpfHGb3neVC-x72o+FEnvHBis87A3JbWRAmoGYA@mail.gmail.com>
	<87tw36sr55.fsf@linaro.org>
	<CAGKXQydodgWiEUstZ4pvPD5g9E92nA5jxWWThCJCfNaoEuGiwg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Jun 2017 16:06:48 +0100
Message-ID: <CAFEAcA-cqmuiJCgMKUuPA9fCW1OPawGynB4hCMJh-J7VzocKAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] TARGET_PAGE_BITS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ali saeedi <ali.saeedi56@gmail.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 23 June 2017 at 16:02, ali saeedi <ali.saeedi56@gmail.com> wrote:
> thank you for answer
> So. why do we have right shift in qemu by "TARGET_PAGE_BITS" ? for exampe
> in below code, what does it mean?
>
> static inline void cpu_physical_memory_set_dirty_range(ram_addr_t start,
>                                                        ram_addr_t length)
> {
>     unsigned long end, page;
>
>     end = TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
>     page = start >> TARGET_PAGE_BITS;
> ...
> }

If you take an address, and you shift it right by the number
of bits in a page, you get a page number...

thanks
-- PMM

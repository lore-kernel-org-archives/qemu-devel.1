Received: from eggs.gnu.org ([2001:4830:134:3::10]:45068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cR1SA-0000dK-E0
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 13:47:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cR1S9-0003rq-RK
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 13:47:26 -0500
Received: from mail-vk0-x231.google.com ([2607:f8b0:400c:c05::231]:36058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cR1S9-0003qj-BL
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 13:47:25 -0500
Received: by mail-vk0-x231.google.com with SMTP id t8so32654687vke.3
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 10:47:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAMo8BfJKXOhiPQz8GT6hXNNBXKsz-67iKx9ct9tEwukVLWR3QA@mail.gmail.com>
References: <CAMo8BfLRP8qUgJAkU3fSwE_H6EmqYmPKO_MhMn7B6WpwGWUudw@mail.gmail.com>
	<001201d26b1b$e5a8ce20$b0fa6a60$@ru>
	<CAMo8BfJKXOhiPQz8GT6hXNNBXKsz-67iKx9ct9tEwukVLWR3QA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Jan 2017 18:47:04 +0000
Message-ID: <CAFEAcA-6-_5S+0YzoJA9twdiPBYOsLPFwq5zT+uoxFpbmfVJKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] implementing architectural timers using QEMU timers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>, Pavel Dovgaluk <Pavel.Dovgaluk@ispras.ru>, qemu-devel <qemu-devel@nongnu.org>, Alex Bligh <alex@alex.org.uk>, Richard Henderson <rth@twiddle.net>

On 10 January 2017 at 18:39, Max Filippov <jcmvbkbc@gmail.com> wrote:
> Ok, looks like what happens in my case is that instruction that
> sets CCOMPARE and thus changes remaining icount does not
> cause exit from the cpu_exec. So merely ending TB on
> QEMU_CLOCK_VIRTUAL timer update is not enough, I need to
> throw an exception of some kind? Or does the timer code need
> to take care of that?

Is your code calling gen_io_start() and gen_io_end() in the right
places around where it generates code to do the CCOMPARE accesses ?
(the rules for getting icount to work right are a bit fiddly)

thanks
-- PMM

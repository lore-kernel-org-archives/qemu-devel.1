Received: from eggs.gnu.org ([2001:4830:134:3::10]:33457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gVDZv-0005Xt-Pw
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:41:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gVDZt-0003WO-Cx
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:41:50 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:37338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gVDZt-0003Vp-6I
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:41:49 -0500
Received: by mail-ot1-x32f.google.com with SMTP id 40so3374057oth.4
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 02:41:49 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9qhe0ZemTkc2jkEO=_hu6PhvKUKGHC9QYTj2j+QHhNf8g@mail.gmail.com>
	<CAFEAcA8fYaKTZkLR8Ja3P590bSWy1cu61-gSxyf6+wXCfCLoxA@mail.gmail.com>
	<CAHmME9qQo4XfRgZUZDt3xbx=5KmRoYbO3N0+3m9gdKi9hvnZQA@mail.gmail.com>
In-Reply-To: <CAHmME9qQo4XfRgZUZDt3xbx=5KmRoYbO3N0+3m9gdKi9hvnZQA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Dec 2018 10:41:37 +0000
Message-ID: <CAFEAcA_3aGAZTEsuqjEnjijTnJi4QCVM09yYJ3-dwQp8wmkA3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] more serial ports on arm?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Fri, 7 Dec 2018 at 04:43, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Tue, Nov 20, 2018 at 11:08 AM Peter Maydell <peter.maydell@linaro.org> wrote:
> > It's still stuck, because unconditionally adding a second serial
> > port to the virt board breaks some commonly used existing guest
> > code (UEFI + Linux), and it's not clear to me what the best
> > command line UI is for allowing the user to request the second
> > serial port.
>
> Can the UI be the same more or less as for x86? Specify a second
> -serial, and then the machine gets one added? If it's in secure mode,
> then it's added as serial 3 instead of 2, to remain backwards
> compatible.

Yeah, that was more or less my plan. I just haven't done
the work of digging around to check whether it matches
what other QEMU board models have done and whether there
are any other hidden snags yet.

thanks
-- PMM

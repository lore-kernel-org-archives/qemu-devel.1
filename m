Received: from eggs.gnu.org ([2001:4830:134:3::10]:49523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fRzYW-0003OL-PB
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 08:34:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fRzYV-0002ab-TS
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 08:34:48 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:36316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fRzYV-0002Zf-NN
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 08:34:47 -0400
Received: by mail-ot0-x244.google.com with SMTP id c15-v6so10912187otl.3
	for <qemu-devel@nongnu.org>; Sun, 10 Jun 2018 05:34:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 10 Jun 2018 13:34:25 +0100
Message-ID: <CAFEAcA83SodNB16GCk_SAjmWE1fZ77ypbFPuRr9A5A=n0ocqwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 000/108] linux-user: Split do_syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

On 10 June 2018 at 04:00, Richard Henderson
<richard.henderson@linaro.org> wrote:
> * Changed the table into a switch, for the reason documented.
>   Use macros to actually enter the syscall into the switch.
> * Finish the split.
> * Fix some bugs along the way.
>
> I know it's a huge patch set, but I guess it was always going
> to be in order to finish -- it was a stupidly large function.

It's still a stupidly large source file -- is it worth taking
advantage of the split into multiple implementation functions
to break it up into multiple source files? (We could group
related syscalls together.)

thanks
-- PMM

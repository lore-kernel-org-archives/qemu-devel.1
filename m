Received: from eggs.gnu.org ([209.51.188.92]:40973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkDlJ-0003dq-Bo
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 14:55:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkDlI-000266-M0
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 14:55:37 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:35320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkDlI-0001vv-Gj
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 14:55:36 -0500
Received: by mail-oi1-x22d.google.com with SMTP id v6so7182396oif.2
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 11:55:27 -0800 (PST)
MIME-Version: 1.0
References: <20190115143650.15725-1-jusual@mail.ru>
	<CAKmqyKOyfP=ZT-diiFFfAieYKt98DPSxf0HyVdwYE4g+jv5w0w@mail.gmail.com>
	<797be79d-7ffc-222a-6acd-b01ff7269a63@mail.ru>
	<20190117101309.GA27840@stefanha-x1.localdomain>
	<960bbd92-a160-a65c-22c7-9e899dc3fa78@mail.ru>
	<CAFEAcA8vWOiXS7iM8heAG5wV1u8Dh_295NbWiqcXCmar9ePuPQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8vWOiXS7iM8heAG5wV1u8Dh_295NbWiqcXCmar9ePuPQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Jan 2019 19:55:15 +0000
Message-ID: <CAFEAcA_wbLRg0-taWLoX-Jm0B0G_Wm9NKyJLPQMOWf9qLbKqGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/core/generic-loader: Fix PC overwriting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Alistair Francis <alistair23@gmail.com>, Alistair Francis <alistair@alistair23.me>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On Thu, 17 Jan 2019 at 19:27, Peter Maydell <peter.maydell@linaro.org> wrote:
> recent gdb neither emits
> 'c addr' nor supports it in its gdbserver implementation

...and I dug about in the gdb git history, and as far as
I can tell even back in 2005 or so gdb's gdbserver never
supported the 'addr' parameter to 'c' and 's', and the
gdb end of the remote protocol doesn't emit it, which raises
the question of whether anybody ever actually used it!

thanks
-- PMM

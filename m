Received: from eggs.gnu.org ([209.51.188.92]:34998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hCDkf-0008Fv-9R
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 21:34:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hCDke-0002d0-Ac
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 21:34:41 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:37692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hCDke-0002Zf-2W
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 21:34:40 -0400
Received: by mail-oi1-x244.google.com with SMTP id v84so3586455oif.4
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 18:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190404185730.GA22512@ls3530.dellerweb.de>
In-Reply-To: <20190404185730.GA22512@ls3530.dellerweb.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Apr 2019 08:34:26 +0700
Message-ID: <CAFEAcA9xP8CtXEruuzPHCyuDT5EyMMHFGdCJdfFBhX+C2Jr36A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] configure: Automatically fall back to TCI
 on non-release architectures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Helge Deller <deller@gmx.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, 5 Apr 2019 at 01:59, Helge Deller <deller@gmx.de> wrote:
> If a non-release architecture is found, and it's known that there is no
> native TCG support for that CPU, automatically fall back to the TCI
> implementation instead of requesting the user to run configure again
> with the --enable-tcg-interpreter option.
>
> This change simplifies building qemu in automatic build environments
> (like in my case the debian buildds) because one does not need to
> special case on the architectures.

I don't think we should do this. TCI is unmaintained, has several
known flaws, does not provide the level of performance that
people expect from QEMU, and we've talked about removing it
altogether. In particular, distros should not automatically ship
a TCI QEMU -- it's something that a user can use if they
explicitly opt into but which I don't think we want to surprise
anybody with.

If we care about a host architecture we should support it
with a proper TCG backend. If we don't care that much we
shouldn't support it.

thanks
-- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:58966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP2xr-0000JJ-Ke
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 05:09:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP2xq-0006XR-Ez
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 05:09:03 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:37978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gP2xm-0006T0-MH
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 05:09:00 -0500
Received: by mail-oi1-x242.google.com with SMTP id a77so1039931oii.5
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 02:08:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHmME9qhe0ZemTkc2jkEO=_hu6PhvKUKGHC9QYTj2j+QHhNf8g@mail.gmail.com>
References: <CAHmME9qhe0ZemTkc2jkEO=_hu6PhvKUKGHC9QYTj2j+QHhNf8g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Nov 2018 10:08:33 +0000
Message-ID: <CAFEAcA8fYaKTZkLR8Ja3P590bSWy1cu61-gSxyf6+wXCfCLoxA@mail.gmail.com>
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

On 19 November 2018 at 23:46, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Hey guys,
>
> I sort of lost track of the discussion, but what ever happened to
> adding an extra serial port to the arm virt machine? I'm still
> carrying around the attached patch to run build.wireguard.com and I'd
> of course like to see a real solution upstream.

It's still stuck, because unconditionally adding a second serial
port to the virt board breaks some commonly used existing guest
code (UEFI + Linux), and it's not clear to me what the best
command line UI is for allowing the user to request the second
serial port.

thanks
-- PMM

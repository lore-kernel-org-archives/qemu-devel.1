Received: from eggs.gnu.org ([2001:4830:134:3::10]:35468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edfKN-00038X-TR
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:52:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edfKN-0007c9-6d
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:52:11 -0500
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:40203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1edfKN-0007bp-1j
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:52:11 -0500
Received: by mail-ot0-x22f.google.com with SMTP id x4so8056360otg.7
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 08:52:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA82WAfmdWTt438ioLoQTztQk-r4Pq2ak8Bcjqv-xWasyw@mail.gmail.com>
References: <20180119182248.10821-1-ard.biesheuvel@linaro.org>
	<20180119182248.10821-4-ard.biesheuvel@linaro.org>
	<CAFEAcA82WAfmdWTt438ioLoQTztQk-r4Pq2ak8Bcjqv-xWasyw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2018 16:51:49 +0000
Message-ID: <CAFEAcA_UY6tg=nSCzMMBH-2gKAFH_Z3J04ZRm+Kute+UeJdO1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 3/4] target/arm: implement SM3
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 22 January 2018 at 16:39, Peter Maydell <peter.maydell@linaro.org> wrote:
> This seems to be missing support for SM4EKEY (which is O==1
> opcode == 0b10 and also part of the v8.2 SM feature) ?

Looks like SM4E (in the crypto-2-reg-sha512 decode section) is
also missing.

thanks
-- PMM

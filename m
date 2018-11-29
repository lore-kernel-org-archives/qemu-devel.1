Received: from eggs.gnu.org ([2001:4830:134:3::10]:49573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSJTY-0003wO-Ku
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:23:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSJTX-00080X-R1
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:23:16 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gSJTX-000807-M1
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:23:15 -0500
Received: by mail-oi1-x242.google.com with SMTP id y23so1171063oia.4
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 02:23:15 -0800 (PST)
MIME-Version: 1.0
References: <1543412590-29716-1-git-send-email-stefan.markovic@rt-rk.com>
	<1543412590-29716-2-git-send-email-stefan.markovic@rt-rk.com>
	<3ef23076-d0b4-4df3-d023-bf18ba33aade@redhat.com>
	<266d7143-54e7-86d7-e29b-64cb923edceb@wavecomp.com>
In-Reply-To: <266d7143-54e7-86d7-e29b-64cb923edceb@wavecomp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Nov 2018 10:23:03 +0000
Message-ID: <CAFEAcA937xXC2mHpM=wmjrU8Rx-dAG6_duAGM9jTzgEScq7PUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-doc: Add nanoMIPS ISA information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <smarkovic@wavecomp.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Stefan Markovic <stefan.markovic@rt-rk.com>, QEMU Developers <qemu-devel@nongnu.org>, Paul Burton <pburton@wavecomp.com>, James Hogan <jhogan@kernel.org>, Thomas Huth <huth@tuxfamily.org>, =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Richard Henderson <richard.henderson@linaro.org>

On Thu, 29 Nov 2018 at 10:18, Stefan Markovic <smarkovic@wavecomp.com> wrote:
> I'll investigate further running with  --enable-debug option to fix this
> issue.
>
> In the meantime, we could note enable-debug as 'To Be Done/Work In
> Progress' for nanoMIPS in qemu docs .

This isn't just "--enable-debug doesn't work", it means there's a
definite bug because you've tripped an assert (that's only enabled
in the debug config). It's quite possible that the code will misbehave
at runtime even on the non-debug config...

thanks
-- PMM

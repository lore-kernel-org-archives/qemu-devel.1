Received: from eggs.gnu.org ([2001:4830:134:3::10]:36727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edfOq-0006E4-5C
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:56:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edfOp-0002RI-A6
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:56:48 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:41212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1edfOp-0002Qd-4z
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:56:47 -0500
Received: by mail-oi0-x243.google.com with SMTP id m83so3941225oik.8
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 08:56:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu87P07jeBezDdxAqoGZCtY-t0y0d4i5UvJ1-BK24UWuJA@mail.gmail.com>
References: <20180119182248.10821-1-ard.biesheuvel@linaro.org>
	<20180119182248.10821-4-ard.biesheuvel@linaro.org>
	<CAFEAcA82WAfmdWTt438ioLoQTztQk-r4Pq2ak8Bcjqv-xWasyw@mail.gmail.com>
	<CAKv+Gu87P07jeBezDdxAqoGZCtY-t0y0d4i5UvJ1-BK24UWuJA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2018 16:56:25 +0000
Message-ID: <CAFEAcA89Lmcfdhfk0p-1KRSdNFsaYUWkG9K39OgkxVDQ_GC0oA@mail.gmail.com>
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

On 22 January 2018 at 16:52, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 22 January 2018 at 16:39, Peter Maydell <peter.maydell@linaro.org> wrote:
>> This seems to be missing support for SM4EKEY (which is O==1
>> opcode == 0b10 and also part of the v8.2 SM feature) ?

> It is part of the v8.2 SM extension, which consists of SM3 secure hash
> and SM4 encryption, which are two different things (and AA64ISAR0 has
> separate feature bits for each). The ARM ARM does stipulate that both
> should be set if either one is set, but still provides two separate
> bits, and so one can be enabled without the other.

Yes, I just discovered that I'd got confused by the ID registers
providing more granular settings than the various specified
extension combinations do.

It would be nice to also have SM4 so we can say we have got all
of the v8.2 crypto extensions, but we can do that as a separate patch.

thanks
-- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1edfQo-00084f-Su
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:58:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1edfQo-00040l-6c
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:58:50 -0500
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:34358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1edfQo-00040T-2f
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:58:50 -0500
Received: by mail-io0-x241.google.com with SMTP id c17so10137924iod.1
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 08:58:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA89Lmcfdhfk0p-1KRSdNFsaYUWkG9K39OgkxVDQ_GC0oA@mail.gmail.com>
References: <20180119182248.10821-1-ard.biesheuvel@linaro.org>
	<20180119182248.10821-4-ard.biesheuvel@linaro.org>
	<CAFEAcA82WAfmdWTt438ioLoQTztQk-r4Pq2ak8Bcjqv-xWasyw@mail.gmail.com>
	<CAKv+Gu87P07jeBezDdxAqoGZCtY-t0y0d4i5UvJ1-BK24UWuJA@mail.gmail.com>
	<CAFEAcA89Lmcfdhfk0p-1KRSdNFsaYUWkG9K39OgkxVDQ_GC0oA@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 22 Jan 2018 16:58:48 +0000
Message-ID: <CAKv+Gu8J+N9n8rX-sYD+PQLCZWu2w2VBa9dM6rZBpcX=xu-1fw@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 22 January 2018 at 16:56, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 22 January 2018 at 16:52, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> On 22 January 2018 at 16:39, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> This seems to be missing support for SM4EKEY (which is O==1
>>> opcode == 0b10 and also part of the v8.2 SM feature) ?
>
>> It is part of the v8.2 SM extension, which consists of SM3 secure hash
>> and SM4 encryption, which are two different things (and AA64ISAR0 has
>> separate feature bits for each). The ARM ARM does stipulate that both
>> should be set if either one is set, but still provides two separate
>> bits, and so one can be enabled without the other.
>
> Yes, I just discovered that I'd got confused by the ID registers
> providing more granular settings than the various specified
> extension combinations do.
>
> It would be nice to also have SM4 so we can say we have got all
> of the v8.2 crypto extensions, but we can do that as a separate patch.
>

I intend to look at SM4 as well, but not sure when exactly.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:33183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZh5s-0005QN-9w
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 12:56:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZh5r-0003xB-9W
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 12:56:48 -0500
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:46963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eZh5r-0003vv-4K
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 12:56:47 -0500
Received: by mail-ot0-x234.google.com with SMTP id f6so2792821oti.13
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 09:56:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171218174552.18871-1-richard.henderson@linaro.org>
References: <20171218174552.18871-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 17:56:25 +0000
Message-ID: <CAFEAcA9Qnj0G03x72BFLAYmodeBMDB=t3pz4JxUj0HvrbhkuGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC 00/23] target/arm: decode generator and
 initial sve patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 18 December 2017 at 17:45, Richard Henderson
<richard.henderson@linaro.org> wrote:
> The most important part here, for review, is the first patch.
>
> I add a code generator, writen in python, which takes an input file
> that describes the opcode bits and field bits of the instructions,
> and outputs a function that does all of the decoding.
>
> The subsequent patches begin to add SVE support and also demonstrate
> how I envision how both the decoder and the tcg host vector support
> are to be used.  Thus, review of the direction would be appreciated
> before there are another 100 patches along the same style.

This doesn't apply to master -- do you have an example of
what the generated code comes out like?

thanks
-- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:50985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fhLwp-00018f-UW
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 17:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fhLwp-00017s-5a
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 17:31:23 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:42596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fhLwo-00017U-Ou
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 17:31:23 -0400
Received: by mail-pl0-x244.google.com with SMTP id z7-v6so5577543plo.9
	for <qemu-devel@nongnu.org>; Sun, 22 Jul 2018 14:31:22 -0700 (PDT)
References: <CAHmME9q8b0Nss8b7DEoGgqoCK4dEvasQN64QWx6Hio+N92wuSg@mail.gmail.com>
	<CAHmME9qX22YP9qrHErc43Z+LUi=ichqzG+OdXqjhJv4ZrKDmWQ@mail.gmail.com>
	<CAHmME9qMASSt2K4vACJTMiGNTt09upRhNFxL_y2KF1G3N1LB2g@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b20edb3f-055a-c531-da70-d20a20137ad4@linaro.org>
Date: Sun, 22 Jul 2018 14:31:18 -0700
MIME-Version: 1.0
In-Reply-To: <CAHmME9qMASSt2K4vACJTMiGNTt09upRhNFxL_y2KF1G3N1LB2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] ARM64 STR Instruction Crash Regression in TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 07/22/2018 01:47 PM, Jason A. Donenfeld wrote:
> Hello,
> 
> Gcc 7.3 compiles bash's array_flush's dual assignment using:
> 
> STP             X20, X20, [X20,#0x10]
> 
> But gcc 8.1 compiles it as:
> 
> STR             Q0, [X20,#0x10]
> 
> Real processors seem okay, and qemu 2.11 seems okay. But qemu 2.12
> results in a segfaulting process. I'm pretty sure this is a TCG bug.
> 
> In the attached tarball, please find kernel and run.sh. Calling
> ./run.sh will start the kernel with the bad bash executable that tries
> to execute `config=({1..100000})` and crashes. Also included in there
> is the actual crashing bash binary, in case you'd like to disassemble
> a little bit.

Interesting.  The test passes on master with --enable-debug, but fails when
qemu is compiled with optimization...

I'll dig a bit deeper.


r~

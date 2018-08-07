Received: from eggs.gnu.org ([2001:4830:134:3::10]:48931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fn7p6-0001UI-Rd
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 15:39:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fn7p1-0006sd-VC
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 15:39:16 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:42444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fn7p1-0006sR-L2
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 15:39:11 -0400
Received: by mail-pg1-x542.google.com with SMTP id y4-v6so8298752pgp.9
	for <qemu-devel@nongnu.org>; Tue, 07 Aug 2018 12:39:11 -0700 (PDT)
References: <BN7PR08MB48688EB667F7EDFF86B90D2CC6200@BN7PR08MB4868.namprd08.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a783bad9-ae0f-c7cb-ecca-317e9269d06a@linaro.org>
Date: Tue, 7 Aug 2018 12:39:06 -0700
MIME-Version: 1.0
In-Reply-To: <BN7PR08MB48688EB667F7EDFF86B90D2CC6200@BN7PR08MB4868.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Question: How to integrate simple tests for a new
 platform so that they fit in well within QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Petar Jovanovic <pjovanovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>

On 08/07/2018 05:34 AM, Aleksandar Markovic wrote:
> We are introducing a new MIPS platform - called nanoMIPS - to the QEMU.
> 
> Besides providing new functionality, we would like to integrate into QEMU
> some basic testing capabilities for that new platform. Something like this:
> 
> Enable user to specify cross compiler and, using QEMU Linux user mode: 
> a. execute several tests that are just almost minimal tests of emulation of
> selected instructions.
> b. execute several tests that are just almost minimal tests of translation 
> of selected system calls.
QEMU has some infrastructure for this now.
I'm not clear on all of the pieces, but Alex will be able to help you.

In configure, there is a section setting cross_cc_foo and cross_cc_cflags_foo;
there is another section that tests target_compiler and target_compiler_cflags
from that.  At minimum you'll need to add a new section that sets
target_compiler etc for nanomips.

In tests/tcg/mips/Makefile.include, one can set up a docker cross-compile
definition.  This is correlated to files in tests/docker/dockerfiles/.

I don't know much about docker, but I know it should be possible to build and
distribute a cross-compiler, for a base system such as debian 9, that other
folk can pull and use.  For a brand new target like nanomips, requiring a brand
new tool chain, this is certainly something that you will have to do yourself.
But having that available for CI should pay dividends.


r~

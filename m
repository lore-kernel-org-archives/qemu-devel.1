Received: from eggs.gnu.org ([209.51.188.92]:41217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGc98-0002aL-2K
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:26:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGc97-0006AU-7q
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:26:06 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hGc96-00069k-QF
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:26:05 -0400
Received: by mail-pg1-x544.google.com with SMTP id i2so11370468pgj.11
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 21:26:04 -0700 (PDT)
References: <20190401031155.21293-1-richard.henderson@linaro.org>
	<20190401031155.21293-4-richard.henderson@linaro.org>
	<c6b66db9-24d5-b55b-8b45-e73f3d7c3fba@mail.uni-paderborn.de>
	<50effb1c-3bbe-126b-9bfb-0b65eacc9c36@linaro.org>
	<abdf9c63-8f27-8cb2-dc94-22318c3836ae@linaro.org>
	<6f30be40-014e-d825-aadc-a689dad120c3@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9f53ba7f-201e-be9f-c1a1-eae23bee8a75@linaro.org>
Date: Tue, 16 Apr 2019 18:25:57 -1000
MIME-Version: 1.0
In-Reply-To: <6f30be40-014e-d825-aadc-a689dad120c3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.1 3/8] target/riscv: Merge argument
 sets for insn32 and insn16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@sifive.com, Alistair.Francis@wdc.com, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>

On 4/16/19 9:43 AM, Thomas Huth wrote:
> I wonder whether we should maybe always add "-Wno-typedef-redefinition"
> in the configure script when we detect clang. All the versions of GCC
> that we currently support seem to ignore typedef redefinitions anyway...?
> (I think I've seen that warning with GCC in the past, too, see e.g.
> commit eeb61d4f8270a6849d9a584fc83da3869b79066d, but that does not seem
> to be the case anymore with GCC >= 4.8)

That would work for me too.  Anything to minimize Werror divergence between the
two compilers makes less work.


r~

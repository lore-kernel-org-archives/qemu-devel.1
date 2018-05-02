Received: from eggs.gnu.org ([2001:4830:134:3::10]:39958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDwmr-0007BM-2h
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:47:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDwmn-0005Qy-TK
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:47:33 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:33563)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fDwmn-0005Qk-KU
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:47:29 -0400
Received: by mail-pg0-x243.google.com with SMTP id i194-v6so11273794pgd.0
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 11:47:29 -0700 (PDT)
References: <20180425012300.14698-1-richard.henderson@linaro.org>
	<20180425012300.14698-9-richard.henderson@linaro.org>
	<87muxjaasd.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0316b98e-1124-1ddc-296f-bdd637d088ef@linaro.org>
Date: Wed, 2 May 2018 11:47:26 -0700
MIME-Version: 1.0
In-Reply-To: <87muxjaasd.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 8/9] target/arm: Implement FP
 data-processing (2 source) for fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On 05/01/2018 04:13 AM, Alex Bennée wrote:
> If we are going to the trouble of adding a read_fp_hreg() we might as
> well do the same for the write case.

The write case is much harder.

Almost all of the time we have a helper function that has already zero-extended
the result from 16 to 32-bits, and therefore write_fp_sreg is perfectly fine.
In more than a few cases, this writeback is shared by both single and half
precision paths and so adjusting the writeback is not appropriate.

There are in fact zero instances at this point in the tree that do require
extra zero-extension.  So I'm going to leave this alone.


r~

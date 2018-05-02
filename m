Received: from eggs.gnu.org ([2001:4830:134:3::10]:58479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDuc8-0000wS-U9
	for qemu-devel@nongnu.org; Wed, 02 May 2018 12:28:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDuc5-00069E-CC
	for qemu-devel@nongnu.org; Wed, 02 May 2018 12:28:20 -0400
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:36282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fDuc5-00068j-6E
	for qemu-devel@nongnu.org; Wed, 02 May 2018 12:28:17 -0400
Received: by mail-pg0-x22f.google.com with SMTP id z129-v6so6832527pgz.3
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 09:28:17 -0700 (PDT)
References: <20180502154344.10585-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6c4608ca-1fe7-5b08-0014-99181c5385ac@linaro.org>
Date: Wed, 2 May 2018 09:28:13 -0700
MIME-Version: 1.0
In-Reply-To: <20180502154344.10585-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] refactor float-to-float conversions
 and fix AHP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 05/02/2018 08:43 AM, Alex Bennée wrote:
> This is a more polished version of the re-factoring of the softfloat
> fcvt code. I've split apart the fixes for ARM alternative
> half-precision format for easier review. Rather than rely on some
> questionable hacks it introduces a new FloatFmt to allow cleaner
> handling of the differences in the common code. If there are other
> alternative floating point formats they can follow a similar approach.
> 
> I've included the test case for reference although I expect it to be
> merged with my tcg-testing revival code which has the rest of the
> build and test machinery for the test case.
> 
> checkpatch dumps a bunch of false-positives as it doesn't like
> scientific notation for floats or inline assembler used in the test
> case.
> 
> Cheers,
> 
> Alex Bennée (3):
>   fpu/softfloat: re-factor float to float conversions
>   fpu/softfloat: support ARM Alternative half-precision
>   tests/tcg/aarch64: add fcvt test cases for AArch64 (!UPSTREAM)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

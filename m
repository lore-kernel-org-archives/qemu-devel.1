Received: from eggs.gnu.org ([2001:4830:134:3::10]:43585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY1fF-0005E4-GD
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:02:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY1fC-0001d9-FS
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:02:41 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:36166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fY1fC-0001c3-6W
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:02:38 -0400
Received: by mail-pl0-x243.google.com with SMTP id a7-v6so382932plp.3
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 21:02:37 -0700 (PDT)
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-24-richard.henderson@linaro.org>
	<CAFEAcA9R-FWVVsrYESi3Nqkfs3FCetcK4L2KVFghtqDLBxUMHQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bc4c85b6-5525-0bc3-93ac-0cc5a3db4495@linaro.org>
Date: Tue, 26 Jun 2018 21:02:33 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9R-FWVVsrYESi3Nqkfs3FCetcK4L2KVFghtqDLBxUMHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 23/35] target/arm: Implement SVE
 floating-point convert precision
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 06/26/2018 03:44 AM, Peter Maydell wrote:
> A comment to the effect that the SVE fp-to-fp conversion
> routines always use IEEE format halfprec (ie ignore FPCR.AHP)
> would be helpful.

Ok.

> Are you sure we have the FPCR.FZ16 handling right here? That
> is, do we need the same "use the not-fp16 fpstatus pointer,
> and temporarily clear the flush flag for the fp16 end of
> the conversion" behaviour that we have in vfp_fcvt_f16_to_f32
> and friends ? The pseudocode FPConvertSVE() calls FPConvert(),
> which is the "ignore FZ16" codepath I think. The test case would
> be (eg) a conversion where the input f16 is denormal and
> FPCR.FZ == 1: this should not do the flush-input-to-zero, right?

Yes, I read it the same way.  I guess both my and Alex's RISU
test cases didn't exercise this?


r~

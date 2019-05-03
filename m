Received: from eggs.gnu.org ([209.51.188.92]:37490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMbzq-0007ea-Ju
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:29:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMbzp-0008Lu-HY
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:29:18 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMbzp-0008Kw-CM
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:29:17 -0400
Received: by mail-pg1-x544.google.com with SMTP id k19so3043817pgh.0
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 10:29:17 -0700 (PDT)
References: <20190411153942.4533-1-peter.maydell@linaro.org>
	<53930e87-3bb1-fdd5-a8fe-8603c0adecc2@linaro.org>
	<CAFEAcA_GZPJj7OQ-jK1TX4wKS4hO6OR43OG0Y3eCuxVdiUtsnQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b798a938-f26a-65df-c718-7a174dff7fb4@linaro.org>
Date: Fri, 3 May 2019 10:29:12 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_GZPJj7OQ-jK1TX4wKS4hO6OR43OG0Y3eCuxVdiUtsnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/arm: Implement NSACR gating of
 floating point
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 5/3/19 6:13 AM, Peter Maydell wrote:
> On Sat, 13 Apr 2019 at 08:07, Richard Henderson
>> This one does do the right thing, but better to clear the bits on write to
>> NSACR.  This lets you avoid the change to fp_exception_el, and the missing
>> change to sve_exception_el.
> 
> Hi Richard -- I was just going through the review comments on this
> patchset, and I saw this bit. Could you clarify what you mean by
> "the missing change to sve_exception_el" ? Since SVE is AArch64 only,
> there can't be any configs where we have SVE and EL3 is AArch32,
> so I don't think these two features should be able to interact.

You're right.  I'm going to assume I had been insufficiently caffeinated at the
time.


r~

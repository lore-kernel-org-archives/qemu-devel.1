Received: from eggs.gnu.org ([209.51.188.92]:52446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guaFR-0003rL-Sy
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 04:57:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guaFR-0003EP-5O
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 04:57:33 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33579)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guaFQ-0003DH-VZ
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 04:57:33 -0500
Received: by mail-ot1-x344.google.com with SMTP id i20so15642978otl.0
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 01:57:32 -0800 (PST)
MIME-Version: 1.0
References: <20190206052857.5077-1-richard.henderson@linaro.org>
	<CAFEAcA9oyJ5RxTqJdptK6bmMwFe++NLn15XTxdBkZbsfOUT_NQ@mail.gmail.com>
	<0334b231-fa3e-210c-ea9e-9d7bb7b21d1f@linaro.org>
	<28da85ff-c718-bd3e-ddca-18772decd777@linaro.org>
In-Reply-To: <28da85ff-c718-bd3e-ddca-18772decd777@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Feb 2019 09:57:20 +0000
Message-ID: <CAFEAcA-3JsR6GNSQjn-79aAAvEdkJMfqZ24UXRwe4dctZhnOXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/3] target/arm: Implement ARMv8.3-JSConv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 14 Feb 2019 at 21:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/14/19 1:10 PM, Richard Henderson wrote:
> > On 2/14/19 5:53 AM, Peter Maydell wrote:
> >> On Wed, 6 Feb 2019 at 05:29, Richard Henderson
> >> <richard.henderson@linaro.org> wrote:
> >>>
> >>> Changes since v1:
> >>>   * Typo fixed in patch 2, which had scrogged FMOV
> >>>   * Return 0 for NaN, as for any other ARM fp conversion.
> >>>
> >>>
> >>> r~
> >>>
> >>>
> >>> Richard Henderson (3):
> >>>   target/arm: Force result size into dp after operation
> >>>   target/arm: Restructure disas_fp_int_conv
> >>>   target/arm: Implement ARMv8.3-JSConv
> >>
> >> I've applied patches 1 and 2 to target-arm.next; 3 has a bug in it,
> >> I think.
> >
> > Please dequeue patch 2; patch 3 has more than one bug in it, and I need to
> > rewrite patch 2 as well.
>
> Grr.  That's patch 1, "force result size into dp" that I want dequeued.
> Of course, now I've seen your pull request, so if that's already gone through,
> I guess I can smoosh a revert with my rewrite?

I saw this before pushing the merge, so I've removed both patches 1 and
2 from target-arm.next and will resend the pullreq.

thanks
-- PMM

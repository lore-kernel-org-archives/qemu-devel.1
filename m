Received: from eggs.gnu.org ([2001:4830:134:3::10]:41567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUEte-0006Sx-3U
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:45:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUEtd-0004Tp-9l
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:45:06 -0500
Received: from mail-ua0-x231.google.com ([2607:f8b0:400c:c08::231]:33682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cUEtb-0004TQ-SY
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:45:05 -0500
Received: by mail-ua0-x231.google.com with SMTP id i68so36852565uad.0
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 07:45:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <03cf70f8-b852-a905-574c-ff96c106af5f@twiddle.net>
References: <1484802878-22681-1-git-send-email-bharata@linux.vnet.ibm.com>
	<03cf70f8-b852-a905-574c-ff96c106af5f@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 15:44:42 +0000
Message-ID: <CAFEAcA-sEF_dQbym=wQ+29tri02zLOAUb_3KL-ZPwDOrdG=pKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC PATCH v0] softfloat: Add round-to-odd
 rounding mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

On 19 January 2017 at 15:29, Richard Henderson <rth@twiddle.net> wrote:
> The description in see in the manual on page 387 is more precise than what
> you quote above:
>
>   # If IR is exact, choose IR.
>   # Otherwise choose NL, and if Guard=1, Round=1 or Sticky=1,
>   # the least significant bit of the result is set to 1.
>
> The "choose NL" part means round-to-zero, which means that we do not
> overflow to infinity.  And since FLOAT128_MAX is already odd, we're done.

...so it does have the same semantics as ARM. Good :-)

thanks
-- PMM

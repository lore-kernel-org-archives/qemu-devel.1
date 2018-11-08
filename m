Received: from eggs.gnu.org ([2001:4830:134:3::10]:60456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKkC1-0005nF-J7
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:17:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKkBz-00005c-HC
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:17:53 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gKkBw-0008KQ-Dw
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:17:51 -0500
Received: by mail-oi1-x243.google.com with SMTP id g188-v6so10890581oif.8
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 05:17:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <7a7929a8-74d3-ed14-b284-f420afe824ea@redhat.com>
References: <20181108125256.30986-1-peter.maydell@linaro.org>
	<7a7929a8-74d3-ed14-b284-f420afe824ea@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Nov 2018 13:17:18 +0000
Message-ID: <CAFEAcA9NSzcDP6UwLYRfOSq=NZE3+4+vF6wNCXjJ7LQ9mMZLwQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tcg/tcg-op.h: Add multiple include guard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, "patches@linaro.org" <patches@linaro.org>

On 8 November 2018 at 13:08, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
> On 8/11/18 13:52, Peter Maydell wrote:
>>
>> The tcg-op.h header was missing the usual guard against multiple
>> inclusion; add it.
>>
>> (Spotted by lgtm.com's static analyzer.)
>
>
> I'm pretty sure there are more occurences.

The only other ones the analyzer spotted all seemed to be
"deliberately multiply included" (like
include/exec/memory_ldst_phys.inc.h), though we don't in
all cases use the ".inc.h" convention that sort-of
indicates that).

https://lgtm.com/projects/g/qemu/qemu/alerts/?mode=3Dtree
is probably the most convenient url if you want to
go looking for other stuff. Some of its issues are
definitely false-positives, but there may be some other
easy to fix things in there (eg the "local variable
hides global variable" ones -- though if we care about
these we should enable -Wshadow and fix the compile
failures).

Notably, lgtm does checks on python, which Coverity does not,
so that is more likely to be a source of real issues to fix,
I think.

thanks
-- PMM

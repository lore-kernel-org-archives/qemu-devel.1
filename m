Received: from eggs.gnu.org ([2001:4830:134:3::10]:60618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQuve-00012s-VI
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQuve-0006kT-7a
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:26:14 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:44245)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQuve-0006ip-0a
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:26:14 -0400
Received: by mail-ot0-x243.google.com with SMTP id w13-v6so11481939ote.11
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 06:26:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180607124016.GJ19032@stefanha-x1.localdomain>
References: <20180604162140.20688-1-peter.maydell@linaro.org>
	<20180604191756.1ae61871@w520.home>
	<20180607124016.GJ19032@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Jun 2018 14:25:52 +0100
Message-ID: <CAFEAcA9z=f9oiqYrF8ZeCMj9-FjZAyMMGwv9e-argF+vRd4X-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] CODING_STYLE: Define our preferred form
 for multiline comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 7 June 2018 at 13:40, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Mon, Jun 04, 2018 at 07:17:56PM -0600, Alex Williamson wrote:
>> Note that the kernel coding style, except for certain exceptions, is:
>>
>> /*
>>  * This is a
>>  * multi-line
>>  * comment
>>  */
>
> Amen, the one true way.  :-)

OK, consensus seems to be for recommending the kernel-style for
multiline comments.

Does anybody who knows checkpatch feel like they could write a
checkpatch check for this? (Unfortunately there isn't one in
the kernel's checkpatch script either, as I found out when I
last wrote a kernel patch and got dinged for not putting that
first blank line in...)

thanks
-- PMM

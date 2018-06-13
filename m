Received: from eggs.gnu.org ([2001:4830:134:3::10]:43609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fT4vR-0003ez-6D
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fT4vN-0008Sj-73
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:30:57 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:34491)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fT4vM-0008RH-PN
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:30:53 -0400
Received: by mail-ot0-x244.google.com with SMTP id r18-v6so2748182otk.1
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 05:30:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <650048df-f4b1-b351-f877-be8c84197ba2@linaro.org>
References: <20180611141716.3813-1-peter.maydell@linaro.org>
	<650048df-f4b1-b351-f877-be8c84197ba2@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Jun 2018 13:30:31 +0100
Message-ID: <CAFEAcA-vZH0KUxi+iYP3eYzXeHxNTotNwCMhEPcGhOLksbG71A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] CODING_STYLE: Define our preferred form
 for multiline comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, "patches@linaro.org" <patches@linaro.org>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>

On 12 June 2018 at 18:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 06/11/2018 04:17 AM, Peter Maydell wrote:
>> The codebase has a bit of a mix of different multiline
>> comment styles. State a preference for the Linux kernel
>> style:
>>     /*
>>      * Star on the left for each line.
>>      * Leading slash-star and trailing star-slash
>>      * each go on a line of their own.
>>      */
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> This is not my personal favourite, but seemed to be the
>> closest we had to consensus in the mail thread for v1;
>> I can live with it in order to avoid getting patches which
>> use the styles I like even less :-)
>
> Honestly, I don't like this except for "important" comments.
>
> A "small" comment, e.g. one that doesn't quite fit on a single line, now takes
> 4 lines instead of 2.  Which is really annoying and IMO tends to break flow.

That's why I prefer
 /* two
  * lines
  */
style over kernel-style. But apparently nobody else does...

thanks
-- PMM

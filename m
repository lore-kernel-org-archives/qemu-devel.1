Received: from eggs.gnu.org ([2001:4830:134:3::10]:59554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fT93m-0005y6-9p
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:55:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fT93i-0004fN-Cf
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:55:50 -0400
References: <20180611141716.3813-1-peter.maydell@linaro.org>
	<650048df-f4b1-b351-f877-be8c84197ba2@linaro.org>
	<CAFEAcA-vZH0KUxi+iYP3eYzXeHxNTotNwCMhEPcGhOLksbG71A@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <f9beda14-7c4a-8f89-baf1-5a79e847c4ac@redhat.com>
Date: Wed, 13 Jun 2018 12:55:43 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-vZH0KUxi+iYP3eYzXeHxNTotNwCMhEPcGhOLksbG71A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, "patches@linaro.org" <patches@linaro.org>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>



On 06/13/2018 08:30 AM, Peter Maydell wrote:
> On 12 June 2018 at 18:30, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> On 06/11/2018 04:17 AM, Peter Maydell wrote:
>>> The codebase has a bit of a mix of different multiline
>>> comment styles. State a preference for the Linux kernel
>>> style:
>>>     /*
>>>      * Star on the left for each line.
>>>      * Leading slash-star and trailing star-slash
>>>      * each go on a line of their own.
>>>      */
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>> This is not my personal favourite, but seemed to be the
>>> closest we had to consensus in the mail thread for v1;
>>> I can live with it in order to avoid getting patches which
>>> use the styles I like even less :-)
>>
>> Honestly, I don't like this except for "important" comments.
>>
>> A "small" comment, e.g. one that doesn't quite fit on a single line, now takes
>> 4 lines instead of 2.  Which is really annoying and IMO tends to break flow.
> 
> That's why I prefer
>  /* two
>   * lines
>   */
> style over kernel-style. But apparently nobody else does...

The same reasoning could be used to justify

/* two
 * lines */

as it's ... actually just two lines. I think people don't seem to like
this much either (why? does it look 'naked' on the end?) and seemingly
the asymmetry is a bit of a killer for the isolated close-comment style:

/* asymmetric
 * three lines
 */

so we seemed to have arrived on the vertically symmetric:

/*
 * four
 * lines
 */

style. I think this is a pretty reasonable compromise with the tastes of
the various maintainers that have chimed in so far -- it seems to be
nobody's favorite but everyone's second choice :)

If there is concern this will balloon "almost" single line comments into
four lines, I think the overall strategy of being either more concise
(or being 70 characters more detailed!) is probably reasonable enough.

...Overall I think it probably doesn't matter too much as long as
comments in each individual file are consistent.

It would only begin to matter terribly much if we actually decided we
wanted to do a doxygen-style doc generation for our internal APIs for
compatibility with, say, fancier IDEs than vim/emacs.

As it stands, we're pretty inconsistent about which exact style we apply
when we "document" internal functions -- sometimes we document the
header, sometimes the implementation, sometimes both (but differently!)
and always with different styles all over the place. That's the real
problem, IMO.

For non-javadoc style comments that aren't intended to document a
function in some methodical way, I think as long as it looks nice in the
file as deemed by the maintainer and it's consistent, it's probably fine.

> 
> thanks
> -- PMM
>
Now I can say after working at Red Hat for four years that I've finally
had a real life "tabs vs spaces" argument, too. I guess I had a good run
without :)

--js

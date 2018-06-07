Received: from eggs.gnu.org ([2001:4830:134:3::10]:37310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQtcu-0006M9-Py
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:02:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQtcr-00085P-M4
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:02:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58406 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fQtcr-00085D-H9
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:02:45 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180604162140.20688-1-peter.maydell@linaro.org>
	<20180604191756.1ae61871@w520.home>
	<52a5446f-4624-fd45-ce7d-492269aa5c3f@redhat.com>
	<20180605094613.52bcf85d.cohuck@redhat.com>
	<CAFEAcA80XzxdxLfwMUYLpHprX8L=AZyNDw1DiJKshhGvbFJLRA@mail.gmail.com>
Date: Thu, 07 Jun 2018 14:02:43 +0200
In-Reply-To: <CAFEAcA80XzxdxLfwMUYLpHprX8L=AZyNDw1DiJKshhGvbFJLRA@mail.gmail.com>
	(Peter Maydell's message of "Tue, 5 Jun 2018 10:19:15 +0100")
Message-ID: <87k1rayfbw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 5 June 2018 at 08:46, Cornelia Huck <cohuck@redhat.com> wrote:
>> On Tue, 5 Jun 2018 06:33:22 +0200
>> Thomas Huth <thuth@redhat.com> wrote:
>>> On 05.06.2018 03:17, Alex Williamson wrote:
>>> > On Mon,  4 Jun 2018 17:21:40 +0100
>>> > Peter Maydell <peter.maydell@linaro.org> wrote:
>>> >> +Multiline comments blocks should have a row of stars on the left
>>> >> +and the terminating */ on its own line:
>>> >> +    /* like
>>> >> +     * this
>>> >> +     */

Uh, winging just one end of the comment offends my eyes.

>>> >> +Putting the initial /* on its own line is accepted, but not required.
>>> >
>>> > Could we say "at maintainer discretion", or is that always implied?  The
>>> > asymmetry of the proposed standard is not my favorite and a mostly
>>> > blank line before and after further supports standing out from
>>> > surrounding code.
>>> I also don't like the asymmetry. I'd prefer more dense comments, though:
>>>
>>>   /* like
>>>    * this */
>
> Wow, I think that looks terrible :-)

Even more terrible, you wanted to say ;)

>>> Anyway, could we either use that dense format or the kernel-style
>>> multi-lines-comment format, please? Mixing it asymmetrically is just ugly.
>>
>> I'd vote for the kernel style, then.
>
> I don't particularly object to the kernel style (though it's not
> how I personally default to writing comments). I just didn't want
> to rule a huge chunk of our existing comments as out-of-standard
> for what I see as a relatively minor divergence in form --
> we do have a lot of no-leading-separate-/* comments. I can live
> with mandating kernel-style if it means we can rule out GNU-form
> and other weirdnesses though :-)

Let's mandate kernel-style for new code.  I could live with giving
maintainers license to tolerate certain other styles.  The fewer, the
better, though.

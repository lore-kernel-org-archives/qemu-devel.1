Received: from eggs.gnu.org ([2001:4830:134:3::10]:34904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fSKu2-0008K6-By
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 07:22:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fSKtz-00016E-3n
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 07:22:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59632 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1fSKty-00015L-U1
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 07:22:23 -0400
Date: Mon, 11 Jun 2018 13:22:18 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180611112218.GD15038@localhost.localdomain>
References: <20180604162140.20688-1-peter.maydell@linaro.org>
	<20180604191756.1ae61871@w520.home>
	<52a5446f-4624-fd45-ce7d-492269aa5c3f@redhat.com>
	<20180605094613.52bcf85d.cohuck@redhat.com>
	<CAFEAcA80XzxdxLfwMUYLpHprX8L=AZyNDw1DiJKshhGvbFJLRA@mail.gmail.com>
	<87k1rayfbw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1rayfbw.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

I'm late to the party, but anyway...

Am 07.06.2018 um 14:02 hat Markus Armbruster geschrieben:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
> > On 5 June 2018 at 08:46, Cornelia Huck <cohuck@redhat.com> wrote:
> >> On Tue, 5 Jun 2018 06:33:22 +0200
> >> Thomas Huth <thuth@redhat.com> wrote:
> >>> On 05.06.2018 03:17, Alex Williamson wrote:
> >>> > On Mon,  4 Jun 2018 17:21:40 +0100
> >>> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >>> >> +Multiline comments blocks should have a row of stars on the left
> >>> >> +and the terminating */ on its own line:
> >>> >> +    /* like
> >>> >> +     * this
> >>> >> +     */
> 
> Uh, winging just one end of the comment offends my eyes.

+1, this is the ugliest style of all.

> >>> >> +Putting the initial /* on its own line is accepted, but not required.
> >>> >
> >>> > Could we say "at maintainer discretion", or is that always implied?  The
> >>> > asymmetry of the proposed standard is not my favorite and a mostly
> >>> > blank line before and after further supports standing out from
> >>> > surrounding code.
> >>> I also don't like the asymmetry. I'd prefer more dense comments, though:
> >>>
> >>>   /* like
> >>>    * this */
> >
> > Wow, I think that looks terrible :-)
> 
> Even more terrible, you wanted to say ;)

I actually prefer this one for short (2 or 3 lines) not too important
comments in order to save some screen space.

For longer or important comments, it's kernel-style.

> >>> Anyway, could we either use that dense format or the kernel-style
> >>> multi-lines-comment format, please? Mixing it asymmetrically is just ugly.
> >>
> >> I'd vote for the kernel style, then.
> >
> > I don't particularly object to the kernel style (though it's not
> > how I personally default to writing comments). I just didn't want
> > to rule a huge chunk of our existing comments as out-of-standard
> > for what I see as a relatively minor divergence in form --
> > we do have a lot of no-leading-separate-/* comments. I can live
> > with mandating kernel-style if it means we can rule out GNU-form
> > and other weirdnesses though :-)
> 
> Let's mandate kernel-style for new code.  I could live with giving
> maintainers license to tolerate certain other styles.  The fewer, the
> better, though.

Kernel-style + give maintainers license to tolerate more compact forms
(mostly for short comments) works for me.

Kevin

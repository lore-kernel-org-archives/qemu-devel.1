Received: from eggs.gnu.org ([2001:4830:134:3::10]:59029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fSoKO-0007MK-4z
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 14:47:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fSoKL-0005RR-0g
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 14:47:36 -0400
Date: Tue, 12 Jun 2018 12:47:29 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180612124729.0e630825@w520.home>
In-Reply-To: <85642e2a-f00a-3d85-8525-0ae89e4d71c9@redhat.com>
References: <20180611141716.3813-1-peter.maydell@linaro.org>
	<650048df-f4b1-b351-f877-be8c84197ba2@linaro.org>
	<85642e2a-f00a-3d85-8525-0ae89e4d71c9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Thomas Huth <thuth@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>, patches@linaro.org, Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, 12 Jun 2018 20:12:02 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 12.06.2018 19:30, Richard Henderson wrote:
> > On 06/11/2018 04:17 AM, Peter Maydell wrote:  
> >> The codebase has a bit of a mix of different multiline
> >> comment styles. State a preference for the Linux kernel
> >> style:
> >>     /*
> >>      * Star on the left for each line.
> >>      * Leading slash-star and trailing star-slash
> >>      * each go on a line of their own.
> >>      */
> >>
> >> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >> ---
> >> This is not my personal favourite, but seemed to be the
> >> closest we had to consensus in the mail thread for v1;
> >> I can live with it in order to avoid getting patches which
> >> use the styles I like even less :-)  
> > 
> > Honestly, I don't like this except for "important" comments.
> > 
> > A "small" comment, e.g. one that doesn't quite fit on a single line, now takes
> > 4 lines instead of 2.  Which is really annoying and IMO tends to break flow.
> > 
> > If you don't like
> > 
> >   /* gnu
> >      style */
> > 
> > or
> > 
> >   /* whatever
> >    * this is */
> > 
> > could you live with
> > 
> >   // c99/c++
> >   // comments  
> 
> FWIW:
> 
> +1 for one or two of those compact styles for two- or three-line comments.

or four-line or single paragraphs or comments that rhyme with
"orange"...  If the comment is too large for a single line, then take
some time to say it more concisely, or maybe it does deserve enough
thought to frame a nice paragraph for it.  We're well into personal
style here, so either this is important enough to make some people
unhappy or we should leave it to maintainer preference and consistency
within a file/area.  Thanks,

Alex

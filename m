Received: from eggs.gnu.org ([2001:4830:134:3::10]:39511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shravan2x@utexas.edu>) id 1eLxav-0007CP-25
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 15:44:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shravan2x@utexas.edu>) id 1eLxat-0005fI-Qb
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 15:44:05 -0500
Received: from mail-qt0-x234.google.com ([2607:f8b0:400d:c0d::234]:37545)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shravan2x@utexas.edu>)
	id 1eLxat-0005ey-Kf
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 15:44:03 -0500
Received: by mail-qt0-x234.google.com with SMTP id f2so891876qtj.4
	for <qemu-devel@nongnu.org>; Mon, 04 Dec 2017 12:44:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-kO_cJKUs5sPkL5ynLd+nNrKac4dgUT-=1QmBC=e7qkg@mail.gmail.com>
References: <1512254273-7567-1-git-send-email-shravan2x@utexas.edu>
	<fa45711a-9203-423f-b9a9-e2006847f6f4@redhat.com>
	<CAFEAcA-kO_cJKUs5sPkL5ynLd+nNrKac4dgUT-=1QmBC=e7qkg@mail.gmail.com>
From: Shravan Rajinikanth <shravan2x@utexas.edu>
Date: Mon, 4 Dec 2017 14:44:01 -0600
Message-ID: <CACxwqYOedsh0rHn=xba350o1SehQJwCa9Er5W0b2daef+XQbzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] qemu-img: Fixed grammatical error in
 dump_human_image_check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Max Reitz <mreitz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

> To me both versions seem fine, could you explain the grammatical error in
the
> old message?

My opinion aligns with Peter's, in that "This means" followed by "waste of"
is a break in the sentence to a reader. Adding an "a" to change it to "This
means a waste of" also seemed like a possible fix, but I made a call to
change it "This means disk space is wasted" instead. This is mainly because
the first sentence says leaked clusters "were found", which following the
same tense in the next sentence should rather be "is wasted" (since the
scan was only run once in the past, but disk space continues to be wasted
even after the message is displayed).

I'm no expert in the English language myself, so perhaps I was wrong in
calling it a grammatical error. However, I do find the changed version more
natural to read.

Regards,
Shravan

On Mon, Dec 4, 2017 at 9:57 AM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 4 December 2017 at 15:51, Max Reitz <mreitz@redhat.com> wrote:
> > On 2017-12-02 23:37, Shravan Rajinikanth wrote:
> >> Signed-off-by: Shravan Rajinikanth <shravan2x@utexas.edu>
> >> ---
> >>  qemu-img.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/qemu-img.c b/qemu-img.c
> >> index 68b375f..bea9268 100644
> >> --- a/qemu-img.c
> >> +++ b/qemu-img.c
> >> @@ -580,7 +580,7 @@ static void dump_human_image_check(ImageCheck
> *check, bool quiet)
> >>          if (check->leaks) {
> >>              qprintf(quiet,
> >>                      "\n%" PRId64 " leaked clusters were found on the
> image.\n"
> >> -                    "This means waste of disk space, but no harm to
> data.\n",
> >> +                    "This means disk space is wasted, but data is
> safe.\n",
> >>                      check->leaks);
> >>          }
> >
> > How exactly is this a grammatical error?  (I'm not a native English
> > speaker, but it always seemed perfectly OK to me)
>
> I think "This means" more naturally takes a verb phrase, not a noun phrase.
> I don't know that I'd go so far as to say that the current text is
> ungrammatical, but I do think the proposed change sounds more natural to
> me.
>
> thanks
> -- PMM
>

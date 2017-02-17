Received: from eggs.gnu.org ([2001:4830:134:3::10]:32966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chadjoan@gmail.com>) id 1celoA-0006VO-L1
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 11:55:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chadjoan@gmail.com>) id 1celo8-0007wB-QT
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 11:54:58 -0500
MIME-Version: 1.0
In-Reply-To: <6ab86cf8-4780-ca76-f648-ac0ce211e27b@redhat.com>
References: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
	<1933406e-2576-e687-3545-a72f3b999310@redhat.com>
	<bf1410bc-bc6d-bb29-5591-55634f25d487@redhat.com>
	<CABHMSTUsZy0u4b1b84YC5CgafKvD-Zms5dCQ=31+XnQphUQxLA@mail.gmail.com>
	<20170217064327.GB21716@lemon.lan>
	<CAFEAcA8_f8SVX+rirAFBJ76ZiXaKUwh9uO0AeBFoR7G_q8pGDg@mail.gmail.com>
	<6ab86cf8-4780-ca76-f648-ac0ce211e27b@redhat.com>
From: Chad Joan <chadjoan@gmail.com>
Date: Fri, 17 Feb 2017 11:54:31 -0500
Message-ID: <CABHMSTWN2KdAXDjEEbyWio6rNM2FuDk_NUj40mFW0HdyZFu68g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Fix build break during configuration on musl-libc
 based Linux systems.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Wow, that is some quick turn-around.  Well done!

My thoughts:

   - I find this summary info very helpful!  On behalf of the N people
   trying to heal paper cuts: thank you!
   - I still recommend an example snippet for shell/bash interaction that
   demonstrates the workflow you expect from a first-time contributor.  It
   should be populated with commonly used values (ex: mailing list
   addresses).  I don't expect this to happen fast like the summary info; I
   suspect someone is going to have to pretend they are submitting a patch,
   write down what they do, and then think about how to present this.
   - Regarding the signature: IIRC, setting up certificates on a machine
   using gpg can be quite time consuming and learning-intensive if you've
   never needed to do it before.  Having that example will go a long way to
   help with this.  There is still a possible pain-point: you might write one
   line of git code in the example, and it is easy for you due to your
   workflow, but it could be hours of fiddling for someone who has never done
   it before.  If I'm wrong, show me (the hypothetical reader) how easy it is
   ;)  If I'm right (and that would be unfortunate, in this case), then it
   might be helpful if you politely ask the reader to spend time X amount of
   time on it (establish accurate expectations) and then provide a link to the
   most helpful how-to article you can find on the subject.
   - The email thing is a pain-point, but I wonder if QEMU can make it
   wonderful without sacrificing much--perhaps just a few words on the page.
   Presumably, not every email client mangles patches.  Can we have a
   whitelist?  So far the whitelist has one item: git send-email.  But git
   send-email is probably not even part of the majority population's workflow,
   so if we can test and approve even /some/ of the more popular mail clients
   (ex: gmail, thunderbird, outlook, etc) for use, it would help newbies A
   LOT.  Less importantly; a blacklist could be useful too, to prevent
   unnecessary "what about my mail client?" questions and unnecessary
   redundant testing in the future.
   - I should also mention that I found the rest of the document to be very
   well-written.  It's comprehensiveness became its weakness, but that's still
   important long-term, hence why I think an alternative path with a short
   example for trivial patches is plenty sufficient: from my perspective,
   there's no need to change the rest of the text; it is already good :).

Note that I'm bothering to stick around and provide feedback, despite other
pressing life obligations.  Providing advice on submit-a-patch usability
for QEMU isn't on my schedule, but I don't have the heart to bail on this,
especially when you all are kindly listening, having high quality
discussion, and sincerely trying to improve things.  If you read between
the lines, you see the truth: I am a yak shaver!

Oh man, when I hit a topic like "use git send-email", the hair started
flying: learning new git commands, two-factor auth on gmail, U2F keys,
governance for the no-mans-land of a server, and so on, a real yak-shaving
party.  After an hour or two, my safety triggered, and I thought, "man, I
am spending way too much time perfecting this workflow that I might never
do again" and I spent a few minutes writing a message in gmail.  I
certainly don't expect QEMU devs to fix garbled patches either: that also
seems like a huge waste of valuable time (and for talented and passionate
individuals, too).  There has to be a better way!  So I hope the whitelist
idea helps, or maybe it's enough to just call awareness to this potential
improvement.

Well, that ended up being very long.  I hope this is helpful and doesn't
spend too much of your time.

Thanks for listening!

On Fri, Feb 17, 2017 at 10:34 AM, Eric Blake <eblake@redhat.com> wrote:

> On 02/17/2017 03:28 AM, Peter Maydell wrote:
> > On 17 February 2017 at 06:43, Fam Zheng <famz@redhat.com> wrote:
> >> But your point is taken, we should make the first (or a one-shot)
> >> contribution as easy as possible.
> >
> > Yes; we could do with providing a "This page seems very long..."
> > introduction section. The absolute bare minimum requirements
> > for a submitter I think are:
> >  * Provide a Signed-off-by: line (this is a hard requirement
> >    because it's how you say "I'm legally OK to contribute this
> >    and am happy for it to go into QEMU")
> >  * send patch by email
> >  * read replies and act on them if you want your patch to go in
> >
> > The larger your contribution is, the more important the other
> > requirements detailed on the page are; but personally I'm
> > happy to manually fix up patches from a first-time submitter,
> > and I think most other maintainers are too.
>
> I've updated the wiki to put in that nice bullet list, prior to the
> table of contents.
>
> --
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
>
>

Received: from eggs.gnu.org ([2001:4830:134:3::10]:42085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chadjoan@gmail.com>) id 1cfLWD-00077C-53
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 02:02:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chadjoan@gmail.com>) id 1cfLWA-00086U-QZ
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 02:02:49 -0500
MIME-Version: 1.0
In-Reply-To: <fc3b6729-6739-5daf-5e78-85fbd7d3260d@redhat.com>
References: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
	<1933406e-2576-e687-3545-a72f3b999310@redhat.com>
	<bf1410bc-bc6d-bb29-5591-55634f25d487@redhat.com>
	<CABHMSTUsZy0u4b1b84YC5CgafKvD-Zms5dCQ=31+XnQphUQxLA@mail.gmail.com>
	<20170217064327.GB21716@lemon.lan>
	<CAFEAcA8_f8SVX+rirAFBJ76ZiXaKUwh9uO0AeBFoR7G_q8pGDg@mail.gmail.com>
	<6ab86cf8-4780-ca76-f648-ac0ce211e27b@redhat.com>
	<CABHMSTWN2KdAXDjEEbyWio6rNM2FuDk_NUj40mFW0HdyZFu68g@mail.gmail.com>
	<fc3b6729-6739-5daf-5e78-85fbd7d3260d@redhat.com>
From: Chad Joan <chadjoan@gmail.com>
Date: Sun, 19 Feb 2017 02:02:19 -0500
Message-ID: <CABHMSTUS4Oi5WZt0NcYaOnX9_u8zQeu=CupLVX2LjvD+mTYATg@mail.gmail.com>
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

On Fri, Feb 17, 2017 at 12:17 PM, Eric Blake <eblake@redhat.com> wrote:

> On 02/17/2017 10:54 AM, Chad Joan wrote:
> > Wow, that is some quick turn-around.  Well done!
> >
> > My thoughts:
> >
> >    - I find this summary info very helpful!  On behalf of the N people
> >    trying to heal paper cuts: thank you!
> >    - I still recommend an example snippet for shell/bash interaction that
> >    demonstrates the workflow you expect from a first-time contributor.
> It
> >    should be populated with commonly used values (ex: mailing list
> >    addresses).  I don't expect this to happen fast like the summary
> info; I
> >    suspect someone is going to have to pretend they are submitting a
> patch,
> >    write down what they do, and then think about how to present this.
>
> For a quickie patch, I make my edits, then 'git commit -a -s' and 'git
> send-email -1' - but that works because I've already set up git hooks to
> auto-cc the list, and I already debugged my 'get send-email' setup years
> ago.  So yeah, doing it from a completely virgin environment could
> benefit from a complete command line that reproduces what I take for
> granted in my normal environment.  And some email setups are a lot
> friendlier than others (I personally do not use gmail, but will readily
> admit that it is probably a lot easier to set up my work emails to use
> Red Hat's SMTP servers than it is for a gmail contributor to get their
> email setup working in a way that does not mangle patches).
>
>
I appreciate this retrospective :)

In my case I am working on a machine that wasn't even supposed to see any
development work.  There are no user accounts, just root.  I have tried to
avoid putting any personal information on it.  If I am on it, then I'm
editing files in /etc or installing system-wide software.  I'm realizing
that I might have to change this a bit due to the WIP nature of the
hardened-musl profile: ultimately I *am* doing development work on it, and
that kind of snuck up on me.  If I give myself a user account, then
authoring patches with git (and using send-email) becomes somewhat more
practical (putting smtp login information onto the machine still bugs me).
Still, I can't imagine I'm the only person who runs into this kind of thing
and wants to write quick patches on an impersonal machine.


> [...]
>
> But nothing requires you to set up a certificate to submit a patch.  I'm
> not sure which piece of the documentation got you steered in that
> direction, but gpg signing of patches is only required of maintainers,
> not contributors (or maybe you're hinting at the extra effort required
> to set up gmail as a valid 'git send-email' target, to which I have no
> experience, but which starts to leave the realm of qemu-specific
> instructions into something where it would be better to link to a good
> git setup tutorial, if one exists).
>
>
I think this is just language ambiguity and confirmation bias doing their
thing.  Usually when I read "you have to sign this" in an OSS context, I
think of cryptographic signing.  I haven't encountered the requirement for
non-cryptographic signing before.  Language is arbitrary and we all have
different experiences and backgrounds.

This is one of the reasons why I suggest a simple example: it would be both
very concise and unambiguous.  If there are no signing steps in the example
then you don't even need to spend words telling the reader that
cryptographic signing is unnecessary.  It'll be implied.

Thankfully, this is a separate concern from the 'git send-email' thing.



> >  Having that example will go a long way to
> >    help with this.
>
> <snip lots of useful ideas for improvement>
>
> >    - I should also mention that I found the rest of the document to be
> very
> >    well-written.  It's comprehensiveness became its weakness, but that's
> still
> >    important long-term, hence why I think an alternative path with a
> short
> >    example for trivial patches is plenty sufficient: from my perspective,
> >    there's no need to change the rest of the text; it is already good :).
>
> Thanks for that feedback.  It's often hard for a core contributor to
> remember what it was like to submit their first patch years ago, and
> having a fresh take on the matter from a new contributor is well worth
> the reminders.  It's also nice to hear this as a compliment, and not
> just a complaint.
>
>
Thanks for listening :)

I know what you mean about the complaint thing.  It's unfortunate, but it
can be very hard to know the significance of your words for others.  For
many people (possibly myself included; hard to remember) it may take a long
time to learn and internalize the implications of a truth such as "no one
wants to be hurt".  I try to be the world that I want to live in.  I'm glad
it's working out for everyone this time around.

FWIW, this thread has also left me impressed with the culture in the QEMU
community, and it makes me feel good about choosing this software too.
Good job everyone!


> >
> > Note that I'm bothering to stick around and provide feedback, despite
> other
> > pressing life obligations.  Providing advice on submit-a-patch usability
> > for QEMU isn't on my schedule, but I don't have the heart to bail on
> this,
> > especially when you all are kindly listening, having high quality
> > discussion, and sincerely trying to improve things.  If you read between
> > the lines, you see the truth: I am a yak shaver!
>
> At the risk of pushing too hard, you could always turn your (good!)
> suggestions into concrete wording, or even request a wiki account to
> make the changes yourself. But even if that is beyond your planned level
> of involvement, I do hope that various readers will be able to act on
> the suggestions in this mail to improve things.
>
>
It's always worth asking!

I'm in deep enough now that I wouldn't cheap out on it ;)

I'm more worried that I'm completely unqualified to do this.  I could try
to read the whole thing and make a small 2-4 liner that would do what QEMU
devs want.  But I'm almost certain I'd botch it up somehow.  I've already
misinterpreted the gpg signature thing; there's more where that came from!
I think a QEMU dev would get results that a QEMU dev would expect.

Well, let me know if you want me to try *anyways*.


> >
> > Oh man, when I hit a topic like "use git send-email", the hair started
> > flying: learning new git commands, two-factor auth on gmail, U2F keys,
> > governance for the no-mans-land of a server, and so on, a real
> yak-shaving
> > party.  After an hour or two, my safety triggered, and I thought, "man, I
> > am spending way too much time perfecting this workflow that I might never
> > do again" and I spent a few minutes writing a message in gmail.  I
> > certainly don't expect QEMU devs to fix garbled patches either: that also
> > seems like a huge waste of valuable time (and for talented and passionate
> > individuals, too).  There has to be a better way!  So I hope the
> whitelist
> > idea helps, or maybe it's enough to just call awareness to this potential
> > improvement.
>
> Again, part of the problem may be that gmail is not really suited to the
> ideal patch flow, and so that's going to be a pain point for any such
> contributor.  Submitting patches as an attachment is harder than the
> inline version you get with 'git send-email', but it is one of those
> one-off manual fixups that a maintainer can overlook, as long as it
> really is a one-off thing and not a repeated pattern.  And yes, we
> should document that use of an attachment is the most likely to avoid
> mangling the patch if you don't have 'git send-email' working, even if
> it is harder for the maintainer to apply such a patch.
>
>
> --
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
>
>
Interesting.  I certainly think that would help.  If the QEMU maintainers
could meet me (the hypothetical mass of first-timers) in the middle and
handle 1-3 attachments or so, then that would make things very painless on
my side.  And at the point where I am submitting more than a few patches, I
know that there is a pattern developing and I wouldn't mind spending the
effort to streamline it for everyone.  tl;dr: This idea makes sense on my
side too.

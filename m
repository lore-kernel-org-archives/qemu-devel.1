Received: from eggs.gnu.org ([2001:4830:134:3::10]:44166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chadjoan@gmail.com>) id 1cfLps-00021S-13
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 02:23:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chadjoan@gmail.com>) id 1cfLpq-0008UB-Ll
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 02:23:08 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_N1j9tpxEBROG6D1per9vDMPZeuRyM93BRzNT5ZK3q0Q@mail.gmail.com>
References: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
	<1933406e-2576-e687-3545-a72f3b999310@redhat.com>
	<bf1410bc-bc6d-bb29-5591-55634f25d487@redhat.com>
	<CABHMSTUsZy0u4b1b84YC5CgafKvD-Zms5dCQ=31+XnQphUQxLA@mail.gmail.com>
	<20170217064327.GB21716@lemon.lan>
	<CAFEAcA8_f8SVX+rirAFBJ76ZiXaKUwh9uO0AeBFoR7G_q8pGDg@mail.gmail.com>
	<6ab86cf8-4780-ca76-f648-ac0ce211e27b@redhat.com>
	<CABHMSTWN2KdAXDjEEbyWio6rNM2FuDk_NUj40mFW0HdyZFu68g@mail.gmail.com>
	<CAFEAcA_N1j9tpxEBROG6D1per9vDMPZeuRyM93BRzNT5ZK3q0Q@mail.gmail.com>
From: Chad Joan <chadjoan@gmail.com>
Date: Sun, 19 Feb 2017 02:22:41 -0500
Message-ID: <CABHMSTUJEEwbo76-4cqRq01Lpv76Y0KMdjAvgcgmuVARZGudEw@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

This is kinda depressing to read :(

But thanks for explaining.

I got a good laugh when it mentioned of Lotus Notes, "Run away from it."

Would it be reasonable to stick a link to that article in the submit a
patch document?  Something like, "If you can't use 'git send-email' for any
reason, then please review [link]this article[/link] to understand which
clients are capable of sending acceptable patches and how to configure
them."

I suspect I'm going to encounter this problem again as I try to make small
fixes for more projects, so it might be worth it for me to spend a small
amount of time at some point setting up a mail client that I can send git
patches with.  Or perhaps I can just move the patch(es) onto another
machine (ex: my personal laptop) and send it with 'git send-email' from
there, instead of needing to install a mail client that is outside of my
normal workflow.  I am not comfortable with putting smtp login information
onto the server that I am using for this work.  If anyone has any advice on
how to handle this situation, I'd appreciate it.  That kernel doc that
Peter linked is already pretty helpful, at least.

Thanks!

On Fri, Feb 17, 2017 at 12:15 PM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 17 February 2017 at 16:54, Chad Joan <chadjoan@gmail.com> wrote:
> > so if we can test and
> > approve even /some/ of the more popular mail clients (ex: gmail,
> > thunderbird, outlook, etc) for use, it would help newbies A LOT.
>
> Pretty sure we've seen mangled emails from all of those.
> The problem is that most email clients will automatically
> wrap long lines, which is fine for text but breaks an
> inline patch. Changing trailing whitespace in patches is
> also a common issue.
>
> The documentation in "git help format-patch" has a section
> "MUA-SPECIFIC HINTS" which says that gmail's web interface
> is definitely no good, and Thunderbird defaults to the wrong
> thing and requires a bunch of config changes which you'd then
> have to switch back to your preferences for normal mail when
> you're done sending patches. Outlook is so hopeless for
> patch mail it isn't even listed :-)
>
> The kernel docs have a longer list of mail clients with
> notes about suitability:
> https://kernel.org/doc/html/latest/process/email-clients.html
> but the set of "just works" clients is very small.
>
> thanks
> -- PMM
>

Received: from eggs.gnu.org ([209.51.188.92]:48225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLWXE-0005MF-Pe
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:27:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLWXD-0003lI-JU
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:27:16 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:38999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLWXD-0003kn-Eu
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:27:15 -0400
Received: by mail-ot1-x330.google.com with SMTP id o39so1398561ota.6
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 10:27:15 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 18:27:03 +0100
Message-ID: <CAFEAcA9BCXuOxaFaHvT0bDnb+7e_vYuhxspjokRp19G+SUf+MA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Spreading the load on QEMU pullreq handling and
 release work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

For most releases in the past five years, I've been handling the
work of applying pull requests, tagging release candidates, and
so on. (For one or two releases somebody else has done this when
I've been off on holiday.) This takes up a fair chunk of my time
during the actual "release" phase of a cycle, and it also
represents a "bus factor" issue for the project if I'm the only
person doing this. I'd like to try to spread this work out a bit
between more people.

Specifically, where I'd like to get to is that we have a rota of
three people doing this, which at our "three releases a year"
pace means any one person only has to handle one release cycle
a year.

Part of this move is going to require moving away from some of the
ad-hoc scripting and testing that I currently do on a selection of
personal and work machines and instead using machines that can be
used by other project members.  (One recent suggestion is that
perhaps the gitlab CI might be a useful place to start, since it
allows us to provide custom build workers rather than only doing
x86 host testing.)

For the moment I'd like to ask for in-principle volunteers
to be on the release-handling rota.

The work involves:
 * the mechanical process of actually processing pullreq
   emails and applying them
 * letting people know about failures, which can mean some
   investigation of exactly why something has failed to
   distinguish problems with the pull from preexisting
   intermittent failures from infrastructure issues
 * more careful by-hand scrutiny of pull requests from
   submaintainers who haven't done it before or who don't make
   pull requests often (checking for missing signoffs, weirdly
   malformed pull requests, patches that shouldn't be in the
   pull, etc)
 * maintenance of what I guess will need to be a shared
   project GPG keyring to add submaintainer keys (there's
   a judgement call required for whether a new key is
   sufficiently trusted, working with the submaintainer to
   ask them to try to get more signatures if possible, etc)
 * curating the "Planning" wiki page where we record things
   not yet fixed in the current release, including chasing
   people for fixes for RC bugs, asking around if anything
   ought to go in, tracking potential RC issues that crop up
   on the mailing list, etc
 * making sure we correctly raise the "is this important
   enough to go in" bar for pull requests during the release
   candidate phase by scrutinizing pull requests and if
   necessary pushing back on submaintainers
 * likely some other things I have forgotten

Since there is a definite human judgement required here, this
isn't going to be a fully automatable process[*], and it would
be best done by people who've got a reasonably long history of
working with the project (both from a trust perspective and
because they have the experience to make the judgement calls
required).

[*] It could quite possibly be automated a bit more than I
currently do it, though. I'm also open to the idea that maybe we
should do less gatekeeping at the apply-pull stage and instead
delegate to submaintainers to make the right judgements, though
in my experience there is usually at least one pullreq
submitted late in the rc process which has stuff in it that
should not go in at that point...

NB: at the moment there is a split in handling of release
candidates and the release, where I do the tagging of an rc in
git, and Michael Roth then rolls tarballs and makes
announcements of the rc or final release. Michael -- is that
work something you'd like to spread around between more people
or are you happy to continue to do it all?

So, any volunteers (from anybody, not just people on the cc list) ?

thanks
-- PMM

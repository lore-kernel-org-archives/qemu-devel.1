Received: from eggs.gnu.org ([2001:4830:134:3::10]:55648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNhqZ-0002zz-Qs
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:24:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNhqY-0002gc-Qs
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:23:59 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:40703)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNhqY-0002gK-Mk
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:23:58 -0500
Received: by mail-oi1-x22a.google.com with SMTP id t3-v6so2406443oie.7
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 09:23:58 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Nov 2018 17:23:37 +0000
Message-ID: <CAFEAcA8WWmwjY+derXd-yM==QmPtP7C3TN3pC0TCTPwVFdhZNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] QEMU Summit 2018 minutes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

As usual, during this year's KVM Forum we also held the
QEMU Summit, which is where the more active subsystem
maintainers meet up for a discussion of various maintenance
and other project issues. As always, none of this is set-in-stone
decisions; further input and discussion on-list is welcome.


 * Jeff Cody (QEMU system admin) leaving Red Hat but staying on as
   system administrator

   Stefan is the fallback admin and Paolo also has server root access
   for emergencies.

 * Google+ is shutting down, how should we replace it?

   G+ was used to announce QEMU releases and internship opportunities.
   Stefan will set up new accounts on Twitter and Mastodon.  Mike Roth
   will have access for release announcements.

 * QEMU Leadership Committee: Are changes to committee membership
   necessary (it's been 3 years)?

   The Leadership Committee represents QEMU in the Software Freedom
   Conservancy (the legal home for our project).  At the moment no
   urgent changes are necessary, but we're open to suggestions for new
   members.

 * MAINTAINERS "R:" (designated reviewer): should this be open to
   anyone?

   The maintainer still merges patches, but R: people have expressed an
   interest in reviewing patches and should be CCed.  There is debate as
   to what exactly R: means.  R: doesn't imply that the person is a
   maintainer although it is sometimes considered as having authority
   over the code.

   Cornelia Huck will send patch to clarify the exact meaning of R:.  It
   will be up to the maintainer to decide who can be added to R:.

 * Deprecating unmaintained features (devices, targets, backends) in QEMU

   QEMU has a mechanism to deprecate features but there remains a lot of
   old unmaintained code.  Refactoring is hindered by untested legacy
   code, so there is a desire to deprecate unmaintained features more
   often.

   Juan Quintela has volunteered to identify potential features for
   deprecation.

   Do we want a staging/unstaging area (similar to the Linux kernel)?
   General view was "no".

   We should require at least a minimal test for each board; if nobody
   cares enough to come up with one, that board should be deprecated.

   Areas that obviously have users, but no maintainers, are a problem
   (but not one we could think of a solution for, alas).

   Also see the qemu-devel discussion about deprecating code:
   https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg05828.html.

 * How do we change defaults in QEMU?

   There was some discussion about how we select and change our
   defaults, and how we decide the trade-off between breaking
   some existing users and making the default experience for users
   better. We didn't really come to a conclusion here, so rather than
   try to summarize the arguments I'm going to suggest that interested
   parties bring that discussion to the wider qemu-devel audience
   (or to the weekly QEMU call if that seems a useful venue).

thanks
-- PMM

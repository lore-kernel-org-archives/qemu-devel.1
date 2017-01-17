Received: from eggs.gnu.org ([2001:4830:134:3::10]:35810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cTVYk-0004TS-29
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 10:20:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cTVYg-0001xM-Sv
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 10:20:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cTVYg-0001xD-MW
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 10:20:26 -0500
Message-ID: <1484666422.31968.74.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 17 Jan 2017 16:20:22 +0100
In-Reply-To: <CAFEAcA9F3UzZkM=qX=aNe2_x9mW6dt3gQsgYUbhaXRVB2FdVhw@mail.gmail.com>
References: <1484132292-21458-1-git-send-email-kraxel@redhat.com>
	<CAFEAcA-X3mXPR5GX0_Xqs6uXiv3ur6rimb4Yoeixop87ZuMaWg@mail.gmail.com>
	<1484641214.31968.26.camel@redhat.com>
	<CAFEAcA9F3UzZkM=qX=aNe2_x9mW6dt3gQsgYUbhaXRVB2FdVhw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] cocoa: stop using MOUSE_EVENT_*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Di, 2017-01-17 at 10:44 +0000, Peter Maydell wrote:
> On 17 January 2017 at 08:20, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > On Mo, 2017-01-16 at 18:35 +0000, Peter Maydell wrote:
> >> On 11 January 2017 at 10:58, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >> > No need to go the indirect route with a bitfield and mapping the bit=
s to
> >> > INPUT_BUTTON_*.  We can use a bool array and INPUT_BUTTON_* directly
> >> > instead.
> >> >
> >> > Untested, not even compiled, due to lack of a osx^Wmacos machine.
> >> > Test results are very welcome.
> >>
> >> So what does the patch gain us?
> >
> > I can drop MOUSE_EVENT_WHEEL* without breaking the osx build.
>=20
> Why do you want to drop it, though? It's a valid mouse event
> type, and you're not going to drop the whole MOUSE_EVENT_* set
> of defines, I assume, because they're used in lots of devices.

Dunno where the MOUSE_EVENT_* #defines originally come from, I suspect
from old ps2 mouse protocols, for historical reasons, simliar to the
numeric key codes we have in qemu which are pc scancodes too.

So, yes, I considered dropping them all and use hardware-specific
#defines instead.  But it seems at least for the left/right/middle
buttons most (all?) hardware agrees on which bit is which.  So the
attempt to drop the button defines looks like pointless churn.

For the wheel that isn't the case though, that is either not present at
all (older devices) or implemented in different ways (virtual buttons,
wheel axis, ...).

cheers,
  Gerd

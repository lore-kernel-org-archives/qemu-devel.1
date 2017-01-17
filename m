Received: from eggs.gnu.org ([2001:4830:134:3::10]:43333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cTP0B-0007mp-CB
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:20:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cTP06-0007Y9-AC
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:20:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cTP06-0007Xw-3a
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:20:18 -0500
Message-ID: <1484641214.31968.26.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 17 Jan 2017 09:20:14 +0100
In-Reply-To: <CAFEAcA-X3mXPR5GX0_Xqs6uXiv3ur6rimb4Yoeixop87ZuMaWg@mail.gmail.com>
References: <1484132292-21458-1-git-send-email-kraxel@redhat.com>
	<CAFEAcA-X3mXPR5GX0_Xqs6uXiv3ur6rimb4Yoeixop87ZuMaWg@mail.gmail.com>
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

On Mo, 2017-01-16 at 18:35 +0000, Peter Maydell wrote:
> On 11 January 2017 at 10:58, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > No need to go the indirect route with a bitfield and mapping the bits t=
o
> > INPUT_BUTTON_*.  We can use a bool array and INPUT_BUTTON_* directly
> > instead.
> >
> > Untested, not even compiled, due to lack of a osx^Wmacos machine.
> > Test results are very welcome.
>=20
> So what does the patch gain us?

I can drop MOUSE_EVENT_WHEEL* without breaking the osx build.

> We'll now loop round
> that button array for every event rather than only
> the ones where the button state changed,

Well, we loop round anyway, you just don't see it directly b/c it is
hidden in the qemu_input_update_buttons() helper function.

cheers,
  Gerd

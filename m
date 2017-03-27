Received: from eggs.gnu.org ([2001:4830:134:3::10]:55756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1csVww-0004FZ-Uj
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:48:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1csVwt-0005us-1S
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:48:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1csVws-0005uR-S9
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:48:46 -0400
Message-ID: <1490621384.31035.30.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 27 Mar 2017 15:29:44 +0200
In-Reply-To: <87bmssxm9s.fsf@linaro.org>
References: <20170322172621.26186.61813.malonedeb@gac.canonical.com>
	<CAFEAcA8UYsjy6sBTGqk1Crd-0tWpF0WWukA03_GyNRaG95L07Q@mail.gmail.com>
	<87d1d8xn41.fsf@linaro.org>
	<CAFEAcA-VQHv-wD+2NBwYAe75139+37qkaypCbKOoHHk5ZRr-QA@mail.gmail.com>
	<87bmssxm9s.fsf@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [Bug 1675108] [NEW] Cocoa UI always crashes on
 startup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Bug 1675108 <1675108@bugs.launchpad.net>, QEMU Developers <qemu-devel@nongnu.org>

On Do, 2017-03-23 at 11:31 +0000, Alex Benn=C3=A9e wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>=20
> > On 23 March 2017 at 11:13, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
> >> Technically its not a random thread its the vCPU context (which ensure=
s
> >> the vCPU isn't updating while the display is being updated). But I gue=
ss
> >> the Cocoa is limited to not being able to update from an arbitrary
> >> thread?
> >
> > Yes. It's very common for windowing libraries to mandate that you
> > do all windowing operations from one specific thread.
>=20
> Fair enough. Well let me know if that works OK on MacOS and I'll fold it
> in to the other console patches. In fact I might as well do the
> start/end_exclusive dance for all OSes and it will achieve the same thing=
.

Where do we stand with this one?

cheers,
  Gerd

Received: from eggs.gnu.org ([2001:4830:134:3::10]:43134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eLtKC-0003g3-2I
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 11:10:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eLtK7-0006bk-Qd
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 11:10:32 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:10290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1eLtK7-0006Zu-G4
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 11:10:27 -0500
Date: Mon, 4 Dec 2017 17:10:24 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20171204161024.q2ttajkuyl24j5af@var.youpi.perso.aquilenet.fr>
References: <20171204151705.26028-1-samuel.thibault@ens-lyon.org>
	<CAFEAcA9CYSCJtGjRPQonyA8jvMZ6VBaWbGtrnJ7y6mJEbERMHg@mail.gmail.com>
	<20171204152645.fy5grsjjn5hedvko@var.youpi.perso.aquilenet.fr>
	<CAFEAcA_g9_qVh+7qaZSenjnCxe53jYkVRGTJF47-oN1wukGS3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_g9_qVh+7qaZSenjnCxe53jYkVRGTJF47-oN1wukGS3A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/1] baum braille device update
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

Peter Maydell, on lun. 04 déc. 2017 15:36:32 +0000, wrote:
> On 4 December 2017 at 15:26, Samuel Thibault <samuel.thibault@gnu.org> wrote:
> > Peter Maydell, on lun. 04 déc. 2017 15:21:48 +0000, wrote:
> >> On 4 December 2017 at 15:17, Samuel Thibault
> >> <samuel.thibault@ens-lyon.org> wrote:
> >> > ----------------------------------------------------------------
> >> > Samuel Thibault (1):
> >> >       baum: Truncate braille device size to 84x1
> >>
> >> Hi. Is this pull request intended for 2.11?
> >
> > If possible, yes.
> >
> >> We're currently in freeze for that and only taking "absolutely release
> >> critical" bug fixes...
> >
> > Ok, as you wish.
> >
> > It's a relatively corner case: a friend of mine does have a 88-cell
> > braille display, and can not use it with guests by running qemu
> > -usbdevice braille due to this bug.
> 
> Mmm. Looking at the code for baum.c for 2.10, this isn't a
> regression from 2.10 or a security issue, which is what it
> would need to be for us to want to put this in at this point.

Ah, ok, nevermind then, it'll have to wait.

Sorry I didn't know that.

Samuel

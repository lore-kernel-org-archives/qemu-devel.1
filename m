Received: from eggs.gnu.org ([209.51.188.92]:50106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gtnVb-0000Cs-0b
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 00:54:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gtnOv-0003JU-03
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 00:48:05 -0500
Received: from mail.ispras.ru ([83.149.199.45]:53296)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gtnOt-0003Fo-SE
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 00:48:04 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <154703587757.13472.3898702635363120794.stgit@pasha-VirtualBox>
	<154703599022.13472.1704009113561450219.stgit@pasha-VirtualBox>
	<20190111104923.GD5010@dhcp-200-186.str.redhat.com>
	<001001d4abf9$b6ea93e0$24bfbba0$@ru>
	<20190114113520.GC6837@linux.fritz.box>
In-Reply-To: <20190114113520.GC6837@linux.fritz.box>
Date: Wed, 13 Feb 2019 08:47:57 +0300
Message-ID: <001801d4c35f$ac572a10$05057e30$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v9 19/21] replay: add BH oneshot event for
 block layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Kevin Wolf' <kwolf@redhat.com>
Cc: 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, thomas.dullien@googlemail.com, pbonzini@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

> From: Kevin Wolf [mailto:kwolf@redhat.com]
> Am 14.01.2019 um 12:10 hat Pavel Dovgalyuk geschrieben:
> > > From: Kevin Wolf [mailto:kwolf@redhat.com]
> > > Am 09.01.2019 um 13:13 hat Pavel Dovgalyuk geschrieben:
> > > > Replay is capable of recording normal BH events, but sometimes
> > > > there are single use callbacks scheduled with aio_bh_schedule_oneshot
> > > > function. This patch enables recording and replaying such callbacks.
> > > > Block layer uses these events for calling the completion function.
> > > > Replaying these calls makes the execution deterministic.
> > > >
> > > > Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> > >
> > > This still doesn't come even close to catching all BHs that need to be
> > > caught. While you managed to show a few BHs that actually don't need to
> > > be considered for recording when I asked for this in v7, most BHs in the
> > > block layer can in some way lead to device callbacks and must therefore
> > > be recorded.
> >
> > Let's have a brief review. I can change all the places, but how
> > should I make a test case to be sure, that all of them are working ok?
> 
> The list is changing all the time. This is why I am so concerned about
> special-casing a few callers instead of having a generic solution. I
> don't know how we could make sure that we call the right function
> everywhere.

I changed all oneshot invocations in the block layer in the new version.
Can you review it and other block-related patches?

Pavel Dovgalyuk

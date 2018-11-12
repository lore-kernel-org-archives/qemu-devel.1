Received: from eggs.gnu.org ([2001:4830:134:3::10]:53381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gMB2e-0002Qh-2X
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 07:10:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gMB2a-0003bi-Mv
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 07:10:08 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40503)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1gMB2a-0003bB-Gb
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 07:10:04 -0500
Received: by mail-wm1-f65.google.com with SMTP id z8-v6so1736391wma.5
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 04:10:03 -0800 (PST)
MIME-Version: 1.0
References: <20181109142032.1628-1-kraxel@redhat.com>
	<9b2c9e91-8904-1200-f491-4ee1d6ed42e3@amsat.org>
	<20181112091205.brrcxxzzvfthyqhk@sirius.home.kraxel.org>
	<c21b1cba-3dee-d7d8-24b3-8d04fb0a9265@redhat.com>
	<20181112112833.hcbgtwjkb3p2qpgx@sirius.home.kraxel.org>
	<475525e6-3eaa-b53f-f987-7f63a5383b3a@redhat.com>
	<20181112115833.5sy5o7xiz2xxqloo@sirius.home.kraxel.org>
In-Reply-To: <20181112115833.5sy5o7xiz2xxqloo@sirius.home.kraxel.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Mon, 12 Nov 2018 13:09:51 +0100
Message-ID: <CAP+75-WTBegfiR0xhzk52XiK5jfXbqwP6TYz70EZN3XXX6o-uA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] pulseaudio: process audio data in
 smaller chunks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Martin Schrodt <martin@schrodt.org>, Max Ehrlich <maxehr@umiacs.umd.edu>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, Nov 12, 2018 at 12:58 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> > > Also, when making chunk size configurable we should not leave that
> > > to the confused user but pick a working value automatically, probably
> > > depending on the emulated device.  I can't see what the benefit would
> > > be though, especially given that intel-hda is probably used in most
> > > configurations these days.
> >
> > For nowadays uses I agree with your patch.
> > For retrocomputing and other weird stuffs, if we don't have this
> > user-configurable, I think we need a comment in the code about this change,
> > else it might be hard for other people to figure this change in the git
> > history.
>
> Again, why?  The pulse audio threads might wake up more often than
> needed.  This should have no negative effect on the functionality of
> the emulated sound cards though.  Worst case is we need a few more cpu
> cycles due to the higher wakeup rate (didn't measure that though).

OK, fine then!

Thanks,

Phil.

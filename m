Received: from eggs.gnu.org ([209.51.188.92]:52230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gkN1G-0005uP-SL
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 00:48:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gkMnw-0005Lo-RO
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 00:34:58 -0500
Received: from mail.ispras.ru ([83.149.199.45]:44078)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gkMnw-0005JZ-Jy
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 00:34:56 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20190117073649.5399.97670.stgit@pasha-VirtualBox>	<20190117073758.5399.16268.stgit@pasha-VirtualBox>
	<87tvi72z8l.fsf@dusky.pond.sub.org>
In-Reply-To: <87tvi72z8l.fsf@dusky.pond.sub.org>
Date: Fri, 18 Jan 2019 08:34:59 +0300
Message-ID: <002701d4aeef$8dc965b0$a95c3110$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v10 12/24] replay: introduce breakpoint at
 the specified step
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Markus Armbruster' <armbru@redhat.com>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, ciro.santilli@gmail.com, jasowang@redhat.com, quintela@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com, artem.k.pisarenko@gmail.com, dgilbert@redhat.com, rth@twiddle.net

> From: Markus Armbruster [mailto:armbru@redhat.com]
> Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru> writes:
> 
> > This patch introduces replay_break, replay_delete_break
> > qmp and hmp commands.
> > These commands allow stopping at the specified instruction.
> > It may be useful for debugging when there are some known
> > events that should be investigated.
> > replay_break command has one argument - number of instructions
> > executed since the start of the replay.
> > replay_delete_break removes previously set breakpoint.
> >
> > Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> >
> > --
> > +
> > +static void replay_break(uint64_t icount, QEMUTimerCB callback, void *opaque)
> > +{
> > +    assert(replay_mode == REPLAY_MODE_PLAY);
> > +    assert(replay_mutex_locked());
> > +    assert(replay_break_icount >= replay_get_current_step());
> 
> The identifier replay_get_current_step() is one of the few remaining
> instances of "step" terminology.  Whether to normalize them to "icount"
> is entirely up to you.

This is already done with the last patch in the series.

Pavel Dovgalyuk

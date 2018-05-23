Received: from eggs.gnu.org ([2001:4830:134:3::10]:57917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fLToI-0005yx-Tm
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:28:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fLToE-0005Qu-2O
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:28:10 -0400
Received: from mail.ispras.ru ([83.149.199.45]:45378)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fLToD-0005Pw-QQ
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:28:06 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180523064941.26016.74274.stgit@pasha-VirtualBox>
	<CAFXrp_fOpwvT0qOZO+L+5LJJvGsj3bXp_GxhbLt-mZN9cN2nPg@mail.gmail.com>
In-Reply-To: <CAFXrp_fOpwvT0qOZO+L+5LJJvGsj3bXp_GxhbLt-mZN9cN2nPg@mail.gmail.com>
Date: Wed, 23 May 2018 16:28:05 +0300
Message-ID: <000301d3f299$e1e20340$a5a609c0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v3 00/19] reverse debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Ciro Santilli' <ciro.santilli@gmail.com>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>
Cc: 'QEMU Developers' <qemu-devel@nongnu.org>

> From: Ciro Santilli [mailto:ciro.santilli@gmail.com]
> On Wed, May 23, 2018 at 7:49 AM, Pavel Dovgalyuk
> <Pavel.Dovgaluk@ispras.ru> wrote:
> > GDB remote protocol supports reverse debugging of the targets.
> > It includes 'reverse step' and 'reverse continue' operations.
> > The first one finds the previous step of the execution,
> > and the second one is intended to stop at the last breakpoint that
> > would happen when the program is executed normally.
> >
> > Reverse debugging is possible in the replay mode, when at least
> > one snapshot was created at the record or replay phase.
> > QEMU can use these snapshots for travelling back in time with GDB.
> >
> > Running the execution in replay mode allows using GDB reverse debugging
> > commands:
> >  - reverse-stepi (or rsi): Steps one instruction to the past.
> >    QEMU loads on of the prior snapshots and proceeds to the desired
> >    instruction forward. When that step is reaches, execution stops.
> >  - reverse-continue (or rc): Runs execution "backwards".
> >    QEMU tries to find breakpoint or watchpoint by loaded prior snapshot
> >    and replaying the execution. Then QEMU loads snapshots again and
> >    replays to the latest breakpoint. When there are no breakpoints in
> >    the examined section of the execution, QEMU finds one more snapshot
> >    and tries again. After the first snapshot is processed, execution
> >    stops at this snapshot.
> >
> > The set of patches include the following modifications:
> >  - gdbstub update for reverse debugging support
> >  - functions that automatically perform reverse step and reverse
> >    continue operations
> >  - hmp/qmp commands for manipulating the replay process
> >  - improvement of the snapshotting for saving the execution step
> >    in the snapshot parameters
> >  - other record/replay fixes
> >
> > The patches are available in the repository:
> > https://github.com/ispras/qemu/tree/rr-180428
> >
> 
> This branch appears to contain one month old commits, is it the correct one?

Right.
There were no significant changes except the fix which was already queued by Paolo.
As soon as it is upstreamed, I'll update the branch.

Pavel Dovgalyuk

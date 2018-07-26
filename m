Received: from eggs.gnu.org ([2001:4830:134:3::10]:58571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fiaph-0000KH-7C
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 03:37:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fiape-0006xv-89
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 03:37:09 -0400
Received: from mail.ispras.ru ([83.149.199.45]:34332)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fiapd-0006xK-Vb
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 03:37:06 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
	<20180725121706.12867.98787.stgit@pasha-VirtualBox>
	<20180725134429.roe7iuzakjywdv7e@var.youpi.perso.aquilenet.fr>
	<000601d424af$74e5c900$5eb15b00$@ru>
	<20180726073549.j277pe6ykdtgbn6k@var.youpi.perso.aquilenet.fr>
In-Reply-To: <20180726073549.j277pe6ykdtgbn6k@var.youpi.perso.aquilenet.fr>
Date: Thu, 26 Jul 2018 10:37:03 +0300
Message-ID: <000701d424b3$74319760$5c94c620$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v5 24/24] slirp: fix ipv6 timers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Samuel Thibault' <samuel.thibault@gnu.org>
Cc: 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, pbonzini@redhat.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, crosthwaite.peter@gmail.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

> From: Samuel Thibault [mailto:samuel.thibault@gnu.org]
> Pavel Dovgalyuk, le jeu. 26 juil. 2018 10:08:29 +0300, a ecrit:
> > > As documented:
> > >
> > >  * @QEMU_CLOCK_REALTIME: Real time clock
> > >  *
> > >  * The real time clock should be used only for stuff which does not
> > >  * change the virtual machine state, as it runs even if the virtual
> > >  * machine is stopped.
> > >
> > > There is no reason to "send RAs" while the machine is stopped.
> >
> > I see.
> > Then we'll need one more clock. Which works like realtime+virtual:
> > intended to be used for the internal QEMU purposes, but stops when
> > VM is stopped.
> 
> Just to be sure: what is meant by "is stopped"? Is it a pause (thus time
> does not advance within the guest), or is it just sleeping because it
> has nothing to do?

Paused with HMP/QMP command.
As virtual clock runs only if VM is not paused.

Pavel Dovgalyuk

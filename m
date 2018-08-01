Received: from eggs.gnu.org ([2001:4830:134:3::10]:50928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fkwhq-0002eB-Gd
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 15:22:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fkwhp-0005Vg-IK
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 15:22:46 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fkwhp-0005UM-Ae
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 15:22:45 -0400
Date: Wed, 1 Aug 2018 21:22:41 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180801192241.frw46eelfgt6a2ok@var.youpi.perso.aquilenet.fr>
References: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
	<20180725121706.12867.98787.stgit@pasha-VirtualBox>
	<20180725134429.roe7iuzakjywdv7e@var.youpi.perso.aquilenet.fr>
	<000601d424af$74e5c900$5eb15b00$@ru>
	<20180726080718.pdzxwxoj4sjjpycm@var.youpi.perso.aquilenet.fr>
	<000801d424bb$f4b23130$de169390$@ru>
	<20180726091527.j3zw677cprhpfazu@var.youpi.perso.aquilenet.fr>
	<000101d4289b$e1874e90$a495ebb0$@ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000101d4289b$e1874e90$a495ebb0$@ru>
Subject: Re: [Qemu-devel] [PATCH v5 24/24] slirp: fix ipv6 timers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, pbonzini@redhat.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, crosthwaite.peter@gmail.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

Pavel Dovgalyuk, le mar. 31 juil. 2018 09:58:26 +0300, a ecrit:
> > From: Samuel Thibault [mailto:samuel.thibault@gnu.org]
> > Pavel Dovgalyuk, le jeu. 26 juil. 2018 11:37:57 +0300, a ecrit:
> > > Or the timers are related to the network devices (e.g., servers in the
> > > outer world)?
> > 
> > No.
> > 
> > > > > > > this service is not related to the guest state.
> > > >
> > > > seems incorrect. At the moment the ip6_icmp timer's current value is not
> > > > saved in the guest state, but in principle it should, so that the guest
> > > > does see the RAs at a regular rate. In practice we don't care because
> > > > the timing is randomized anyway.
> > >
> > > Isn't this just a side effect?
> > > I mean that slirp may be replaced by, say, tap, and the guest should not notice
> > > the difference.
> > 
> > Well, if a guest is connected through a tap, the virtual time should
> > really run as fast as the realtime, and it should not be paused.
> > Otherwise TCP connections will break since the guest won't be able to
> > reply fast enough, without even knowing about the issue. Slirp can
> > compensate this thanks to a buffer between what happens in the real
> > world and what happens in the virtual world. Real world timings are
> > handled by the OS socket implementation, and virtual world timings are
> > handled with the qemu timer.
> 
> Then maybe the solution is the new clock with the frequency of the virtual
> clock, but which does not affect the replayed core?
> This clock should stop when VM is paused.
> It also could be saved in vmstate. As it does not affect the replay,
> saving and restoring its state won't break anything.

I guess so.

Samuel

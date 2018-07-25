Received: from eggs.gnu.org ([2001:4830:134:3::10]:39496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fiK5k-0004H7-A4
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 09:44:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fiK5h-0005He-Bm
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 09:44:36 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:53087)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fiK5h-0005Go-0D
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 09:44:33 -0400
Date: Wed, 25 Jul 2018 15:44:29 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180725134429.roe7iuzakjywdv7e@var.youpi.perso.aquilenet.fr>
References: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
	<20180725121706.12867.98787.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725121706.12867.98787.stgit@pasha-VirtualBox>
Subject: Re: [Qemu-devel] [PATCH v5 24/24] slirp: fix ipv6 timers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, pbonzini@redhat.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, crosthwaite.peter@gmail.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com, dovgaluk@ispras.ru, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

Pavel Dovgalyuk, le mer. 25 juil. 2018 15:17:06 +0300, a ecrit:
> ICMP implementation for IPv6 uses timers based on virtual clock.
> This is incorrect because this service is not related to the guest state.

? Why not?  The RAs are seen by the guest.  As documented:

 * @QEMU_CLOCK_REALTIME: Real time clock
 *
 * The real time clock should be used only for stuff which does not
 * change the virtual machine state, as it runs even if the virtual
 * machine is stopped.

There is no reason to "send RAs" while the machine is stopped.

Samuel

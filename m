Received: from eggs.gnu.org ([2001:4830:134:3::10]:46192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gOoj6-00082h-WF
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 13:56:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gOoj2-00074z-1a
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 13:56:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:62584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gOoj1-00072Q-Sb
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 13:56:47 -0500
Date: Mon, 19 Nov 2018 18:56:43 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181119185643.GE2365@work-vm>
References: <20181119183343.GD2365@work-vm>
	<13233.1542653690@dschgrazlin2.units.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13233.1542653690@dschgrazlin2.units.it>
Subject: Re: [Qemu-devel] 3.1.0-rc{0,1} doesn't start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: balducci@units.it
Cc: qemu-devel@nongnu.org

* balducci@units.it (balducci@units.it) wrote:
> > A colleague has confirmed this on his FX-8320 on Fedora 29 with the
> > virt-next repo;  so it's nothing that's special about your machine;
> > it's 3.1 that really doesn't like the old AMDs.
> 
> ouch! does this mean that I must stop upgrading qemu or do you think
> that some development work will be directed towards this "back
> compatibility" issue?

It'll probably be fixed; thanks to your report I've added it to the
known issues part of the 3.1rc list.

> (apologies for being totally unable to help with patches/code...I know
> zero about all the qemu business)

Those bits of the MSRs are pretty specialised as well; so I've asked
a few people more familiar with them to jump in.

Dave

> thanks a lot
> ciao
> -gabriele
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

Received: from eggs.gnu.org ([2001:4830:134:3::10]:45612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fJeJa-0004TR-LY
	for qemu-devel@nongnu.org; Fri, 18 May 2018 08:16:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fJeJX-00079L-HM
	for qemu-devel@nongnu.org; Fri, 18 May 2018 08:16:54 -0400
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:59638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fJeJX-00078Y-AC
	for qemu-devel@nongnu.org; Fri, 18 May 2018 08:16:51 -0400
Received: from player158.ha.ovh.net (unknown [10.109.122.80])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id B806C134F52
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 14:16:49 +0200 (CEST)
Date: Fri, 18 May 2018 14:16:42 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180518141642.6ad639ac@bahia.lan>
In-Reply-To: <e9333edf-fa2a-6ad8-412b-459b0b8002e9@xenosoft.de>
References: <4521b265-855f-7f06-ffff-3fa394380922@xenosoft.de>
	<b3243bab-58b6-0b43-67b5-94a2f90d9199@tuxfamily.org>
	<5BD35D0B-E490-4693-8858-E11B7401709F@xenosoft.de>
	<1821476d-7724-ad71-eb3f-69c731633582@tuxfamily.org>
	<886dc490-c96a-ad5a-e1f7-8e41a686a53e@xenosoft.de>
	<20180518131303.6f0778eb@bahia.lan>
	<e9333edf-fa2a-6ad8-412b-459b0b8002e9@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PPC64] P5020DS: Booting from img possible
 (-drive)?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org, "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

On Fri, 18 May 2018 13:50:42 +0200
Christian Zigotzky <chzigotzky@xenosoft.de> wrote:

> On 18 May 2018 at 1:13PM, Greg Kurz wrote:
> > And of course your kernel should be built with virtio support.
> I think I have enabled virtio support. Please find attached my kernel 
> config.
> 

Indeed, what about passing root=/dev/vda3 to the kernel ?

> -- Christian

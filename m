Received: from eggs.gnu.org ([2001:4830:134:3::10]:33707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpuQ9-0000f6-6G
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 06:52:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpuQ5-0008A9-Ay
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 06:52:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dpuQ5-00089v-5U
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 06:52:25 -0400
Date: Thu, 7 Sep 2017 12:52:20 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170907125220.0d78d285.cohuck@redhat.com>
In-Reply-To: <f06e081a-aff4-f2db-5741-b1f85f98f995@linux.vnet.ibm.com>
References: <20170905111645.18068-1-pasic@linux.vnet.ibm.com>
	<20170905111645.18068-6-pasic@linux.vnet.ibm.com>
	<20170906151821.1a77afe5.cohuck@redhat.com>
	<20170907073108.GD31680@bjsdjshi@linux.vnet.ibm.com>
	<20170907100817.08ddae29.cohuck@redhat.com>
	<f06e081a-aff4-f2db-5741-b1f85f98f995@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/5] s390x/ccs: add ccw-tester emulated
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Thu, 7 Sep 2017 12:21:50 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 09/07/2017 10:08 AM, Cornelia Huck wrote:
> > On Thu, 7 Sep 2017 15:31:09 +0800
> > Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> >> I'm thinking of a method these days:
> >> Could passing through an fully emulated ccw device (e.g. 3270), or a
> >> virtio ccw device, in the level 1 kvm guest to a level 2 guest be a test
> >> method for this?
> >>
> >> All of the CCWs will be translated to IDAL CCWs by vfio-ccw in the level
> >> 1 guest (which is the level 2 kvm host) and issued to the level 1 kvm
> >> host. So, those IDALs will eventually be handled by the emulated device,
> >> or the virtio ccw device, on the level 1 kvm host...
> >>
> >> Some days ago, one of my colleague tried the emulated 3270 passing
> >> through. She stucked with the problem that the level 1 kvm host handling
> >> a senseid IDAL ccw as a Direct ccw.
> >>
> >> Maybe I could try to pass through a virtio ccw device. I don't think of
> >> any obvious problem that would lead to fail. Any comment?
> >>  
> > 
> > That actually looks like a good thing to try! Cool idea.
> >   
> 
> I'm afraid that it would not work without some extra work.
> AFAIR Connie we said that the 3270 does not use any IDA, so
> I did not touch the 3270 emulation code in QEMU. To make
> the scenario viable one should convert the 3270 emulation
> to ccw data stream (unless the original implementation
> already took care of IDA, which I doubt).

But the vfio-ccw code uses idals... no need to touch the 3270 emulation.

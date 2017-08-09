Received: from eggs.gnu.org ([2001:4830:134:3::10]:40038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dfNf4-0004wW-L2
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:52:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dfNf0-0006Dj-J7
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:52:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dfNf0-0006DA-D6
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:52:18 -0400
Date: Wed, 9 Aug 2017 11:52:11 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170809115211.06dd074e.cohuck@redhat.com>
In-Reply-To: <CAFEAcA99yzszYLH4rVt4T5h7qJbePkU=TgCJ==nhDU-ogscuDw@mail.gmail.com>
References: <20170809071718.17924-1-cohuck@redhat.com>
	<f384f920-9d51-4663-f7e7-95c8b13044f4@redhat.com>
	<20170809102737.18436fb4.cohuck@redhat.com>
	<5e015c3e-7973-f397-cc1e-fee190292616@redhat.com>
	<CAFEAcA99yzszYLH4rVt4T5h7qJbePkU=TgCJ==nhDU-ogscuDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] 9pfs: fix dependencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

On Wed, 9 Aug 2017 10:47:18 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 9 August 2017 at 10:07, Thomas Huth <thuth@redhat.com> wrote:
> > While virtio-pci and virtio-ccw seem to require separate dedicated
> > devices (e.g. virtio-9p-pci and virtio-9p-ccw) for everything,
> > virtio-mmio seems to work different. As far as I can see, there are no
> > dedicated virtio-xxx-mmio devices in the code at all. According to
> > https://www.redhat.com/archives/libvir-list/2013-August/msg00009.html
> > you simply have to use virtio-xxx-device here instead. And a
> > virtio-9p-device is available. So theoretically, the 9p code should work
> > with virtio-mmio, too, or is there a problem that I did not see yet?
> >
> > Anyway, we likely should not blindly enable this, so unless somebody has
> > a setup to test it, we should go with your current patch instead, I think.  
> 
> As you say, we already compile the virtio-9p-device that can
> plug into any virtio transport. So why not just build it
> whenever virtio of any form is enabled? Having it only
> build if PCI is also enabled seems very odd: the backend
> should not care at all about what transport it is using.

Given the previous discussions, I think just dropping the PCI
dependency is indeed the way to go. I'll send a v3.

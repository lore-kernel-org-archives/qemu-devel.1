Received: from eggs.gnu.org ([2001:4830:134:3::10]:35130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRsTK-0003j0-Oa
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 23:28:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRsTH-0007ZA-LR
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 23:28:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eRsTH-0007Xp-ES
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 23:28:39 -0500
Date: Thu, 21 Dec 2017 06:28:34 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171221062738-mutt-send-email-mst@kernel.org>
References: <1511859789-43680-1-git-send-email-arei.gonglei@huawei.com>
	<33183CC9F5247A488A2544077AF19020DA4ED5D3@DGGEMA505-MBX.china.huawei.com>
	<20171220193658-mutt-send-email-mst@kernel.org>
	<33183CC9F5247A488A2544077AF19020DA4F143F@DGGEMA505-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA4F143F@DGGEMA505-MBX.china.huawei.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] cryptodev: add vhost support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, longpeng <longpeng2@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "roy.fan.zhang@intel.com" <roy.fan.zhang@intel.com>

On Thu, Dec 21, 2017 at 12:51:12AM +0000, Gonglei (Arei) wrote:
> 
> 
> > -----Original Message-----
> > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > Sent: Thursday, December 21, 2017 1:39 AM
> > To: Gonglei (Arei)
> > Cc: qemu-devel@nongnu.org; pbonzini@redhat.com; Huangweidong (C);
> > stefanha@redhat.com; Zhoujian (jay); pasic@linux.vnet.ibm.com; longpeng;
> > xin.zeng@intel.com; roy.fan.zhang@intel.com
> > Subject: Re: [PATCH 0/4] cryptodev: add vhost support
> > 
> > On Mon, Dec 18, 2017 at 09:03:16AM +0000, Gonglei (Arei) wrote:
> > > Ping...
> > >
> > > Fan (working for DPDK parts) is waiting for those patches upstreamed. :)
> > >
> > > Thanks,
> > > -Gonglei
> > 
> > As far as I am concerned, the main issue is that it says it assumes
> > polling.  virtio does not work like this right now.  As long as spec
> > does not support interrupt mode, I don't think we can merge this.
> > 
> Sorry, Michael. This makes me confused. Because the Qemu part about vhost-user crypto 
> doesn't do this assumption. The main controversial point is whether session operations
> should be added in the vhost-user protocol, raised by Paolo. And we made an explanation. 
> 
> Thanks,
> -Gonglei

Looks like I misunderstood some code. Will look some more.

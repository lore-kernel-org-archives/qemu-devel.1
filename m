Received: from eggs.gnu.org ([209.51.188.92]:44431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cjia@nvidia.com>) id 1gwiZc-0005bW-Ih
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 02:15:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cjia@nvidia.com>) id 1gwiZb-0005gj-9a
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 02:15:12 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7583)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cjia@nvidia.com>) id 1gwiZa-0005fn-Nm
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 02:15:11 -0500
Date: Wed, 20 Feb 2019 23:10:03 -0800
From: Neo Jia <cjia@nvidia.com>
Message-ID: <20190221071003.GA10501@nvidia.com>
References: <1550611400-13703-1-git-send-email-kwankhede@nvidia.com>
	<20190220102252.GB2608@work-vm>
	<e76e19a8-1c98-7c62-5587-ab0b898d2473@nvidia.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19C95040C@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19C95040C@SHSMSX104.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/5] Add migration support for VFIO
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Kirti Wankhede <kwankhede@nvidia.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Yang, Ziye" <ziye.yang@intel.com>, "Liu,
	Changpeng" <changpeng.liu@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>, "eskultet@redhat.com" <eskultet@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "eauger@redhat.com" <eauger@redhat.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "felipe@nutanix.com" <felipe@nutanix.com>, "Zhengxiao.zx@alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>, "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>, "Wang,
	Zhi A" <zhi.a.wang@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>, "yulei.zhang@intel.com" <yulei.zhang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Thu, Feb 21, 2019 at 05:52:53AM +0000, Tian, Kevin wrote:
> > From: Kirti Wankhede [mailto:kwankhede@nvidia.com]
> > Sent: Thursday, February 21, 2019 1:25 PM
> > 
> > On 2/20/2019 3:52 PM, Dr. David Alan Gilbert wrote:
> > > * Kirti Wankhede (kwankhede@nvidia.com) wrote:
> > >> Add migration support for VFIO device
> > >
> > > Hi Kirti,
> > >   Can you explain how this compares and works with Yan Zhao's
> > > set?
> > 
> > This patch set is incremental version of my previous patch set:
> > https://patchwork.ozlabs.org/cover/1000719/
> > This takes care of the feedbacks received on previous version.
> > 
> > This patch set is different than Yan Zhao's set.
> > 
> 
> I can help give some background about Yan's work:
> 
> There was a big gap between Kirti's last version and the overall review
> comments, especially this one:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg576652.html

Hi Kevin,

> 
> Then there was no reply from Kirti whether she agreed with the comments
> and was working on a new version.

Sorry, we should ack on those comments when we have received them last time.

> 
> Then we think we should jump in to keep the ball moving, based on
> a fresh implementation according to recommended direction, i.e. focusing
> on device state management instead of sticking to migration flow in kernel
> API design.
> 
> and also more importantly we provided kernel side implementation based
> on Intel GVT-g to give the whole picture of both user/kernel side changes.
> That should give people a better understanding of how those new APIs
> are expected to be used by Qemu, and to be implemented by vendor driver.
> 
> That is why Yan just shared her work.

Really glad to see the v2 version works for you guys, appreciate for the driver
side changes.

> 
> Now it's great to see that Kirti is still actively working on this effort and is
> also moving toward the right direction. Let's have a close look at two
> implementations and then choose a cleaner one as base for future
> enhancements. :-)

Yes, the v3 has addressed all the comments / concerns raised in the v2, I think
we should take a look and keep moving.

Just a quick thought - would be possible / better to have Kirti focus on the QEMU 
patches and Yan take care GVT-g kernel driver side changes? This will give us
the best testing coverage. Hope I don't step on anybody's toes here. ;-)

Thanks,
Neo

> 
> Thanks
> Kevin

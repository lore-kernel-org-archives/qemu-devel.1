Received: from eggs.gnu.org ([209.51.188.92]:54010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1gyoO4-000079-Im
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 20:51:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1gyoO2-0003JB-J3
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 20:51:56 -0500
Received: from mga01.intel.com ([192.55.52.88]:13423)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kevin.tian@intel.com>)
	id 1gyoNt-0002mV-9o
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 20:51:48 -0500
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Wed, 27 Feb 2019 01:51:29 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19C95F062@SHSMSX104.ccr.corp.intel.com>
References: <1550611400-13703-1-git-send-email-kwankhede@nvidia.com>
	<20190220102252.GB2608@work-vm>
	<e76e19a8-1c98-7c62-5587-ab0b898d2473@nvidia.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19C95040C@SHSMSX104.ccr.corp.intel.com>
	<20190221071003.GA10501@nvidia.com>
In-Reply-To: <20190221071003.GA10501@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Neo Jia <cjia@nvidia.com>
Cc: Kirti Wankhede <kwankhede@nvidia.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Yang, Ziye" <ziye.yang@intel.com>, "Liu,
	Changpeng" <changpeng.liu@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>, "eskultet@redhat.com" <eskultet@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "eauger@redhat.com" <eauger@redhat.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "felipe@nutanix.com" <felipe@nutanix.com>, "Zhengxiao.zx@alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>, "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>, "Wang,
	Zhi A" <zhi.a.wang@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>, "yulei.zhang@intel.com" <yulei.zhang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> From: Neo Jia [mailto:cjia@nvidia.com]
> Sent: Thursday, February 21, 2019 3:10 PM
>=20
> On Thu, Feb 21, 2019 at 05:52:53AM +0000, Tian, Kevin wrote:
> > > From: Kirti Wankhede [mailto:kwankhede@nvidia.com]
> > > Sent: Thursday, February 21, 2019 1:25 PM
> > >
> > > On 2/20/2019 3:52 PM, Dr. David Alan Gilbert wrote:
> > > > * Kirti Wankhede (kwankhede@nvidia.com) wrote:
> > > >> Add migration support for VFIO device
> > > >
> > > > Hi Kirti,
> > > >   Can you explain how this compares and works with Yan Zhao's
> > > > set?
> > >
> > > This patch set is incremental version of my previous patch set:
> > > https://patchwork.ozlabs.org/cover/1000719/
> > > This takes care of the feedbacks received on previous version.
> > >
> > > This patch set is different than Yan Zhao's set.
> > >
> >
> > I can help give some background about Yan's work:
> >
> > There was a big gap between Kirti's last version and the overall review
> > comments, especially this one:
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg576652.html
>=20
> Hi Kevin,
>=20
> >
> > Then there was no reply from Kirti whether she agreed with the comments
> > and was working on a new version.
>=20
> Sorry, we should ack on those comments when we have received them last
> time.
>=20
> >
> > Then we think we should jump in to keep the ball moving, based on
> > a fresh implementation according to recommended direction, i.e. focusin=
g
> > on device state management instead of sticking to migration flow in ker=
nel
> > API design.
> >
> > and also more importantly we provided kernel side implementation based
> > on Intel GVT-g to give the whole picture of both user/kernel side chang=
es.
> > That should give people a better understanding of how those new APIs
> > are expected to be used by Qemu, and to be implemented by vendor driver=
.
> >
> > That is why Yan just shared her work.
>=20
> Really glad to see the v2 version works for you guys, appreciate for the =
driver
> side changes.
>=20
> >
> > Now it's great to see that Kirti is still actively working on this effo=
rt and is
> > also moving toward the right direction. Let's have a close look at two
> > implementations and then choose a cleaner one as base for future
> > enhancements. :-)
>=20
> Yes, the v3 has addressed all the comments / concerns raised in the v2, I=
 think
> we should take a look and keep moving.
>=20
> Just a quick thought - would be possible / better to have Kirti focus on =
the
> QEMU
> patches and Yan take care GVT-g kernel driver side changes? This will giv=
e us
> the best testing coverage. Hope I don't step on anybody's toes here. ;-)
>=20

That is one option to be considered. For now let's focus on closing=20
kernel interface definition. I saw Alex given lots of comments on both
series. Hope we can discuss and converge on that part soon, before
moving to next version. :-)

Thanks
Kevin

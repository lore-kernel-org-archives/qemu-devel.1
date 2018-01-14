Received: from eggs.gnu.org ([2001:4830:134:3::10]:39267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eaZ5z-0008P9-4B
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 22:36:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eaZ5v-0002gX-6s
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 22:36:31 -0500
Received: from mga05.intel.com ([192.55.52.43]:45877)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eaZ5u-0002ci-UJ
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 22:36:27 -0500
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Sun, 14 Jan 2018 03:36:19 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7393CA35E@shsmsx102.ccr.corp.intel.com>
References: <20180110161438.GA28096@stefanha-x1.localdomain>
	<5A5704B4.5090502@intel.com>
	<CAJSP0QWyaE8qUGMgcpzB460Y=kpX4VDfqFWm-CWmmX4X3nmRMQ@mail.gmail.com>
	<5A585930.1030009@intel.com>
	<20180112103736.GF7356@stefanha-x1.localdomain>
In-Reply-To: <20180112103736.GF7356@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] vhost-pci and virtio-vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>

On Friday, January 12, 2018 6:38 PM, Stefan Hajnoczi wrote:
> On Fri, Jan 12, 2018 at 02:44:00PM +0800, Wei Wang wrote:
> > On 01/11/2018 05:56 PM, Stefan Hajnoczi wrote:
> > > On Thu, Jan 11, 2018 at 6:31 AM, Wei Wang <wei.w.wang@intel.com>
> wrote:
> > > > On 01/11/2018 12:14 AM, Stefan Hajnoczi wrote:
> >
> I expect vhost-pci to require fewer code changes.  If you judge "simpler"=
 just
> by the patch count or size, then vhost-pci will win.
>=20
> The reason for that is virtio-vhost-user integrates with librte_vhost.
> This requires refactoring librte_vhost to support multiple transports.
>=20

I think the driver having more code is fine. The device part is what will g=
o into the spec, and people have the freedom to implement their own driver =
(either the dpdk or kernel driver) in the future, if they don't want the li=
brte_vhost based one.

So, for the first version, I think it would be better to not make the devic=
e full-featured (e.g. pass through as little messages as possible), this wo=
uld give users a chance to get a device and driver with the least lines of =
code. =20


> I think the virtio-vhost-user end result is worth it though: vhost device=
s like
> examples/vhost/ and examples/vhost/scsi/ will work with both AF_UNIX and
> virtio-vhost-user.  This makes it simpler for users and vhost device
> developers - you only have one implementation of net, scsi, blk, etc devi=
ces.

For the driver part, isn't it that net, scsi, blk will have their own separ=
ate implementation on top of the common libret_vhost?

Best,
Wei

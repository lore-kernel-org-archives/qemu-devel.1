Received: from eggs.gnu.org ([2001:4830:134:3::10]:36763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1cMS2M-0003Do-9P
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 23:09:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1cMS2H-0002NP-Bw
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 23:09:54 -0500
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Thu, 29 Dec 2016 04:09:39 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190BEED9B@SHSMSX101.ccr.corp.intel.com>
References: <20161220163139.12016-1-famz@redhat.com>
In-Reply-To: <20161220163139.12016-1-famz@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/4] RFC: A VFIO based block driver for
 NVMe device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Karl Rister <krister@redhat.com>

> From: Fam Zheng
> Sent: Wednesday, December 21, 2016 12:32 AM
>=20
> This series adds a new protocol driver that is intended to achieve about =
20%
> better performance for latency bound workloads (i.e. synchronous I/O) tha=
n
> linux-aio when guest is exclusively accessing a NVMe device, by talking t=
o the
> device directly instead of through kernel file system layers and its NVMe
> driver.
>=20

Curious... if the NVMe device is exclusively owned by the guest, why
not directly passing through to the guest? is it a tradeoff between
performance (better than linux-aio) and composability (snapshot and
live migration which not supported by direct passthrough)?

Thanks
Kevin

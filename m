Received: from eggs.gnu.org ([2001:4830:134:3::10]:34651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d6ETA-0000Nd-HP
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:58:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d6ET5-0003s9-R9
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:58:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:39830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d6ET5-0003qj-GE
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:58:43 -0400
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Thu, 4 May 2017 10:58:37 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7391FDD30@shsmsx102.ccr.corp.intel.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] virtio-net: configurable TX queue size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Jan Scheurich <jan.scheurich@ericsson.com>

Hi,

I want to re-open the discussion left long time ago:
https://lists.gnu.org/archive/html/qemu-devel/2015-11/msg06194.html
, and discuss the possibility of changing the hardcoded (256) TX  queue
size to be configurable between 256 and 1024.

The reason to propose this request is that a severe issue of packet drops i=
n
TX direction was observed with the existing hardcoded 256 queue size,
which causes performance issues for packet drop sensitive guest
applications that cannot use indirect descriptor tables. The issue goes awa=
y
with 1K queue size.

The concern mentioned in the previous discussion (please check the link
above) is that the number of chained descriptors would exceed
UIO_MAXIOV (1024) supported by the Linux.

>From the code,  I think the number of the chained descriptors is limited to
MAX_SKB_FRAGS + 2 (~18), which is much less than UIO_MAXIOV.
Please point out if I missed anything. Thanks.

Best,
Wei

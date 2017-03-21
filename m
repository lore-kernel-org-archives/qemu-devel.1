Received: from eggs.gnu.org ([2001:4830:134:3::10]:50572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cqAeX-0005mC-JJ
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:40:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cqAeS-0003H3-OF
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:40:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cqAeS-0003GY-Id
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:40:04 -0400
References: <1489657928-14919-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <22303218-697c-7166-406b-050888efdfd5@redhat.com>
Date: Tue, 21 Mar 2017 11:39:56 +0800
MIME-Version: 1.0
In-Reply-To: <1489657928-14919-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] Add COLO-proxy virtio-net support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, bian naimeng <biannm@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>



On 2017=E5=B9=B403=E6=9C=8816=E6=97=A5 17:52, Zhang Chen wrote:
> If user use -device virtio-net-pci, virtio-net driver will add a header
> to raw net packet that colo-proxy can't handle it. COLO-proxy just
> focus on the packet payload, so we skip the virtio-net header to compar=
e
> the sent packet that primary guest's to secondary guest's.
>
>
> Zhang Chen (3):
>    COLO-proxy: Add virtio-net packet parse function
>    COLO-proxy: Add a tag to mark virtio-net packet
>    COLO-compare: Add virtio-net packet compare support
>
>   net/colo-compare.c    | 42 +++++++++++++++++++++++++++++++++---------
>   net/colo.c            | 14 ++++++++++----
>   net/colo.h            |  7 ++++++-
>   net/filter-rewriter.c | 15 ++++++++++-----
>   4 files changed, 59 insertions(+), 19 deletions(-)
>

Hi:

Git grep told us virtio-net is not the only user for vnet header. E1000e=20
and vmxnet3 uses it too.

So we need solve them all instead of being virtio-net specific.

Thanks

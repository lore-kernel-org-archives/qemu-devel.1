Received: from eggs.gnu.org ([2001:4830:134:3::10]:49170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1fnv3p-0004ts-0L
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 20:13:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1fnv3k-0000Q8-WA
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 20:13:44 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:58412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1fnv3k-0000MK-Hq
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 20:13:40 -0400
From: Felipe Franciosi <felipe@nutanix.com>
Date: Fri, 10 Aug 2018 00:13:31 +0000
Message-ID: <BC4392CF-60B8-49EC-A9A2-74682D3A335E@nutanix.com>
References: <20180808195235.5843-1-gedwards@ddn.com>
	<20180808195235.5843-2-gedwards@ddn.com>
In-Reply-To: <20180808195235.5843-2-gedwards@ddn.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EA155D11E673F743A54DA46037368DF7@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/3] vhost-user-scsi: move host_features
 into VHostSCSICommon
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Edwards <gedwards@ddn.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, "Michael
	S. Tsirkin" <mst@redhat.com>, "Nicholas A. Bellinger" <nab@linux-iscsi.org>


> On 8 Aug 2018, at 12:52, Greg Edwards <gedwards@ddn.com> wrote:
>=20
> In preparation for having vhost-scsi also make use of host_features,
> move it from struct VHostUserSCSI into struct VHostSCSICommon.
>=20
> Signed-off-by: Greg Edwards <gedwards@ddn.com>
> ---
> hw/scsi/vhost-user-scsi.c             | 15 ++++++++-------
> include/hw/virtio/vhost-scsi-common.h |  1 +
> include/hw/virtio/vhost-user-scsi.h   |  1 -
> 3 files changed, 9 insertions(+), 8 deletions(-)
>=20

Reviewed-by: Felipe Franciosi <felipe@nutanix.com>

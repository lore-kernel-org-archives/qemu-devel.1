Received: from eggs.gnu.org ([2001:4830:134:3::10]:35367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dX1WS-0006s5-P4
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dX1WO-0000hQ-Ra
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:36:56 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dX1WO-0000ZJ-6c
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:36:52 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Mon, 17 Jul 2017 08:36:28 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA32D3FF@DGGEMA505-MBX.china.huawei.com>
References: <20170717081152.17153-1-lprosek@redhat.com>
	<20170717081152.17153-9-lprosek@redhat.com>
In-Reply-To: <20170717081152.17153-9-lprosek@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 8/9] virtio-crypto: use virtqueue_error
 for errors with queue context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "casasfernando@hotmail.com" <casasfernando@hotmail.com>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "groug@kaod.org" <groug@kaod.org>, "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>



> -----Original Message-----
> From: Ladi Prosek [mailto:lprosek@redhat.com]
> Sent: Monday, July 17, 2017 4:12 PM
> To: qemu-devel@nongnu.org
> Cc: casasfernando@hotmail.com; mst@redhat.com; jasowang@redhat.com;
> cohuck@redhat.com; armbru@redhat.com; groug@kaod.org; Gonglei (Arei);
> aneesh.kumar@linux.vnet.ibm.com
> Subject: [PATCH v3 8/9] virtio-crypto: use virtqueue_error for errors wit=
h queue
> context
>=20
> virtqueue_error includes the queue index in the error output and is prefe=
rred
> for errors that pertain to a virtqueue rather than to the device as a who=
le.
>=20
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> ---
>  hw/virtio/virtio-crypto.c | 49 ++++++++++++++++++++++++-----------------=
------
>  1 file changed, 25 insertions(+), 24 deletions(-)
>=20

Reviewed-by: Gonglei <arei.gonglei@huawei.com>

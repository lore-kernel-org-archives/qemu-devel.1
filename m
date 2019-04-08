Received: from eggs.gnu.org ([209.51.188.92]:40941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hDW2H-0003cX-8Q
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hDW2G-0003w7-CH
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:18:13 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1hDW2F-0003sB-Vr
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:18:12 -0400
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <99f9b621-7e23-0ada-ca49-605cabf2abbd@oracle.com>
Date: Mon, 8 Apr 2019 18:17:47 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <4283A075-04C3-4DE3-AEA1-298E400EC7CA@oracle.com>
References: <20190321075545.14929-1-nir.weiner@oracle.com>
	<99f9b621-7e23-0ada-ca49-605cabf2abbd@oracle.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] vhost-scsi: Support live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Weiner <nir.weiner@oracle.com>
Cc: qemu-devel@nongnu.org, Bijan Mottahedeh <bijan.mottahedeh@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Second ping.
This series has been sent almost 2 weeks ago. We would appreciate some =
feedback/review.

Thanks,
-Liran

> On 27 Mar 2019, at 12:40, Nir Weiner <nir.weiner@oracle.com> wrote:
>=20
> On 3/21/19 9:55 AM, Nir Weiner wrote:
>=20
>> Originally migration was not possible with vhost-scsi because
>> as part of migration, the source host target SCSI device state
>> needs to be saved and loaded into the destination host target SCSI
>> device. This cannot be done by QEMU.
>>=20
>> As this can be handled either by external orchestrator or by having
>> shared-storage (i.e. iSCSI), there is no reason to limit the
>> orchestrator from being able to explictly specify it wish to enable
>> migration even when VM have a vhost-scsi device.
>>=20
>> Liran Alon (1):
>>   vhost-scsi: Allow user to enable migration
>>=20
>> Nir Weiner (2):
>>   vhost-scsi: The vhost device should be stopped when the VM is not
>>     running
>>   vhost-scsi: Add vmstate descriptor
>>=20
>>  hw/scsi/vhost-scsi.c                  | 57 =
++++++++++++++++++++++-----
>>  include/hw/virtio/vhost-scsi-common.h |  1 +
>>  2 files changed, 48 insertions(+), 10 deletions(-)
>>=20
> ping + CC to relevant maintainers

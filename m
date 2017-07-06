Received: from eggs.gnu.org ([2001:4830:134:3::10]:45345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <james.r.harris@intel.com>) id 1dTABt-0004Sx-OJ
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:03:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <james.r.harris@intel.com>) id 1dTABq-0000Do-JK
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:03:45 -0400
Received: from mga05.intel.com ([192.55.52.43]:14220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <james.r.harris@intel.com>)
	id 1dTABq-0000DF-94
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:03:42 -0400
From: "Harris, James R" <james.r.harris@intel.com>
Date: Thu, 6 Jul 2017 17:03:39 +0000
Message-ID: <7813DE88-EB6D-4330-AC69-27E7051C4000@intel.com>
References: <1488479153-21203-1-git-send-email-felipe@nutanix.com>
	<20170302214746.GA4711@redhat.com>
	<9950C259-FD65-4286-84D0-89FA00420E86@nutanix.com>
	<20170706164014-mutt-send-email-mst@kernel.org>
	<757B1E6A-A74C-47E2-A239-893F40922DD2@intel.com>
	<30b1f1cb-f959-7711-96c2-5d5c138135e1@redhat.com>
In-Reply-To: <30b1f1cb-f959-7711-96c2-5d5c138135e1@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <282D1E96ACA4194F80C08298E81A2BE1@intel.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 0/4] Introduce vhost-user-scsi and
 sample application
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Liu, Changpeng" <changpeng.liu@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Felipe Franciosi <felipe@nutanix.com>, Stefan Hajnoczi <stefanha@redhat.com>, Marc-Andre
	Lureau <marcandre.lureau@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>


> On Jul 6, 2017, at 9:56 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
>=20
>=20
> On 06/07/2017 18:54, Harris, James R wrote:
>> Hi Michael,
>>=20
>> Yes - we (SPDK team at Intel) have this on our TODO list, in addition
>> to a polled mode virtio-scsi driver (akin to the DPDK virtio-net driver =
that
>> can be used in the guest).
>=20
> Can you also look at virtio-blk poll-mode drivers and vhost-user-blk
> (vhost-user-blk would be really easy to write, the sample server being
> much more work than the QEMU code)?
>=20
> Paolo

Hi Paolo,

vhost-user-blk:

We have an initial implementation in our SPDK QEMU repo.  Changpeng Liu (ad=
ded)
will be sending this to the QEMU mailing list shortly.  If you are interest=
ed in viewing it
before it hits the mailing list, you can take a look at the patch here:

https://github.com/spdk/qemu/commit/db2fcb0f5002c3d195e756eab07bd976ccf6e7c=
8

virtio-blk poll-mode driver:

Yes - this is part of our plan as well - once we have virtio-scsi in place,=
 adding virtio-blk
will be relatively straightforward.

Thanks,

-Jim

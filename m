Received: from eggs.gnu.org ([209.51.188.92]:46317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hJKvO-0000OQ-3f
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:39:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hJKvM-0008F9-Nn
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:39:10 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1hJKvM-0008Ar-DM
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:39:08 -0400
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <20190418094101.GA23876@stefanha-x1.localdomain>
Date: Wed, 24 Apr 2019 19:38:57 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <17635C1F-A477-4C0F-B052-2948D853E6CD@oracle.com>
References: <20190416125912.44001-1-liran.alon@oracle.com>
	<20190418094101.GA23876@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] vhost-scsi: Support migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net, ehabkost@redhat.com, nir.weiner@oracle.com, bijan.mottahedeh@oracle.com



> On 18 Apr 2019, at 12:41, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>=20
> On Tue, Apr 16, 2019 at 03:59:09PM +0300, Liran Alon wrote:
>> Hi,
>>=20
>> This patch series aims to add supprot to migrate a VM with a =
vhost-scsi device.
>>=20
>> The 1st patch fixes a bug of mistakenly not stopping vhost-scsi =
backend when a
>> VM is stopped (As happens on migratino pre-copy completion).
>>=20
>> The 2nd patch adds ability to save/load vhost-scsi device state in =
VMState.
>>=20
>> The 3rd and final paqtch adds a flag to vhost-scsi which allows admin =
to specify
>> it's setup supports vhost-scsi migratino. For more detailed =
information on why
>> this is valid, see commit message of specific patch.
>>=20
>> Regards,
>> -Liran
>=20
> Looks fine for vhost_scsi.ko.  I have not checked how this interacts
> with vhost-user-scsi.
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Gentle Ping.

-Liran=

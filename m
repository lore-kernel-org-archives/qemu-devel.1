Received: from eggs.gnu.org ([209.51.188.92]:56105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gk94f-000463-R2
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:55:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gk926-00073v-5v
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:52:38 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:52818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gk922-0006vx-GO
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:52:37 -0500
References: <20190117090259.32713-1-sgarzare@redhat.com>
	<20190117090259.32713-6-sgarzare@redhat.com>
	<0bbdcb55-27d9-7098-10f4-aa7aef0a1c24@oracle.com>
	<aa7f4f9e-90b2-c53c-9ddb-b27fd2977d2d@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <8cdb60f6-4a52-f968-d498-ee9273cb69b3@oracle.com>
Date: Thu, 17 Jan 2019 14:52:25 +0000
MIME-Version: 1.0
In-Reply-To: <aa7f4f9e-90b2-c53c-9ddb-b27fd2977d2d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 5/5] optionrom/pvh: load initrd from
 fw_cfg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Maran Wilson <maran.wilson@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Richard Henderson <rth@twiddle.net>, George Kennedy <george.kennedy@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>



On 17/01/2019 14:37, Paolo Bonzini wrote:
> On 17/01/19 15:33, Liam Merwick wrote:
>> #=C2=A0=C2=A0=C2=A0 pc-bios/optionrom/pvh.bin
>> #=C2=A0=C2=A0=C2=A0 pc-bios/optionrom/pvh.img
>> #=C2=A0=C2=A0=C2=A0 pc-bios/optionrom/pvh.raw
>=20
> pvh.bin should not be ignored.
>=20

That's part of what I didn't quite understand.=20
pc-bios/optionrom/linuxboot.bin (and the other binaries in the=20
'build-all' target in pc-bios/optionrom/Makefile) are in .gitignore.

Also, should pvh.bin be added to BLOBS in Makefile like those files?

Regards,
Liam

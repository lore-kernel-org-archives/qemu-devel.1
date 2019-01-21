Received: from eggs.gnu.org ([209.51.188.92]:59178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gleOx-0002mK-7K
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:34:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gleOr-0000vn-Pa
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:34:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gleOr-0000rN-65
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:34:21 -0500
References: <20190118120143.21631-1-sgarzare@redhat.com>
	<20190118120143.21631-5-sgarzare@redhat.com>
	<20190121170541.GN4136@habkost.net>
	<20190121173650.ydihxdyhheq7xcpq@steredhat>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e889e61c-f5fe-51cc-c703-45487efd4d3f@redhat.com>
Date: Mon, 21 Jan 2019 19:33:32 +0100
MIME-Version: 1.0
In-Reply-To: <20190121173650.ydihxdyhheq7xcpq@steredhat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 4/5] hw/i386/pc: use PVH option rom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, George Kennedy <george.kennedy@oracle.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Maran Wilson <maran.wilson@oracle.com>, Liam Merwick <liam.merwick@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Richard Henderson <rth@twiddle.net>, Eric Blake <eblake@redhat.com>

On 21/01/19 18:36, Stefano Garzarella wrote:
>>
>> | On Tue, Jan 15, 2019 at 01:57:22PM -0500, Michael S. Tsirkin wrote:
>> | > OK but this is guest visible so needs to be guarded by the
>> | > new machine type.
>> |=20
>> | Aren't option ROMs treated like other firmware?  i.e.: guest
>> | visible, but copied during live migration and not considered part
>> | of guest ABI.
> I don't know the exact answer, but reading the wiki, I think Michael is=
 right!
> (https://wiki.qemu.org/Features/Migration/Troubleshooting#ROMs)
>=20
> Maybe it is related for PVH feature in general, because if we try to
> migrate to a QEMU version that doesn't support PVH I'm not sure what is
> the behaviour.

As far as I understand, QEMU would fail to migrate to the destination
because the PVH option ROM doesn't have a corresponding RAMBlock.

Paolo

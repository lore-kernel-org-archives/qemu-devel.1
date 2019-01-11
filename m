Received: from eggs.gnu.org ([209.51.188.92]:43409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gi11z-0004xl-BA
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 12:55:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gi11y-0003GJ-JH
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 12:55:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gi11y-0003Fr-9u
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 12:55:42 -0500
References: <20190111131836.107549-1-sgarzare@redhat.com>
	<20190111131836.107549-3-sgarzare@redhat.com>
	<20190111162649.GC14776@stefanha-x1.localdomain>
	<CAGxU2F6mpxE7-xw1LWS3Q6R+NSPMnkrqo8mdhhgn-SfARN3XKQ@mail.gmail.com>
	<20190111124742-mutt-send-email-mst@kernel.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a313ccb0-4c81-5753-6ca7-95b6811d6f5d@redhat.com>
Date: Fri, 11 Jan 2019 11:55:24 -0600
MIME-Version: 1.0
In-Reply-To: <20190111124742-mutt-send-email-mst@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="YKIHAehlrdLB4ynjIo9sdrS4DNilR71cw"
Subject: Re: [Qemu-devel] [PATCH 2/4] linuxboot_dma: move common functions
 in a new header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Maran Wilson <maran.wilson@oracle.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, George Kennedy <george.kennedy@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YKIHAehlrdLB4ynjIo9sdrS4DNilR71cw
From: Eric Blake <eblake@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Maran Wilson <maran.wilson@oracle.com>, Stefan Hajnoczi
 <stefanha@gmail.com>, qemu-devel@nongnu.org,
 George Kennedy <george.kennedy@oracle.com>, Gerd Hoffmann
 <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Richard Henderson <rth@twiddle.net>
Message-ID: <a313ccb0-4c81-5753-6ca7-95b6811d6f5d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] linuxboot_dma: move common functions in
 a new header
References: <20190111131836.107549-1-sgarzare@redhat.com>
 <20190111131836.107549-3-sgarzare@redhat.com>
 <20190111162649.GC14776@stefanha-x1.localdomain>
 <CAGxU2F6mpxE7-xw1LWS3Q6R+NSPMnkrqo8mdhhgn-SfARN3XKQ@mail.gmail.com>
 <20190111124742-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190111124742-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/11/19 11:48 AM, Michael S. Tsirkin wrote:

>>>
>>>> diff --git a/pc-bios/optionrom/optrom.h b/pc-bios/optionrom/optrom.h=

>>>> new file mode 100644
>>>> index 0000000000..36f43b43fd
>>>> --- /dev/null
>>>> +++ b/pc-bios/optionrom/optrom.h

>>>> +#include "../../include/standard-headers/linux/qemu_fw_cfg.h"
>>>
>>> This depends on <stdint.h>, please include it first.
>>
>> Sure.
>>
>>
>> Thanks,
>> Stefano
>=20
> Better to just pull in qemu/osdep.h

Except that qemu/osdep.h should already have been pulled in by whatever
=2Ec file is including this header. We specifically document that .h file=
s
shouldn't need to include osdep.h (and in turn, anything that osdep.h
already pulls in, like <stdint.h>).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--YKIHAehlrdLB4ynjIo9sdrS4DNilR71cw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw42IwACgkQp6FrSiUn
Q2qG+wgAgBjzDSj9Odp9/w+Uubl1g61CGXIFwXyqNV52zEDPHAVSewLqby8vQRJy
otT5Xj0dfDw4k/EGa2RVCC1xQL+oXKUfZ4bsJ/57ioao2x/jYMc+rvBbx/noLjS4
MT/P1/HbIZqbS+7okoALyZGeVS37abWJUhFJ0QxbF3QiivsVmnfuTYHW9cmF2CSY
d4yH66+9ZQtH09PhGszY3HRtAKFhashrDAvhZ0j7Q1ao+ao/ITIpw7ObfO6Xy7QJ
x8P1NHtL6jnSyCZXBRt2LRmL0Xp2EmIN5jvHVpHOeYCHZHYfGSkI074Wepg11oam
BBRx5VdOB6sfXnr3hBia9WN8ZWx0pQ==
=RcYV
-----END PGP SIGNATURE-----

--YKIHAehlrdLB4ynjIo9sdrS4DNilR71cw--
